<%@page import="dao.CompraDao"%>
<%@page import="entidade.Compra"%>
<%@page import="apoio.Formatacao"%>
<%@page import="javax.xml.crypto.Data"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../menu/menu.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" 
              integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" 
              crossorigin="anonymous" />
        <title>XingoLingo</title>
    </head>
    <body>
        <%  String busca = request.getParameter("busca");
            if (busca == null) {
                busca = "";
            }
        %>
        <h1 style="text-align: center;">Pesquisa de Compras</h1>
        <form method="get" style="text-align: center;" action="/WebMarket/compra/pesquisaCompra.jsp">

            <input type="text" name="busca" value="<%= busca%>" placeholder="Pesquise" >

            <input type="submit" value="Pesquisar">

        </form>

        <h1 style="text-align: center;padding-top: 40px">Listagem de Compras</h1>

        <%
                ArrayList<Compra> listaCompra = new CompraDao().consultaAvancada(busca);
        %>

        <div class="table-responsive" style="text-align: center;">
            <table class="table table-striped table-sm">
                <!--<th>Editar</th>-->
                <!--<th>Excluir</th>-->
                <th>Cliente</th>
                <th>Parcelas</th>
                <th>Valor</th>
                <th>Criado Em</th>
                    <%
                        if (listaCompra == null) {
                            out.print("Não há vendas para listar");
                        } else {
                            for (int i = 0; i < listaCompra.size(); i++) {
                                Compra c = listaCompra.get(i);
                                Pessoa pessoas = new PessoaDao().consultarId(c.id_pessoa);
                    %>

                <tr>
                    <!--<td><a href='/WebMarket/Compra?param=editarCategoria&id=<%= c.id%>'><i class="far fa-edit center"></i></a></td>-->
                    <!--<td><a href='/WebMarket/Compra?param=excluirCategoria&id=<%= c.id%>'><i class="far fa-trash-alt"></i></a></td>-->
                    <td><%= pessoas.nome%></td>
                    <td><%= c.parcelas%></td>
                    <td><%= Formatacao.formatarDecimal(c.valorTotal)%></td>
                    <td><%= Formatacao.ajustaDataDMA(String.valueOf(c.created_at))%></td>
                </tr>
                <%
                        }
                    }
                %>

            </table>
        </div>
    </body>
</html>
