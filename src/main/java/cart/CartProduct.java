package cart;

import dao.ProductDAO;
import database.DBConnect;
import model.Product;

import java.util.HashMap;
import java.util.Map;

public class CartProduct {

    Map<Integer, Cart> data = new HashMap<>();
    ProductDAO dao = new ProductDAO(DBConnect.getConnection());

    public boolean add(int id){
        return this.add(id,1);
    }

    public boolean add(int id, int quantity) {
        Product product = dao.getProductById(id);
        if(product == null || Integer.parseInt(product.getQuantity()) == 0) return false;
        Cart cart = null;
        if(data.containsKey(id)){
            cart = data.get(id);
            cart.increaseQuantity(quantity);
        } else {
            cart = new Cart(product,quantity);
        }
        data.put(id,cart);
        return true;
    }

    public int getTotal() {
        return data.size();
    }

    public Map<Integer, Cart> getData() {
        return data;
    }

    public void setData(Map<Integer, Cart> data) {
        this.data = data;
    }

    public void removeProduct(int key) {
        this.data.remove(key);
    }

    public double totalPriceAllProduct() {
        double total = 0.0;
        for(Map.Entry<Integer, Cart> entry: data.entrySet()) {
            Product product = entry.getValue().getProduct();
            double price = Double.parseDouble(product.getPrice());
            double discount = product.getDiscount();
            double discountedPrice = price - (price * discount / 100);
            total += entry.getValue().getQuantity() * discountedPrice;
        }
        return total;
    }

    public static void main(String[] args) {
        CartProduct cartProduct = new CartProduct();
        System.out.println(cartProduct.totalPriceAllProduct());
    }
}
