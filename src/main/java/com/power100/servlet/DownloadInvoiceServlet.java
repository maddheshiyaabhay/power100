package com.power100.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.power100.util.DBConnection;
import java.sql.*;

public class DownloadInvoiceServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=invoice_" + orderId + ".pdf");

        try {
            Connection conn = DBConnection.getConnection();

            // PDF banane ka kaam
            OutputStream out = response.getOutputStream();
            Document document = new Document();
            PdfWriter.getInstance(document, out);
            document.open();

            // Logo
            String logoPath = getServletContext().getRealPath("/images/logo.png");
            Image logo = Image.getInstance(logoPath);
            logo.scaleToFit(100, 100);
            logo.setAlignment(Element.ALIGN_CENTER);
            document.add(logo);

            // Title
            Paragraph title = new Paragraph("Invoice for Order #" + orderId,
                    new Font(Font.FontFamily.HELVETICA, 20, Font.BOLD));
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);
            document.add(new Paragraph(" "));

            // Database se order details
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT o.id, o.total_amount, o.order_date, oa.fullname, oa.phone, oa.address, oa.city, oa.state, oa.pincode " +
                            "FROM orders o JOIN order_address oa ON o.id = oa.order_id WHERE o.id = ?");
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                document.add(new Paragraph("Customer: " + rs.getString("fullname")));
                document.add(new Paragraph("Phone: " + rs.getString("phone")));
                document.add(new Paragraph("Address: " + rs.getString("address") + ", " +
                        rs.getString("city") + ", " + rs.getString("state") + " - " + rs.getString("pincode")));
                document.add(new Paragraph("Order Date: " + rs.getTimestamp("order_date")));
                document.add(new Paragraph("Total Amount: ₹" + rs.getDouble("total_amount")));
                document.add(new Paragraph(" "));
            }

            // Footer
            Paragraph footer = new Paragraph("Thank you for shopping with POWER100!",
                    new Font(Font.FontFamily.HELVETICA, 12, Font.ITALIC));
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);

            document.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}