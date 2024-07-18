package model;

import java.sql.Timestamp;

public class Warehouse {
    private int id;
    private int productId;

    private int quantity;
    private Timestamp timestamp;

    public Warehouse() {
    }

    public Warehouse(int productId, int quantity) {
        this.productId = productId;
        this.quantity = quantity;
    }

    public Warehouse(int id, int productId, int quantity, Timestamp timestamp) {
        this.id = id;
        this.productId = productId;
        this.quantity = quantity;
        this.timestamp = timestamp;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    @Override
    public String toString() {
        return "Warehouse{" +
                "id=" + id +
                ", productId=" + productId +
                ", quantity=" + quantity +
                ", timestamp=" + timestamp +
                '}';
    }
}
