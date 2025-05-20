package arora.moulik.springboot.carma.transactionspage;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface TransactionRepository extends JpaRepository<Transaction, Long> {
    
    @Query(value = "SELECT * FROM transaction t " +
                   "WHERE (t.sender_username = :username AND t.type = 'Debit') " +
                   "OR (t.recipient_username = :username AND t.type = 'Credit') " +
                   "ORDER BY t.date DESC", nativeQuery = true)
    List<Transaction> findByUsername(@Param("username") String username);
    
    @Query(value = "SELECT * FROM transaction t " +
                   "WHERE (t.sender_username = :username AND t.type = 'Debit') " +
                   "OR (t.recipient_username = :username AND t.type = 'Credit') " +
                   "ORDER BY t.date DESC LIMIT 2", nativeQuery = true)
    List<Transaction> findTop2ByUsernameOrderByDateDesc(@Param("username") String username);
}