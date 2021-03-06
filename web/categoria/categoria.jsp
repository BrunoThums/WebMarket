<%@page import="entidade.Categoria"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../menu/menu.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" 
              content="text/html; charset=UTF-8">

    </head>
    <body>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <%--Categoria --%>
        <%  Categoria cat = (Categoria) request.getAttribute("objetoCategoria");
            if (cat == null) {
                cat = new Categoria();

                cat.id = 0;
                cat.descricao = "";
                cat.ativo = "";
            }
        %>
        <h1 style="text-align: center;">Cadastro de Categorias</h1>

        <form style="padding: 20px; text-align: center;" name='formCateg' method='post' action='/WebMarket/Categoria?param=salvarCategoria'>
            <input type="hidden" name="id" id="id" value= <%= cat.id%>>
            <script type="text/javascript" src="https://code.jquery.com/jquery-3.1.1.min.js"></script>


            <input type="text" 
                   name="descricao" 
                   id="descricao"
                   placeholder="Descrição"
                   pattern="^.{3,45}$"
                   value="<%= cat.descricao%>">

            <div style="margin-left: -9.10%; margin-top: 0.25%">
                <label style="">Ativo?
                    <input <%= cat.id != 0 && cat.ativo.equals("Y") ? "checked" : "!"%> type="checkbox" name="ativo"></input></label>
            </div>



            <button type="submit" value="salvar">Cadastrar</button>
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
                            text: "Erro ao excluir categoria!",
                            icon: "warning",
                            button: false,
                            timer: 1500
                        });
                    } else if (params.get('certo') === 'SALVA') {
                        swal({
                            title: "Salvo!",
                            text: "A categoria foi salva com sucesso!",
                            icon: "success",
                            button: false,
                            timer: 1500
                        });
                    } else if (params.get('certo') === 'ATUALIZADO') {
                        swal({
                            title: "Atualizado!",
                            text: "A categoria foi atualizada com sucesso!",
                            icon: "success",
                            button: false,
                            timer: 1500
                        });
                    } else if (params.get('certo') === 'EXCLUIDO') {
                        swal({
                            title: "Excluido!",
                            text: "A categoria foi atualizada com sucesso!",
                            icon: "success",
                            button: false,
                            timer: 1500
                        });
                    }
                });
            </script>
            <br>
            <br>
            <br>
            <%@include file = "listagemCategoria.jsp" %>
        </form>
    </body>
</html>
