package servlet;

import apoio.ConexaoBD;
import apoio.Cripto;
import apoio.Validacao;
import dao.PessoaDao;
import entidade.Categoria;
import entidade.Pessoa;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
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
        System.out.println("Entrou no Get");

        String param = request.getParameter("param");
        if (param.equals("exPessoa")) {
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
                    System.out.println("pessoa atualizada com sucesso");
                }
            } else {
                encaminharPagina("erro.jsp", request, response);
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
        System.out.println("Entrou no post");

        String param = request.getParameter("param");

        // SALVAR PESSOA
        if (param.equals("cadastroPessoa")) {
            Pessoa p = new Pessoa();
            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("nome");
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");
            String endereco = request.getParameter("endereco");
            String telefone = request.getParameter("telefone");

            if (!nome.matches("^[A-Za-z ]{3,45}$") || nome.isEmpty()) {
                System.out.println(nome);
                return;
            } else if (!Validacao.isEmail(email)) {
                System.out.println("O email está invalido");
                return;
            } else if (!senha.matches("^.{8,22}$")) {
                System.out.println(senha);
                System.out.println("A senha está inválida");
                return;
            } else if (!telefone.matches("^((\\+\\d{1,2})?\\d{2})?\\d{9}$")) {
                System.out.println(telefone);
                System.out.println("o telefone está inválido");
            } else if (!nome.isEmpty() /*&& !senha.isEmpty()*/ && !email.isEmpty() && !telefone.isEmpty()) {
                p.id = id;
                p.nome = nome;
                p.email = email;
               // p.senha = Cripto.criptografar(senha);
                p.endereco = endereco;
                p.telefone = telefone;
                p.ativo = "Y";
            }
            String retorno = null;
            if (id == 0) {
                retorno = new PessoaDao().salvar(p);
                encaminharPagina("login.jsp", request, response);
                System.out.println("O usuário foi cadastrado");
            } else {
                
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
                    System.out.println("Erro no email");
                    encaminharPagina("login.jsp", request, response);
                }

                if (Cripto.eIgual(set.getString("senha"), new String(senha))) {
                    pessoa.email = email;
                    System.out.println("email cripto:" + email);
                    HttpSession sessao = ((HttpServletRequest) request).getSession();

                    sessao.setAttribute("usuarioLogado", pessoa);
                    sessao.setAttribute("email", email);
                    encaminharPagina("index.jsp", request, response);
                    System.out.println("Pessoa Autenticada");
                } else {
                    System.out.println("erro geral(?)");
                    encaminharPagina("login.jsp", request, response);
                }

            } catch (SQLException ex) {
                Logger.getLogger(srvAcao.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (param.equals("edPessoa")) {
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
