<%
            String email = (String) session.getAttribute("email");
            if (email == null) {
                System.out.println("Index: Conta Não Logada");
                response.sendRedirect("/WebMarket/login.jsp");
            }
        %>