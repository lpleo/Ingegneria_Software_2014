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
			String query = "select * from problemi p where p.tipologia ='"+request.getParameter("cod_problema")+"';";
			String queryStorico = "select p.id_problema, p.tipologia, s.id_utenza, s.data_report, s.desc_report from problemi p, storico s where p.tipologia ='" + request.getParameter("cod_problema")+"' and s.id_problemi = p.id_problema;";
			Vector vettore = dbase.eseguiQuery(query);
			Vector vettoreStorico = dbase.eseguiQuery(queryStorico);
			String[] record = (String[]) vettore.elementAt(0);
%>
			<div id="div_log_larga">
			<div id="testo_sx">
				<h3> Problema richiesto: </h3>
			</div>
			</div>
			<div id="div_log_larga">
				<b>id: <%=record[0]%></b> <bt /> <br />
			 	Tipo problema: <%=record[1]%> <br /><br />
				<b>Soluzione consigliata all'utente:</b><br /> <%=record[2]%> <br /><br/>
				Tipo di barca: <%=record[3]%> <br />
				Categoria problema: <%=record[4]%> <br />
				<br />
				<form name="Torna" action="prima_schermata.jsp" method="post">
				<input type="hidden" name="username" value="<%=request.getParameter("username")%>" />
				<input type="hidden" name="password" value="<%=request.getParameter("password")%>" />
				<input id="submit" type="submit" value="Torna alla Schermata principale"/>
				</form>
			</div>
			
			<br />
			<br />
			<div id="div_log_larga">
				<div id="testo_sx">
					<h3> Incidenti passati simili </h3>
				</div>	
			</div>
<%
			for(int i=0;i<vettoreStorico.size();i++) {
				String[] recordStorico = (String[]) vettoreStorico.elementAt(i);
%>
			<div id="div_log_larga">
				<h4>Incidente simile n <%=i+1%> </h4>
			 	Id utente: <%=recordStorico[2]%> <br />
			 	Id problema: <%=recordStorico[1]%> <br />
				Data report: <%=recordStorico[3]%>
				<h4>Evenuale risoluzione:</h4> <%=recordStorico[4]%> <br />
			</div>

<%
			}
		}
		catch (Exception e) {
%>
			<div id="div_log_larga">
			<h3>Rilevato un problema</h3>
			<!--Query: <=query> <br />-->
			<h4> Il problema di id <%=request.getParameter("cod_problema")%> non &#232 presente nel sistema </h4>
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
