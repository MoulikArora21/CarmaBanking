package arora.moulik.springboot.carma;

import java.util.Collections;
import org.springframework.security.core.userdetails.*;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;

import arora.moulik.springboot.carma.register.UserRepository;

@Service
public class JpaUserDetailsService implements UserDetailsService {

    private final UserRepository userRepo;

    public JpaUserDetailsService(UserRepository userRepo) {
        this.userRepo = userRepo;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        arora.moulik.springboot.carma.register.User user = userRepo.findByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("User not found: " + username);
        }

        return new org.springframework.security.core.userdetails.User(
            user.getUsername(),
            user.getPassword(),
            Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER")) // Customize roles as needed
        );
    }
}
