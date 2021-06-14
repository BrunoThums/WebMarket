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

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" 
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" 
              crossorigin="anonymous" />

        <title>XingoLingo</title>
    </head>
    <body>
        <%  String categoria = request.getParameter("categoria");
            String pesquisa = request.getParameter("pesquisa");
        %>
                <div class="col-lg-12 card-margin">
                    <form id="search-form" method="get" action='/WebMarket/index.jsp'>
                        <%ArrayList<Categoria> listCateg = new CategoriaDao().consultaAvancada("Y");%>
                        <div class="row">
                            <div class="col-12">
                                <div class="row no-gutters">
                                    <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                                        <select class="form-control" name="categoria" id="exampleFormControlSelect1">
                                            <option value="tudo">Tudo</option>
                                            <%for (int i = 0; i < listCateg.size(); i++) {
                                                    Categoria c = listCateg.get(i);%>
                                            <option value="<%=c.id%>" <%= Integer.toString(c.id).equals(categoria) ? "selected" : ""%>><%=c.descricao%></option>
                                            <%}%>
                                        </select>
                                    </div>
                                    <div class="col-lg-8 col-md-6 col-sm-12 p-0">
                                        <input type="text" placeholder="Digite o que procuras..." value="<%=pesquisa == null ? "" : pesquisa%>" class="form-control" id="search" name="pesquisa">
                                    </div>
                                    <div class="col-lg-1 col-md-3 col-sm-12 p-0">
                                        <button type="submit" class="btn btn-base">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search">
                                            <circle cx="11" cy="11" r="8"></circle>
                                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                                            </svg>
                                        </button>
                            </div>
                    </form>
                </div>
            </div>
        </div>
        <%
            ArrayList<Produto> prod = new ProdutoDao().consultaCriteriosa(pesquisa, categoria, "ASC");
        %>
        <div class="wrapper">
            <%
                if (prod == null) {
                    System.out.println("No tienes productos");
                } else {
                    for (int i = 0; i < prod.size(); i++) {

                        Produto prodt = prod.get(i);
                        Categoria c = new CategoriaDao().consultarId(prodt.id_categoria);
            %>
            <% String isEstoque = "";
                if (prodt.estoque == 0) {
                    isEstoque = "Indisponível";
                } else {
                    isEstoque = "Comprar";
                }
            %>

            <script>
                function addToCart(id) {
                    fetch(`/WebMarket/cart?param=insertProd&id=\${id}`, {method: 'post'});
                    swal({
                        title: "YEY!",
                        text: "O produto foi adicionado ao carrinho!",
                        icon: "success",
                        button: false,
                        timer: 1500
                    });
                }
            </script>

            <div class="outer">
                <div class="content animated fadeInLeft" >

                    <span class="bg animated fadeInDown"><%=c.descricao%></span>
                    <h5><%=prodt.nome%></h5>

                    <div class="button">
                        <%
                            if (prodt.estoque == 0 || prodt.ativo.equals("N")) {
                        %>
                        <a>R$ <%=String.format("%.2f", prodt.valor)%></a><a class="cart-btn"><i class="alert-danger ion-bag "style="margin-right: 5px"></i >Indisponível</a>
                        <%} else {%>
                        <a>R$ <%=String.format("%.2f", prodt.valor)%></a><a class="cart-btn" onclick="addToCart('<%=prodt.id%>')"><i class="cart-icon ion-bag"></i>Adicione ao Carrinho</a>
                        <%}%> 
                    </div>
                </div>
                <img src="<%=prodt.file%>" onclick="location = '/WebMarket/produto/paginaProduto.jsp?id=<%=prodt.id%>'" width="200px" class="animated fadeInRight">

            </div>
            <%}%>
            <%}%>
        </div>
    </body>
    <link rel="stylesheet" href='https://fonts.googleapis.com/css?family=Montserrat'>
    <link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css'>
    <link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css'>
    <link rel="stylesheet" href="/WebMarket/card/card.css">
</html>
