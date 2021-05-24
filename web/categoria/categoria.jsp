

<%@page import="entidade.Categoria"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../menu.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" 
              content="text/html; charset=UTF-8">
        
        <title>XL Categoria</title>
    </head>
    <body>
        
        <%--Categoria --%>
        <%
            Categoria cat = new Categoria();

                cat.id = 0;
                cat.descricao = "";
                cat.ativo="";
        %>

        <h1>Cadastro de Categorias</h1>

        <form style="padding: 20px" 
              name='formCateg' 
              method='post' 
              action='/WebMarket/Categoria?param=salvarCategoria';

            <input type="hidden" 
            name="id" 
            id="id"
            value=
            <%= cat.id%>>


            <input type="text" 
                   name="descricao" 
                   id="descricao"
                   placeholder="Descrição" 
                   value="<%= cat.descricao%>">
            
            <br>
            <input type ="hidden"
                   name="ativo"
                   id="ativo"
                   value="<%="Y"%>">
            <input type="submit" 
                   value="salvar">

            <br>
            <br>
            <br>
            <%@include file = "listagemCategoria.jsp" %>
        </form>
    </body>
</html>
