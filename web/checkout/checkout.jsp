<%@page import="apoio.Formatacao"%>
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
        <%  HttpSession sessaoo = ((HttpServletRequest) request).getSession();
            ArrayList<ItemCarrinho> prodt = (ArrayList<ItemCarrinho>) sessaoo.getAttribute("cart");
            double subTotal = 0.0;
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
        .descricao{
            font-size: 12px;
        }

        table, td{
            border: 1px solid transparent;

        }

        td{
            vertical-align: middle;   
            padding: 4px 0;
        }

        .produto{
            background-color: #FFF;
            border-radius: 8px;
        }

        table{
            border-spacing: 0 16px;
            border-collapse: separate;
        }
    </style>
    <%
        double valor = 0;
        int quantidade = 0;
    %>
    <div class="container mt-5 mb-5">
        <div class="d-flex justify-content-center row">
            <div class="col-md-8" style="background-color: #ecedee">
                <div class="p-2">
                    <h4>Seu Carrinho</h4>
                    <table>
                        <tbody>

                            <%  if (prodt.size() == 0) {
                                    out.print("<div style='text-align: center; margin: 10px;'>"
                                            + "<span style='font-size: 35px; font-weight: bold;'>"
                                            + "Nenhum Produto Adicionado :("
                                            + "</span>"
                                            + "<div>");
                                } else {
                                    for (int i = 0; i < prodt.size(); i++) {
                                        Produto c = new ProdutoDao().consultarId(prodt.get(i).id_produto);
                                        valor += c.valor;
                            %>
                            <tr class="produto">
                                <td class="imagem">
                                    <img class="rounded" src="<%=c.file%>" width="70">
                                </td>
                                <td class="nome">
                                    <span><%=c.nome%></span>
                                </td>
                                <td class="quantidade" >
                                    <a class="fa fa-minus text-danger" href="/WebMarket/cart?param=qntRemove&id=<%= c.id%>"></a>
                                </td>

                                <td class="quantidade">
                                    <h5 class="text-grey mt-1 mr-1 ml-1"><%= prodt.get(i).quant %></h5>
                                </td>

                                <td class="quantidade">
                                    <a class="fa fa-plus text-success" href="/WebMarket/cart?param=qntInsert&id=<%= c.id%>"></a>
                                </td>


                                <td class="valor" style="padding-left: 20px; padding-right: 20px">
                                    <h5 class="text-grey">R$<%=Formatacao.formatarDecimal(c.valor)%></h5>
                                </td>
                                <td class="apagar">
                                    <a class="fa fa-trash mb-1 text-danger" href="/WebMarket/cart?param=excluirDoCarrinho&id=<%= c.id%>"></a>
                                </td>
                            </tr>



                            <!--<div class="d-flex flex-row align-items-center p-2 bg-white mt-4 px-3 rounded">
                                <div class="mr-1"><img class="rounded" src="<%=c.file%>" width="70"></div>
                                <div class="d-flex flex-column justify-content-lg-start product-details"><span><%=c.nome%></span>
                                </div>
                                <div class="d-flex flex-row align-items-center qty"><i class="fa fa-minus text-danger"></i>
                                    <h5 class="text-grey mt-1 mr-1 ml-1">1</h5><i class="fa fa-plus text-success"></i>
                                </div>
                                <div>
                                    <h5 class="text-grey"><%=c.valor%></h5>
                                </div>
                                <div class="d-flex align-items-center"><a class="fa fa-trash mb-1 text-danger" href=""></a></div>
                            </div>-->
                            <%
                                    }
                                }
                            %>

                        </tbody>    
                    </table>
                    <% if (prodt.size() != 0) {%>
                    <div class="d-flex flex-row align-items-center mt-3 p-2 bg-white rounded"><i type="text" class="form-control border-0 gift-card">Total: R$<%=Formatacao.formatarDecimal(valor)%> ou 12x de R$<%=Formatacao.formatarDecimal(valor / 12)%></i></div>
                    <div class="d-flex flex-row align-items-center mt-3 p-2 bg-white rounded"><button class="btn btn-warning btn-block btn-lg ml-2 pay-button" type="button">Prosseguir para Pagamento</button></div>
                    <%} else {%>
                    <div class="d-flex flex-row align-items-center mt-3 p-2 bg-white rounded"><a class="btn btn-warning btn-block btn-lg ml-2 pay-button" type="button" href="/WebMarket/index.jsp">Experimente adicionar items :D</a></div>
                    <%}%>

                </div>
            </div>
        </div>
        <link href='https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css'>
        <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js'></script>
        <link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'>
        <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
        <script  src="/WebMarket/checkout/checkout.css"></script>