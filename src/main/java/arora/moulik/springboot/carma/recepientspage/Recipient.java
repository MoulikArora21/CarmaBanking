package arora.moulik.springboot.carma.recepientspage;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;

@Entity
public class Recipient {
	@jakarta.persistence.Id
	@GeneratedValue
	private Integer id;
    private String username; // The recipient's username
    private String addedBy; // The username of the user who added this recipient

    public Recipient(String username, String addedBy) {
        this.username = username;
        this.addedBy = addedBy;
    }
    
    public Recipient() {}

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getAddedBy() {
        return addedBy;
    }

    public void setAddedBy(String addedBy) {
        this.addedBy = addedBy;
    }
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}
