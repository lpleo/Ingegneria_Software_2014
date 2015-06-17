<%@ page import="pdtb.Database" %>
<%@page import="java.util.Vector"%>
<%@ page import="pdtb.Connessioni" %>
 <html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="stile.css" rel="stylesheet" type="text/css">	
	<title>Inserimento utente</title>
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
		Vector vettore = dbase.eseguiQuery("SELECT MAX(id_utente) FROM utenti;");
		String[] record = (String[]) vettore.elementAt(0);
		int numero = Integer.parseInt(record[0]);
		numero = numero+1;
		
		String nome = request.getParameter("nome_utente");
		String cognome = request.getParameter("cognome_utente");
		String telefono = request.getParameter("tel_utente");
		String indirizzo = request.getParameter("ind_utente");
		
		if(nome.length()==0 || cognome.length()==0 || telefono.length()==0 || indirizzo.length()==0) {
%>
		<div id="div_log_larga">
			<h3> Problema </h3>
			<h4> Tutti i parametri di inserimento devono essere completati </h4>
			
		</div>
		<div id="div_log_larga">
			<form name="Torna" action="prima_schermata.jsp" method="post">
				<input type="hidden" name="username" value="<%=request.getParameter("username")%>" />
				<input type="hidden" name="password" value="<%=request.getParameter("password")%>" />
				<input id="submit" type="submit" value="Torna alla Schermata principale"/>
			</form>
		</div>
<%
		}
		
		else {
		
			String query = "INSERT INTO utenti (id_utente, nome, cognome, numerotel, indirizzo) VALUES ("+ numero + ",'" +nome+ "','" +cognome+ "','" +telefono+ "','" +indirizzo+ "');";
			boolean successo = dbase.eseguiAggiornamento(query);
			if(successo) {
%>
			<div id="div_log_larga">
			<div id="testo_sx">
				<h3> Inserimento riuscito dell'utente: </h3>
			</div>
			</div>
			
			<div id="div_log_larga">
			Id: <%=numero%> <br />
		 	Nome: <%=request.getParameter("nome_utente")%> <br />
			Cognome: <%=request.getParameter("cognome_utente")%> <br />
			Via: <%=request.getParameter("ind_utente")%> <br />
			Numero Telefono: <%=request.getParameter("tel_utente")%> <br />
			</div>

			<div id="div_log_larga">
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
			<div id="div_log_larga">
				<div id="testo_sx">
					<h3> Errore nell'inserimento del nuovo utente: </h3>
				</div>
			</div>
			<div id="div_log_larga">
			Id: <%=numero%> <br />
		 	Nome: <%=nome%> <br />
			Cognome: <%=cognome%> <br />
			Via: <%=indirizzo%> <br />
			Numero Telefono: <%=telefono%> <br />
			</div>
		
			<div id="div_log_larga">
				<form name="Torna" action="prima_schermata.jsp" method="post">
					<input type="hidden" name="username" value="<%=request.getParameter("username")%>" />
					<input type="hidden" name="password" value="<%=request.getParameter("password")%>" />
					<input id="submit" type="submit" value="Torna alla Schermata principale"/>
				</form>
			</div>
<%
			}
		}
	}
	dbase.disconnetti();
%>
</body>
