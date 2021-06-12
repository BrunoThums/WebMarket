package servlet;

import dao.ProdutoDao;
import entidade.Produto;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "srvProduto", urlPatterns = {"/srvProduto"})
public class srvProduto extends HttpServlet {

    Produto prod = new Produto();

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
            out.println("<title>Servlet srvProduto</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet srvProduto at " + request.getContextPath() + "</h1>");
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

        if (param.equals("editarProduto")) {

            String id = request.getParameter("id");

            Produto produto = (Produto) new ProdutoDao().consultarId(Integer.parseInt(id));

            if (produto != null) {

                request.setAttribute("objetoProduto", produto);
                encaminharPagina("produto/cadastroProduto.jsp", request, response);
            } else {
                response.sendRedirect("produto/cadastroProduto.jsp?erro=DESCRICAO_INVALIDA");
            }

        } else if (param.equals("excluirProduto")) {

            String id = request.getParameter("id");
            prod = new ProdutoDao().consultarId(Integer.parseInt(id));

            if (prod != null) {
                ProdutoDao excluir = new ProdutoDao();
                excluir.excluir(Integer.parseInt(id));
                response.sendRedirect("produto/cadastroProduto.jsp?certo=EXCLUIDO");
            } else {
                response.sendRedirect("produto/cadastroProduto.jsp?erro=NAO_EXCLUIU");
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

        if (param.equals("salvarProduto")) {
            ProdutoDao ProdDao = new ProdutoDao();
            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("nome");
            String descricao = request.getParameter("descricao");
            double valor = Double.parseDouble(request.getParameter("valor"));
            String estoque = request.getParameter("estoque");
            String file = request.getParameter("file");
            int idCategoria = Integer.parseInt(request.getParameter("comboCategoria"));
            boolean pegaAtivo = Boolean.parseBoolean((request.getParameter("ativo")!=null?"true":"false"));
            String ativo = "";
            System.out.println("ativo: "+pegaAtivo);
            if(pegaAtivo==true){
                ativo = "Y";
            } else if (pegaAtivo==false){
                ativo = "N";
            }

            if (!nome.isEmpty() || !descricao.isEmpty() || valor != 0
                    || estoque.matches("^\\d$|^[1-9]\\d{1,5}$") || idCategoria != 0) {

                prod.id = id;
                prod.nome = nome;
                prod.descricao = descricao;
                prod.valor = valor;
                prod.estoque = Integer.parseInt(estoque);
                prod.ativo = ativo;
                prod.file = file;
                prod.id_categoria = idCategoria;
            } else {
                response.sendRedirect("produto/cadastroProduto.jsp?erro=DESCRICAO_INVALIDA");
                return;
            }
            String retorno = null;

            if (id == 0) {
                if(ProdDao.salvar(prod)==null){
                response.sendRedirect("produto/cadastroProduto.jsp?certo=SALVA");
                }
            } else if (id != 0) {
                ProdDao.atualizar(prod);
                response.sendRedirect("produto/cadastroProduto.jsp?certo=ATUALIZADO");
            }
        }
        processRequest(request, response);
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
            RequestDispatcher rd = request.getRequestDispatcher(pagina);
            rd.forward(request, response);
        } catch (Exception e) {
            System.out.println("Erro ao encaminhar: " + e);
        }
    }

}
