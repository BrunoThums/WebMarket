<%@page import="apoio.Formatacao"%>
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
    </head>
    <body>
       
        <h1 style="text-align: center;padding-top: 40px">Listagem de Categorias</h1>

        <%
            ArrayList<Categoria> listCateg = new CategoriaDao().consultarTodos();
        %>
        
        <div class="table-responsive" style="text-align: center;">
            <table class="table table-striped table-sm">
                <th>Editar</th>
                <th>Excluir</th>
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
                    <td><a href='/WebMarket/Categoria?param=editarCategoria&id=<%= c.id%>'><i class="far fa-edit center"></i></a></td>
                    <td><a href='/WebMarket/Categoria?param=excluirCategoria&id=<%= c.id%>'><i class="far fa-trash-alt"></i></a></td>
                    <td><%= c.descricao%></td>
                    <td><%= Formatacao.ajustaDataDMA(String.valueOf(c.criado_em)) %></td>
                    <td><%= Formatacao.ajustaDataDMA(String.valueOf(c.atualizado_em)) %></td>
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
        <a href='/WebMarket/index.jsp' style="text-align: center;">Voltar</a>
    </body>
</html> 
