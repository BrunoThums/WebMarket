<%@page import="dao.CategoriaDao"%>
<%@page import="entidade.Categoria"%>
<%@page import="dao.ProdutoDao"%>
<%@page import="entidade.Produto"%>
<%@page import="java.util.ArrayList"%>
<%@include file="../menu/menu.jsp" %>
<html>
    <head>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
            google.charts.load('current', {'packages': ['bar']});
            google.charts.setOnLoadCallback(drawChart);
            <%ArrayList<Produto> listProd = new ProdutoDao().consultarTodos();%>
            function drawChart() {
                var data = google.visualization.arrayToDataTable([
                    ['Nome', 'Valor', 'Estoque'],
            <%  if (listProd == null) {
                    out.print("Não há produtos para listar");
                } else {
                    for (int i = 0; i < listProd.size(); i++) {
                        Produto prod = listProd.get(i);
                        Categoria c = new CategoriaDao().consultarId(prod.id_categoria);%>
                    ['<%=prod.nome%>', <%=prod.valor%>, '<%=prod.estoque%>'],
            <%}%>
                ]);
            <%}%>

                var options = {
                    chart: {
                        title: 'Relação Preço/Estoque'
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