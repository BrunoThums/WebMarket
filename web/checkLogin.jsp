<%
            String mail = (String) session.getAttribute("email");
            if (mail == null) {
                System.out.println("Index: Conta N�o Logada");
                response.sendRedirect("/WebMarket/login.jsp");
            }
        %>