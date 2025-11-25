package arora.moulik.springboot.carma.register;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Service
public class OtpService {

    @Autowired
    private JavaMailSender mailSender;

    @Value("${twilio.account.sid}")
    private String accountSid;

    @Value("${twilio.auth.token}")
    private String authToken;

    @Value("${twilio.phone.number}")
    private String twilioPhoneNumber;

    // Setters for testing
    public void setAccountSid(String accountSid) {
        this.accountSid = accountSid;
    }

    public void setAuthToken(String authToken) {
        this.authToken = authToken;
    }

    public void setTwilioPhoneNumber(String twilioPhoneNumber) {
        this.twilioPhoneNumber = twilioPhoneNumber;
    }

    private static final int OTP_LENGTH = 6;
    private static final int OTP_VALIDITY_MINUTES = 5;

    private static List<Otp> otps = new ArrayList<>();

    public String generateOtp(String username) {
        otps.removeIf(otp -> otp.getUsername().equals(username));

        String otp = generateRandomOtp();
        LocalDateTime now = LocalDateTime.now();
        Otp otpEntity = new Otp(otp, username, now, now.plusMinutes(OTP_VALIDITY_MINUTES));
        otps.add(otpEntity);
        System.out.println("Generated OTP: " + otp +
                ", for username: " + username +
                ", CreatedAt: " + now +
                ", ExpiresAt: " + now.plusMinutes(OTP_VALIDITY_MINUTES));
        return otp;
    }

    private String generateRandomOtp() {
        SecureRandom random = new SecureRandom();
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < OTP_LENGTH; i++) {
            otp.append(random.nextInt(10));
        }
        return otp.toString();
    }

    public void sendOtpEmail(String username, String email) {
        String otp = generateOtp(username);
        System.out.println("Generated OTP for username: " + username + ", OTP: " + otp +
                ", Email: " + email);
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject("Your OTP");
        message.setText("Your OTP is: " + otp + ". Valid for 5 minutes.");
        mailSender.send(message);
    }

    public void sendOtpSms(String username, String phoneNumber) {
        String otp = generateOtp(username);
        Twilio.init(accountSid, authToken);
        Message.creator(
                new PhoneNumber(phoneNumber),
                new PhoneNumber(twilioPhoneNumber),
                "Your OTP is: " + otp + ". Valid for 5 minutes.")
                .create();
    }

    public boolean verifyOtp(String username, String otp) {
        // Clean up expired OTPs
        otps.removeIf(otpRecord -> LocalDateTime.now().isAfter(otpRecord.getExpiresAt()));

        System.out.println("Verifying OTP for username: " + username + ", OTP: " + otp);
        System.out.println("Current OTP list size: " + otps.size());

        for (Otp otpRecord : otps) {
            System.out.println("Checking OTP record: username=" + otpRecord.getUsername() +
                    ", OTP=" + otpRecord.getOtp() +
                    ", ExpiresAt=" + otpRecord.getExpiresAt() +
                    ", CurrentTime=" + LocalDateTime.now());
            if (otpRecord.getUsername().equals(username) &&
                    otpRecord.getOtp().equals(otp) &&
                    LocalDateTime.now().isBefore(otpRecord.getExpiresAt())) {
                System.out.println("OTP match found, removing record");
                otps.remove(otpRecord);
                return true;
            }
        }
        System.out.println("No valid OTP found for username: " + username);
        return false;
    }
}