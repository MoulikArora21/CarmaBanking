package arora.moulik.springboot.carma.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public class RecipientRequestDTO {

    @NotBlank(message = "Recipient username cannot be empty")
    @Size(min = 3, max = 20, message = "Recipient username must be between 3 and 20 characters")
    private String recipientUsername;

    // Constructors
    public RecipientRequestDTO() {
    }

    public RecipientRequestDTO(String recipientUsername) {
        this.recipientUsername = recipientUsername;
    }

    // Getters and Setters
    public String getRecipientUsername() {
        return recipientUsername;
    }

    public void setRecipientUsername(String recipientUsername) {
        this.recipientUsername = recipientUsername;
    }
}