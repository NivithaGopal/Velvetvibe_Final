<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    // Invalidate the session
    HttpSession httpsession = request.getSession(false);
    if (httpsession != null) {
        httpsession.invalidate();
    }

    // Redirect to login page
    response.sendRedirect("login.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>