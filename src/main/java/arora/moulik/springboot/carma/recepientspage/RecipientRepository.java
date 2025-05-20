package arora.moulik.springboot.carma.recepientspage;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
public interface RecipientRepository extends JpaRepository<Recipient, Integer> {

	List<Recipient> findByAddedBy(String username);

}
