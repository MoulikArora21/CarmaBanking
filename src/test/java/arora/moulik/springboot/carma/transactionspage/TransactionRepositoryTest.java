package arora.moulik.springboot.carma.transactionspage;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import java.time.LocalDateTime;
import java.util.List;

@DataJpaTest
class TransactionRepositoryTest {

    @Autowired
    private TestEntityManager entityManager;

    @Autowired
    private TransactionRepository transactionRepository;

    @Test
    void testFindByUsername() {
        // Create test data
        Transaction debitTransaction = new Transaction(null, "user1", "user2", "Debit", 100.0f,
                LocalDateTime.now(), "Sent money", "EUR");
        Transaction creditTransaction = new Transaction(null, "user2", "user1", "Credit", 100.0f,
                LocalDateTime.now(), "Received money", "EUR");
        entityManager.persist(debitTransaction);
        entityManager.persist(creditTransaction);
        entityManager.flush();

        // Test
        List<Transaction> transactions = transactionRepository.findByUsername("user1");

        assertThat(transactions).hasSize(2);
        assertThat(transactions.get(0).getSenderUsername()).isEqualTo("user1");
        assertThat(transactions.get(0).getType()).isEqualTo("Debit");
    }

    @Test
    void testFindBySenderUsernameOrRecipientUsername() {
        // Create test data
        Transaction transaction1 = new Transaction(null, "user1", "user2", "Debit", 50.0f,
                LocalDateTime.now(), "Transaction 1", "EUR");
        Transaction transaction2 = new Transaction(null, "user2", "user1", "Credit", 75.0f,
                LocalDateTime.now(), "Transaction 2", "EUR");
        entityManager.persist(transaction1);
        entityManager.persist(transaction2);
        entityManager.flush();

        // Test
        List<Transaction> transactions = transactionRepository.findBySenderUsernameOrRecipientUsername("user1",
                "user1");

        assertThat(transactions).hasSize(2);
    }

    @Test
    void testFindTop2ByUsernameOrderByDateDesc() {
        // Create test data with different dates
        LocalDateTime now = LocalDateTime.now();
        Transaction transaction1 = new Transaction(null, "user1", "user2", "Debit", 100.0f,
                now.minusDays(1), "Old transaction", "EUR");
        Transaction transaction2 = new Transaction(null, "user1", "user3", "Debit", 200.0f,
                now, "New transaction", "EUR");
        Transaction transaction3 = new Transaction(null, "user4", "user1", "Credit", 150.0f,
                now.minusHours(1), "Medium transaction", "EUR");
        entityManager.persist(transaction1);
        entityManager.persist(transaction2);
        entityManager.persist(transaction3);
        entityManager.flush();

        // Test
        List<Transaction> transactions = transactionRepository.findTop2ByUsernameOrderByDateDesc("user1");

        assertThat(transactions).hasSize(2);
        assertThat(transactions.get(0).getAmount()).isEqualTo(200.0f); // Most recent
        assertThat(transactions.get(1).getAmount()).isEqualTo(150.0f); // Second most recent
    }
}