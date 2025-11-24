package arora.moulik.springboot.carma.profile;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import arora.moulik.springboot.carma.register.User;
import arora.moulik.springboot.carma.register.UserRepository;
import jakarta.servlet.http.HttpSession;

@Controller
@SessionAttributes("username")
public class AccountManagementController {

    private UserRepository userRepo;
    private PasswordEncoder passwordEncoder;

    public AccountManagementController(UserRepository userRepo, PasswordEncoder passwordEncoder) {
        this.userRepo = userRepo;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/edit-details")
    public String showEditForm(ModelMap model) {
        String username = (String) model.get("username");
        User user = userRepo.findByUsername(username);

        if (user == null) {
            return "redirect:/login";
        }

        model.put("user", user);
        return "edit-details";
    }

    @PostMapping("/edit-details")
    public String updateDetails(@RequestParam String name,
            @RequestParam String surname,
            @RequestParam String email,
            @RequestParam String phone_number,
            @RequestParam String country,
            @RequestParam(required = false) String address,
            @RequestParam(required = false) String personalid,
            @RequestParam(required = false) String newPassword,
            ModelMap model) {
        String username = (String) model.get("username");
        User existingUser = userRepo.findByUsername(username);

        if (existingUser == null) {
            return "redirect:/login";
        }

        // Validate required fields
        if (name == null || name.trim().isEmpty() ||
                surname == null || surname.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                phone_number == null || phone_number.trim().isEmpty() ||
                country == null || country.trim().isEmpty()) {
            model.put("errorMessage", "Please fill in all required fields");
            model.put("user", existingUser);
            return "edit-details";
        }

        // Update fields
        existingUser.setName(name.trim());
        existingUser.setSurname(surname.trim());
        existingUser.setEmail(email.trim());
        existingUser.setPhone_number(phone_number.trim());
        existingUser.setCountry(country.trim());
        existingUser.setAddress(address != null ? address.trim() : "");
        existingUser.setPersonalid(personalid != null ? personalid.trim() : "");

        // Update password if provided
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            existingUser.setPassword(passwordEncoder.encode(newPassword));
        }

        userRepo.save(existingUser);

        return "redirect:/account-management";
    }

    @PostMapping("/delete-account")
    public String deleteAccount(ModelMap model, HttpSession session) {
        String username = (String) model.get("username");
        User user = userRepo.findByUsername(username);

        if (user != null) {
            userRepo.delete(user);
        }

        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/terms")
    public String showTerms(ModelMap model) {
        String username = (String) model.get("username");
        if (username == null) {
            return "redirect:/login";
        }
        return "terms";
    }
}
