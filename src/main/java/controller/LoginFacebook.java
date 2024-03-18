package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.Parameter;
import com.restfb.Version;
import dao.UserDAO;
import database.DBConnect;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Constants;
import com.restfb.types.User;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;


import java.io.IOException;
@WebServlet("/login_facebook")
public class LoginFacebook extends HttpServlet {

    private static final long serialVersionUID = 1L;
    public LoginFacebook() {
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
            User user = getUserInfo(accessToken);
            String name = user.getName();
            model.User user1 = new model.User(name,"","","","2","1");
            if (userDAO.isFbUser(name)&&userDAO.isUsernameExist(name)){
                session.setAttribute("success",user1);
                response.sendRedirect("index.jsp");
            }else {
                userDAO.registerUser(user1);
                session.setAttribute("success",user1);
                response.sendRedirect("index.jsp");
            }
        }

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    public static String getToken(final String code) throws ClientProtocolException, IOException {
        String link = String.format(Constants.FACEBOOK_LINK_GET_TOKEN, Constants.FACEBOOK_APP_ID, Constants.FACEBOOK_APP_SECRET, Constants.FACEBOOK_REDIRECT_URL, code);
        String response = Request.Get(link).execute().returnContent().asString();
        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }
    public static User getUserInfo(String accessToken) {
        FacebookClient facebookClient = new DefaultFacebookClient(accessToken, Constants.FACEBOOK_APP_SECRET, Version.LATEST);
        return facebookClient.fetchObject("me", User.class, Parameter.with("fields", "id,name,email"));

    }
}
