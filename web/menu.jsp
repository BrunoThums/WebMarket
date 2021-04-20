<%-- 
    Document   : menu
    Created on : Mar 22, 2021, 8:36:37 PM
    Author     : usuario
--%>
<%@page import="entidade.Pessoa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="checkLogin.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" 
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" 
              integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" 
              crossorigin="anonymous" />
        <title>XingoLingo</title>

        <style>

            .center {
                display: flex;
                justify-content: center;
                align-items: center;
                color: #D3D3D3;
                margin-left: 7px;
            }
            .bd-placeholder-img {
                font-size: 1.125rem;
                text-anchor: middle;
                -webkit-user-select: none;
                -moz-user-select: none;
                user-select: none;
            }

            @media (min-width: 768px) {
                .bd-placeholder-img-lg {
                    font-size: 3.5rem;
                }
            }
        </style>

        <!-- Bootstrap core CSS -->
        <link href="/WebMarket/css/bootstrap.min.css" rel="stylesheet">

        <link href="/WebMarket/css/navbar.css" rel="stylesheet">
    </head>
    <body>
        <%            Pessoa p = new Pessoa();
        %>
        <nav class="navbar navbar-expand-md navbar-dark bg-dark" 
             aria-label="Fourth navbar example">
            <div class="container-fluid">
                <a class="navbar-brand" 
                   href="#">XingoLingo
                </a>
                <button class="navbar-toggler" 
                        type="button" 
                        data-bs-toggle="collapse" 
                        data-bs-target="#navbarsExample04" 
                        aria-controls="navbarsExample04" 
                        aria-expanded="false" 
                        aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon">
                    </span>
                </button>

                <div class="collapse navbar-collapse" 
                     id="navbarsExample04">
                    <ul class="navbar-nav me-auto mb-2 mb-md-0">
                        <li class="nav-item">
                            <a class="nav-link active" 
                               aria-current="page"
                               href="/WebMarket/index.jsp">
                                Início
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" 
                               href="#">
                                Produtos
                            </a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" 
                               href="#" id="dropdown04" 
                               data-bs-toggle="dropdown" 
                               aria-expanded="false">
                                Cadastros
                            </a>
                            <ul class="dropdown-menu" 
                                aria-labelledby="dropdown04">
                                <li>
                                    <a class="dropdown-item" 
                                       href="categoria/categoria.jsp">
                                        Categoria
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" 
                                       href="pesquisa.jsp">
                                        Pesquisar
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <form>
                        <input class="form-control" type="text" placeholder="Search" aria-label="Search">
                    </form>
                    <div>
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
                                       href="deslogar.jsp">
                                        Deslogar
                                    </a>
                                </li>
                                
                                <li><a class="dropdown-item" href="pessoa/cadastroLogin.jsp">Cadastro</a></li>
                            </ul>
                        </li>
                    </div>
                </div>
            </div>
        </nav>

        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    </body>
</html>
