<%-- 
    Document   : login
    Created on : 29 de mar. de 2021, 19:26:01
    Author     : Usuario
--%>

<%@page import="entidade.Pessoa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
        <meta name="generator" content="Hugo 0.80.0">
        <title>XL - Login</title>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">



        <!-- Bootstrap core CSS -->
        <link href="/WebMarket/css/bootstrap.min.css" rel="stylesheet">

        <!-- Favicons -->
        <link rel="apple-touch-icon" href="/docs/5.0/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
        <link rel="icon" href="/docs/5.0/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
        <link rel="icon" href="/docs/5.0/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
        <link rel="mask-icon" href="/docs/5.0/assets/img/favicons/safari-pinned-tab.svg" color="#7952b3">
        <link rel="icon" href="/docs/5.0/assets/img/favicons/favicon.ico">
        <meta name="theme-color" content="#7952b3">


        <style>
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
            #msgErroLogin {
                color: #0c4128;
            }

            a, a:hover {
                width: 100%;
                color: blue;
                text-decoration: none;
                font-size: 20px;
            }

        </style>


        <!-- Custom styles for this template -->
        <link href="/WebMarket/css/signin.css" rel="stylesheet">
    </head>
    <body class="text-center">

        <main class="form-signin">
            <form method="post" action="/WebMarket/acao?param=login">            

                <h1 class="h3 mb-3 fw-normal">Autenticação</h1>

                <h2>XingoLingo</h2>
                <br>
                <label for="inputEmail" 
                       class="visually-hidden">Email address</label>
                <input type="email" 
                       name="email" 
                       id="email" 
                       class="form-control" 
                       placeholder="Email" 
                       required autofocus>

                <label for="inputPassword" 
                       class="visually-hidden">
                    Password
                </label>
                <input type="password" 
                       name="senha" 
                       id="senha" 
                       class="form-control" 
                       placeholder="Senha" required>
                <button class="w-100 btn btn-lg btn-dark" 
                        type="submit" 
                        value="logar">
                    
                    Acessar</button>   
                
                



                <div class="text-center">
                    <a class="w-100 btn btn-lg btn-blue" href="pessoa/cadastroLogin.jsp">Cadastrar-se</a>
                </div>


                <p class="mt-5 mb-3 text-muted">&copy;XingoLingo 2021</p>
            </form>
        </main>

    </body>

</html>

