package arora.moulik.springboot.carma.profile;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import arora.moulik.springboot.carma.register.UserRepository;

@Controller
@SessionAttributes("username")
public class ProfileController {
	
	UserRepository userRepo;

	public ProfileController(UserRepository userRepo) {
		super();
		this.userRepo = userRepo;
	}
	
    @RequestMapping("account-management")
    public String showaccmanagement(ModelMap model) {
    	
    	return "account-management";
    }

}
