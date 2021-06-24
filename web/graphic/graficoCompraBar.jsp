<%@page import="apoio.Formatacao"%>
<%@page import="apoio.ConexaoBD"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="dao.CompraDao"%>
<%@page import="entidade.Compra"%>
<%@page import="dao.CategoriaDao"%>
<%@page import="java.util.ArrayList"%>
<%@include file="../menu/menu.jsp" %>
<html>
    <head>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
            google.charts.load('current', {'packages': ['bar']});
            google.charts.setOnLoadCallback(drawChart);
            <%ArrayList<Compra> listCompra = new CompraDao().consultarTodos();%>
            function drawChart() {
                var data = google.visualization.arrayToDataTable([
                    ['Data', 'Valor'], ...[
            <%  if (listCompra == null) {
                    out.print("Não há produtos para listar");
                } else {
                    String sql
                            = "SELECT compra.created_at AS data, "
                            + "SUM(compra.valorTotal) AS total "
                            + "FROM compra "
                            + "GROUP BY compra.created_at "
                            + "HAVING SUM(compra.valorTotal) > 0 "
                            + "ORDER BY data DESC "
                            + "LIMIT 7";

                    ResultSet res = ConexaoBD.getInstance().getConnection().createStatement().executeQuery(sql);
                    while (res.next()) {%>
                    ['<%=Formatacao.ajustaDataDMA(String.valueOf(res.getDate("data")))%>',<%=res.getLong("total")%>],
            <%}
                }%>

            ].reverse()]);

                var options = {
                    chart: {
                        title: 'Relação de compras'
                    },
                    bars: 'vertical' // Required for Material Bar Charts.
                };

                var chart = new google.charts.Bar(document.getElementById('barchart_material'));

                chart.draw(data, google.charts.Bar.convertOptions(options));
            }
        </script>
    </head>
    <body>
        <div id="barchart_material" style="width: 900px; height: 500px;"></div>
        <div class="text-center">
            <a class="a" href="../index.jsp">Voltar</a> 
        </div>
    </body>
</html>