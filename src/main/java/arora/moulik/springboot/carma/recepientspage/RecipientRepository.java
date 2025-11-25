package arora.moulik.springboot.carma.recepientspage;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface RecipientRepository extends JpaRepository<Recipient, Integer> {

	List<Recipient> findByAddedBy(String username);

	List<Recipient> findByUsername(String username);

	@Modifying
	@Query("DELETE FROM Recipient r WHERE r.username = ?1")
	void deleteByUsername(String username);

}
