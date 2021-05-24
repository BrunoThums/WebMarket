<%@page import="apoio.Formatacao"%>
<%@page contentType="text/html" pageEncoding="ISO8859-1"%>
<%@include file="menu.jsp" %>
<%@include file="logo.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <style>
            <%--Plano de Fundo Carrinho de Compras --%>
            body {
                background-image: url(https://img.ibxk.com.br/2020/04/03/03141525284452.jpg?w=1120&h=420&mode=crop&scale=both);
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: 100% 100%;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" 
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" 
              crossorigin="anonymous" />
        <title>XingoLingo</title>
    </head>
    <body>
        <h1 style="color: blue;padding-left:12px">Navegue pelas seções:</h1>
        <ul>
            <a href ='pessoa/listagemPessoas.jsp'><img src="users.png" alt="Usuários" style="width:32px;height:32px;margin-bottom: 10px"></a>
            <a href='pessoa/listagemPessoas.jsp' title="Usuários" style="font-size: 32px">Usuários</a>
            <br>
            <a href='categoria/categoria.jsp'><img src="tags.png" alt="Categorias" style="width:32px;height:32px;margin-bottom: 10px"></a>
            <a href='categoria/categoria.jsp' title="Categorias" style="font-size: 32px">Categorias</a>
        </a>
        </ul>
        
    </body>
</html>
