package model;

import java.sql.Timestamp;
import java.util.Date;

public class Feedback {
    private int id;
    private String name;
    private String email;
    private String message;
    private Timestamp created;
    private int productID;

    public Feedback() {
        super();
    }

    public Feedback(int id, String name, String email,String message, Timestamp created, int productID) {
        super();
        this.id = id;
        this.name = name;
        this.email = email;
        this.message = message;
        this.created = created;
        this.productID = productID;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getCreated() {
        return created;
    }

    public void setCreated(Timestamp created) {
        this.created = created;
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public int getProductID() {
        return productID;
    }
    public void setProductID(int productID) {
        this.productID = productID;
    }

    @Override
    public String toString() {
        return "Feedback [id=" + id + ", name=" + name + ", email=" + email + ", message=" + message + ", created="
                + created + ", productID=" + productID + "]";
    }


}
