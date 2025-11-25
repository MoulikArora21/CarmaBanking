package arora.moulik.springboot.carma;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

@SpringBootTest
@TestPropertySource(properties = {
        "spring.mail.host=",
        "spring.mail.username=",
        "spring.mail.password=",
        "twilio.account.sid=",
        "twilio.auth.token=",
        "twilio.phone.number="
})
class CarmawebappApplicationTests {

    @Test
    void contextLoads() {
    }

}