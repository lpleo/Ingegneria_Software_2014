<%@ page import="pdtb.Database" %>
<%@page import="java.util.Vector"%> 
 <html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="stile.css" rel="stylesheet" type="text/css">	
	<title>Ricerca e storico</title>
 </head>
 <body> 
<%
	Database dbase = new Database("iceberg",request.getParameter("username"),request.getParameter("password"));
	dbase.connetti();
	if(dbase.isConnesso()==false) {
		String site = "errore_collegamento.html";
		response.setStatus(response.SC_MOVED_TEMPORARILY);
   		response.setHeader("Location", site);
	}
	else {
	Vector vettore = dbase.eseguiQuery("select * from problemi p where p.id_problema ="+request.getParameter("cod_problema")+";");
	String[] record = (String[]) vettore.elementAt(0);
%>
	<div id="div_log">
		<h4> Problema richiesto: </h4>
	 	Tipo problema: <%=record[1]%> <br />
		Soluzione consigliata all'utente: <%=record[2]%> <br />
		Tipo di barca: <%=record[3]%> <br />
		Categoria problema: <%=record[4]%> <br />
		Sottocategoria problema: <%=record[5]%> <br />
	</div>
	<br />
<%
	}
%>
</body>