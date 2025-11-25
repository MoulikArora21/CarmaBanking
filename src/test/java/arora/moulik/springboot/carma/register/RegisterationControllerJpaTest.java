package arora.moulik.springboot.carma.register;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.web.servlet.MockMvc;

import arora.moulik.springboot.carma.dto.UserRegistrationDTO;

@WebMvcTest(RegisterationControllerJpa.class)
@AutoConfigureMockMvc(addFilters = false)
class RegisterationControllerJpaTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private UserRepository userRepository;

    @MockBean
    private PasswordEncoder passwordEncoder;

    @Test
    void testStartRegistration() throws Exception {
        mockMvc.perform(get("/registration"))
                .andExpect(status().isOk())
                .andExpect(view().name("registration"))
                .andExpect(model().attributeExists("user"));
    }

    @Test
    void testSaveUser_Success() throws Exception {
        when(userRepository.findByUsername("testuser")).thenReturn(null);
        when(userRepository.existsByAccount(anyString())).thenReturn(false);
        when(passwordEncoder.encode("Password1!")).thenReturn("encodedPassword");

        mockMvc.perform(post("/registration")
                .param("name", "Test")
                .param("surname", "User")
                .param("country", "Country")
                .param("address", "Address")
                .param("phoneNumber", "+1234567890")
                .param("email", "test@example.com")
                .param("username", "testuser")
                .param("personalId", "123456")
                .param("password", "Password1!")
                .param("confirmPassword", "Password1!"))

                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("otpverify"));
    }

    @Test
    void testSaveUser_UsernameExists() throws Exception {
        when(userRepository.findByUsername("testuser")).thenReturn(new User());

        mockMvc.perform(post("/registration")
                .param("name", "Test")
                .param("surname", "User")
                .param("country", "Country")
                .param("address", "Address")
                .param("phoneNumber", "+1234567890")
                .param("email", "test@example.com")
                .param("username", "testuser")
                .param("personalId", "123456")
                .param("password", "Password1!")
                .param("confirmPassword", "Password1!"))
                .andExpect(status().isOk())
                .andExpect(view().name("registration"))
                .andExpect(model().hasErrors());
    }

    @Test
    void testSaveUser_PasswordMismatch() throws Exception {
        mockMvc.perform(post("/registration")
                .param("name", "Test")
                .param("surname", "User")
                .param("country", "Country")
                .param("address", "Address")
                .param("phoneNumber", "+1234567890")
                .param("email", "test@example.com")
                .param("username", "testuser")
                .param("personalId", "123456")
                .param("password", "Password1!")
                .param("confirmPassword", "different"))
                .andExpect(status().isOk())
                .andExpect(view().name("registration"))
                .andExpect(model().hasErrors());
    }
}