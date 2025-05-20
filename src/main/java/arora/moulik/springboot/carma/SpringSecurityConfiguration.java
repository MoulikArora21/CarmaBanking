package arora.moulik.springboot.carma;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SpringSecurityConfiguration {

    private final UserDetailsService userDetailsService;

    public SpringSecurityConfiguration(UserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.authorizeHttpRequests(auth -> auth
            .requestMatchers("/login", "/login.jsp", "/registration", "/otpverify", "/otpresend").permitAll()
            .requestMatchers("/css/**", "/js/**", "/images/**").permitAll()
            .requestMatchers("/WEB-INF/**").permitAll() // Allow internal JSP access
            .anyRequest().authenticated()
        )
        .formLogin()
            .loginPage("/login")
            .loginProcessingUrl("/login-process")
            .defaultSuccessUrl("/homepage", true)
            .permitAll();
        http.csrf().disable();
        http.headers().frameOptions().disable();
        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authConfig) throws Exception {
        return authConfig.getAuthenticationManager();
    }
}
