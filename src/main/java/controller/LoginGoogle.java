package controller;

import dao.UserDAO;
import database.DBConnect;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.http.HttpSession;
import model.User;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;
import org.apache.http.client.fluent.Form;
import model.Constants;
import model.UserGoogle;

import java.io.IOException;

@WebServlet("/loginGoogle")
public class LoginGoogle extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public LoginGoogle() {
        super();
    }

    UserDAO userDAO = new UserDAO(DBConnect.getConnection());
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
            RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
            dis.forward(request, response);
        } else {
            String accessToken = getToken(code);
            UserGoogle googlePojo = getUserInfo(accessToken);
            String name = googlePojo.getName();
            String email = googlePojo.getEmail();
            User googleuser = new User(name,email,"","","2","1");
            if (!userDAO.isEmailExists(email)){
                userDAO.registerUser(googleuser);
                session.setAttribute("success",googleuser);
                response.sendRedirect("index.jsp");
            }else if (userDAO.isEmailExists(email)&&userDAO.isPasswordNull(email)){
                session.setAttribute("success",googleuser);
                response.sendRedirect("index.jsp");
            }else {
                session.setAttribute("failed","Email này đã được liên kết với một tên đăng nhập");
                response.sendRedirect("account/login.jsp");
            }

        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    public static String getToken(String code) throws ClientProtocolException, IOException {
        // call api to get token
        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI).add("code", code)
                        .add("grant_type", Constants.GOOGLE_GRANT_TYPE).build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

    public static UserGoogle getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();

        UserGoogle googlePojo = new Gson().fromJson(response, UserGoogle.class);
        System.out.println(googlePojo);

        return googlePojo;
    }



}
