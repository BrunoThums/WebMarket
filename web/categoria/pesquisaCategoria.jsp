<%@page import="entidade.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../menu/menu.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>XingoLingo</title>
    </head>
    <body>

        <h1 style="text-align: center;">Pesquisa de categorias</h1>
        <form method="post" style="text-align: center;" action="/WebMarket/pesquisa?param=pesquisar">

            <input type="text" name="busca" placeholder="Pesquisa senhor" >

            <input type="submit" value="Pesquisar">


        </form>

        <%            ArrayList<Categoria> listCateg = (ArrayList) request.getAttribute("categoriasPesquisa");
        %>

        <div class="table-responsive" style="text-align: center; padding-top: 20px; width: 90%; margin: auto" >
            <table class="table table-bordered table-striped table-sm">
                <th>Editar</th>
                <th>Excluir</th>
                <th>Id</th>
                <th>Descrição</th>
                <th>Criado Em</th>
                <th>Atualizado Em</th>
                <th>Ativo</th>
                    <%
                        if (listCateg == null) {
                            out.print("Não há categorias para listar");
                        } else {
                            for (int i = 0; i < listCateg.size(); i++) {
                                Categoria c = listCateg.get(i);
                    %>

                <tr >
                    <td><a href='/WebMarket/Categoria?param=editarCategoria&id=<%= c.id%>'><i class="far fa-edit center"></i></a></td>
                    <td><a href='/WebMarket/Categoria?param=excluirCategoria&id=<%= c.id%>'><i class="far fa-trash-alt"></i></a></td>
                    <td><%= c.id%></td>                
                    <td><%= c.descricao%></td>
                    <td><%= c.criado_em%></td>
                    <td><%= c.atualizado_em%></td>
                    <td><%= c.ativo%></td>
                </tr>
                <%
                        }
                    }
                %>

            </table>
        </div>
    </body>
</html>
