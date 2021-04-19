<%-- 
    Document   : dadosConta
    Created on : 8 de abr de 2021, 19:45:33
    Author     : STI
--%>

<%@page import="dao.PessoaDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="apoio.Cripto"%>
<%@page import="apoio.ConexaoBD"%>
<%@page import="entidade.Pessoa"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
        <meta name="generator" content="Hugo 0.80.0">
        <title>Dados Pessoais</title>


        <!-- Bootstrap core CSS -->
        <link href="/WebMarket/css/bootstrap.min.css" rel="stylesheet">

        <!-- Favicons -->
        <link rel="apple-touch-icon" href="/docs/5.0/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
        <link rel="icon" href="/docs/5.0/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
        <link rel="icon" href="/docs/5.0/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
        <link rel="manifest" href="/docs/5.0/assets/img/favicons/manifest.json">
        <link rel="mask-icon" href="/docs/5.0/assets/img/favicons/safari-pinned-tab.svg" color="#7952b3">
        <link rel="icon" href="/docs/5.0/assets/img/favicons/favicon.ico">
        <meta name="theme-color" content="#7952b3">
    </head>
    <body>

        <%

            HttpSession sessao = ((HttpServletRequest) request).getSession();

            Pessoa f = (Pessoa) sessao.getAttribute("usuarioLogado");

            f = new PessoaDao().consultarEmail(f.email);

            System.out.println(f);
        %>   

        <style>
            html, body {
                width: 100%;
                height: 100vh;
            }

            a, a:hover {
                color: white;
                text-decoration: none;
            }

            body {
                display: grid;
                align-items: center;
            }

            main {
                display: grid;
                grid-template-columns: 1fr 1fr;
                place-items: center;
                align-items: baseline;
            }

            form {
                width: 70%;
                max-width: 350px;
            }

            label {
                margin: .45em 0;
            }

            input {
                margin-top: .35em;
            }

            button {
                margin: .6em 0;
            }

            input + button {
                margin-top: 1.2em;
            }

            input, label {
                width: 100%;
            }

            h2 {
                margin-bottom: .5em;
            }

            button {
                width: 100%;

            }

            @media screen and (max-width: 750px) {
                main {
                    grid-template-columns: 1fr;
                    grid-template-rows: 1fr 1fr;
                }
                form {
                    margin: 2.5em 0;
                }
            }

            .separator {
                display: block;

                margin-left: 3%;
                width: 94%;
                height: 2px;

                border-top: 1px dashed #12121266;
            }

        </style>

        <main>
            <form method="post" action="/WebMarket/acao?param=editarPessoa">
                <h2>Dados Pessoais</h2>

                <input type="hidden" name="id" value="<%=f.id%>">

                <label for="Email">Nome *
                    <input type="text" name="nome" class="form-control" value="<%= f.nome%>" required autofocus>
                </label>

                <label for="Email">Email *
                    <input type="email" name="email" class="form-control" value="<%= f.email%>" required >
                </label>

                <label for="Endereço">Endereço *
                    <input type="text" name="endereco" class="form-control" value="<%= f.endereco%>" required >
                </label>

                <label for="Telefone">Telefone *
                    <input type="text" name="telefone" class="form-control" value="<%= f.telefone%>" required >
                </label>

                <button type="submit" class="btn btn-dark">Mudar Dados da Conta</button>
                <%
                    String msg = String.valueOf(request.getAttribute("erroEdit"));
                    if (msg.equals("erro")) {       %>
                <p>Erro ao Editar os Dados da Conta/p>
                    <% }%>
            </form>
            <form method="post" action="/WebMarket/acao?param=mudarSenha">
                <h2>Senha e Conta</h2>

                <label for="Senha">Senha Velha *
                    <input type="password" name="senha" class="form-control" required >
                </label>

                <label for="Senha">Nova Senha *
                    <input type="password" name="senhaNova" class="form-control" required >
                </label>

                <label for="Senha">Confirmar Nova Senha *
                    <input type="password" name="confirmarSenha" class="form-control" required >
                </label>

                <button type="submit" class="btn btn-dark">Mudar Senha</button>

                <i class="separator"></i>

                <button class="btn btn-danger"><a href="/WebMarket/acao?param=excluirPessoa&id=<%= f.id%>">Desativar Conta</a> </button>
            </form>
        </main>
    </body>
</html>
