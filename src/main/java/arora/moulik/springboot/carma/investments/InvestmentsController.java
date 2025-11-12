package arora.moulik.springboot.carma.investments;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import arora.moulik.springboot.carma.register.UserRepository;

@Controller
@SessionAttributes("username")
public class InvestmentsController {

    UserRepository userRepo;

    public InvestmentsController(UserRepository userRepo) {
        this.userRepo = userRepo;
    }

    @RequestMapping("investments")
    public String showInvestments(ModelMap model) {
        String username = getLoggedinUsername();

        // Check if user is authenticated (not anonymous)
        if (username == null || "anonymousUser".equals(username)) {
            return "redirect:/login";
        }

        model.put("username", username);

        // Find user in database
        var user = userRepo.findByUsername(username);
        if (user == null) {
            return "redirect:/login";
        }

        String name = user.getName() + " " + user.getSurname();
        model.put("name", name);
        model.put("balance", user.getbalance());

        return "investments";
    }

    private String getLoggedinUsername() {
        return SecurityContextHolder.getContext().getAuthentication().getName();
    }
}
