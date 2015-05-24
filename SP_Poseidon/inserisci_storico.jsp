<%@ page import="pdtb.Database" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@page import="java.util.Vector"%> 

 <html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="stile.css" rel="stylesheet" type="text/css">	
	<title>Inserimento storico</title>
 </head>
 <body> 
<%
	Database dbase = new Database("iceberg",request.getParameter("username"),request.getParameter("password"));
	dbase.connetti();
	if(dbase.isConnesso()==false) {
		dbase.disconnetti();
		String site = "errore_collegamento.html";
		response.setStatus(response.SC_MOVED_TEMPORARILY);
   		response.setHeader("Location", site);
	}
	else {
		Vector vettore = dbase.eseguiQuery("SELECT MAX(id_report) FROM storico;");
		GregorianCalendar gc = new GregorianCalendar();
		String data = "'"+gc.get(Calendar.YEAR)+"-"+gc.get(Calendar.MONTH)+"-"+gc.get(Calendar.DATE)+"',";
		String[] record = (String[]) vettore.elementAt(0);
		int numero = Integer.parseInt(record[0]);
		numero = numero+1;
		String query = "INSERT INTO storico VALUES ("+ numero + ", " +request.getParameter("cod_problema") + " , " + request.getParameter("cod_utente") + " ," + data + " '" + request.getParameter("soluz") +"');";
		boolean successo = dbase.eseguiAggiornamento(query);
		if(successo) {
%>
		<div id="div_log">
		<h4> Aggiornamento dello storico riuscito:</h4>
		Id Problema: <%=numero%> <br />
	 	Codice Problema: <%=request.getParameter("cod_problema")%> <br />
		Codice Utente: <%=request.getParameter("cod_utente")%> <br />
		</div>

		<div id="div_log">
			<form name="Torna" action="prima_schermata.jsp" method="post">
				<input type="hidden" name="username" value="<%=request.getParameter("username")%>" />
				<input type="hidden" name="password" value="<%=request.getParameter("password")%>" />
				<input id="submit" type="submit" value="Torna alla Schermata principale"/>
			</form>
		</div>
<%			
		}
		else {
%>
		<div id="div_log">
			Query: <%=query%> <br />
			<%=dbase.getErrore()%> <br />
		</div>
		
		<div id="div_log">
			<form name="Torna" action="prima_schermata.jsp" method="post">
				<input type="hidden" name="username" value="<%=request.getParameter("username")%>" />
				<input type="hidden" name="password" value="<%=request.getParameter("password")%>" />
				<input id="submit" type="submit" value="Torna alla Schermata principale"/>
			</form>
		</div>
<%
		}
	}
	dbase.disconnetti();
%>
</body>
