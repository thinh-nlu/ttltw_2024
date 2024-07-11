package model;

import com.ip2location.IP2Location;
import com.ip2location.IPResult;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;

public class IPAddressUtil {
    public static String getPublicIPAddress() {
        String ip = "";
        try {
            CloseableHttpClient httpClient = HttpClients.createDefault();
            HttpGet request = new HttpGet("https://api.ipify.org?format=json");

            JSONObject jsonObject;
            try (CloseableHttpResponse response = httpClient.execute(request)) {
                String jsonResponse = EntityUtils.toString(response.getEntity());
                jsonObject = new JSONObject(jsonResponse);
            }

            ip = jsonObject.getString("ip");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ip;
    }

    public static void main(String[] args) {

            try {
                String ip = IPAddressUtil.getPublicIPAddress();
                System.out.println("Public IP: " + ip);

                IP2Location loc = new IP2Location();
                loc.Open("src/main/webapp/WEB-INF/ipAddress.mmdb"); // Thay đường dẫn tới file cơ sở dữ liệu

                IPResult rec = loc.IPQuery(ip);
                if ("OK".equals(rec.getStatus())) {
                    System.out.println("Country: " + rec.getCountryShort() + " (" + rec.getCountryLong() + ")");
                } else {
                    System.out.println("Error: " + rec.getStatus());
                }
            } catch (Exception e) {
                e.printStackTrace();
            }



    }
}
