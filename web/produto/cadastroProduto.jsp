<%@page import="dao.CategoriaDao"%>
<%@page import="entidade.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidade.Produto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <%@include file="/menu/menu.jsp" %>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
        <meta name="generator" content="Hugo 0.80.0">

        <link href="/WebMarket/css/bootstrap.min.css" rel="stylesheet">

        <link rel="apple-touch-icon" href="/docs/5.0/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
        <link rel="icon" href="/docs/5.0/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
        <link rel="icon" href="/docs/5.0/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
        <link rel="manifest" href="/docs/5.0/assets/img/favicons/manifest.json">
        <link rel="mask-icon" href="/docs/5.0/assets/img/favicons/safari-pinned-tab.svg" color="#7952b3">
        <link rel="icon" href="/docs/5.0/assets/img/favicons/favicon.ico">
        <meta name="theme-color" content="#7952b3">


        <title>Cadastro de Produto</title>
    </head>
    <body>

        <style>

            html, body {
                width: 100%;
                height: 100vh;
            }

            .mainProd {
                display: grid;
                grid-template-columns: 1fr;
                grid-template-rows: 1fr;
                place-items: center;
            }
            body {
                display: grid;
                align-items: center;

            }
            .prod {
                width: 70%;
                max-width: 700px;
            }

            label, input {
                width: 100%;
            }

            h1 {
                text-align: center;
            }

            .cadastro {
                width: 100%;
                margin-bottom: 2em;
            }

            a{
                text-decoration: none;
                align-self: center;
            }

            button:hover {
                transition: 2s;
                opacity: 0.8;
            }

            .checkBox {
                text-align: center;
                margin-bottom: 15px;
            }

            .Cheeck {
                width: 2%;
            }

            .inputt {
                margin-bottom: 1.5em;
            }

            .labell {
                padding: 5px;
            }

            .table-responsive {
                width: 90%;
            }

        </style>

        <main class="mainProd">
            <%  Produto prod = null;

                String id = request.getParameter("id");

                if (id != null) {
                    try {
                        prod = new ProdutoDao().consultarId(Integer.parseInt(id));
                    } catch (NumberFormatException e) {
                    }
                }
                if (prod == null) {
                    prod = new Produto();
                    prod.id = 0;
                    prod.nome = "";
                    prod.descricao = "";
                    prod.estoque = 0;
                    prod.file = "";
                    prod.id_categoria = 0;
                    prod.valor = 0.0;
                }
            %>

            <form method="post" class="prod" action="/WebMarket/srvProduto?param=salvarProduto">            

                <h1 class="h3 mb-3 fw-normal">Cadastro de Produto</h1>       

                <input type="hidden" name="id" value="<%= prod.id%>">

                <label for="inputNome" class="labell">Nome*
                    <input type="text" name="nome" class="form-control inputt" autofocus required value="<%= prod.nome%>"  > 
                </label>

                <label for="inputDescricao" class="labell">Descrição do Produto*
                    <textarea class="form-control inputt" name="descricao" placeholder="Descrição detalhada do produto*" type="text" required><%=prod.descricao%></textarea>
                </label>

                <label for="inputQuantidade" class="labell">Quantidade*
                    <input type="text" name="estoque" class="form-control inputt" placeholder="Quantidade*" pattern="\d|[1-9]\d+" title="Somente Valores Inteiros" required value="<%= prod.estoque%>" >
                </label>

                <label for="inputValor" class="labell">Valor*
                    <input type="text" name="valor" pattern="\d+(?:.\d+)?" class="form-control inputt" value="<%= prod.valor%>" >
                </label>

                <label for="inputLink" class="labell">Link
                    <input type="text" name="file" class="form-control inputt" value="<%= prod.file%>" >
                </label>

                <label for="inputCategoria" class="labell" >Categoria do Produto*
                    <select name="comboCategoria" class="form-select form-select-lg inputt" aria-label=".form-select-sm example">
                        <option value="0">Selecione</option>
                        <%
                            ArrayList<Categoria> categorias = new CategoriaDao().consultarTodos();

                            for (Categoria categ : categorias) {
                        %>

                        <option 
                            <%= prod.id_categoria == categ.id ? "selected" : ""%>
                            value="<%= categ.id%>"><%= categ.descricao%></option>
                        <%
                            }
                        %>
                    </select>
                </label>
                <label class="checkBox">Ativo:
                    <input  <%= prod.id != 0 && prod.ativo.equals("Y") ? "checked" : "!"%>
                        type="checkbox" class="Cheeck" name="ativo"></input></label>

                <button class="btn btn-lg btn-dark cadastro" type="submit" value="Salvar" >Cadastrar</button>
                <script>
                    document.addEventListener('readystatechange', () => {
                        if (document.readyState !== 'complete')
                            return;
                        const params = new URL(location.href).searchParams;
                        if (params.get('erro') === 'DESCRICAO_INVALIDA') {
                            swal({
                                title: "Hey!",
                                text: "Descrição inválida, tente novamente!",
                                icon: "error",
                                button: false,
                                timer: 1500
                            });
                        } else if (params.get('erro') === 'NAO_EXCLUIU') {
                            swal({
                                title: "Vish!",
                                text: "Erro ao excluir produto!",
                                icon: "warning",
                                button: false,
                                timer: 1500
                            });
                        } else if (params.get('certo') === 'SALVA') {
                            swal({
                                title: "Salvo!",
                                text: "O produto foi salvo com sucesso!",
                                icon: "success",
                                button: false,
                                timer: 1500
                            });
                        } else if (params.get('certo') === 'ATUALIZADO') {
                            swal({
                                title: "Atualizado!",
                                text: "O produto foi atualizado com sucesso!",
                                icon: "success",
                                button: false,
                                timer: 1500
                            });
                        } else if (params.get('certo') === 'EXCLUIDO') {
                            swal({
                                title: "Excluido!",
                                text: "O produto foi atualizado com sucesso!",
                                icon: "success",
                                button: false,
                                timer: 1500
                            });
                        }
                    });
                </script>
            </form>

            <%@include file="listagemProduto.jsp" %>
        </main>
    </body>
    <footer><p class="mt-5 mb-3 text-muted">&copy;XingoLingo 2021</p></footer>
</html>
