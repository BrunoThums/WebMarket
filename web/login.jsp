<%@page import="entidade.Pessoa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            body {
                <%--Plano de Fundo do mimi --%>
                background-image: url(https://preview.redd.it/02avbubxp1521.jpg?auto=webp&s=bdbe94267d062cc40d4c93aeb3770d4b8b5368c8);
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: 100% 100%;
            }
        </style>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <!-- Logo na página-->
        <link rel="shortcut icon" href="logo.ico" type="image/x-icon">
        <link rel="icon" href="logo.ico" type="image/x-icon">

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
        <meta name="generator" content="Hugo 0.80.0">

        <title>XL - Login</title>

        <!-- Bootstrap core CSS | Estilização-->
        <link href="/WebMarket/css/bootstrap.min.css" rel="stylesheet">

        <style>
            <%--Sombras no texto--%>
            .a1{
                text-shadow: #FFF 0 -1px 1px, #ff0 0 -1px 1px, #ff8000 0 -1px 2px, red 0 -1px 4px;
                color: rgb(25, 200, 200); 
            }
            @media (min-width: 768px) {
                .bd-placeholder-img-lg {
                    font-size: 3.5rem;
                }
            }
            <%--Sombras no botão--%>    
            button {
                color: #000;
                text-shadow: #FFF 0 -1px 4px, #ff0 0 -2px 10px, #ff8000 0 -10px 20px, red 0 -18px 40px;
            }
            .myButton {
                width: 250px; 
                height: 30px;
                color: rgb(255, 255, 255); 
                font-size: 22px; 
                line-height: 30px; 
                padding: 1px; 
                border-radius: 20px; 
                font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif;
                font-weight: normal;
                text-decoration: none;
                font-style: normal;
                font-variant: normal;
                text-transform: none;
                background-image: linear-gradient(to right, rgb(28, 110, 164) 0% , rgb(35, 136, 203) 50% , rgb(20, 78, 117) 100%);
                box-shadow: rgb(39, 59, 255) 0px 0px 0px 2px;
                border: 1px solid rgb(28, 110, 164);
                display: inline-block; 
                margin-top: 5%; 
                align-content: center;


            }
            .myButton:hover {
                background: #1C6EA4; }
            .myButton:active {
                background: #144E75; }
            </style>


            <!-- Custom styles for this template -->
            <link href="/WebMarket/css/signin.css" rel="stylesheet">
        </head>
        <body class="text-center">

        <main class="form-signin">
            <form method="post" action="/WebMarket/acao?param=login">            

                <h1 class="h3 mb-3 fw-normal a1">Autenticação</h1>

                <h2 class="a1">XingoLingo</h2>
                <br>
                <label for="inputEmail" 
                       class="visually-hidden">Email address</label>
                <input title="nome@dominio.com"
                       type="email" 
                       name="email" 
                       id="email" 
                       class="form-control" 
                       placeholder="Email" 
                       pattern="^[_A-Za-z0-9-\+]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})$"
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

                <script>

                    document.addEventListener('readystatechange', () => {
                        if (document.readyState !== 'complete')
                            return;

                        const params = new URL(location.href).searchParams;
                        if (params.get('erro') === 'ERRO') {
                            swal({
                                title: "Ihhhhh!",
                                text: "Usuário ou senha não conferem!",
                                icon: "warning",
                                button: "Tentar novamente"
                            });
                        } else if (params.get('certo') === 'TRUE') {
                            swal({
                                title: "YEEEEEEY!",
                                text: "Usuário e senha conferem!",
                                icon: "success",
                                buttons: false,
                                timer: 2000
                            }).then(() => {
                                location = '/WebMarket/index.jsp'
                            });
                        }

                    });


                </script>

                <button class="myButton" 
                        type="submit" 
                        value="logar">

                    Acessar</button>   

                <div class="text-center">
                    <a class="w-100 btn btn-lg btn-blue a1" href="pessoa/cadastroLogin.jsp">Cadastrar-se</a>
                </div>

                <p class="mt-5 mb-3 text-muted"   >&copy;XingoLingo 2021</p>
            </form>
        </main>
    </body>
</html>

