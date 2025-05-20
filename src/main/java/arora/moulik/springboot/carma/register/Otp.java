package arora.moulik.springboot.carma.register;

import java.time.LocalDateTime;

public class Otp {
	private String otp;
	public Otp(String otp, String username, LocalDateTime createdAt, LocalDateTime expiresAt) {
		super();
		this.otp = otp;
		this.username = username;
		this.createdAt = createdAt;
		this.expiresAt = expiresAt;
	}
	private String username;

    private LocalDateTime createdAt;
    private LocalDateTime expiresAt;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getOtp() {
		return otp;
	}
	public void setOtp(String otp) {
		this.otp = otp;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public LocalDateTime getExpiresAt() {
		return expiresAt;
	}
	public void setExpiresAt(LocalDateTime expiresAt) {
		this.expiresAt = expiresAt;
	}
	
    
}
