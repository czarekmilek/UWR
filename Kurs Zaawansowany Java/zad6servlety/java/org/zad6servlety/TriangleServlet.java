package org.zad6servlety;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "triangle-servlet", value = "/triangle-servlet")
public class TriangleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        // Domyślne wartości a, b, c
        String defaultA = getServletConfig().getInitParameter("defaultA");
        String defaultB = getServletConfig().getInitParameter("defaultB");
        String defaultC = getServletConfig().getInitParameter("defaultC");

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Generowanie formularza
        out.println("<html><body>");
        out.println("<h2>Wprowadź długości boków trójkąta</h2>");
        out.println("<form action=\"/zad6servlety/triangle-servlet\" method=\"post\">");
        out.println("Bok A: <input type='number' step='0.1' min='0.1' name='a' value='" + defaultA + "'/><br/><br/>");
        out.println("Bok B: <input type='number' step='0.1' min='0.1' name='b' value='" + defaultB + "'/><br/><br/>");
        out.println("Bok C: <input type='number' step='0.1' min='0.1' name='c' value='" + defaultC + "'/><br/><br/>");
        out.println("<input type='submit' value='Oblicz'/>");
        out.println("</form>");
        out.println("</body></html>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Pobieranie danych z formularza
        String aStr = request.getParameter("a");
        String bStr = request.getParameter("b");
        String cStr = request.getParameter("c");

        double a, b, c;
        try {
            a = Double.parseDouble(aStr);
            b = Double.parseDouble(bStr);
            c = Double.parseDouble(cStr);
        } catch (NumberFormatException e) {
            out.println("<html><body>");
            out.println("<h3>Błędny format danych. Upewnij się, że podajesz liczby.</h3>");
            out.println("</body></html>");
            return;
        }

        if (a <= 0 || b <= 0 || c <= 0) {
            out.println("<html><body>");
            out.println("<h3>Błędne wartości: długości boków muszą być dodatnie.</h3>");
            out.println("</body></html>");
            return;
        }

        // Sprawdzenie, czy suma długości dowolnych dwóch boków jest większa od trzeciego
        if (a + b <= c || a + c <= b || b + c <= a) {
            out.println("<html><body>");
            out.println("<h3>Dane nie spełniają nierówności trójkąta. Upewnij się, że najdłuższy bok jest krótszy od sumy dwóch pozostałych.</h3>");
            out.println("</body></html>");
            return;
        }

        // Obliczenia
        double perimeter = a + b + c;
        double s = perimeter / 2; // połowa obwodu
        double area = Math.sqrt(s * (s - a) * (s - b) * (s - c)); // wzór Herona

        // Generowanie odpowiedzi HTML
        out.println("<html><body>");
        out.println("<h2>Wyniki obliczeń dla trójkąta</h2>");
        out.println("<p>Obwód: " + perimeter + "</p>");
        out.println("<p>Pole powierzchni: " + area + "</p>");

        String author = getServletContext().getInitParameter("authorName");
        String email = getServletContext().getInitParameter("authorEmail");
        out.println("<hr/>");
        out.println("<p>Autor: " + author + "<br/>Email: " + email + "</p>");
        out.println("</body></html>");
    }
}
