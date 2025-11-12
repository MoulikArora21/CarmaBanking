package arora.moulik.springboot.carma.login;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@SessionAttributes("username")
public class LoginController {	
	
	@RequestMapping(value="/login")
	public String loginpage(ModelMap model) {
		return "login";
	}
	
	
//	private String getLoggedinUsername() {
//		return SecurityContextHolder.getContext().getAuthentication().getName();	
//	}
}
