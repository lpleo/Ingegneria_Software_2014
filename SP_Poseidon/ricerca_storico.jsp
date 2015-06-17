<%@ page import="pdtb.Database" %>
<%@page import="java.util.Vector"%>
<%@ page import="pdtb.Connessioni" %>
 <html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="stile.css" rel="stylesheet" type="text/css">	
	<title>Ricerca e storico</title>
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
		try {
			String query = "select * from utenti u where u.id_utente ="+request.getParameter("cod_utente")+";";
			Vector vettore = dbase.eseguiQuery(query);
			Vector vettoreStorico = dbase.eseguiQuery("SELECT u.nome, p.tipo_problema, p.tipo_barca FROM utenti u, storico s, problemi p WHERE u.id_utente = s.id_utenza AND s.id_problemi = p.id_problema AND u.id_utente ="+request.getParameter("cod_utente")+";");
			String[] record = (String[]) vettore.elementAt(0);
%>
		<div id="div_log_larga">
			<div id="testo_sx">
				<h3> Utente richiesto </h3>
			</div>
		</div>
		<div id="div_log_larga">
		 	Nome: <%=record[1]%> <br />
			Cognome: <%=record[2]%> <br />
			Id: <%=record[0]%> <br />
			Numero-Tel: <%=record[3]%> <br />
			<br />
			<form name="Torna" action="prima_schermata.jsp" method="post">
				<input type="hidden" name="username" value="<%=request.getParameter("username")%>" />
				<input type="hidden" name="password" value="<%=request.getParameter("password")%>" />
				<input id="submit" type="submit" value="Torna alla Schermata principale"/>
			</form>
		</div>
		<br />
		<div id="div_log_larga">
			<div id="testo_sx">
				<h3> Storico utente </h3>
			</div>
		</div>
<%
			for(int i=0;i<vettoreStorico.size();i++) {
				String[] recordStorico = (String[]) vettoreStorico.elementAt(i);
%>

		<div id="div_log_larga">
			<h4>Incidente passato n <%=i+1%> </h4>
		 	Nome: <%=recordStorico[0]%> <br />
			Tipo Barca: <%=recordStorico[2]%> <br />
			Tipo Problema: <%=recordStorico[1]%> <br />
		</div>


<%
		
				}
			}
		catch (Exception e) {
%>
			<div id="div_log_larga">
			<h3>Rilevato un problema</h3>
			<h4> l'utente di id <%=request.getParameter("cod_utente")%> non &#232 presente nel sistema </h4>
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
	dbase.disconnetti();
%>
</body>
