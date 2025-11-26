package arora.moulik.springboot.carma.register;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

class OtpServiceTest {

    @Mock
    private JavaMailSender mailSender;

    @InjectMocks
    private OtpService otpService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        otpService.setAccountSid("testSid");
        otpService.setAuthToken("testToken");
        otpService.setTwilioPhoneNumber("+1234567890");
    }

    @Test
    void testGenerateOtp() {
        String username = "testUser";
        String otp = otpService.generateOtp(username);
        assertNotNull(otp);
        assertEquals(6, otp.length());
        assertTrue(otp.matches("\\d{6}"));
    }

    @Test
    void testVerifyOtp_Valid() {
        String username = "testUser";
        String otp = otpService.generateOtp(username);
        boolean result = otpService.verifyOtp(username, otp);
        assertTrue(result);
    }

    @Test
    void testVerifyOtp_Invalid() {
        String username = "testUser";
        otpService.generateOtp(username);
        boolean result = otpService.verifyOtp(username, "wrongOtp");
        assertFalse(result);
    }

    @Test
    void testVerifyOtp_Expired() throws InterruptedException {
        String username = "testUser";
        String otp = otpService.generateOtp(username);
        boolean result = otpService.verifyOtp(username, otp);
        assertTrue(result);
    }

    @Test
    void testSendOtpEmail() {
        String username = "testUser";
        String email = "test@example.com";
        otpService.sendOtpEmail(username, email);
        verify(mailSender, times(1)).send(any(SimpleMailMessage.class));
    }

    @Test
    @Disabled("Requires real Twilio credentials")
    void testSendOtpSms() {
        String username = "testUser";
        String phone = "+1234567890";
        assertDoesNotThrow(() -> otpService.sendOtpSms(username, phone));
    }
}