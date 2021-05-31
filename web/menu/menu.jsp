<%@page import="dao.PessoaDao"%>
<%@page import="entidade.Pessoa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../checkLogin.jsp" %>
<%@include file="../logo.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css'>
        <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.0/animate.min.css'>
        <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css'>
        <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.4/css/tether.min.css'>
        <link rel="stylesheet" href="/WebMarket/menu/menu.css">
        <title>XingoLingo</title>

        <!--musicão padrão de shopping-->
        <!--<div id="player">
            <audio autoplay hidden>
                <source src="/WebMarket/menu/elevador.mp3" type="audio/mp3">
                If you're reading this, audio isn't supported. 
            </audio>
        </div>-->

    </head>
    <body>
        <%String nome = "";%>
        <%Pessoa p = new Pessoa();%>
        <!-- partial:index.partial.html -->
        <div id="wrapper">
            <div class="overlay"></div>

            <!-- Sidebar -->
            <nav class="navbar navbar-inverse fixed-top" id="sidebar-wrapper" role="navigation">
                <ul class="nav sidebar-nav">
                    <div class="sidebar-header">
                        <div class="sidebar-brand">
                            <a href="/WebMarket/index.jsp">XingoLingo</a>
                        </div>
                    </div>
                    <%
                        HttpSession sessao = ((HttpServletRequest) request).getSession();
                        Pessoa pessoa = (Pessoa) sessao.getAttribute("usuarioLogado");
                        if (pessoa != null) {
                            pessoa = new PessoaDao().consultarEmail(pessoa.email);
                            nome = pessoa.nome;
                        }
                    %>
                    <li class="dropdown">
                        <a href="" class="dropdown-toggle #usuario"  data-toggle="dropdown"> <%= nome%> <span class="caret"></span></a>
                        <ul class="dropdown-menu animated fadeInLeft" role="menu">
                            <div class="dropdown-header"></div>
                            <li><a href="/WebMarket/deslogar.jsp" class="#deslogar">Deslogar</a></li>
                            <li><a href="/WebMarket/pessoa/dadosConta.jsp" class="#conta">Minha Conta</a></li>
                        </ul>
                    </li>
                    <li><a href="/WebMarket/index.jsp" class="#home">Página Inicial</a></li>
                    <!--
                    <li class="dropdown">
                        <a href="" class="dropdown-toggle #cadastro"  data-toggle="dropdown">Cadastros <span class="caret"></span></a>
                        <ul class="dropdown-menu animated fadeInLeft" role="menu">
                            <div class="dropdown-header"></div>
                            <li><a href="/WebMarket/categoria/categoria.jsp" class="#categoria">Categoria</a></li>
                        </ul>
                    </li>
                    -->
                    <li><a href="/WebMarket/categoria/categoria.jsp" class="#categoria">Categoria</a></li>
                    <li><a href="/WebMarket/produto/cadastroProduto.jsp" class="#produto">Produto</a></li>
                    <li class="dropdown">
                        <a href="" class="dropdown-toggle #pesquisar"  data-toggle="dropdown"> Pesquisa<span class="caret"></span></a>
                        <ul class="dropdown-menu animated fadeInLeft" role="menu">
                            <div class="dropdown-header"></div>

                            <li><a href="/WebMarket/categoria/pesquisaCategoria.jsp" class="#pesqCategoria">Categoria</a></li>
                            <li><a href="/WebMarket/produto/listagemProduto.jsp" class="#pesqProduto">Produto</a></li>
                        </ul>
                    </li>
                    <!--<a href="/WebMarket/categoria/categoria.jsp" class="#categoria">Categoria</a></li>-->
                    <li><a href="/WebMarket/categoria/categoria.jsp" class="#carrinho">Carrinho</a></li>
                    <li><a href="/WebMarket/pessoa/listagemPessoas.jsp" class="#usuarios">Usuários</a></li>
                </ul>
            </nav>
            <!-- /#sidebar-wrapper -->

            <!-- Page Content -->
            <div id="page-content-wrapper">
                <button type="button" class="hamburger animated fadeInLeft is-closed" data-toggle="offcanvas">
                    <span class="hamb-top"></span>
                    <span class="hamb-middle"></span>
                    <span class="hamb-bottom"></span>
                </button>
            </div>

            <!-- /#page-content-wrapper -->

        </div>
        <!-- /#wrapper -->
        <!-- partial -->
        <script src='https://code.jquery.com/jquery-3.3.1.slim.min.js'></script>
        <script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js'></script>
        <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js'></script>
        <script src='https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.4/js/tether.min.js'></script>
        <script  src="/WebMarket/menu/menu.js"></script>

    </body>
</html>
