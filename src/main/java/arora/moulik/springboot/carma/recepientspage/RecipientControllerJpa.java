package arora.moulik.springboot.carma.recepientspage;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import arora.moulik.springboot.carma.dto.RecipientRequestDTO;
import arora.moulik.springboot.carma.dto.TransactionRequestDTO;
import arora.moulik.springboot.carma.register.User;
import arora.moulik.springboot.carma.register.UserRepository;
import arora.moulik.springboot.carma.transactionspage.Transaction;
import arora.moulik.springboot.carma.transactionspage.TransactionRepository;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@SessionAttributes("username")
public class RecipientControllerJpa {

    private UserRepository userRepo;
    private TransactionRepository trxRepo;
    private RecipientRepository recRepo;

    public RecipientControllerJpa(UserRepository userRepo, TransactionRepository trxRepo, RecipientRepository recRepo) {
        this.userRepo = userRepo;
        this.trxRepo = trxRepo;
        this.recRepo = recRepo;
    }

    @RequestMapping(value = "recipients", method = RequestMethod.GET)
    public String showRecipientsPage(ModelMap model) {
        String username = getLoggedinUsername();

        if (username == null) {
            model.addAttribute("error", "Session expired or invalid. Please log in again.");
            return "login";
        }

        // Get recipient list for the logged-in user as usernames
        List<Recipient> recipients = recRepo.findByAddedBy(username)
                .stream()
                .collect(Collectors.toList());
        model.addAttribute("recipients", recipients);
        model.addAttribute("username", username);

        // Add empty DTO for the form
        if (!model.containsAttribute("recipientRequestDTO")) {
            model.addAttribute("recipientRequestDTO", new RecipientRequestDTO());
        }

        return "recipients";
    }

    @RequestMapping(value = "addRecipient", method = RequestMethod.POST)
    @Transactional
    public String addRecipient(@Valid RecipientRequestDTO recipientDTO, BindingResult result, ModelMap model) {
        String username = getLoggedinUsername();

        if (username == null) {
            model.addAttribute("error", "Session expired or invalid. Please log in again.");
            return "login";
        }

        if (result.hasErrors()) {
            List<Recipient> recipients = recRepo.findByAddedBy(username)
                    .stream()
                    .collect(Collectors.toList());
            model.addAttribute("recipients", recipients);
            model.addAttribute("username", username);
            model.addAttribute("recipientRequestDTO", recipientDTO);
            return "recipients";
        }

        // Normalize usernames
        String normalizedRecipientUsername = recipientDTO.getRecipientUsername().toLowerCase().trim();
        String normalizedAddedBy = username.toLowerCase();

        // Validate: Check if recipientUsername exists in user repository
        User recipientUser = userRepo.findByUsername(normalizedRecipientUsername);
        if (recipientUser == null) {
            result.rejectValue("recipientUsername", "error.recipientUsername", "Username does not exist.");
            List<Recipient> recipients = recRepo.findByAddedBy(username)
                    .stream()
                    .collect(Collectors.toList());
            model.addAttribute("recipients", recipients);
            model.addAttribute("username", username);
            model.addAttribute("recipientRequestDTO", recipientDTO);
            return "recipients";
        }

        // Validate: Prevent adding self as recipient
        if (normalizedRecipientUsername.equals(normalizedAddedBy)) {
            result.rejectValue("recipientUsername", "error.recipientUsername", "Cannot add yourself as a recipient.");
            List<Recipient> recipients = recRepo.findByAddedBy(username)
                    .stream()
                    .collect(Collectors.toList());
            model.addAttribute("recipients", recipients);
            model.addAttribute("username", username);
            model.addAttribute("recipientRequestDTO", recipientDTO);
            return "recipients";
        }

        // Check if recipient already exists for this user
        boolean alreadyExists = recRepo.findByAddedBy(normalizedAddedBy)
                .stream()
                .anyMatch(r -> r.getUsername().equals(normalizedRecipientUsername));
        if (alreadyExists) {
            result.rejectValue("recipientUsername", "error.recipientUsername", "Recipient already added.");
            List<Recipient> recipients = recRepo.findByAddedBy(username)
                    .stream()
                    .collect(Collectors.toList());
            model.addAttribute("recipients", recipients);
            model.addAttribute("username", username);
            model.addAttribute("recipientRequestDTO", recipientDTO);
            return "recipients";
        }

        // Add recipient
        Recipient recipient = new Recipient(normalizedRecipientUsername, normalizedAddedBy);
        recRepo.save(recipient);
        System.out.println("Added recipient: " + normalizedRecipientUsername + " for user: " + normalizedAddedBy);
        model.addAttribute("message", "Recipient added successfully!");

        // Refresh recipient list and add empty DTO for form
        List<Recipient> recipients = recRepo.findByAddedBy(username)
                .stream()
                .collect(Collectors.toList());
        model.addAttribute("recipients", recipients);
        model.addAttribute("recipientRequestDTO", new RecipientRequestDTO());
        return "recipients";
    }

