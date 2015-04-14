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
	Vector vettore = dbase.eseguiQuery("select * from utenti u where u.id_utente ="+request.getParameter("cod_utente")+";");
	Vector vettoreStorico = dbase.eseguiQuery("SELECT u.nome, p.tipo_problema, p.tipo_barca FROM utenti u, storico s, problemi p WHERE u.id_utente = s.id_utenza AND s.id_problemi = p.id_problema AND u.id_utente ="+request.getParameter("cod_utente")+";");
	String[] record = (String[]) vettore.elementAt(0);
%>
	<div id="div_log">
		<h4> Utente richiesto: </h4>
	 	Nome: <%=record[1]%> <br />
		Cognome: <%=record[2]%> <br />
		Id: <%=record[0]%> <br />
		Numero-Tel: <%=record[3]%> <br />
	</div>
	<br />
	<h3> Storico utente </h3>
	<br />

	<%
	for(int i=0;i<vettoreStorico.size();i++) {
		String[] recordStorico = (String[]) vettoreStorico.elementAt(i);
		%>

	<div id="div_log">
		<h4>Incidente passato n <%=i+1%> </h4>
	 	Nome: <%=recordStorico[0]%> <br />
		Tipo Barca: <%=recordStorico[2]%> <br />
		Tipo Problema: <%=recordStorico[1]%> <br />
	</div>
	<br />

<%
	}
}
%>
</body>
