package arora.moulik.springboot.carma.recepientspage;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import arora.moulik.springboot.carma.register.User;
import arora.moulik.springboot.carma.register.UserRepository;
import arora.moulik.springboot.carma.transactionspage.Transaction;
import arora.moulik.springboot.carma.transactionspage.TransactionRepository;

class RecipientControllerJpaTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private TransactionRepository transactionRepository;

    @Mock
    private RecipientRepository recipientRepository;

    @InjectMocks
    private RecipientControllerJpa recipientController;

    public RecipientControllerJpaTest() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testAddTransaction_Success() {
        // Arrange
        User sender = new User();
        sender.setUsername("sender");
        sender.setbalance(1000);

        User recipient = new User();
        recipient.setUsername("recipient");
        recipient.setbalance(500);

        when(userRepository.findByUsername("sender")).thenReturn(sender);
        when(userRepository.findByUsername("recipient")).thenReturn(recipient);

        // Act
        boolean result = recipientController.addTransaction("sender", "recipient", 100.0f, "EUR", "Test transaction");

        // Assert
        assertTrue(result);
        assertEquals(900, sender.getbalance()); // 1000 - 100
        assertEquals(600, recipient.getbalance()); // 500 + 100
        verify(userRepository, times(2)).save(any(User.class));
        verify(transactionRepository, times(2)).save(any(Transaction.class));
    }

    @Test
    void testAddTransaction_InvalidAmount() {
        // Act
        boolean result = recipientController.addTransaction("sender", "recipient", -50.0f, "EUR", "Test");

        // Assert
        assertFalse(result);
        verify(userRepository, never()).findByUsername(anyString());
    }

    @Test
    void testAddTransaction_UserNotFound() {
        // Arrange
        when(userRepository.findByUsername("sender")).thenReturn(null);

        // Act
        boolean result = recipientController.addTransaction("sender", "recipient", 100.0f, "EUR", "Test");

        // Assert
        assertFalse(result);
    }

    @Test
    void testAddTransaction_InsufficientBalance() {
        // Arrange
        User sender = new User();
        sender.setUsername("sender");
        sender.setbalance(50);

        when(userRepository.findByUsername("sender")).thenReturn(sender);
        when(userRepository.findByUsername("recipient")).thenReturn(new User());

        // Act
        boolean result = recipientController.addTransaction("sender", "recipient", 100.0f, "EUR", "Test");

        // Assert
        assertFalse(result);
    }
}