    @RequestMapping(value = "sendMoney", method = RequestMethod.POST)
    @Transactional
    public String sendMoney(@RequestParam String recipientUsername, @RequestParam float amount,
            ModelMap model) {
        String username = getLoggedinUsername();

        if (username == null) {
            model.addAttribute("error", "Session expired or invalid. Please log in again.");
            return "login";
        }

        // Create and validate TransactionRequestDTO
        TransactionRequestDTO transactionDTO = new TransactionRequestDTO();
        transactionDTO.setRecipientUsername(recipientUsername != null ? recipientUsername.trim() : "");
        transactionDTO.setAmount(BigDecimal.valueOf(amount));
        transactionDTO.setCurrency("EUR");

        // Manual validation since we're using @RequestParam
        if (transactionDTO.getRecipientUsername().isEmpty()) {
            model.addAttribute("error", "Recipient username cannot be empty.");
            List<Recipient> recipients = recRepo.findByAddedBy(username)
                    .stream()
                    .collect(Collectors.toList());
            model.addAttribute("recipients", recipients);
            model.addAttribute("username", username);
            return "recipients";
        }

        if (transactionDTO.getAmount().compareTo(BigDecimal.valueOf(0.01)) < 0) {
            model.addAttribute("error", "Amount must be greater than 0.");
            List<Recipient> recipients = recRepo.findByAddedBy(username)
                    .stream()
                    .collect(Collectors.toList());
            model.addAttribute("recipients", recipients);
            model.addAttribute("username", username);
            return "recipients";
        }

        if (transactionDTO.getAmount().compareTo(BigDecimal.valueOf(100000.00)) > 0) {
            model.addAttribute("error", "Amount cannot exceed 100,000 EUR.");
            List<Recipient> recipients = recRepo.findByAddedBy(username)
                    .stream()
                    .collect(Collectors.toList());
            model.addAttribute("recipients", recipients);
            model.addAttribute("username", username);
            return "recipients";
        }

        // Normalize usernames
        String normalizedRecipientUsername = transactionDTO.getRecipientUsername().toLowerCase();
        String normalizedUsername = username.toLowerCase();

        // Validate recipient exists in user's recipient list
        boolean recipientExists = recRepo.findByAddedBy(normalizedUsername)
                .stream()
                .anyMatch(r -> r.getUsername().equalsIgnoreCase(normalizedRecipientUsername));
        if (!recipientExists) {
            model.addAttribute("error", "Recipient not found in your list.");
            List<Recipient> recipients = recRepo.findByAddedBy(username)
                    .stream()
                    .collect(Collectors.toList());
            model.addAttribute("recipients", recipients);
            model.addAttribute("username", username);
            return "recipients";
        }

        // Validate recipient account still exists
        User recipientUser = userRepo.findByUsername(normalizedRecipientUsername);
        if (recipientUser == null) {
            model.addAttribute("error", "This account no longer exists. The user may have deleted their account.");
            List<Recipient> recipients = recRepo.findByAddedBy(username)
                    .stream()
                    .collect(Collectors.toList());
            model.addAttribute("recipients", recipients);
            model.addAttribute("username", username);
            return "recipients";
        }

        boolean success = addTransaction(
                normalizedUsername,
                normalizedRecipientUsername,
                transactionDTO.getAmountAsFloat(),
                transactionDTO.getCurrency(),
                username + " sent " + transactionDTO.getAmount() + " " + transactionDTO.getCurrency() + " to "
                        + recipientUsername);

        if (success) {
            model.addAttribute("message", "Money sent successfully!");
        } else {
            model.addAttribute("error", "Failed to send money. Invalid amount or details.");
        }

        // Refresh recipient list
        List<Recipient> recipients = recRepo.findByAddedBy(username)
                .stream()
                .collect(Collectors.toList());
        model.addAttribute("recipients", recipients);
        model.addAttribute("username", username);
        return "recipients";
    }

