package model;

import java.sql.Timestamp;

public class User {
    private int id;
    private String name;
    private String email;
    private String password;
    private String contact;
    private String isAdmin;
    private Timestamp timestamp;
    private String isActive;

    private String address;

    private String ip;



    public User(){}

    public User(String name, String email, String password, String contact, String isAdmin, String isActive) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.contact = contact;
        this.isAdmin = isAdmin;
        this.isActive = isActive;
    }

    public User(String name, String email, String password, String contact, String isAdmin, String isActive, String address, String ip) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.contact = contact;
        this.isAdmin = isAdmin;
        this.isActive = isActive;
        this.address = address;
        this.ip = ip;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(String isAdmin) {
        this.isAdmin = isAdmin;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    public String getAddress() {return address;}

    public void setAddress(String address) {this.address = address;}
    public String getIsActive() {return isActive;}

    public void setIsActive(String isActive) {
        this.isActive = isActive;
    }

    public String getIp() {return ip;}

    public void setIp(String ip) {this.ip = ip;}

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", contact='" + contact + '\'' +
                ", isAdmin='" + isAdmin + '\'' +
                ", timestamp=" + timestamp +
                '}';
    }
}
