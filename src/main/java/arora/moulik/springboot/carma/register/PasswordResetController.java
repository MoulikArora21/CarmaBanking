package arora.moulik.springboot.carma.register;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class PasswordResetController {

    private final UserRepository userRepository;
    private final PasswordResetTokenRepository tokenRepository;
    private final PasswordEncoder passwordEncoder;

    public PasswordResetController(UserRepository userRepository,
            PasswordResetTokenRepository tokenRepository,
            PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.tokenRepository = tokenRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/forgot-password")
    public String showForgotPasswordPage() {
        return "forgot-password";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam("email") String email,
            ModelMap model,
            RedirectAttributes redirectAttributes) {
        try {
            User user = userRepository.findByEmail(email);
            if (user == null) {
                // Don't reveal if email exists or not for security
                redirectAttributes.addFlashAttribute("successMessage",
                        "If an account with that email exists, we've sent a password reset link.");
                return "redirect:/forgot-password";
            }

            // Clean up expired tokens
            tokenRepository.deleteExpiredTokens(LocalDateTime.now());

            // Create new reset token
            String token = UUID.randomUUID().toString();
            PasswordResetToken resetToken = new PasswordResetToken(token, user);
            tokenRepository.save(resetToken);

            // In a real application, you would send an email here
            // For now, we'll just show the reset link in the success message
            String resetLink = "http://localhost:8080/reset-password?token=" + token;

            System.out.println("Password reset link for " + email + ": " + resetLink);

            redirectAttributes.addFlashAttribute("successMessage",
                    "Password reset link has been sent to your email address. " +
                            "For demo purposes, the link is: " + resetLink);

            return "redirect:/forgot-password";

        } catch (Exception e) {
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

            if (!resetTokenOpt.isPresent() || resetTokenOpt.get().isExpired()) {
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
            if (!resetTokenOpt.isPresent() || resetTokenOpt.get().isExpired()) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Invalid or expired password reset token.");
                return "redirect:/forgot-password";
            }

            // Update user password
            PasswordResetToken resetToken = resetTokenOpt.get();
            User user = resetToken.getUser();
            user.setPassword(passwordEncoder.encode(password));
            userRepository.save(user);

            // Delete the used token
            tokenRepository.delete(resetToken);

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
                password.matches(".*[!@#$%^&*()_+-=\\[\\]{};':\"\\\\|,.<>\\/?].*");
    }
}