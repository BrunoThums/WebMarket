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
                    ['Data', 'parcelas', 'Valor', 'Nome'],
            <%  if (listCompra == null) {
                    out.print("Não há produtos para listar");
                } else {
                    for (int i = 0; i < listCompra.size(); i++) {
                        Compra compra = listCompra.get(i);
                        Pessoa pe = new PessoaDao().consultarId(compra.id_pessoa);%>
                    ['<%=compra.created_at%>', <%=compra.parcelas%>, <%=compra.valorTotal%>, '<%=pe.nome%>'],
            <%}%>
                ]);
            <%}%>

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