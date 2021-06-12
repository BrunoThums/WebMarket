<%@page import="dao.ItemCarrinhoDao"%>
<%@page import="dao.CarrinhoDao"%>
<%@page import="entidade.ItemCarrinho"%>
<%@page import="dao.CategoriaDao"%>
<%@page import="entidade.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProdutoDao"%>
<%@page import="entidade.Produto"%>
<%@page import="apoio.Formatacao"%>
<%@page contentType="text/html" pageEncoding="ISO8859-1"%>
<%@include file="/menu/menu.jsp" %>
<%@include file="logo.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <style>
            body {
                <%--Plano de Fundo do mimi --%>
                background-image: url(https://f.vividscreen.info/soft/d33549e3dd89507ecc202498f7810d22/Cat-Gamer-1920x1200.jpg);
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: 100% 100%;
            }
        </style>

        <% ArrayList<Produto> prod = new ProdutoDao().consultarTodos();
            ItemCarrinho item = new ItemCarrinho();
            ArrayList<ItemCarrinho> itens = new ArrayList(Produto);
            request.setAttribute("itens", itens);
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" 
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" 
              crossorigin="anonymous" />

        <title>XingoLingo</title>
    </head>
    <body>
        <div class="wrapper">
            <%
                if(itens == null){
                    System.out.println("No tienes nada no carrito");
                }
                if (prod == null) {
                    System.out.println("No tienes productos");
                } else {
                    for (int i = 0; i < prod.size(); i++) {

                        Produto prodt = prod.get(i);
                        Categoria c = new CategoriaDao().consultarId(prodt.id_categoria);
            %>
            <% String isEstoque = "";
                if (prodt.estoque == 0) {
                    isEstoque = "Indispon�vel";
                } else {
                    isEstoque = "Comprar";
                }
            %>


            <%=item.id=prodt.id%>
            <div class="outer" onclick="<%=itens.add(prodt.id,prodt.)%>location = '/WebMarket/produto/paginaProduto.jsp?id=<%= prodt.id%>'">
                <div class="content animated fadeInLeft" >

                    <span class="bg animated fadeInDown"><%=c.descricao%></span>
                    <h5><%=prodt.nome%></h5>

                    <div class="button">
                        <%
                            if (prodt.estoque == 0 || prodt.ativo.equals("N")) {
                        %>
                        <a>R$ <%=String.format("%.2f", prodt.valor)%></a><a class="cart-btn"><i class="alert-danger ion-bag "style="margin-right: 5px"></i >Indispon�vel</a>
                        <%} else {%>
                        <a href="/WebMarket/produto/cadastroProduto">R$ <%=String.format("%.2f", prodt.valor)%></a><a class="cart-btn" href="/WebMarket/checkout/checkout?insertProd&id= <%= prodt.id %>"><i class="cart-icon ion-bag"></i>Adicione ao Carrinho</a>
                        <%}%>
                    </div>

                </div>
                <img src="<%=prodt.file%>" width="200px" class="animated fadeInRight">
            </div>
            <%}
                }%>
        </div>
    </body>
    <link rel="stylesheet" href='https://fonts.googleapis.com/css?family=Montserrat'>
    <link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css'>
    <link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css'>
    <link rel="stylesheet" href="/WebMarket/card/card.css">
</html>
