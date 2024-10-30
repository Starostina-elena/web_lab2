<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.ResultRow" %>
<%
    // Получаем данные из контекста приложения
    ArrayList<ResultRow> resultTable = (ArrayList<ResultRow>) application.getAttribute("resultTable");
%>
<html>
<head>
    <title>Lab2</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="style.css">
</head>
<body>
<header>
    <div>
        <p>
        <h1 id="about-me">Старостина Елена Петровна, P3219, ИСУ 414257. Вариант 34350</h1>
        </p>
    </div>
</header>
<main>
    <div class="image-container">
    <svg width="300px" height="300px" onclick="svgHandler(event)" class="svgClass" id="graphSvg">
        <line x1="0" x2="300" y1="150" y2="150" stroke="#343548"></line>
        <line x1="150" x2="150" y1="0" y2="300" stroke="#343548"></line>
        <polygon points="150,0 145,10 155,10" stroke="#343548"></polygon>
        <polygon points="300,150 290,145 290,155" stroke="#343548"></polygon>
        <path d="M150,250 A100,100 90 0,1 50,150 L 150,150 Z" fill="#87CEEB"></path>
        <polygon points="150,150 150,100 50,100 50,150" fill="#87CEEB"></polygon>
        <polygon points="250,150 150,200 150,150" fill="#87CEEB"></polygon>

        <line x1="50" x2="50" y1="145" y2="155" stroke="#343548"></line>
        <line x1="100" x2="100" y1="145" y2="155" stroke="#343548"></line>
        <line x1="200" x2="200" y1="145" y2="155" stroke="#343548"></line>
        <line x1="250" x2="250" y1="145" y2="155" stroke="#343548"></line>

        <line x1="145" x2="155" y1="50" y2="50" stroke="#343548"></line>
        <line x1="145" x2="155" y1="100" y2="100" stroke="#343548"></line>
        <line x1="145" x2="155" y1="200" y2="200" stroke="#343548"></line>
        <line x1="145" x2="155" y1="250" y2="250" stroke="#343548"></line>

        <text x="290" y="140">X</text>
        <text x="155" y="10">Y</text>
        <text x="40" y="138">-R</text>
        <text x="85" y="138">-R/2</text>
        <text x="190" y="138">R/2</text>
        <text x="245" y="138">R</text>
        <text x="162" y="54">R</text>
        <text x="162" y="104">R/2</text>
        <text x="162" y="204">-R/2</text>
        <text x="162" y="254">-R</text>
        <%
            if (resultTable != null) {
                for (int i = 0; i < resultTable.size(); i++) {
        %>
        <circle class="shot" cx="<%= 150 + 50 * 2/ resultTable.get(i).getR() * resultTable.get(i).getX() %>"
                cy="<%= 150 - 50 * 2/ resultTable.get(i).getR() * resultTable.get(i).getY() %>" r="2"
                fill="orangered" stroke-width="0"></circle>
        <%
                }
            }
        %>
                </svg>
                </div>
                <form id="dataForm">
                    <p class="form-block">
                        Выберите X
                        <input id="-2" type="checkbox" class="x">
                        <label for="-2">-2</label>
                        <input id="-1.5" type="checkbox" class="x">
                        <label for="-1.5">-1.5</label>
                        <input id="-1" type="checkbox" class="x">
                        <label for="-1">-1</label>
                        <input id="-0.5" type="checkbox" class="x">
                        <label for="-0.5">-0.5</label>
                        <input id="0" type="checkbox" class="x">
                        <label for="0">0</label>
                        <input id="0.5" type="checkbox" class="x">
                        <label for="0.5">0.5</label>
                        <input id="1" type="checkbox" class="x">
                        <label for="1">1</label>
                        <input id="1.5" type="checkbox" class="x">
                        <label for="1.5">1.5</label>
                        <input id="2" type="checkbox" class="x">
                        <label for="2">2</label>
                    </p>
                    <p class="form-block">
                        Введите Y
                        <input type="text" id="y">
                    </p>
                    <p class="form-block">
                        Введите R
                        <input type="text" id="r">
                    </p>
                    <p><input type="submit" class="form-block"></p>
                </form>
                <table id="history">
                    <tr id="table-first-row">
                        <th>X</th>
                        <th>Y</th>
                        <th>R</th>
                        <th>Время</th>
                        <th>Результат</th>
                    </tr>
                    <%
                        if (resultTable != null) {
                            for (int i = 0; i < resultTable.size(); i++) {
                    %>
                    <tr>
                        <td><%= resultTable.get(i).getX() %></td>
                        <td><%= resultTable.get(i).getY() %></td>
                        <td><%= resultTable.get(i).getR() %></td>
                        <td><%= resultTable.get(i).getStartTime() %></td>
                        <% if (resultTable.get(i).isHit()) {
                            %>
                        <td>Да</td>
                        <%
                        } else {
                            %>
                        <td>Нет</td>
                        <%
                        }
                        %>
                    </tr>
                    <%
                        }
                        }
                    %>
                </table>
            </main>
            <script type="text/javascript" src="main.js"></script>
</body>
</html>
