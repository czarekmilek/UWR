package org.zad5alpha;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.GregorianCalendar;

@WebServlet(name = "timeServlet", value = "/time-servlet")
public class TimeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        GregorianCalendar cal = new GregorianCalendar();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head><title>Aktualny czas</title></head>");
        out.println("<body>");
        out.println("<h1>Aktualny czas:</h1>");
        out.println(String.format("<h4>Czas: %1$tH:%1$tM:%1$tS</h4>", cal));
        out.println(String.format("<h4>Data: %1$td-%1$tm-%1$tY</h4>", cal));
        out.println("</body>");
        out.println("</html>");
    }
}
