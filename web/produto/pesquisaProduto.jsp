<%@page import="dao.ProdutoDao"%>
<%@page import="dao.CategoriaDao"%>
<%@page import="apoio.Formatacao"%>
<%@page import="entidade.Produto"%>
<%@page import="entidade.Categoria"%>
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
            boolean ativo = "on".equals(request.getParameter("ativo"));
            String value = request.getParameter("ordem");
            String ordem = "";
            if ("ASC".equals(value)) {
                ordem = "ASC";
            } else {
                ordem = "DESC";
            }
        %>
        <h1 style="text-align: center;">Pesquisa de produtos</h1>
        <form method="get" style="text-align: center;" action="/WebMarket/produto/pesquisaProduto.jsp">
            <input type="text" name="busca" value="<%= busca%>" placeholder="Pesquisa senhor">
            <input type="submit" value="Pesquisar">
            <br>
            <div style="margin-left: -15%; margin-top: 0.25%">
                <label style="">Ativo?
                    <input type="checkbox" <%=ativo ? "checked" : ""%> name="ativo"></input></label>
            </div>
            <form style="align-content: center; align-self: flex-end; display: grid">

                <label><input type="radio" name="ordem" <%="ASC".equals(ordem) ? "checked" : ""%> value="ASC">Crescente</label>
                <label><input type="radio" name="ordem" <%="DESC".equals(ordem) ? "checked" : ""%> value="DESC">Decrescente</label>

            </form>
        </form>

        <%
            ArrayList<Produto> listProd = new ProdutoDao().consultaAvancada(busca, ativo ? "Y" : "N", ordem);
        %>

        <div class="table-responsive" style="text-align: center; padding-top: 20px; width: 90%; margin: auto" >
            <table class="table table-bordered table-striped table-sm">
                <th>Editar</th>
                <th>Excluir</th>
                <th>Id</th>
                <th>Categoria</th>
                <th>Nome</th>
                <th>Valor</th>
                <th>Estoque</th>
                <th>Ativo</th>
                    <%  if (listProd == null) {
                            out.print("NAO CONTEM NADA");
                        } else {
                            for (int i = 0; i < listProd.size(); i++) {
                                Produto prod = listProd.get(i);
                    %>

                <tr class="table-light">
                    <td><a href='/WebMarket/srvProduto?param=editarProduto&id=<%= prod.id%>'><i class="far fa-edit center"></i></a></td>
                    <td><a href='/WebMarket/srvProduto?param=excluirProduto&id=<%= prod.id%>'><i class="far fa-trash-alt"></i></a></td>
                    <td><%= prod.id%></td>   
                    <% Categoria cat = new CategoriaDao().consultarId(prod.id_categoria);%>
                    <td><%= cat.descricao%></td>
                    <td><%= prod.nome%></td>
                    <td><%= Formatacao.formatarDecimal(prod.valor)%></td>
                    <td><%= prod.estoque%></td>
                    <td><%= prod.ativo%></td>
                </tr>
                <%
                        }
                    }
                %>

            </table>
        </div>
        <a href="/WebMarket/index.jsp" class="link-light" style="align-self: center; justify-content: center">Voltar</a>
    </body>
</html>
