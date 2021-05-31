<%@page import="dao.PessoaDao"%>
<%@page import="entidade.Pessoa"%>
<%@page import="dao.CategoriaDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listagem de Categoria</title>
    </head>
    <body>
        <%
            String nome = "";
            HttpSession sessao = ((HttpServletRequest) request).getSession();
            Pessoa pessoa = (Pessoa) sessao.getAttribute("usuarioLogado");
            if (pessoa != null) {
                pessoa = new PessoaDao().consultarEmail(pessoa.email);
                nome = pessoa.nome;
                System.out.println("nome: "+ nome);
            }
            
            byte[] bytes = new CategoriaDao().gerarRelatorio(nome);

            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outStream = response.getOutputStream();
            outStream.write(bytes, 0, bytes.length);
            outStream.flush();
            outStream.close();
        %>
    </body>
</html>
