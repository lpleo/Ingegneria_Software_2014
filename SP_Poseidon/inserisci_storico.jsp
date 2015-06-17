<%@ page import="pdtb.Database" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@page import="java.util.Vector"%> 
<%@ page import="pdtb.Connessioni" %>

 <html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="stile.css" rel="stylesheet" type="text/css">	
	<title>Inserimento storico</title>
 </head>
 <body> 
<%
	Connessioni conAttive = Connessioni.getInstance();
	boolean esiste = conAttive.esisteConnessione(request.getParameter("username"));
	Database dbase = new Database("iceberg",request.getParameter("username"),request.getParameter("password"));
	dbase.connetti();
	if(dbase.isConnesso()==false||esiste==false) {
		dbase.disconnetti();
		String site = "errore_collegamento.html";
		response.setStatus(response.SC_MOVED_TEMPORARILY);
   		response.setHeader("Location", site);
	}
	else {
		Vector vettore = dbase.eseguiQuery("SELECT MAX(id_report) FROM storico;");
		Vector idProblema = dbase.eseguiQuery("SELECT id_problema FROM problemi WHERE tipologia='"+request.getParameter("cod_problema")+"';");
		GregorianCalendar gc = new GregorianCalendar();
		String data = "'"+gc.get(Calendar.YEAR)+"-"+gc.get(Calendar.MONTH)+"-"+gc.get(Calendar.DATE)+"',";
		String[] record = (String[]) vettore.elementAt(0);
		int numero = Integer.parseInt(record[0]);
		numero = numero+1;
		String idProb="";
		if(idProblema.size() > 0) {
			record = (String[]) idProblema.elementAt(0);
			idProb = record[0];
		}
		
		String query = "INSERT INTO storico VALUES ("+ numero + ", " + idProb + " , " + request.getParameter("cod_utente") + " ," + data + " '" + request.getParameter("soluz") +"');";
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
			<h3> Errore nell'inserimento dello storico </h3>
			<h4> Controllare l'esattezza dei campi di inserimento </h4>
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
