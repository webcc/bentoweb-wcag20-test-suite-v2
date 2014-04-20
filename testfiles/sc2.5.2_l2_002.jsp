<%@page contentType="text/html"%><%
 boolean usMiss = false;
 boolean pwMiss = false;
 boolean logFailus = false;
 boolean logFailpw = false;
 String strErr="";
 int error = 0;
 if (request.getMethod().equals("POST")) {
	if (request.getParameter("username").equals("test@test.org") && request.getParameter("password").equals("test")) {
	   response.sendRedirect("processformdummy.html");
	}
	if (request.getParameter("username").equals("")) {
		usMiss=true;
		strErr="<li><a href='#id1'>The user name is required</a></li>";
		error++;
	} 
	if (request.getParameter("password").equals("")) {
		pwMiss=true;
		strErr=strErr+"<li><a href='#id2'>The password is required</a></li>";
		error++;
	} 
	if (!request.getParameter("username").equals("") && !request.getParameter("username").equals("test@test.org")) {
		logFailus=true;
		strErr=strErr+"<li><a href='#id1'>The user name is wrong.</a></li>";
		error++;
	}
	if (!request.getParameter("password").equals("") && !request.getParameter("password").equals("test")) {
		logFailpw=true;
		strErr=strErr+"<li><a href='#id1'>The password is wrong.</a></li>";
		error++;
	}
 }
%><?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title>Web form - log-in page</title>
     <link rel="stylesheet" media="screen,projection" href="resources/css/sc2.5.css" type="text/css" />
  </head>
  <body>
	<h1>Log-in</h1>
   <%
       if (usMiss || pwMiss || logFailus || logFailpw) {
		out.println("<div id='error'><strong>Log-in was not successful.<br /><br />The form is redisplayed with incorrect fields identified by: <img src='resources/images/alert_icon.gif' alt='**' /><br /><br />Suggestions on how to correct the failures are provided in a help link next to the label of the corresponding form field.<br /><br />"+error+" error"+((error>1)?"s have ":" has ")+"been detected. Please check the following item"+((error>1)?"s ":" ")+"and try again: </strong><ol>"+strErr+"</ol></div>");
       }
    %>
    <p>
    Please enter your user name and password.
    </p>
    <form method="post" action="sc2.5.2_l2_002.jsp">
    <div>
	    <% if (usMiss || logFailus) {  out.println("<div><img src='resources/images/alert_icon.gif' alt='**' /> <span class='errTxt'>Please provide your user name.</span><br />"); } %>
		<label for="id1">User name: </label>
		<input type="text" name="username" id="id1" value="<%= (request.getParameter("username")!=null)?request.getParameter("username"):"" %>" /><br />
		<% if (usMiss || logFailus) { out.println("<a href='#hou'>help for 'user name'</a><br/>");} %><br />
		<% if (usMiss || logFailus) {  out.println("</div>");} %>
	
	
		<% if (pwMiss || logFailpw) {  out.println("<div><img src='resources/images/alert_icon.gif' alt='**' /> <span class='errTxt'>Please provide your password.</span><br />"); } %>
		<label for="id2">Password: </label>
		<input type="password" name="password" id="id2" value="<%= (request.getParameter("password")!=null)?request.getParameter("password"):"" %>" /><br />
		<% if (pwMiss || logFailpw) { out.println("<a href='#hop'>help for 'password'</a><br/>");} %><br />
		<% if (pwMiss || logFailpw) {  out.println("</div>");} %>
	
		<div class="space"><input type="submit" value="submit" /><br/></div>
	</div>
	</form>
	<% if (usMiss || logFailus) { %>
	<h2><a name="hou" id="hou">User name</a></h2>
	<p>The user name has the format of a mail address. If you can't remember your user name anymore, please contact the administrator.</p>
	<p>For example: test@test.org</p>
	<p><a href="#id1">Return to the user name field</a></p>
	<% } 
    if (pwMiss || logFailpw) { %>
    <h2><a name="hop" id="hop">Password</a></h2>
	<p>If you can't remember your password anymore, please contact the administrator.</p>
	<p><a href="#id2">Return to the password field</a></p>
	<% } %>
<!-- 	<p><small>*) testaccount - user name: test@test.org, password: test</small></p> -->
  </body>

<!--
 Copyright &#169; BenToWeb Consortium 2004-2007

 Licensed under the BenToWeb License, Version 1.0 (the "License"); you may
 not use this file except in compliance with the License. You may obtain
 a copy of the License at http://bentoweb.org/refs/LICENSE.html

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
-->
</html>