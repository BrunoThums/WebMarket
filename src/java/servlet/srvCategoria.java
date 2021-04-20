/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.CategoriaDao;
import entidade.Categoria;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author bbt-1
 */
@WebServlet(name = "Categoria", urlPatterns = {"/Categoria"})
public class srvCategoria extends HttpServlet {
    Categoria categoria = new Categoria();
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
            out.println("<title>Servlet srvCategoria</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet srvCategoria at " + request.getContextPath() + "</h1>");
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
        
        if (param.equals("edCategoria")) {

            String id = request.getParameter("id");

            Categoria categoria = (Categoria) new CategoriaDao().consultarId(Integer.parseInt(id));
            System.out.println(categoria);

            if (categoria != null) {

                request.setAttribute("objetoCategoria", categoria);
                
                encaminharPagina("categoria/categoria.jsp", request, response);
            } else {
                encaminharPagina("error.jsp", request, response);
            }

        } else if (param.equals("exCategoria")) {
            String id = request.getParameter("id");
            categoria = new CategoriaDao().consultarId(Integer.parseInt(id));

            if (categoria != null) {
                CategoriaDao excluir = new CategoriaDao();
                excluir.excluir(Integer.parseInt(id));
                encaminharPagina("categoria/categoria.jsp", request, response);
            } else {
                
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
        
        // SALVAR CATEGORIA        
        if (param.equals("salvarCategoria")) {
            System.out.println("entrei no salvar categoria");
            categoria = new Categoria();
            int id = Integer.parseInt(request.getParameter("id"));
            String descricao = request.getParameter("descricao");
            String ativo = request.getParameter("ativo");
            

            if (!descricao.matches("^.{5,45}$")) {
                System.out.println("descrição não ta certa");
                return;
            } else {
                categoria.id = id;
                categoria.descricao = descricao;
                categoria.ativo = "Y";
            }
            String retorno = null;

            if (id == 0) {
                retorno = new CategoriaDao().salvar(categoria);
                System.out.println("Categoria salva");
                encaminharPagina("categoria/categoria.jsp", request, response);
            } else {
                retorno = new CategoriaDao().atualizar(categoria);
                System.out.println("Categoria atualizada");
                encaminharPagina("categoria/categoria.jsp", request, response);
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
