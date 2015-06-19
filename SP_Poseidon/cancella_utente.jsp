<%@ page import="pdtb.database.Database" %>
<%@ page import="pdtb.connessioni.Connessioni" %>
<%@page import="java.util.Vector"%> 
 <html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="stile.css" rel="stylesheet" type="text/css">	
	<title>Cancella utente</title>
 </head>
 <body> 
<%	
	/*
	Testo l'esistenza della connessione e la connessione con il database,
	se uno dei due rimanda esito negativo rimando ad una pagina di errore.
	*/
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
		/*
		Testo la presenza del campo codice utente, se non è stato inserito mostro 
		una pagina di errore.
		*/
		String codice = request.getParameter("cod_utente");
		if(codice.length()==0) {
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
			/*Creo le query*/
			String query = "DELETE utenti FROM utenti WHERE id_utente = "+codice+";";
			String esTest = "SELECT id_utente FROM utenti WHERE id_utente="+codice+";";
			
			try {
				/*
				Testo l'esecuzione della query, se l'utente è stato effettivamente eliminato
				rimando ad una pagina di conferma, altrimenti rimando ad una pagina di errore.
				*/
				Vector vettore = dbase.eseguiQuery(esTest);
				boolean successo = dbase.eseguiAggiornamento(query);
				
			if(successo && vettore.size()>0) {
%>
				<div id="div_log_larga">
					<div id="testo_sx">
						<h3> Cancellazione riuscita dell'utente: <%=codice%> </h3>
					</div>
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
						<h3> Errore nella cancellazione dell'utente: <%=codice%> </h3>
						<h4> L'utente non &#232 riconosciuto dal sistema </h4>
					</div>
					</ br>
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
			catch(Exception e) {
%>
				<div id="div_log_larga">
					<div id="testo_sx">
						<h3> Errore nella cancellazione dell'utente: <%=codice%> </h3>
						<h4> L'utente non &#232 riconosciuto dal sistema </h4>
					</div>
					</ br>
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
