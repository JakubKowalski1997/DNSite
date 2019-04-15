<%--suppress ALL --%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Create an account</title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<div class="container">

    <form:form method="POST" modelAttribute="userForm" class="form-signin">
        <h2 class="form-signin-heading">Create your account</h2>
        <spring:bind path="firstName">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="firstName" class="form-control" placeholder="First name"></form:input>
                <form:errors path="firstName"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="lastName">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="lastName" class="form-control" placeholder="Last name"></form:input>
                <form:errors path="lastName"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="username">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="username" class="form-control" placeholder="Username"
                            autofocus="true"></form:input>
                <form:errors path="username"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="password">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="password" path="password" class="form-control" placeholder="Password"></form:input>
                <form:errors path="password"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="passwordConfirm">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="password" path="passwordConfirm" class="form-control"
                            placeholder="Confirm your password"></form:input>
                <form:errors path="passwordConfirm"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="email">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="email" class="form-control"
                            placeholder="Email"></form:input>
                <form:errors path="email"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="hostname">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="hostname" class="form-control"
                            placeholder="Hostname"></form:input>
                <form:errors path="hostname"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="dbPort">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="dbPort" class="form-control"
                            placeholder="dbPort"></form:input>
                <form:errors path="dbPort"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="database">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="database" class="form-control"
                            placeholder="Database"></form:input>
                <form:errors path="database"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="powerAdminPassword">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="powerAdminPassword" class="form-control"
                            placeholder="Power admin password"></form:input>
                <form:errors path="powerAdminPassword"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="powerAdminUsername">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="powerAdminUsername" class="form-control"
                            placeholder="powerAdminUsername"></form:input>
                <form:errors path="powerAdminUsername"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="hostmaster">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="hostmaster" class="form-control"
                            placeholder="hostmaster"></form:input>
                <form:errors path="hostmaster"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="primaryNameServer">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="primaryNameServer" class="form-control"
                            placeholder="primaryNameServer"></form:input>
                <form:errors path="primaryNameServer"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="secondNameServer">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="secondNameServer" class="form-control"
                            placeholder="secondNameServer"></form:input>
                <form:errors path="secondNameServer"></form:errors>
            </div>
        </spring:bind>


        <button class="btn btn-lg btn-primary btn-block" type="submit">Submit</button>
    </form:form>

</div>
<!-- /container -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>
