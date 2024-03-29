package servlet;

import apoio.ConexaoBD;
import dao.CarrinhoDao;
import dao.CompraDao;
import dao.ItemCarrinhoDao;
import dao.PessoaDao;
import dao.ProdutoDao;
import entidade.Carrinho;
import entidade.Compra;
import entidade.ItemCarrinho;
import entidade.Pessoa;
import entidade.Produto;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.function.Predicate;

@WebServlet(name = "cart", urlPatterns = {"/cart"})
public class srvCarrinho extends HttpServlet {

    ConexaoBD bd = new ConexaoBD();
    ProdutoDao pd = new ProdutoDao();

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
            out.println("<title>Servlet cart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet carrinho at " + request.getContextPath() + "</h1>");
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

        HttpSession session = ((HttpServletRequest) request).getSession();
        String param = request.getParameter("param");

        ArrayList<ItemCarrinho> produtos = (ArrayList<ItemCarrinho>) session.getAttribute("cart");

        if (param.equals("excluirDoCarrinho")) {
            String id = request.getParameter("id");
            int d = Integer.parseInt(id);

            removeItem(produtos, p -> p.id_produto == d);

            response.sendRedirect("/WebMarket/checkout/cart.jsp");
        } else if (param.equals("qntInsert")) {
            System.out.println(param);

            int id = Integer.parseInt(request.getParameter("id"));
            ItemCarrinho item = produtos.stream().filter(p -> p.id_produto == id).findFirst().get();
            if (pd.consultarId(id).estoque > item.quant) {
                item.quant++;
            }
            response.sendRedirect("/WebMarket/checkout/cart.jsp");

        } else if (param.equals("qntRemove")) {
            int id = Integer.parseInt(request.getParameter("id"));
            ItemCarrinho item = produtos.stream().filter(p -> p.id_produto == id).findFirst().get();
            if (item.quant > 1) {
                item.quant--;
            }
            response.sendRedirect("/WebMarket/checkout/cart.jsp");
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
        HttpSession session = ((HttpServletRequest) request).getSession();
        String param = request.getParameter("param");

        ArrayList<ItemCarrinho> produtos = (ArrayList<ItemCarrinho>) session.getAttribute("cart");
        
        Pessoa pessoa = (Pessoa) session.getAttribute("usuarioLogado");
        if (param.equals("insertProd")) {

            int id = Integer.parseInt(request.getParameter("id"));

            ItemCarrinho item = produtos.stream().filter(p -> p.id_produto == id).findFirst().orElse(null);

            if (item == null) {

                item = new ItemCarrinho();
                item.id = 0;
                item.quant = 1;
                item.valorUnit = 0;
                item.id_produto = id;

                produtos.add(item);
            } else if (pd.consultarId(item.id_produto).estoque < item.quant) {
                item.quant++;
            }
            response.sendRedirect("index.jsp?certo=ADICIONADO");

        } else if (param.equals("compra")) {
            ItemCarrinhoDao itemCarrinhoDao = new ItemCarrinhoDao();
            CarrinhoDao carrinhoDao = new CarrinhoDao();
            CompraDao compraDao = new CompraDao();
            PessoaDao pessoaDao = new PessoaDao();
            pessoa = pessoaDao.consultarEmail(pessoa.email);
            
            if (produtos.size() <= 0) {
                return;
            }

            double valorTotal = 0.0;
            int parcelas = Integer.parseInt(request.getParameter("parcelas"));
            
            for (ItemCarrinho item : produtos) {

                Produto p = pd.consultarId(item.id_produto);
                if (p.estoque >= item.quant) {
                    p.estoque -= item.quant;
                    pd.atualizar(p);
                } else {
                    response.sendRedirect("/WebMarket/checkout/checkout.jsp?erro=ERRO");
                    return;
                }
                item.valorUnit = p.valor;
                valorTotal += item.valorUnit * item.quant;
            }

            Compra c = new Compra();

            c.id = 0;
            c.parcelas = parcelas;
            //c.valorTotal = valorTotal / parcelas;
            c.valorTotal = valorTotal;
            c.id_pessoa = pessoa.id;
            // Salva a compra e vê o novo id da compra
            // Salvar os itens e pegar os novos ids e dps salvar o carrinho

            compraDao.salvar(c);

            /*Carrinho carrinho = new Carrinho();
            carrinho.id_compra = c.id;
            for (ItemCarrinho item : produtos) {
                itemCarrinhoDao.salvar(item);

                carrinho.id_item = item.id;
                carrinhoDao.salvar(carrinho);
            }*/
            produtos.clear();
            session.setAttribute("cart", new ArrayList<ItemCarrinho>());
            response.sendRedirect("/WebMarket/checkout/checkout.jsp?certo=COMPRADO");

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

    public static <T> void removeItem(ArrayList<T> items, Predicate<T> find) {
        for (int i = 0; i < items.size(); i++) {
            if (find.test(items.get(i))) {
                items.remove(i);
                return;
            }
        }
    }
}
