package arora.moulik.springboot.carma.login;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import jakarta.servlet.http.HttpSession;

@Controller
@SessionAttributes("username")
public class LoginController {

	private final AuthenticationManager authenticationManager;

	public LoginController(AuthenticationManager authenticationManager) {
		this.authenticationManager = authenticationManager;
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginpage(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout,
			ModelMap model) {
		if (error != null) {
			if ("access_denied".equals(error)) {
				model.put("errorMessage", "Access denied. Please log in to continue.");
			} else if ("system_error".equals(error)) {
				model.put("errorMessage", "A system error occurred. Please try again.");
			} else if ("unknown_error".equals(error)) {
				model.put("errorMessage", "An unknown error occurred. Please try again.");
			} else {
				model.put("errorMessage", "Login required to access this page.");
			}
		}
		if (logout != null) {
			model.put("successMessage", "You have been logged out successfully.");
		}
		return "login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String handleLogin(
			@RequestParam("username") String username,
			@RequestParam("password") String password,
			HttpSession session,
			ModelMap model) {

		try {
			// Create authentication token
			UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(username, password);

			// Authenticate using Spring Security's AuthenticationManager
			Authentication authentication = authenticationManager.authenticate(authToken);

			// Set authentication in SecurityContext
			SecurityContextHolder.getContext().setAuthentication(authentication);

			// Store SecurityContext in session
			session.setAttribute(
					HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY,
					SecurityContextHolder.getContext());

			// Store username in model for session
			model.put("username", username);

			System.out.println("Login successful for user: " + username);

			// Redirect to homepage
			return "redirect:/homepage";

		} catch (AuthenticationException e) {
			System.out.println("Login failed for user: " + username + " - " + e.getMessage());
			model.put("errorMessage", "Invalid username or password");
			return "login";
		}
	}
}
