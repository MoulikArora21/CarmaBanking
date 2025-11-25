package arora.moulik.springboot.carma.register;

import org.hibernate.validator.constraints.UniqueElements;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity(name = "bankers")
public class User {
	@Id
	@GeneratedValue
	private Integer id;

	@NotBlank(message = "Name cannot be empty!")
	private String name;

	@NotBlank(message = "Surame cannot be empty!")
	private String surname;

	@NotBlank(message = "Country cannot be empty!")
	private String country;
	private String address;

	@NotBlank
	@Size(min = 7, max = 15, message = "Invalid Phone number!")
	private String phone_number;

	@Email(message = "Invalid Email!")
	@NotBlank
	@Column(unique = true)
	private String email;

	@NotBlank(message = "Username cannot be empty!")
	@Column(unique = true)
	private String username;
	private String personalid;

	@NotBlank(message = "Password cannot be empty!")
	private String password;

	@Transient
	private String confirm_password;

	private Integer balance;

	@Column(unique = true)
	private String account;

	public User() {
	}

	public User(Integer id, String name, String surname, String country, String address, String phone_number,
			String email,
			String username, String personalid, String password, String confirm_password, Integer balance,
			String account) {
		super();
		this.id = id;
		this.name = name;
		this.surname = surname;
		this.country = country;
		this.address = address;
		this.phone_number = phone_number;
		this.email = email;
		this.username = username;
		this.personalid = personalid;
		this.password = password;
		this.confirm_password = confirm_password;
		this.account = account;
		this.balance = balance;
	}

	public Integer getid() {
		return id;
	}

	public void setid(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone_number() {
		return phone_number;
	}

	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPersonalid() {
		return personalid;
	}

	public void setPersonalid(String personalid) {
		this.personalid = personalid;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirm_password() {
		return confirm_password;
	}

	public void setConfirm_password(String confirm_password) {
		this.confirm_password = confirm_password;
	}

	public Integer getbalance() {
		return balance;
	}

	public void setbalance(Integer balance) {
		this.balance = balance;
	}

	public String getaccount() {
		return account;
	}

	public void setaccount(String account) {
		this.account = account;
	}

}
