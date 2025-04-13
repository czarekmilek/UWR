package org.zad6servlety;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "kula-servlet", value = "/kula-servlet")
public class KulaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Pobieranie parametru r z adresu URL
        String rParam = request.getParameter("r");
        if (rParam == null || rParam.trim().isEmpty()) {
            // Jeśli parametr nie podany
            out.println("<html><body>");
            out.println("<h3>Użycie: dodaj parametr 'r' do adresu URL, np.: ?r=3.14</h3>");
            out.println("</body></html>");
            return;
        }

        double r;
        try {
            r = Double.parseDouble(rParam);
        } catch (NumberFormatException e) {
            // Jeśli parametr nie jest liczbą
            out.println("<html><body>");
            out.println("<h3>Błędny format danych. Podaj liczbę jako wartość promienia kuli.</h3>");
            out.println("</body></html>");
            return;
        }

        if (r < 0) {
            // Jeśli parametr jest liczbą ujemną
            out.println("<html><body>");
            out.println("<h3>Niepoprawna wartość: promień nie może być ujemny.</h3>");
            out.println("</body></html>");
            return;
        }

        // Obliczanie objętości i pola kuli
        double volume = (4.0 / 3.0) * Math.PI * Math.pow(r, 3);
        double surface = 4 * Math.PI * Math.pow(r, 2);

        // Generowanie odpowiedzi HTML
        out.println("<html><body>");
        out.println("<h2>Wyniki obliczeń dla kuli o promieniu: " + r + "</h2>");
        out.println("<p>Objętość: " + volume + "</p>");
        out.println("<p>Pole powierzchni: " + surface + "</p>");

        String author = getServletContext().getInitParameter("authorName");
        String email = getServletContext().getInitParameter("authorEmail");
        out.println("<hr/>");
        out.println("<p>Autor: " + author + "<br/>Email: " + email + "</p>");
        out.println("</body></html>");
    }
}
