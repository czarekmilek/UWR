package org.zad5alpha;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "noticeServlet", value = "/notice-servlet")
public class NoticeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        InputStream is = getServletContext().getResourceAsStream("/WEB-INF/notice.txt");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (is == null) {
            out.println("<h1>Błąd: Plik notice.txt nie został znaleziony.</h1>");
            return;
        }

        BufferedReader reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8));
        String line;
        boolean isFirstLine = true;
        boolean fileHasContent = false;

        while ((line = reader.readLine()) != null) {
            if (line.trim().isEmpty()) {
                continue;
            }
            fileHasContent = true;
            if (isFirstLine) {
                out.println("<h1>" + line + "</h1>");
                isFirstLine = false;
            } else {
                out.println("<p>" + line + "</p>");
            }
        }

        if (!fileHasContent) {
            out.println("<h1>Błąd: Plik notice.txt jest pusty.</h1>");
        }
    }
}
