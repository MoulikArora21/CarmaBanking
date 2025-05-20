package arora.moulik.springboot.carma.register;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@SessionAttributes ("username")
public class OtpControllerJpa {

    private final OtpService otpService;
    private UserRepository userRepo;


    public OtpControllerJpa(OtpService otpService, UserRepository userRepo) {
		super();
		this.otpService = otpService;
		this.userRepo = userRepo;
	}

	@RequestMapping(value = "otpverify", method = RequestMethod.GET)
    public String showOtpVerifyForm(ModelMap model) {
        String username =  (String) model.get("username");
        
        User user = userRepo.findByUsername(username);
        String email = user.getEmail();
        String phoneNumber = user.getPhone_number();

        System.out.println("GET /otpverify - Session username: " + username + 
                          ", email: " + email + 
                          ", phoneNumber: " + phoneNumber);

        if (username == null) {
            model.addAttribute("error", "Session expired or invalid. Please register again.");
            return "registration";
        }

        if ((email == null || email.isEmpty()) && (phoneNumber == null || phoneNumber.isEmpty())) {
            model.addAttribute("error", "Email or phone number required to send OTP.");
            model.addAttribute("username", username);
            model.addAttribute("email", email);
            model.addAttribute("phoneNumber", phoneNumber);
            return "otpverify";
        }

        try {
            if (email != null && !email.isEmpty()) {
                otpService.sendOtpEmail(username, email);
                model.addAttribute("message", "OTP sent to email");
            }
//            if (phoneNumber != null && !phoneNumber.isEmpty()) {
//                otpService.sendOtpSms(username, phoneNumber);
//                model.addAttribute("message", "OTP sent to phone");
//            }
        } catch (Exception e) {
            model.addAttribute("error", "Failed to send OTP: " + e.getMessage());
            model.addAttribute("username", username);
            model.addAttribute("email", email);
            model.addAttribute("phoneNumber", phoneNumber);
            return "otpverify";
        }

        model.put("username", username);
        model.put("email", email);
        model.put("phoneNumber", phoneNumber);
        return "otpverify";
    }

    @RequestMapping(value = "otpresend", method = RequestMethod.POST)
    public String resendOtp(ModelMap model) {
        String username =  (String) model.get("username");
        User user = userRepo.findByUsername(username);
        String email = user.getEmail();
        String phoneNumber = user.getPhone_number();

        if (username == null) {
            model.addAttribute("error", "Session expired. Please try again.");
            return "registration";
        }

        if ((email == null || email.isEmpty()) && (phoneNumber == null || phoneNumber.isEmpty())) {
            model.addAttribute("error", "No email or phone number provided to resend OTP.");
            model.addAttribute("username", username);
            model.addAttribute("email", email);
            model.addAttribute("phoneNumber", phoneNumber);
            return "otpverify";
        }

        try {
            if (email != null && !email.isEmpty()) {
                otpService.sendOtpEmail(username, email);
                model.addAttribute("message", "OTP resent to email");
            }
//            if (phoneNumber != null && !phoneNumber.isEmpty()) {
//                otpService.sendOtpSms(username, phoneNumber);
//                model.addAttribute("message", "OTP resent to phone");
//            }
        } catch (Exception e) {
            model.addAttribute("error", "Failed to resend OTP: " + e.getMessage());
            model.addAttribute("username", username);
            model.addAttribute("email", email);
            model.addAttribute("phoneNumber", phoneNumber);
            return "otpverify";
        }

        model.addAttribute("username", username);
        model.addAttribute("email", email);
        model.addAttribute("phoneNumber", phoneNumber);
        return "otpverify";
    }

    @RequestMapping(value = "otpverify", method = RequestMethod.POST)
    public String verifyOtp(@RequestParam String username, @RequestParam String otp, ModelMap model) {
        System.out.println("POST /otpverify - Submitted username: " + username + 
                          ", OTP: " + otp + 
                          ", Session username: " + model.get("username"));
        
        if (otpService.verifyOtp(username, otp)) {
            model.addAttribute("message", "OTP verified successfully! Transaction authorized.");
            return "redirect:login";
        } else {
            model.addAttribute("error", "Invalid or expired OTP");
            model.addAttribute("username", username);
            model.addAttribute("email", (String) model.get("email"));
            model.addAttribute("phoneNumber", (String) model.get("phoneNumber"));
            return "otpverify";
        }
    }
    
    
    
	private String getLoggedinUsername() {
		return SecurityContextHolder.getContext().getAuthentication().getName();	
	}
}