package arora.moulik.springboot.carma.register;

import java.security.SecureRandom;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import arora.moulik.springboot.carma.dto.UserRegistrationDTO;
import jakarta.validation.Valid;

@Controller
@SessionAttributes("username")
public class RegisterationControllerJpa {
    private final UserRepository userRepo;
    private final PasswordEncoder passwordEncoder;

    public RegisterationControllerJpa(PasswordEncoder passwordEncoder,
            UserRepository userRepo) {
        this.passwordEncoder = passwordEncoder;
        this.userRepo = userRepo;
    }

    @RequestMapping(value = "registration", method = RequestMethod.GET)
    public String startRegistration(ModelMap model) {
        UserRegistrationDTO userDTO = new UserRegistrationDTO();
        model.put("user", userDTO);
        return "registration";
    }

    @RequestMapping(value = "registration", method = RequestMethod.POST)
    public String saveUser(ModelMap model, @Valid UserRegistrationDTO userDTO, BindingResult result) {
        if (result.hasErrors()) {
            return "registration";
        }

        // Custom validation for password confirmation
        if (!userDTO.isPasswordConfirmed()) {
            result.rejectValue("confirmPassword", "error.confirmPassword", "Passwords do not match!");
            return "registration";
        }

        // Check if username already exists
        if (userRepo.findByUsername(userDTO.getUsername().toLowerCase()) != null) {
            result.rejectValue("username", "error.user", "Username already exists!");
            return "registration";
        }

        try {
            // Generate a unique account number
            String uniqueAccount = generateUniqueAccountNumber();
            String encodedPassword = passwordEncoder.encode(userDTO.getPassword());

            // Create and save the user
            User newUser = new User(
                    null, // Let JPA generate the ID
                    userDTO.getName(),
                    userDTO.getSurname(),
                    userDTO.getCountry(),
                    userDTO.getAddress(),
                    userDTO.getPhoneNumber(),
                    userDTO.getEmail(),
                    userDTO.getUsername().toLowerCase(), // Normalize username
                    userDTO.getPersonalId(),
                    encodedPassword,
                    null, // Clear confirm_password
                    generateRandomBal(),
                    uniqueAccount);
            userRepo.save(newUser);

            model.put("username", userDTO.getUsername().toLowerCase());
            model.put("email", userDTO.getEmail());
            model.put("phoneNumber", userDTO.getPhoneNumber());
            return "redirect:otpverify";

        } catch (DataIntegrityViolationException e) {
            // Check if the exception is due to duplicate account or username
            if (e.getMessage().contains("ACCOUNT")) {
                result.rejectValue("account", "error.account",
                        "Failed to generate a unique account number. Please try again.");
            } else {
                result.rejectValue("username", "error.user", "Username already exists!");
            }
            return "registration";
        }
    }

    private String generateUniqueAccountNumber() {
        SecureRandom random = new SecureRandom();
        int maxAttempts = 10; // Limit retries to prevent infinite loops
        for (int attempt = 0; attempt < maxAttempts; attempt++) {
            StringBuilder acc = new StringBuilder();
            for (int i = 0; i < 12; i++) {
                acc.append(random.nextInt(10));
            }
            String accountNumber = acc.toString();
            if (!userRepo.existsByAccount(accountNumber)) {
                return accountNumber; // Unique account number found
            }
        }
        throw new RuntimeException("Unable to generate a unique account number after " + maxAttempts + " attempts");
    }

    private Integer generateRandomBal() {
        SecureRandom random = new SecureRandom();
        return random.nextInt(10000);
    }
}