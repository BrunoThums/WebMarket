<%@page import="dao.CategoriaDao"%>
<%@page import="apoio.Formatacao"%>
<%@page import="entidade.Categoria"%>
<%@page import="dao.ProdutoDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidade.Produto"%>
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

        <h1 class="h3 mb-3 fw-normal" >Listagem de Produtos</h1>

        <%
            ArrayList<Produto> listProd = new ProdutoDao().consultaAvancada("", "Y", "");


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
                            out.print("Não há produtos para listar");
                        } else {
                            for (int i = 0; i < listProd.size(); i++) {
                                Produto c = listProd.get(i);
                    %>

                <tr class="table-light">
                    <td><a href='/WebMarket/srvProduto?param=editarProduto&id=<%= c.id%>'><i class="far fa-edit center"></i></a></td>
                    <td><a href='/WebMarket/srvProduto?param=excluirProduto&id=<%= c.id%>'><i class="far fa-trash-alt"></i></a></td>
                    <td><%= c.id%></td>   
                    <% Categoria cat = new CategoriaDao().consultarId(c.id_categoria); %>
                    <td><%= cat.descricao %></td>
                    <td><%= c.nome%></td>
                    <td><%= Formatacao.formatarDecimal(c.valor)%></td>
                    <td><%= c.estoque%></td>
                    <td><%= c.ativo%></td>
                </tr>
                <%
                        }
                    }
                %>

            </table>
        </div>

        <a href="/WebMarket/index.jsp" class="link-light"><button class="btn btn-dark lista" value="Voltar">Voltar</button></a>
    </body>
</html>
