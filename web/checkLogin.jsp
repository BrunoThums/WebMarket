<%
            String email = (String) session.getAttribute("email");
            if (email == null) {
                System.out.println("Index: Conta N�o Logada");
                response.sendRedirect("/WebMarket/login.jsp");
            }
        %>