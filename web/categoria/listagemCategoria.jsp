<%@page import="dao.CategoriaDao"%>
<%@page import="entidade.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" 
              integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" 
              crossorigin="anonymous" />
        <title>XL - Categorias</title>
    </head>
    <body>
        <h1>Listagem de Categorias</h1>

        <form method="post" action="/WebMarket/pesquisa?param=pesquisar">

            <input type="search" name="busca" placeholder="Faça o filtro">

            <input type="submit" value="Pesquisar">

        </form>
        <%
            ArrayList<Categoria> listCateg = new CategoriaDao().consultarTodos();
        %>

        <div class="table-responsive">
            <table class="table table-striped table-sm">
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

                <tr>
                    <td><a href='/WebMarket/Categoria?param=edCategoria&id=<%= c.id%>'><i class="far fa-edit center"></i></a></td>
                    <td><a href='/WebMarket/Categoria?param=exCategoria&id=<%= c.id%>'><i class="far fa-trash-alt"></i></a></td>
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
        <br>
        <br>
        <a href='/WebMarket/index.jsp'>Voltar</a>
    </body>
</html>
