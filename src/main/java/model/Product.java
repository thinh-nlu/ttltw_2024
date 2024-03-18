package model;

import java.sql.Time;
import java.sql.Timestamp;
import java.util.Date;

public class Product {
    private int id;
    private String title;
    private String price;
    private String unit;
    private String image;
    private String categoryId;
    private String keyword;
    private Timestamp timestamp;
    private String quantity;
    private String status;
    private String unitPrice;
    private String descript;


    public Product() {}

    public Product(String title, String price, String unit, String image, String categoryId, String keyword, String quantity, String status, String unitPrice, String descript) {
        this.title = title;
        this.price = price;
        this.unit = unit;
        this.image = image;
        this.categoryId = categoryId;
        this.keyword = keyword;
        this.quantity = quantity;
        this.status = status;
        this.unitPrice = unitPrice;
        this.descript = descript;

    }

    public Product(int id, String title, String price, String unit, String image, String categoryId, String keyword, Timestamp timestamp, String quantity, String status, String unitPrice) {
        this.id = id;
        this.title = title;
        this.price = price;
        this.unit = unit;
        this.image = image;
        this.categoryId = categoryId;
        this.keyword = keyword;
        this.timestamp = timestamp;
        this.quantity = quantity;
        this.status = status;
        this.unitPrice = unitPrice;
    }


    public String getDescription() {
        return descript;
    }

    public void setDescription(String descript) {
        this.descript = descript;
    }
    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    public String getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(String unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public Timestamp getDateInsert() {
        return timestamp;
    }

    public void setDateInsert(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", price='" + price + '\'' +
                ", unit='" + unit + '\'' +
                ", image='" + image + '\'' +
                ", categoryId='" + categoryId + '\'' +
                ", keyword='" + keyword + '\'' +
                ", timestamp=" + timestamp +
                ", quantity='" + quantity + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
