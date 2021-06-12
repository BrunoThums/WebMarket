<%@page import="dao.ProdutoDao"%>
<%@page import="entidade.Produto"%>
<%@include file="../menu/menu.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>
        <%  Produto prod = null;
            try {
                Integer id = Integer.parseInt(request.getParameter("id"));
                if (id == null) {
                    throw new RuntimeException();
                }
                prod = new ProdutoDao().consultarId(id);
                if (prod == null) {
                    throw new RuntimeException();
                }
            } catch (Exception e) {
                response.sendRedirect("/WebMarket/index.jsp");
            }

        %>

        <style>
            body {
                <%--Plano de Fundo do produto, em repetição, tamanho 1%--%>
                background-image: url(<%= prod.file%>);
                background-repeat: repeat;
                background-attachment: scroll;
                background-size: 1%;
            }
        </style>
        <div class="container mt-5 mb-5">
            <div class="card">
                <div class="row g-0">
                    <div class="col-md-6 border-end" style="padding-top: 50px; padding-bottom: 50px; padding-left:50px">
                        <div class="d-flex justify-content-center">
                            <div class="main_image"> <img src=<%=prod.file%> id="main_product_image" width="350"> </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="p-3 right-side" style="height: 100%;display: flex;flex-direction: column;justify-content: space-around; background-color: #ecedee">
                            <div class="d-flex justify-content-between align-items-center">
                                <h3><%=prod.nome%></h3> <span class="heart"><i class='bx bx-heart'></i></span>
                            </div>
                            <div class="mt-2 pr-3 content">
                                <p><%=prod.descricao%></p>
                            </div>
                            <h3 style="padding-top:80px;">R$<%=String.format("%.2f",prod.valor)%></h3>
                            <% String isEstockOrIndisponible = "";
                                String isCartOrAdvise = "";
                                if (prod.estoque == 0) {
                                    isEstockOrIndisponible = "Indisponível";
                                    isCartOrAdvise = "Avise-me";
                           
                                } else {
                                isEstockOrIndisponible = "Comprar";
                                isCartOrAdvise = "Colocar no Carrinho";
                            }%>
                            <div class="buttons d-flex flex-row mt-5 gap-3" > <button class="btn btn-outline-dark"><%= isEstockOrIndisponible%></button>

                            <button class="btn btn-dark" style="margin-left: 5px;"><%= isCartOrAdvise%> </button></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<body>
</html>