<%@ page import="pdtb.database.Database" %>
<%@ page import="pdtb.connessioni.Connessioni" %>
<%@page import="java.util.Vector"%> 
 <html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="stile.css" rel="stylesheet" type="text/css">	
	<title>Database Iceberg</title>
 </head>
 <body>
 <jsp:useBean id="connetti" scope="session" class="pdtb.database.Database" /> 
 
 <%
 	/*
 	Salvo username e password in variabili, controllo se la connessione
 	esiste ed è attiva e mi connetto al database
 	*/
	String username = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");
	if(username == null || username.length() == 0) {
		username = request.getParameter("username");
		password = request.getParameter("password");
	}
	Connessioni conAttive = Connessioni.getInstance();
	boolean esiste = conAttive.esisteConnessione(username);
	Database dbase = new Database("iceberg",username,password);
	dbase.connetti();
	request.setAttribute("dblog",dbase);
	%>
 
 <form name="esci" action="esci.jsp" method="post">
 	<input type="hidden" name="username" value=<%=username%> />
	<input id="submit" type="submit" value="Disconnetti"/>
 </form>
 <b>  Benvenuto utente "<%=username%>" </b>
 <div style="text-align:center">
	<%
	
	/*
	Controllo se il database è effettivamente connesso
	altrimenti reindirizzo a pagina di errore
	*/
	
	if(dbase.isConnesso()==false || esiste==false) {
		String site = "errore_collegamento.html";
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", site);
	}
	else {
	%>
	
		<h2>Connessione al sistema riuscita.<br />
		Cosa si desidera fare? <br /></h2>
 </div>
		<div id="contenitore">
			<div id="div_log_sx">
				<div id="div_log"> 
				<h4>Ricerca utente e storico</h4>
					<form name="ricerut" action="ricerca_storico.jsp" method="post">
						Inserire il codice utente: <input name="cod_utente" type="text" /> <br />
						<input type="hidden" name="username" value="<%=username%>" />
						<input type="hidden" name="password" value="<%=password%>" />
						<br />
						<input id="submit" type="submit" value="Ricerca Utente"/>
						<br />
					</form>
				</div>
				<br />
				<div id="div_log"> 
					<h4>Inserimento nuovo utente</h4>
					<form name="insUt" action="inserisci_utente.jsp" method="post">
						<div  id="testo_sx">
							<table>
							<tr>
								<td>
								Nome:
								</td>
								<td>
								<input name="nome_utente" type="text" />
								</td>
							</tr>
							<tr>
								<td>
								Cognome:
								</td>
								<td>
								<input name="cognome_utente" type="text" />
								</td>
							</tr>
							<tr>
								<td>
								Telefono: 
								</td>
								<td>
								<input name="tel_utente" type="text" />
								</td>
							</tr>
							<tr>
								<td>
								Indirizzo:
								</td>
								<td>
								 <input name="ind_utente" type="text" /> <br />
								</td>
							</tr>
							</table>
							<input type="hidden" name="username" value="<%=username%>" />
							<input type="hidden" name="password" value="<%=password%>" />
						</div>
						</br>
						<input id="submit" type="submit" value="Inserisci Utente"/>
					</form>
				</div>
				<br />
				
				<div id="div_log"> 
				<h4>Cancellazione utente</h4>
					<form name="cancut" action="cancella_utente.jsp" method="post">
						Inserire il codice utente: <input name="cod_utente" type="text" /> <br />
						<input type="hidden" name="username" value="<%=username%>" />
						<input type="hidden" name="password" value="<%=password%>" />
						<br />
						<input id="submit" type="submit" value="Cancella Utente"/>
						<br />
						<h5> ATTENZIONE - le modifiche non potranno essere annullate </h5>
					</form>
				</div>
			
			</div>
			<div id="div_log_dx">
				<div id="div_log"> 
				<h4>Ricerca problemi</h4>
					<form name="ricerpb" action="ricerca_problema.jsp" method="post">
						Inserire il codice problema: <input name="cod_problema" type="text" /> <br />
						<input type="hidden" name="username" value="<%=username%>" />
						<input type="hidden" name="password" value="<%=password%>" />
						<br />
						<input id="submit" type="submit" value="Ricerca Problema"/>
					</form>
				</div>
				<br />
				<div id="div_log"> 
				<h4>Inserimento Report Storico</h4> 
					<form name="insSt" action="inserisci_storico.jsp" method="post">
						<div  id="testo_sx">
							<table>
							<tr>
								<td>
								Inserire codice problema: 
								</td>
								<td>
								<input name="cod_problema" type="text" />
								</td>
							</tr>
							<tr>
								<td>
								Inserire codice utente:
								</td>
								<td>
								<input name="cod_utente" type="text" />
								</td>
							</tr>
							<tr>
								<td>
								Inserire eventuale soluzione data:
								</br>
								</td>
							</tr>
							<tr>
								<td colspan="2">
								<textarea name="soluz" rows="5" cols="60"> </textarea>
								</td>
							</tr>
							</table>
							<input type="hidden" name="username" value="<%=username%>" />
							<input type="hidden" name="password" value="<%=password%>" />
						</div>
						</br>
						<input id="submit" type="submit" value="Inserisci Storico"/>
					</form>
				</div>
				</br>
				<div id="div_log">
				</br>
				</br>
				<h5>Subproject NeptuneRescue - Version 1.2 - For authorized personnel only</h5>
				</br>
				</br>
				</div>
			</div>
			<div id="div_fine">
			</div>
			
		</div>
		<%
		
	/*
	Chiudo il collegamento con il database
	*/
	dbase.disconnetti();
	}
		%>
 </body>
 </html>
