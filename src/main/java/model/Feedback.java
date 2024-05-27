package model;

import java.sql.Timestamp;
import java.util.Date;

public class Feedback {
    private int id;

    private String message;
    private Timestamp created;
    private int productID;

    public Feedback() {
        super();
    }

    public Feedback(int id, String message, Timestamp created, int productID) {
        super();
        this.id = id;
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

    public int getProductID() {
        return productID;
    }
    public void setProductID(int productID) {
        this.productID = productID;
    }

    @Override
    public String toString() {
        return "Feedback [id=" + id + ", message=" + message + ", created="
                + created + ", productID=" + productID + "]";
    }


}
