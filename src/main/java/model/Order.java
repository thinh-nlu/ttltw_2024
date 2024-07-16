package model;

import java.sql.Timestamp;

public class Order {
    private int id;
    private int userId;
    private String invoiceNumber;
    private String amountDue;
    private Timestamp orderDate;
    private String orderStatus;

    private int addressId;

    private  String addressShipStatus;

    public Order() {}

    public Order(int id, int userId, String invoiceNumber, String amountDue, Timestamp orderDate, String orderStatus) {
        this.id = id;
        this.userId = userId;
        this.invoiceNumber = invoiceNumber;
        this.amountDue = amountDue;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
    }

    public Order(int userId, String invoiceNumber, String amountDue, Timestamp orderDate, String orderStatus) {
        this.userId = userId;
        this.invoiceNumber = invoiceNumber;
        this.amountDue = amountDue;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
    }

    public Order(int userId, String invoiceNumber, String amountDue, Timestamp orderDate, String orderStatus, int addressId) {
        this.userId = userId;
        this.invoiceNumber = invoiceNumber;
        this.amountDue = amountDue;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.addressId = addressId;
    }

    public String getAddressShipStatus() {
        return addressShipStatus;
    }

    public void setAddressShipStatus(String addressShipStatus) {
        this.addressShipStatus = addressShipStatus;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getInvoiceNumber() {
        return invoiceNumber;
    }

    public void setInvoiceNumber(String invoiceNumber) {
        this.invoiceNumber = invoiceNumber;
    }

    public String getAmountDue() {
        return amountDue;
    }

    public void setAmountDue(String amountDue) {
        this.amountDue = amountDue;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", userId=" + userId +
                ", invoiceNumber='" + invoiceNumber + '\'' +
                ", amountDue='" + amountDue + '\'' +
                ", orderDate=" + orderDate +
                ", orderStatus='" + orderStatus + '\'' +
                ", addressId=" + addressId +
                ", addressShipStatus='" + addressShipStatus + '\'' +
                '}';
    }
}
