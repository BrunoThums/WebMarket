<%@page import="entidade.Pessoa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../logo.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        
        <style> 
            <%--Sombras no texto--%>
            .a{
                text-shadow: #FFF 0 -1px 1px, #ff0 0 -1px 1px, #ff8000 0 -1px 2px, red 0 -1px 4px;
                color: rgb(25, 200, 200); 
                margin-bottom: 4%;
            }
            @media (min-width: 768px) {
                .bd-placeholder-img-lg {
                    font-size: 3.5rem;
                }
            }
            <%--Sombras no texto--%>
            .a1{
                text-shadow: #FFF 0 -1px 1px, #ff0 0 -1px 1px, #ff8000 0 -1px 2px, red 0 -1px 4px;
                color: rgb(25, 200, 200); 
                width: 50px; 
                height: 40px;
                font-size: 22px; 
                line-height: 30px; 
                padding: 1px; 
                font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif;
                font-weight: normal;
                text-decoration: none;
                font-style: normal;
                font-variant: normal;
                text-transform: none;
                margin-bottom: 4%; 
            }
            button:hover {
                font-style: oblique;
                border-color: rgb(25, 200, 200);
            }
            button:active {
                background-color: rgb(25, 200, 200);
                color: rgb(15, 15, 15); 
            }
            
            body {
                <%--Plano de Fundo do Bonoro --%>
                background-image: url(bonoro.jpg);
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: 100% 100%;
            }
            input:invalid:not(:placeholder-shown){
                box-shadow: 0px 0px 0px 0.25rem rgba(255,0,0,.25);
                border-color: red;
                z-index:2;
            }
        </style>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
        <meta name="generator" content="Hugo 0.80.0">
        <!--Título-->
        <title>XL - Criar Conta</title>
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
        </style>

        <!-- Custom styles for this template -->
        <link href="/WebMarket/css/signin.css" rel="stylesheet">
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    </head>
    <body class="text-center">

        <%
            Pessoa pessoa = new Pessoa();

            pessoa.id = 0;
            pessoa.nome = "";
            pessoa.senha = "";
            pessoa.email = "";
            pessoa.endereco = "";
            pessoa.telefone = "";
        %>

        <main class="form-signin">
            <form method="post" name="cadastroUsuario" action="/WebMarket/acao?param=cadastroPessoa">            
                <script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
                <script language="JavaScript" src="../js/validaLogin.js"></script>
                
                <h1 class="h3 mb-3 fw-normal a">Criar conta</h1>
                <h2 class="a" >XingoLingo</h2>
                <%--ID--%>
                <input type="hidden" 
                       name="id" 
                       id="id"
                       value=
                       <%= pessoa.id%>>

                <%--Nome--%>
                <label for="txtNome" 
                       class="visually-hidden">
                    Nome
                </label>
                <input type="name" 
                       name="nome" 
                       id="nome" autofocus
                       class="form-control" 
                       placeholder="Nome*" 
                       required value=
                       <%= pessoa.nome%>  > 

                <%--Email--%>
                <label for="txtEmail" 
                       class="visually-hidden">
                    Email address
                </label>
                <input title="nome@dominio.com"
                       type="email" 
                       name="email" 
                       id="email" 
                       class="form-control" 
                       placeholder="Email*" 
                       required 
                       pattern="^[_A-Za-z0-9-\+]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})$"
                       value="<%= pessoa.email%>">

                <%--Senha--%>
                <label for="txtPassword" 
                       class="visually-hidden">
                    Password
                </label>
                <input type="password" 
                       pattern="^.{8,22}$" 
                       title="De 8 a 22 caracteres" 
                       name="senha" 
                       id="password" 
                       class="form-control" 
                       placeholder="Senha*" 
                       required 
                       value="<%= pessoa.senha%>">

                <%--Endereço--%>
                <label for="txtEndereco" 
                       class="visually-hidden">
                    Endereco
                </label>
                <input type="endereco" 
                       name="endereco" 
                       id="endereco" 
                       class="form-control" 
                       placeholder="Endereço" 
                       value="<%= pessoa.endereco%>">

                <%--Endereço--%>
                <label for="inputTelefone" 
                       class="visually-hidden">
                    Telefone
                </label>
                <input type="telefone" 
                       pattern="^((\+\d{1,2})?\d{2})?\d{9}$" 
                       title="Formato: (xx)99999-9999" 
                       name="telefone" 
                       id="telefone" 
                       class="form-control" 
                       placeholder="Telefone*" 
                       required 
                       value="<%= pessoa.telefone%>">

                <%--Cadastrar--%>
                <button class="w-100 btn btn-lg btn-blue a1" 
                        type="submit" 
                        value="Salvar">
                    Cadastrar
                </button>

                <h6 class="a">Campos com o "*" são obrigatórios</h6>
                <%--Voltar para login--%>
                <div class="text-center">
                    <a class="a" href="../login.jsp">Voltar</a> 
                </div>
                <%--Copyrights XingoLingo--%>
                <p class="mt-5 mb-3 text-muted">&copy;XingoLingo 2021</p>
            </form>
                <script>

                document.addEventListener('readystatechange', () => {

                    if (document.readyState !== 'complete')
                        return;

                    const params = new URL(location.href).searchParams;

                    if (params.get('erro') === 'ERRO') {
                        swal({
                            title: "Vishhhh",
                            text: "Algum campo não foi preenchido corretamente",
                            icon: "warning",
                            button: "Vou arrumar aqui, pode deixar"
                        });

                    } else if (params.get('certo') === 'TRUE') {
                        swal({
                            title: "YEY! Cadastro completo!",
                            text: "Agora você é um de nós :D",
                            icon: "success",
                            button: "Mazá! To só pelo pczão agora"
                        });
                    }
                });


            </script>
        </main>

    </body>
</html>
