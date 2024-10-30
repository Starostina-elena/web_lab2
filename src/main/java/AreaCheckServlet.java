import com.google.gson.Gson;
import models.ResultRow;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Map;

@WebServlet("/check")
public class AreaCheckServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        java.util.Date startDate = new java.util.Date();

        double x = 0;
        double y = 0;
        double r = 0;
        try {
            x = Double.parseDouble(request.getParameter("x"));
            y = Double.parseDouble(request.getParameter("y"));
            r = Double.parseDouble(request.getParameter("r"));

            if (x > 2 || x < -2 || y < -3 || y > 5 || r < 2 || r > 5) {
                throw new NumberFormatException("Invalid arguments");
            }

            DateFormat df = new SimpleDateFormat("dd.MM.yyyy HH:mm:ss");
            ResultRow resultRow = new ResultRow(x, y, r, df.format(startDate));

            ServletContext servletContext = request.getServletContext();
            if(servletContext.getAttribute("resultTable") == null) {
                servletContext.setAttribute("resultTable", new ArrayList<ResultRow>());
            }
            ArrayList<ResultRow> resultTable = (ArrayList<ResultRow>) servletContext.getAttribute("resultTable");

            resultTable.add(resultRow);
            if (resultTable.size() > 10) {
                resultTable.remove(0);
            }

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(new Gson().toJson(Map.of("data", resultRow, "new request:", "http://localhost:34350/lab2/main")));
        } catch (NumberFormatException | NullPointerException e) {
            response.setStatus(400);
            response.getWriter().write(new Gson().toJson(Map.of("error", "Illegal argument")));
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(400);
            System.out.println(new Gson().toJson(Map.of("error", "Internal Server Error")));
            response.getWriter().write(new Gson().toJson(Map.of("error", "Internal Server Error")));
        }
    }

}
