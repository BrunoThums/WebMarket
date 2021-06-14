<%@page import="dao.ProdutoDao"%>
<%@page import="entidade.Produto"%>
<%@page import="java.util.ArrayList"%>
<%@include file="../menu/menu.jsp" %>
<html>
    <head>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <%ArrayList<Produto> listProd = new ProdutoDao().consultaAvancada("", "Y", "");%>
        <script type="text/javascript">
            google.charts.load('current', {'packages': ['corechart']});
            google.charts.setOnLoadCallback(drawChart);

            function drawChart() {

                var data = google.visualization.arrayToDataTable([
                    ['Task', 'Hours per Day'],
            <%  if (listProd == null) {
                    out.print("Não há produtos para listar");
                } else {
                    for (int i = 0; i < listProd.size(); i++) {
                        Produto c = listProd.get(i);
            %>
                    ['<%=c.nome%>', <%=c.estoque%>],
            <%}%>
                ]);
            <%}%>

                var options = {
                    title: 'Relação de Estoque de Produtos'
                };

                var chart = new google.visualization.PieChart(document.getElementById('piechart'));

                chart.draw(data, options);
            }
        </script>
    </head>
    <body>
        <div id="piechart" style="width: 900px; height: 500px;"></div>
        <div class="text-center">
            <a class="a" href="../index.jsp">Voltar</a> 
        </div>
    </body>
</html>