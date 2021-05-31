<%
            String mail = (String) session.getAttribute("email");
            if (mail == null) {
                System.out.println("Index: Conta Não Logada");
                response.sendRedirect("/WebMarket/login.jsp");
            }
        %>