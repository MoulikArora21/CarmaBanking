package arora.moulik.springboot.carma.register;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Integer> {
    User findByUsername(String username);
    boolean existsByAccount(String accountNumber);
}