    @Transactional
    public boolean addTransaction(String senderUsername, String recipientUsername, float amount,
            String currency, String description) {
        if (amount <= 0) {
            System.out.println("Invalid amount: " + amount);
            return false;
        }
        if (senderUsername == null || recipientUsername == null || currency == null) {
            System.out.println("Invalid transaction details: sender=" + senderUsername +
                    ", recipient=" + recipientUsername + ", currency=" + currency);
            return false;
        }

        // Normalize usernames to avoid case sensitivity issues
        senderUsername = senderUsername.toLowerCase();
        recipientUsername = recipientUsername.toLowerCase();

        // Fetch sender and recipient from UserRepository
        User sender = userRepo.findByUsername(senderUsername);
        User recipient = userRepo.findByUsername(recipientUsername);

        // Validate users exist
        if (sender == null || recipient == null) {
            System.out.println("Invalid user: sender=" + senderUsername + ", recipient=" + recipientUsername);
            return false;
        }

        // Validate sufficient balance
        Integer senderBalance = sender.getbalance();
        if (senderBalance == null || senderBalance < amount) {
            System.out.println("Insufficient balance for sender: " + senderUsername + ", balance=" + senderBalance);
            return false;
        }

        // Update balances
        sender.setbalance(senderBalance - (int) amount);
        recipient.setbalance((recipient.getbalance() != null ? recipient.getbalance() : 0) + (int) amount);

        // Save updated user entities
        userRepo.save(sender);
        userRepo.save(recipient);

        // Create transaction for the sender (Debit)
        Transaction senderTransaction = new Transaction(
                null,
                senderUsername,
                recipientUsername,
                "Debit",
                amount,
                LocalDateTime.now(),
                description != null ? description
                        : senderUsername + " sent " + amount + " " + currency + " to " + recipientUsername,
                currency);
        trxRepo.save(senderTransaction);
        System.out.println("Added sender transaction: ID=" + senderTransaction.getId() +
                ", Sender=" + senderUsername +
                ", Recipient=" + recipientUsername +
                ", Type=Debit, Amount=" + amount + " " + currency);

        // Create transaction for the recipient (Credit)
        Transaction recipientTransaction = new Transaction(
                null,
                senderUsername,
                recipientUsername,
                "Credit",
                amount,
                LocalDateTime.now(),
                description != null ? description
                        : recipientUsername + " received " + amount + " " + currency + " from " + senderUsername,
                currency);
        trxRepo.save(recipientTransaction);
        System.out.println("Added recipient transaction: ID=" + recipientTransaction.getId() +
                ", Sender=" + senderUsername +
                ", Recipient=" + recipientUsername +
                ", Type=Credit, Amount=" + amount + " " + currency);

        return true;
    }

    private String getLoggedinUsername() {
        return SecurityContextHolder.getContext().getAuthentication().getName();
    }
}