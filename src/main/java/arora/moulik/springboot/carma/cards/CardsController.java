package arora.moulik.springboot.carma.cards;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import arora.moulik.springboot.carma.register.User;
import arora.moulik.springboot.carma.register.UserRepository;

@Controller
@SessionAttributes("username")
public class CardsController {
	
	UserRepository userRepo;

	public CardsController(UserRepository userRepo) {
		super();
		this.userRepo = userRepo;
	}
	
    @RequestMapping("cards")
    public String showaccmanagement(ModelMap model) {
    	String username = (String) model.get("username");
    	User user = userRepo.findByUsername(username);
    	
    	String name = user.getName() +" " + user.getSurname();
    	model.put("name", name);
    	return "cards";
    }

}
