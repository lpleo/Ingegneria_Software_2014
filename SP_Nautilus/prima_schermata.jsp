<%@ page import="pdtb.Database" %>
<%@page import="java.util.Vector"%> 
 <html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="stile.css" rel="stylesheet" type="text/css">	
	<title>Database</title>
 </head>
 <body>
 <jsp:useBean id="connetti" scope="session" class="pdtb.Database" /> 
 <h3>Database</h3>
 <div style="text-align:center">
	<%
	Database dbase = new Database("iceberg",request.getParameter("username"),request.getParameter("password"));
	dbase.connetti();
	request.setAttribute("dblog",dbase);
	if(dbase.isConnesso()==false) {
		String site = "errore_collegamento.html";
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", site);
	}
	else {
	%>
	
		<h2>Connessione al database riuscita.<br />
		Cosa si desidera fare? <br /></h2>
		<div id="div_log"> 
		<h4>Ricerca utente e storico</h4> <br />
			<form name="ricerut" action="ricerca_storico.jsp">
				Inserire il codice utente: <input name="cod_utente" type="text" /> <br />
				<input type="hidden" name="username" value="<%=request.getParameter("username")%>" />
				<input type="hidden" name="password" value="<%=request.getParameter("password")%>" />
				<input id="submit" type="submit" value="Ricerca Utente"/>
			</form>
		</div>
		<br />
		<div id="div_log"> 
		Ricerca problemi <br />
			<form name="ricerpb" action="ricerca_problema.jsp">
				Inserire il codice utente: <input name="cod_utente" type="text" /> <br />
				<input type="hidden" name="username" value="<%=request.getParameter("username")%>" />
				<input type="hidden" name="password" value="<%=request.getParameter("password")%>" />
				<input id="submit" type="submit" value="Ricerca Problema"/>
			</form>
		</div>
		<br />
		<div id="div_log"> 
		Inserimento nuovo utente <br />
		<input type="button" onclick="location.href='inserisci_utente.jsp'" value="Inserisci utente"/>
		</div>
		<br />
		<div id="div_log"> 
		Inserimento nuovo problema <br />
		<input type="button" onclick="location.href='inserisci_problema.jsp'" value="Inserisci problema"/>
		</div>
		<br />
		<%
	}
		%>
 <br />
 </div>
 </body>
 </html>
