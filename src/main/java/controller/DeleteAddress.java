package controller;


import dao.AddressDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/deleteAddress")
public class DeleteAddress extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int addressId = Integer.parseInt(req.getParameter("id"));
        AddressDAO addressDAO = new AddressDAO(DBConnect.getConnection());
        boolean success = addressDAO.deleteAddressById(addressId);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write("{\"success\":" + success + "}");

    }
}

