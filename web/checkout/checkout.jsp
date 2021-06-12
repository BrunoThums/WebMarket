<%@page import="entidade.ItemCarrinho"%>
<%@page import="java.util.ArrayList"%>
<%@include file="/menu/menu.jsp" %>
<%@page import="dao.ProdutoDao"%>
<%@page import="entidade.Produto"%>
<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>
        <%
            ArrayList<ItemCarrinho> items = (ArrayList<ItemCarrinho>) request.getAttribute("itens");
            /*  Carrinho cart = null;
            try {
                Integer id = Integer.parseInt(request.getParameter("id"));
                if (id == null) {
                    throw new RuntimeException();
                }
                cart = new CarrinhoDao().consultarId(id);
                if (cart == null) {
                    throw new RuntimeException();
                }
            } catch (Exception e) {
                response.sendRedirect("/WebMarket/index.jsp");
            }*/

        %>
    </body>
<style>
            body {
                <%--Plano de Fundo do mimi --%>
                background-image: url(https://www.flixxy.com/grocery-shopping-cats-image10.jpg);
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: 100% 100%;
            }
        </style>
<div class="container mt-5 mb-5">
    <div class="d-flex justify-content-center row">
        <div class="col-md-8" style="background-color: #ecedee">
            <div class="p-2">
                <h4>Shopping cart</h4>
            <div class="d-flex flex-row justify-content-between align-items-center p-2 bg-white mt-4 px-3 rounded">
                <div class="mr-1"><img class="rounded" src="https://i.imgur.com/XiFJkhI.jpg" width="70"></div>
                <div class="d-flex flex-column align-items-center product-details"><span class="font-weight-bold">Basic T-shirt</span>
                    <div class="d-flex flex-row product-desc">
                        <div class="size mr-1"><span class="text-grey">Descrição</span><span class="font-weight-bold"> xxx</span></div>
                    </div>
                </div>
                <div class="d-flex flex-row align-items-center qty"><i class="fa fa-minus text-danger"></i>
                    <h5 class="text-grey mt-1 mr-1 ml-1">1</h5><i class="fa fa-plus text-success"></i>
                </div>
                <div>
                    <h5 class="text-grey">$20.00</h5>
                </div>
                <div class="d-flex align-items-center"><i class="fa fa-trash mb-1 text-danger"></i></div>
            </div>
                
            
            <div class="d-flex flex-row align-items-center mt-3 p-2 bg-white rounded"><input type="text" class="form-control border-0 gift-card" placeholder="discount code/gift card"><button class="btn btn-outline-warning btn-sm ml-2" type="button">Apply</button></div>
            <div class="d-flex flex-row align-items-center mt-3 p-2 bg-white rounded"><button class="btn btn-warning btn-block btn-lg ml-2 pay-button" type="button">Proceed to Pay</button></div>
        </div>
    </div>
</div>
<link href='https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css'>
<script src='https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js'></script>
<link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'>
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
<script  src="/WebMarket/checkout/checkout.css"></script>