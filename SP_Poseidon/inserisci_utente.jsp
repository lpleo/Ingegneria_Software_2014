<%@ page import="pdtb.Database" %>
<%@page import="java.util.Vector"%> 
 <html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="stile.css" rel="stylesheet" type="text/css">	
	<title>Inserimento utente</title>
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
		Vector vettore = dbase.eseguiQuery("SELECT MAX(id_utente) FROM utenti;");
		String[] record = (String[]) vettore.elementAt(0);
		int numero = Integer.parseInt(record[0]);
		numero = numero+1;
		String query = "INSERT INTO utenti (id_utente, nome, cognome, numerotel, indirizzo) VALUES ("+ numero + ",'" +request.getParameter("nome_utente") + "','" + request.getParameter("cognome_utente") + "','" + request.getParameter("tel_utente") + "','" + request.getParameter("ind_utente") + "');";
		boolean successo = dbase.eseguiAggiornamento(query);
		if(successo) {
%>
		<div id="div_log">
		<h4> Inserimento riuscito dell'utente:</h4>
		Id: <%=numero%> <br />
	 	Nome: <%=request.getParameter("nome_utente")%> <br />
		Cognome: <%=request.getParameter("cognome_utente")%> <br />
		Via: <%=request.getParameter("ind_utente")%>
		Numero Telefono: <%=request.getParameter("tel_utente")%>
		</div>

		<div id="div_log">
			<form name="Torna" action="prima_schermata.jsp">
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
			<form name="Torna" action="prima_schermata.jsp">
				<input type="hidden" name="username" value="<%=request.getParameter("username")%>" />
				<input type="hidden" name="password" value="<%=request.getParameter("password")%>" />
				<input id="submit" type="submit" value="Torna alla Schermata principale"/>
			</form>
		</div>
<%
		}
	}
%>
</body>
