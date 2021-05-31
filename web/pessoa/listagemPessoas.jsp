<%@page import="dao.PessoaDao"%>
<%@page import="entidade.Pessoa"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <%@include file="../menu/menu.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" 
              integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" 
              crossorigin="anonymous" />
        <title>XL - Pessoas</title>
    </head>
    <body>
        <h1 style="text-align: center;">Listagem de Pessoas</h1>

        <%
            ArrayList<Pessoa> listagemPessoas = new PessoaDao().consultarTodos();
        %>

        <div style="text-align: center";class="table-responsive">
            <table class="table table-striped table-sm">
                <th>Editar</th>
                <th>Excluir</th>
                <th>Id</th>
                <th>Nome</th>
                <th>Email</th>
                <th>Telefone</th>
                <th>Ativo</th>
                    <%
                        if (listagemPessoas == null) {
                            out.print("Não há pessoas para listar");
                        } else {
                            for (int i = 0; i < listagemPessoas.size(); i++) {
                                Pessoa c = listagemPessoas.get(i);
                    %>
                
                <tr>
                    <td><a href='/WebMarket/pessoa/editaConta.jsp?id=<%= c.id%>'><i class="far fa-edit center"></i></a></td>
                    <td><a href='/WebMarket/acao?param=excluirPessoa&id=<%= c.id%>'><i class="far fa-trash-alt"></i></a></td>
                    <td><%= c.id%></td>                
                    <td><%= c.nome%></td>
                    <td><%= c.email%></td>
                    <td><%= c.telefone%></td>
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
        <a href='../index.jsp' style="text-align: center">Voltar</a>
    </body>
</html>
