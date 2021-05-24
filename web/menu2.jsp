<%@page import="entidade.Pessoa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="checkLogin.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <!-- Bootstrap core CSS -->
        <%--<link href="/WebMarket/css/bootstrap.min.css" rel="stylesheet">
        <link href="/WebMarket/css/navbar.css" rel="stylesheet">--%>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            ul {
                list-style-type: none;
                margin: 0;
                padding: 0;
                overflow: hidden;
                background-color: #333;
            }

            li {
                float: left;
            }

            li a, .dropbtn {
                display: inline-block; <%--mostra o menu horizontalmente--%>
                color: white;
                text-align: center;
                padding: 14px 16px;
                text-decoration: none;
            }

            li a:hover, .dropdown:hover .dropbtn {
                background-color: red;
            }

            li.dropdown {
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #f9f9f9;
                min-width: 160px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
            }

            .dropdown-content a {
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
                text-align: left;
            }

            .dropdown-content a:hover {background-color: #f1f1f1;}

            .dropdown:hover .dropdown-content {
                display: block;
            }
        </style>
    </head>
    <%@include file="logo.jsp" %>
    <link rel="stylesheet" 
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" 
          crossorigin="anonymous" />
    <body>
        <%            Pessoa p = new Pessoa();
        %>
        <ul class="topnav">
            <li><a class="active" href="/WebMarket/index.jsp">XingoLingo</a></li>
            <li><a href="#news">News</a></li>
            <li><a href="#contact">Contact</a></li>
            <li class="dropdown">
                <a href="javascript:void(0)" class="dropbtn">Cadastros</a>
                <div class="dropdown-content">
                    <a href="/WebMarket/categoria/categoria.jsp">Categoria</a>
                    <a href="pesquisa.jsp"">Pesquisar</a>
                    <a href="#">Link 3</a>
                </div>
            <li class="right"><a href="#about">About</a></li>
            <li class="nav-item dropdown center">
                <a class="nav-link dropdown-toggle center" 
                   href="#" 
                   id="dropdown04" 
                   data-bs-toggle="dropdown" 
                   aria-expanded="false">
                    <i class="fas fa-user-alt center"></i></a>
                <ul class="dropdown-menu" aria-labelledby="dropdown04">


                    <%
                        String user = (String) session.getAttribute("email");
                    %>

                    <li>
                        <a class="dropdown-item" 
                           href="/WebMarket/deslogar.jsp">
                            Deslogar
                        </a>
                    </li>

                    <li><a class="dropdown-item" href="/WebMarket/pessoa/cadastroLogin.jsp">Cadastro</a></li>
                </ul>
        </ul>

    </body>
</html>
