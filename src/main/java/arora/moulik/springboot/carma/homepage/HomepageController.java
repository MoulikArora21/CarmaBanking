package arora.moulik.springboot.carma.homepage;

import java.time.LocalDate;
import java.util.List;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import arora.moulik.springboot.carma.register.UserRepository;
import arora.moulik.springboot.carma.transactionspage.Transaction;
import arora.moulik.springboot.carma.transactionspage.TransactionRepository;

@Controller
@SessionAttributes("username")
public class HomepageController {

    UserRepository userRepo;
    TransactionRepository trxRepo;
        
    public HomepageController(UserRepository userRepo, TransactionRepository trxRepo) {
        this.userRepo = userRepo;
        this.trxRepo = trxRepo;
    }

    @RequestMapping("homepage")
    public String showhome(ModelMap model) {
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

        // Format account number
        String account = user.getaccount();
        String account1 = account.substring(0, 4);
        String account2 = account.substring(4, 8);
        String account3 = account.substring(8, 12);

        model.put("account", account);
        model.put("account1", account1);
        model.put("account2", account2);
        model.put("account3", account3);

        System.out.println("Before: " + account);
        System.out.println("After: " + account);
        System.out.println(account1);
        System.out.println(account2);
        System.out.println(account3);

        model.put("balance", user.getbalance());

        // Fetch the latest two transactions
        List<Transaction> transactions = trxRepo.findTop2ByUsernameOrderByDateDesc(username);
        System.out.println("Fetched transactions for " + username + ": " + transactions);
        model.put("transactions", transactions);

        // Add today and yesterday for date comparison
        model.put("today", LocalDate.now());
        model.put("yesterday", LocalDate.now().minusDays(1));

        return "welcome";
    }
    
    private String getLoggedinUsername() {
        return SecurityContextHolder.getContext().getAuthentication().getName();    
    }
}