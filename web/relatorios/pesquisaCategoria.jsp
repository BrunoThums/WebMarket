

<%@page import="java.util.ArrayList"%>
<%@page import="entidade.Categoria"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="/WebMarket/css/bootstrap.min.css" rel="stylesheet">
        <title>Pesquisa de Categorias</title>
    </head>
    <body>
        <%@include file="../menu/menu.jsp" %>
        <style>
            .pesquisa {
                display: flex;
                width: 100%;
                align-items: center;
                flex-direction: column;
            }

            .titulo {
                width: 100%;
                text-align: center;
            }
            .btn-pesquisar, .inpPes {
                margin-top: 15px;
                width: 25%;
                height: 48px;
            }

            h2 {
                margin-top: 1.5em;
                width: 100%;
                text-align: center;
            }

            .table {
                width: 70%;
                margin: auto;
                border: 1px solid;
                border-radius: 10px 5%;
            }


        </style>


        <h1 class="titulo" >Pesquisa de categorias</h1>

        <form class="pesquisa" method="post" action="/WebMarket/pesquisa?param=pesquisar">

            <input class="form-control inpPes" type="text" name="busca" placeholder="Digite o que deseja pesquisar">

            <button type="submit" class="btn btn-lg btn-dark btn-pesquisar">Pesquisar</button>

        </form>

        <%            ArrayList<Categoria> categs = (ArrayList) request.getAttribute("categoriasPesquisa");
            // testar se obj esta nulo.
            // quando viemos do Menu (direto), não há obj em categoriasPesquisa, logo, o cast será NULL
            if (categs != null) {

                if (categs.size() == 0) {
        %>  
        <p>Nenhum resultado encontrado.</p>

        <%
        } else {
        %>
        <h2>Resultados</h2>

        <div class="table-responsive">
            <table class="table table-sm table-bordered">
                <th>Id</th>
                <th>Descrição</th>
                <th>Criado Em</th>
                <th>Atualizado Em</th>                                
                    <%
                        for (int i = 0; i < categs.size(); i++) {
                            Categoria categ = categs.get(i);
                    %>
                <tr class="table-light">
                    <td><%= categ.id%></td>                
                    <td><%= categ.descricao%></td>
                    <td><%= categ.criado_em%></td>
                    <td><%= categ.atualizado_em%></td>
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
