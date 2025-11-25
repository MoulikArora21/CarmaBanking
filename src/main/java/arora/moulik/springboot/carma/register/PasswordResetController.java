package arora.moulik.springboot.carma.register;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class PasswordResetController {

    @Value("${app.base-url}")
    private String baseUrl;

    private final UserRepository userRepository;
    private final PasswordResetTokenRepository tokenRepository;
    private final PasswordEncoder passwordEncoder;
    private final JavaMailSender mailSender;

    public PasswordResetController(UserRepository userRepository,
            PasswordResetTokenRepository tokenRepository,
            PasswordEncoder passwordEncoder,
            JavaMailSender mailSender) {
        this.userRepository = userRepository;
        this.tokenRepository = tokenRepository;
        this.passwordEncoder = passwordEncoder;
        this.mailSender = mailSender;
    }

    @GetMapping("/forgot-password")
    public String showForgotPasswordPage() {
        return "forgot-password";
    }

    @PostMapping("/forgot-password")
    @Transactional
    public String processForgotPassword(@RequestParam("email") String email,
            ModelMap model,
            RedirectAttributes redirectAttributes) {
        try {
            User user = userRepository.findFirstByEmail(email);
            if (user == null) {
                // Don't reveal if email exists or not for security
                redirectAttributes.addFlashAttribute("successMessage",
                        "If an account with that email exists, we've sent a password reset link.");
                return "redirect:/forgot-password";
            }

            // Clean up expired tokens
            tokenRepository.deleteExpiredTokens(LocalDateTime.now());

            // Delete any existing tokens for this user (must be before creating new one)
            tokenRepository.deleteByUser(user);

            // Force flush to ensure delete is executed before insert
            tokenRepository.flush();

            // Create new reset token
            String token = UUID.randomUUID().toString();
            PasswordResetToken resetToken = new PasswordResetToken(token, user);
            tokenRepository.save(resetToken);

            // Send password reset email
            String resetLink = baseUrl + "/reset-password?token=" + token;
            sendPasswordResetEmail(user.getEmail(), user.getName(), resetLink);

            redirectAttributes.addFlashAttribute("successMessage",
                    "Password reset link has been sent to your email address. Please check your inbox.");

            return "redirect:/forgot-password";

        } catch (Exception e) {
            e.printStackTrace(); // Log the full stack trace
            System.out.println("ERROR in processForgotPassword: " + e.getMessage());
            redirectAttributes.addFlashAttribute("errorMessage",
                    "An error occurred while processing your request. Please try again.");
            return "redirect:/forgot-password";
        }
    }

    @GetMapping("/reset-password")
    public String showResetPasswordPage(@RequestParam("token") String token,
            ModelMap model,
            RedirectAttributes redirectAttributes) {
        try {
            Optional<PasswordResetToken> resetTokenOpt = tokenRepository.findByToken(token);

            if (!resetTokenOpt.isPresent() || resetTokenOpt.get().isExpired() || resetTokenOpt.get().isUsed()) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Invalid or expired password reset token.");
                return "redirect:/forgot-password";
            }

            model.put("token", token);
            return "reset-password";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "An error occurred while processing your request.");
            return "redirect:/forgot-password";
        }
    }

    @PostMapping("/reset-password")
    @Transactional
    public String processResetPassword(@RequestParam("token") String token,
            @RequestParam("password") String password,
            @RequestParam("confirmPassword") String confirmPassword,
            ModelMap model,
            RedirectAttributes redirectAttributes) {
        try {
            // Validate passwords match
            if (!password.equals(confirmPassword)) {
                model.put("errorMessage", "Passwords do not match.");
                model.put("token", token);
                return "reset-password";
            }

            // Validate password strength
            if (!isValidPassword(password)) {
                model.put("errorMessage", "Password does not meet requirements.");
                model.put("token", token);
                return "reset-password";
            }

            // Find and validate token
            Optional<PasswordResetToken> resetTokenOpt = tokenRepository.findByToken(token);
            if (!resetTokenOpt.isPresent() || resetTokenOpt.get().isExpired() || resetTokenOpt.get().isUsed()) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Invalid or expired password reset token.");
                return "redirect:/forgot-password";
            }

            // Update user password
            PasswordResetToken resetToken = resetTokenOpt.get();
            User user = resetToken.getUser();
            user.setPassword(passwordEncoder.encode(password));
            userRepository.save(user);

            // Mark token as used
            resetToken.setUsed(true);
            tokenRepository.save(resetToken);

            redirectAttributes.addFlashAttribute("successMessage",
                    "Your password has been successfully reset. You can now log in with your new password.");

            return "redirect:/login";

        } catch (Exception e) {
            model.put("errorMessage", "An error occurred while resetting your password. Please try again.");
            model.put("token", token);
            return "reset-password";
        }
    }

    private boolean isValidPassword(String password) {
        // Password must be at least 8 characters and contain:
        // at least one uppercase letter, one lowercase letter, one number, and one
        // special character
        return password.length() >= 8 &&
                password.matches(".*[A-Z].*") &&
                password.matches(".*[a-z].*") &&
                password.matches(".*\\d.*") &&
                password.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?].*");
    }

    private void sendPasswordResetEmail(String toEmail, String userName, String resetLink) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(toEmail);
            message.setSubject("Password Reset Request - CARMA Banking");
            message.setText(String.format(
                    "Dear %s,\n\n" +
                            "We received a request to reset your password for your CARMA Banking account.\n\n" +
                            "Click the link below to reset your password:\n%s\n\n" +
                            "This link will expire in 24 hours.\n\n" +
                            "If you did not request a password reset, please ignore this email and your password will remain unchanged.\n\n"
                            +
                            "Best regards,\n" +
                            "CARMA Banking Team",
                    userName, resetLink));
            message.setFrom("noreply@carmabanking.com");

            mailSender.send(message);
        } catch (Exception e) {
            // Log the error but don't expose it to the user
            System.err.println("Failed to send password reset email: " + e.getMessage());
            e.printStackTrace();
        }
    }
}