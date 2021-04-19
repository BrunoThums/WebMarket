<%-- 
    Document   : pesquisaCategoria
    Created on : 9 de abr. de 2021, 07:03:28
    Author     : Usuario
--%>

<%@page import="servlet.pesquisa"%>
<%@page import="entidade.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="menu.jsp" %>

        <h1>Pesquisa de categorias</h1>

        <form method="post" action="/WebMarket/pesquisa?param=pesquisar">

            <input type="text" name="busca" placeholder="Digite o que deseja pesquisar">
          
            <input type="submit" value="Pesquisar">

        </form>

        <%            ArrayList<Categoria> categoria = (ArrayList) request.getAttribute("categoriasPesquisa");

            // testar se obj esta nulo.
            // quando viemos do Menu (direto), não há obj em categoriasPesquisa, logo, o cast será NULL
            if (categoria != null) {

                if (categoria.size() == 0) {
        %>  
        <p>Nenhum resultado encontrado.</p>

        <%
        } else {
        %>
        <h2>Resultados</h2>

        <div class="table-responsive">
            <table class="table table-striped table-sm">
                <th>Id</th>
                <th>Descrição</th>
                <th>Criado Em</th>
                <th>Atualizado Em</th>
                <th>Ativo</th>

                <%
                    for (int i = 0; i < categoria.size(); i++) {
                        Categoria categ = categoria.get(i);
                %>
                <tr>
                    <td><a href='/WebApp2021A/acao?param=edCategoria&id=<%= categ.id%>'><%= categ.id%></a></td>                
                    <td><%= categ.descricao%></td>
                    <td><%= categ.criado_em%></td>
                    <td><%= categ.atualizado_em%></td>
                    <td><%= categ.ativo%></td>
                </tr>

                <%
                    }
                %>

            </table>
        </div>
        <%
                }
            }
        %>

    </body>
</html>
