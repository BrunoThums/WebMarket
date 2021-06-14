package servlet;

import dao.CategoriaDao;
import dao.ProdutoDao;
import entidade.Categoria;
import entidade.Produto;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "pesquisa", urlPatterns = {"/pesquisa"})
public class svrPesquisa extends HttpServlet {

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
            out.println("<title>Servlet pesquisa</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet pesquisa at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        if (param.equals("pesquisar")) {
            String criterio = request.getParameter("busca");

            ArrayList<Categoria> categorias = new CategoriaDao().consultar(criterio);

            request.setAttribute("categoriasPesquisa", categorias);

            encaminharPagina("categoria/pesquisaCategoria.jsp", request, response);
        }

        if (param.equals("pesquisar_prod")) {

            String criterio = request.getParameter("produtoPesquisa");

            ArrayList<Produto> produtos = new ProdutoDao().consultar(criterio);

            request.setAttribute("produtoPesquisa", produtos);

            encaminharPagina("produto/pesquisaProduto.jsp", request, response);
        }
        if (param.equals("pesqProd")) {
            String categoria = request.getParameter("categoria");
            String criterio = request.getParameter("produtoPesquisa");
            if ("tudo".equals(categoria) && criterio == null) {
                ArrayList<Produto> prod = new ProdutoDao().consultarTodos();
                request.setAttribute("produtoPesquisa", prod);
                encaminharPagina("index.jsp", request, response);
            }
            ArrayList<Produto> produtos = new ProdutoDao().consultar(criterio);

            request.setAttribute("produtoPesquisa", produtos);

            encaminharPagina("index.jsp", request, response);
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
            RequestDispatcher rd = request.getRequestDispatcher(pagina);
            rd.forward(request, response);
        } catch (Exception e) {
            System.out.println("Erro ao encaminhar: " + e);
        }
    }
}
