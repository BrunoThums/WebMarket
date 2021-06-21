<%@page import="dao.CompraDao"%>
<%@page import="dao.PessoaDao"%>
<%@page import="entidade.Pessoa"%>
<%@page import="java.util.Locale"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Compras</title>
    </head>
    <body>
        <%
            String nome = "";
            HttpSession sessao = ((HttpServletRequest) request).getSession();
            Pessoa pessoa = (Pessoa) sessao.getAttribute("usuarioLogado");
            pessoa = new PessoaDao().consultarEmail(pessoa.email);
            nome = pessoa.nome;
            
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
            
            String dataIni = request.getParameter("dataInicial");
            String dataFim = request.getParameter("dataFinal");
            
            byte[] bytes = new CompraDao().gerarRelatorioData(nome, dataIni, dataFim);
            
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outStream = response.getOutputStream();
            outStream.write(bytes, 0, bytes.length);
            outStream.flush();
            outStream.close();
        %>
    </body>
</html>
