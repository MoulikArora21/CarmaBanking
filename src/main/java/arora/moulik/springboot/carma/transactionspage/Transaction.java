package arora.moulik.springboot.carma.transactionspage;

import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;

@Entity
public class Transaction {
	
	@Id
	@GeneratedValue
    private Long id; // Unique transaction ID
    private String senderUsername; // User sending money
    private String recipientUsername; // User receiving money
    private String type; // "Send" or "Request"
    private float amount; // Transaction amount
    private LocalDateTime date; // Transaction date
    private String description; // Optional description
    private String currency; // Currency (e.g., EUR)

    public Transaction(Long id, String senderUsername, String recipientUsername, String type, 
                      float amount, LocalDateTime date, String description, String currency) {
        this.id = id;
        this.senderUsername = senderUsername;
        this.recipientUsername = recipientUsername;
        this.type = type;
        this.amount = amount;
        this.date = date;
        this.description = description;
        this.currency = currency;
    }
    
    public Transaction() {
    	
    }

    // Getters and setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSenderUsername() {
        return senderUsername;
    }

    public void setSenderUsername(String senderUsername) {
        this.senderUsername = senderUsername;
    }

    public String getRecipientUsername() {
        return recipientUsername;
    }

    public void setRecipientUsername(String recipientUsername) {
        this.recipientUsername = recipientUsername;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }
}
	
