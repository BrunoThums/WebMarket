<%@page import="dao.CategoriaDao"%>
<%@page import="apoio.Formatacao"%>
<%@page import="javax.xml.crypto.Data"%>
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
        <%
            String busca = request.getParameter("busca");
            if (busca == null){
                busca="";
            }
            boolean ativo = "on".equals(request.getParameter("ativo"));
        %>
        <h1 style="text-align: center;">Pesquisa de categorias</h1>
        <form method="get" style="text-align: center;" action="/WebMarket/categoria/pesquisaCategoria.jsp">

            <input type="text" name="busca" value="<%= busca %>" placeholder="Pesquisa senhor" >

            <input type="submit" value="Pesquisar">

            <div style="margin-left: -15%; margin-top: 0.25%">
                <label style="">Ativo?
                    <input type="checkbox" <%=ativo ? "checked" : ""%> name="ativo"></input></label>
            </div>
        </form>

            <% ArrayList<Categoria> listCateg = new CategoriaDao().consultaAvancada(busca, ativo ? "Y" : "N");
                    
                        
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
                    <td><%= Formatacao.ajustaDataDMA(String.valueOf(c.criado_em))%></td>
                    <td><%= Formatacao.ajustaDataDMA(String.valueOf(c.atualizado_em))%></td>
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
