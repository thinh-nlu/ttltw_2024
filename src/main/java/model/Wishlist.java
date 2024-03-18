package model;

import java.sql.Timestamp;


public class Wishlist {

    private int id;
    private int user_id;
    private int product_id ;
    private Timestamp timestamp;

    public Wishlist() {
    }

    public Wishlist(int id, int user_id, int product_id, Timestamp timestamp) {
        this.id = id;
        this.user_id = user_id;
        this.product_id = product_id;
        this.timestamp = timestamp;
    }

    public Wishlist(int user_id, int product_id, Timestamp timestamp) {
        this.user_id = user_id;
        this.product_id = product_id;
        this.timestamp = timestamp;
    }
    public Wishlist(int user_id, int product_id) {
        this.user_id = user_id;
        this.product_id = product_id;

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    @Override
    public String toString() {
        return "Wishlist{" +
                "id=" + id +
                ", user_id=" + user_id +
                ", product_id=" + product_id +
                ", timestamp=" + timestamp +
                '}';
    }
}
