<%@page import="apoio.Formatacao"%>
<%@page import="dao.ProdutoDao"%>
<%@page import="entidade.Produto"%>
<%@include file="/menu/menu.jsp" %>
<%@page import="entidade.ItemCarrinho"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link href="/WebMarket/checkout/checkout.css" rel="stylesheet">
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    </head>
    <!------ Include the above in your HEAD tag ---------->
    <body>
        <style>
            body {
                <%--Plano de Fundo do mimi --%>
                background-image: url("https://www.thesprucepets.com/thmb/bO7uac9LGqWIkBQ79ekwB_d5JKc=/4368x2912/filters:fill(auto,1)/cat-search-91112434-57d96a3a3df78c58339733a8.jpg");
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: 100% 100%;
            }
        </style>
        
        <script>
            document.addEventListener('readystatechange', () => {
                if (document.readyState !== "complete")
                    return;

                const params = new URL(location.href).searchParams;
                if (params.get('erro') === 'ERRO') {
                    Swal.fire({
                        title: "Houve um Problema!",
                        text: "erro ao comprar o(s) produto(s)",
                        icon: "error",
                        button: "OK"
                    });
                } else if (params.get('erro') === 'NENHUM_PRODUTO') {
                    Swal.fire({
                        title: "Houve um Problema!",
                        text: "Nenhum Produto foi Adicionado ao Carrinho",
                        icon: "error",
                        button: "OK"
                    }).then(() => {
                        location.href = "/WebMarket/index.jsp";
                    });
                    } else if (params.get('certo') === 'COMPRADO') {
                    Swal.fire({
                        title: "Feitoria!",
                        text: "Compra confirmada!",
                        icon: "sucess",
                        button: "YEY!"
                    }).then(() => {
                        location.href = "/WebMarket/index.jsp";
                    });
                }
            });
        </script>
        
        
        <%  HttpSession sessaoo = ((HttpServletRequest) request).getSession();
            ArrayList<ItemCarrinho> prodt = (ArrayList<ItemCarrinho>) sessaoo.getAttribute("cart");
            double subTotal = 0.0;
            double valor = 0;
            int quantidade = 0;
        %>
        <div class="container wrapper">
            <div class="row cart-head">
                <div class="container">
                    <div class="row">
                        <p></p>
                    </div>
                    <div class="row">
                        <div style="display: table; margin: auto;">
                            <span class="step step_complete"> <a href="/WebMarket/index.jsp" class="check-bc">Início</a> <span class="step_line "> </span> <span class="step_line step_complete"> </span> </span>
                            <span class="step step_complete"> <a href="/WebMarket/checkout/cart.jsp" class="check-bc">Carrinho</a> <span class="step_line step_complete"> </span> <span class="step_line backline"> </span> </span>
                        </div>
                    </div>
                    <div class="row">
                        <p></p>
                    </div>
                </div>
            </div>    
            <div class="row cart-body">
                <form class="form-horizontal" method="post" action="/WebMarket/cart?param=compra">
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 col-md-push-6 col-sm-push-6">
                        <!--REVIEW ORDER-->
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                Resumo do Pedido <div class="pull-right"><small><a class="afix-1" href="/WebMarket/checkout/cart.jsp">Editar Carrinho</a></small></div>
                            </div>
                            <div class="panel-body">
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
                                <div class="form-group">
                                    <div class="col-sm-3 col-xs-3">
                                        <img class="img-responsive" src="<%=c.file%>" />
                                    </div>

                                    <div class="col-sm-6 col-xs-6">
                                        <div class="col-xs-12" id="nome" name="nome">
                                            <!--<input type="text" 
                                                   disabled=""
                                                   name="nome" 
                                                   id="nome"
                                                   value="-->
                                            <%= c.nome%>
                                            <!--">-->
                                            <input type="text" 
                                                   hidden=""
                                                   disabled=""
                                                   name="id" 
                                                   id="id"
                                                   value="<%= c.id%>">
                                        </div>
                                        <div class="col-xs-12"><small>Quantidade:<span><%= prodt.get(i).quant%></span></small></div>
                                    </div>
                                    <div class="col-sm-3 col-xs-3 text-right">
                                        <h6><span>R$</span><%=Formatacao.formatarDecimal(c.valor)+" x"+prodt.get(i).quant%></h6>
                                        <input type="text" 
                                                   hidden=""
                                                   disabled=""
                                                   name="valorTotal" 
                                                   id="valorTotal"
                                                   value="<%= valor%>">
                                    </div>
                                </div>
                                <%}%>
                                <%}%>
                                <div class="form-group"><hr/></div>
                                <div class="form-group">
                                    <div class="col-xs-12">
                                        <strong>Subtotal</strong>
                                        <div class="pull-right"><span>R$</span><span><%=Formatacao.formatarDecimal(valor)%></span></div>
                                    </div>
                                    <div class="col-xs-12">
                                        <small>Envio</small>
                                        <div class="pull-right"><span>Gratuito</span></div>
                                    </div>
                                </div>
                                <div class="form-group"><hr /></div>
                                <div class="form-group">
                                    <div class="col-xs-12">
                                        <strong>Total do Pedido</strong>
                                        <div class="pull-right"><span>R$</span><span><%=Formatacao.formatarDecimal(valor)%></span></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--REVIEW ORDER END-->
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 col-md-pull-6 col-sm-pull-6">
                        <!--SHIPPING METHOD-->
                        <div class="panel panel-info">
                            <div class="panel-heading">Endereço</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <h4>Endereço de Entrega</h4>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-6 col-xs-12">
                                        <strong>Nome:</strong>
                                        <input type="text" name="first_name" class="form-control" value="" />
                                    </div>
                                    <div class="span1"></div>
                                    <div class="col-md-6 col-xs-12">
                                        <strong>Sobrenome:</strong>
                                        <input type="text" name="last_name" class="form-control" value="" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12"><strong>País:</strong></div>
                                    <div class="col-md-12">
                                        <input type="text" class="form-control" name="country" value="" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12"><strong>Estado:</strong></div>
                                    <div class="col-md-12">
                                        <input type="text" name="address" class="form-control" value="" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12"><strong>Cidade:</strong></div>
                                    <div class="col-md-12">
                                        <input type="text" name="city" class="form-control" value="" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12"><strong>Endereço:</strong></div>
                                    <div class="col-md-12">
                                        <input type="text" name="state" class="form-control" value="" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12"><strong>CEP:</strong></div>
                                    <div class="col-md-12">
                                        <input type="text" name="zip_code" class="form-control" value="" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12"><strong>Celular:</strong></div>
                                    <div class="col-md-12"><input type="text" name="phone_number" class="form-control" value="" /></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12"><strong>Email:</strong></div>
                                    <div class="col-md-12"><input type="text" name="email_address" class="form-control" value="" /></div>
                                </div>
                            </div>
                        </div>
                        <!--SHIPPING METHOD END-->
                        <!--CREDIT CART PAYMENT-->
                        <div class="panel panel-info">
                            <div class="panel-heading"><span><i class="glyphicon glyphicon-lock"></i></span> Pagamento Seguro</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <div class="col-md-12"><strong>Bandeira</strong></div>
                                    <div class="col-md-12">
                                        <select id="CreditCardType" name="CreditCardType" class="form-control">
                                            <option value="1">Visa</option>
                                            <option value="2">MasterCard</option>
                                            <option value="3">American Express</option>
                                            <option value="4">Hipercard</option>
                                            <option value="5">Elo</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12"><strong>Nº do Cartão:</strong></div>
                                    <div class="col-md-12"><input type="text" class="form-control" name="car_number" value="" /></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12"><strong>CVV:</strong></div>
                                    <div class="col-md-12"><input type="text" class="form-control" name="car_code" value="" /></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <strong>Data de Validade:</strong>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                        <select class="form-control" name="">
                                            <option value="">Mês</option>
                                            <option value="01">01</option>
                                            <option value="02">02</option>
                                            <option value="03">03</option>
                                            <option value="04">04</option>
                                            <option value="05">05</option>
                                            <option value="06">06</option>
                                            <option value="07">07</option>
                                            <option value="08">08</option>
                                            <option value="09">09</option>
                                            <option value="10">10</option>
                                            <option value="11">11</option>
                                            <option value="12">12</option>
                                        </select>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                        <select class="form-control" name="">
                                            <option value="">Ano</option>
                                            <option value="2015">2015</option>
                                            <option value="2016">2016</option>
                                            <option value="2017">2017</option>
                                            <option value="2018">2018</option>
                                            <option value="2019">2019</option>
                                            <option value="2020">2020</option>
                                            <option value="2021">2021</option>
                                            <option value="2022">2022</option>
                                            <option value="2023">2023</option>
                                            <option value="2024">2024</option>
                                            <option value="2025">2025</option>
                                            <option value="2026">2026</option>
                                            <option value="2027">2027</option>
                                            <option value="2028">2028</option>
                                            <option value="2029">2029</option>
                                            <option value="2030">2030</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <strong>Nº de Parcelas:</strong>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                        <select class="form-control" name="parcelas">
                                            <option value="0">Parcelas</option>
                                            <option value="1">1x R$<%=Formatacao.formatarDecimal(valor/1) %></option>
                                            <option value="2">2x R$<%=Formatacao.formatarDecimal(valor/2) %></option>
                                            <option value="3">3x R$<%=Formatacao.formatarDecimal(valor/3) %></option>
                                            <option value="4">4x R$<%=Formatacao.formatarDecimal(valor/4) %></option>
                                            <option value="5">5x R$<%=Formatacao.formatarDecimal(valor/5) %></option>
                                            <option value="6">6x R$<%=Formatacao.formatarDecimal(valor/6) %></option>
                                            <option value="7">7x R$<%=Formatacao.formatarDecimal(valor/7) %></option>
                                            <option value="8">8x R$<%=Formatacao.formatarDecimal(valor/8) %></option>
                                            <option value="9">9x R$<%=Formatacao.formatarDecimal(valor/9) %></option>
                                            <option value="10">10x R$<%=Formatacao.formatarDecimal(valor/10) %></option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <button type="submit" class="btn btn-primary btn-submit-fix">Finalizar Pedido</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--CREDIT CART PAYMENT END-->
            </div>
        </form>
    </div>
</body>
</html>