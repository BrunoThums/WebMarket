<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="dao.ProdutoDao"%>
<%@page import="entidade.Produto"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "org.apache.commons.io.output.*" %>

<%
    int maxFileSize = 5000 * 1024;
    int maxMemSize = 5000 * 1024;
    ServletContext context = pageContext.getServletContext();
    String filePath = context.getInitParameter("file-upload") + "/";
    new File(filePath).mkdirs();

    // Verify the content type
    String contentType = request.getContentType();

    if ((contentType.indexOf("multipart/form-data") >= 0)) {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // maximum size that will be stored in memory
        factory.setSizeThreshold(maxMemSize);

        // Location to save data that is larger than maxMemSize.
        factory.setRepository(new File("./temp"));

        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);

        // maximum file size to be uploaded.
        upload.setSizeMax(maxFileSize);

        // Parse the request to get file items.
        List fileItems = upload.parseRequest(request);

        // Process the uploaded file items
        Iterator i = fileItems.iterator();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>JSP File upload</title>");
        out.println("<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>");
        out.println("</head>");
        out.println("<body>");

        HashMap<String, String> params = new HashMap();

        while (i.hasNext()) {
            FileItem fi = (FileItem) i.next();
            if (!fi.isFormField()) {
                // Get the uploaded file parameters
                if ("application/octet-stream".equals(fi.getContentType())) {
                    continue;
                }
                if (!"image/png".equals(fi.getContentType()) || !"file".equals(fi.getFieldName())) {
                    out.println("<script>");
                    out.println("swal({"
                            + "title: 'ERRO!',"
                            + "text: 'Erro ao cadastrar!',"
                            + "icon: 'warning',"
                            + "button: 'OK!'"
                            + "})");
                    out.println("</script>");
                    System.out.println(fi.getFieldName());
                    System.out.println(fi.getContentType());
                    return;
                }

                String imageUrl = UUID.randomUUID().toString() + ".png";
                // Write the file
                File file = new File(filePath + imageUrl);
                file.createNewFile();
                fi.write(file);
                params.put("imageUrl", imageUrl);
            } else {
                params.put(fi.getFieldName(), fi.getString());
            }
        }
        int id = Integer.parseInt(params.get("id"));
        Produto p;
        ProdutoDao pdao = new ProdutoDao();
        if (id == 0) {
            p = new Produto();
        } else {
            p = pdao.consultarId(id);
        }
        p.id = id;
        p.nome = params.get("nome");
        p.descricao = params.get("descricao");
        p.valor = Double.parseDouble(params.get("valor"));
        p.file = params.containsKey("imageUrl") ? params.get("imageUrl") : p.file;
        p.estoque = Integer.parseInt(params.get("estoque"));
        p.id_categoria = Integer.parseInt(params.get("comboCategoria"));
        p.ativo = params.containsKey("checkbox") ? "ativo" : "inativo";

        if (p.id == 0 || p.id == null) {

            pdao.salvar(p);
        } else if (p.id != 0) {
            pdao.atualizar(p);
        }

        response.sendRedirect("/WebMarket/produto/cadastroProduto.jsp");
        out.println("</body>");
        out.println("</html>");

    } else {
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Servlet upload</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<p>No file uploaded</p>");
        out.println("</body>");
        out.println("</html>");
    }
%>