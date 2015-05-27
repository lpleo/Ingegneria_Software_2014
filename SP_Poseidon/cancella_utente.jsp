<%@ page import="pdtb.Database" %>
<%@page import="java.util.Vector"%> 
 <html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="stile.css" rel="stylesheet" type="text/css">	
	<title>Cancella utente</title>
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
			String query = "DELETE utenti FROM utenti WHERE id_utente = "+codice+";";
			String esTest = "SELECT id_utente FROM utenti WHERE id_utente="+codice+";";
			
			try {
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
					</div>
				</div>

				<div id="div_log_larga">
					Query di errore: <%=query%> <br />
					<%=dbase.getErrore()%> <br />
					<br />
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
					</div>
				</div>

				<div id="div_log_larga">
					Query di errore: <%=query%> <br />
					<%=dbase.getErrore()%> <br />
					<br />
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
