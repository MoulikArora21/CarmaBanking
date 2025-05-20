package arora.moulik.springboot.carma.transactionspage;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import java.util.List;

@Controller
@SessionAttributes("username")
public class TransactionsControllerJpa {

    private TransactionRepository trxRepo;

    public TransactionsControllerJpa(TransactionRepository trxRepo) {
        this.trxRepo = trxRepo;
    }

    @RequestMapping("transactions")
    public String showTransactions(ModelMap model) {
        String username = getLoggedinUsername();

        if (username == null) {
            model.addAttribute("error", "Session expired or invalid. Please log in again.");
            return "login";
        }

        List<Transaction> allTransactions = trxRepo.findByUsername(username);
        System.out.println("Fetched transactions for " + username + ": " + allTransactions);
        
        model.put("transactionsinjsp", allTransactions);
        model.put("username", username);
        return "transactions";
    }
    
    private String getLoggedinUsername() {
        return SecurityContextHolder.getContext().getAuthentication().getName();    
    }
}