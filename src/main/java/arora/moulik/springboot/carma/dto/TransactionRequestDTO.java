package arora.moulik.springboot.carma.dto;

import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

import java.math.BigDecimal;

public class TransactionRequestDTO {

    @NotBlank(message = "Recipient username cannot be empty")
    @Size(min = 3, max = 20, message = "Recipient username must be between 3 and 20 characters")
    private String recipientUsername;

    @NotNull(message = "Amount cannot be null")
    @DecimalMin(value = "0.01", message = "Amount must be greater than 0")
    @DecimalMax(value = "100000.00", message = "Amount cannot exceed 100,000")
    private BigDecimal amount;

    @NotBlank(message = "Currency cannot be empty")
    @Pattern(regexp = "^(EUR|USD|GBP|CAD|AUD)$", message = "Currency must be one of: EUR, USD, GBP, CAD, AUD")
    private String currency;

    @Size(max = 255, message = "Description cannot exceed 255 characters")
    private String description;

    // Constructors
    public TransactionRequestDTO() {
    }

    public TransactionRequestDTO(String recipientUsername, BigDecimal amount, String currency, String description) {
        this.recipientUsername = recipientUsername;
        this.amount = amount;
        this.currency = currency;
        this.description = description;
    }

    // Getters and Setters
    public String getRecipientUsername() {
        return recipientUsername;
    }

    public void setRecipientUsername(String recipientUsername) {
        this.recipientUsername = recipientUsername;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    // Utility method to convert BigDecimal to float for legacy compatibility
    public float getAmountAsFloat() {
        return amount != null ? amount.floatValue() : 0.0f;
    }
}