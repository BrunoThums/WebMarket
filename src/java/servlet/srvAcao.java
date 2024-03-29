package servlet;

import apoio.ConexaoBD;
import apoio.Cripto;
import apoio.Validacao;
import dao.PessoaDao;
import entidade.Categoria;
import entidade.ItemCarrinho;
import entidade.Pessoa;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class srvAcao extends HttpServlet {

    ConexaoBD bd = new ConexaoBD();
    ResultSet r = null;
    Categoria categoria = new Categoria();
    Pessoa pessoa = new Pessoa();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet srvAcao</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet srvAcao at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String param = request.getParameter("param");

        //LOGOUT - Tirar a paessoa da sessão ao fazer logout
        if (param.equals("logout")) {
            HttpSession sessao = request.getSession();
            sessao.invalidate();
            response.sendRedirect("/WebMarket/login.jsp");
        } //DESATIVAR CONTA
        else if (param.equals("desativarPessoa")) {
            String id = request.getParameter("id");
            pessoa = new PessoaDao().consultarId(Integer.parseInt(id));

            if (pessoa != null) {
                PessoaDao desativar = new PessoaDao();
                desativar.excluir(Integer.parseInt(id));
                encaminharPagina("login.jsp", request, response);
            } else {
                encaminharPagina("erro.jsp", request, response);
            }
        }

        //EXCLUSÃO DE PESSOA
        if (param.equals("excluirPessoa")) {
            String id = request.getParameter("id");
            pessoa = new PessoaDao().consultarId(Integer.parseInt(id));

            if (pessoa != null) {
                PessoaDao pessoa = new PessoaDao();
                pessoa.excluir(Integer.parseInt(id));
                encaminharPagina("/WebMarket/pessoa/listagemPessoas.jsp", request, response);
                return;
            } else {
                System.out.println("Erro ao excluir cliente");
            }
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String param = request.getParameter("param");

        // SALVAR PESSOA
        if (param.equals("cadastroPessoa")) {
            Pessoa pessoa = new Pessoa();
            PessoaDao pessoaDAO = new PessoaDao();
            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("nome");
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");
            String endereco = request.getParameter("endereco");
            String telefone = request.getParameter("telefone");

            if (!nome.matches("^[A-Za-z ]{3,45}$") || nome.isEmpty()) {
                response.sendRedirect("/WebMarket/pessoa/cadastroLogin.jsp?erro=NOME_INVALIDO");
                return;
            } else if (!Validacao.isEmail(email)) {
                response.sendRedirect("/WebMarket/pessoa/cadastroLogin.jsp?erro=EMAIL_INVALIDO");
                return;
            } else if (!senha.matches("^.{8,22}$")) {
                response.sendRedirect("/WebMarket/pessoa/cadastroLogin.jsp?erro=SENHA_INVALIDA");
                System.out.println("A senha está inválida");
                return;
            } else if (!telefone.matches("^((\\+\\d{1,2})?\\d{2})?\\d{9}$")) {
                response.sendRedirect("/WebMarket/pessoa/cadastroLogin.jsp?erro=TELEFONE_INVALIDO");
                System.out.println("o telefone está inválido");
            } else if (!nome.isEmpty() /*&& !senha.isEmpty()*/ && !email.isEmpty() && !telefone.isEmpty()) {
                pessoa.id = id;
                pessoa.nome = nome;
                pessoa.email = email;
                pessoa.senha = Cripto.criptografar(senha);
                pessoa.endereco = endereco;
                pessoa.telefone = telefone;
                pessoa.ativo = "Y";
            }
            String retorno = null;
            if (pessoaDAO.salvar(pessoa) == null) {
                response.sendRedirect("/WebMarket/pessoa/cadastroLogin.jsp?certo=TRUE");
            } else {
                response.sendRedirect("/WebMarket/pessoa/cadastroLogin.jsp?erro=ERRO");
            }
        }

        // -------------------LOGIN------------------
        if (param.equals("login")) {
            Pessoa pessoa = new Pessoa();
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");
            try {
                ResultSet set = bd.getConnection().createStatement()
                        .executeQuery("SELECT * FROM pessoa WHERE email = '" + email + "'");

                if (!set.next()) {
                    response.sendRedirect("/WebMarket/login.jsp?erro=ERRO");
                }

                if (Cripto.eIgual(set.getString("senha"), new String(senha))) {

                    pessoa.email = email;
                    HttpSession sessao = ((HttpServletRequest) request).getSession();

                    sessao.setAttribute("usuarioLogado", pessoa);
                    sessao.setAttribute("email", email);
                    sessao.setAttribute("cart", new ArrayList<ItemCarrinho>());
                    response.sendRedirect("/WebMarket/login.jsp?certo=TRUE");
                } else {
                    response.sendRedirect("/WebMarket/login.jsp?erro=ERRO");
                }

            } catch (SQLException ex) {
                Logger.getLogger(srvAcao.class.getName()).log(Level.SEVERE, null, ex);
            }

            //EDITAR PESSOA
        } else if (param.equals("editarPessoa")) {
            pessoa = new Pessoa();
            PessoaDao pessoaDao = new PessoaDao();

            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("nome");
            String email = request.getParameter("email");
            String endereco = request.getParameter("endereco");
            String telefone = request.getParameter("telefone");
            String ativo = request.getParameter("ativo");

            if (!nome.matches("^[A-Za-z ]{3,45}$") || nome.isEmpty()) {
                System.out.println(nome);
                encaminharPagina("/WebMarket/pessoa/listagemPessoas.jsp", request, response);
                return;
            } else if (!nome.isEmpty() && !email.isEmpty() && !telefone.isEmpty()) {
                pessoa.id = id;
                pessoa.nome = nome;
                pessoa.email = email;
                pessoa.endereco = endereco;
                pessoa.telefone = telefone;
                pessoa.ativo = "Y";
                pessoaDao.atualizar(pessoa);
                System.out.println("Pessoa atualizada");
                encaminharPagina("/WebMarket/pessoa/listagemPessoas.jsp", request, response);
            }

        }

        //MUDAR SENHA
        if (param.equals("mudarSenha")) {
            PessoaDao pessoaDao = new PessoaDao();
            HttpSession sessao = ((HttpServletRequest) request).getSession();
            String senha = request.getParameter("senha");
            String senhaNova = request.getParameter("senhaNova");
            String confirmarSenha = request.getParameter("confirmarSenha");

            Pessoa pessoa = (Pessoa) sessao.getAttribute("usuarioLogado");

            pessoa = pessoaDao.consultarEmail(pessoa.email);

            if (!senha.isEmpty() && !senhaNova.isEmpty() && !confirmarSenha.isEmpty()) {

                if (Cripto.eIgual(pessoa.senha, senha) && senhaNova.equals(confirmarSenha)) {
                    pessoa.senha = Cripto.criptografar(senhaNova);
                    pessoaDao.atualizar(pessoa);
                    response.sendRedirect("/WebMarket/pessoa/dadosConta.jsp");
                }
            } else {
                encaminharPagina("erro.jsp", request, response);
            }
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void encaminharPagina(String pagina, HttpServletRequest request, HttpServletResponse response) {
        try {
            response.sendRedirect(pagina);
            /*RequestDispatcher rd = request.getRequestDispatcher(pagina);
            rd.forward(request, response);*/
        } catch (Exception e) {
            System.out.println("Erro ao encaminhar: " + e);
        }
    }
}
