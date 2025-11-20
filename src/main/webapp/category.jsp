<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 25. 11. 20.
  Time: 오후 1:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>${param.type} 명언</title>
</head>
<body>
<h1>${param.type} 명언</h1>

<c:forEach var="quote" items="${quoteList}">
    <p>${quote.content} - ${quote.author}</p>
</c:forEach>
</body>
</html>
