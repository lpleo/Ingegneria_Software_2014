<%@ page import="pdtb.Database" %>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Arrays"%> 
 <html>
 <head>
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <title>Database</title>
 </head>
 <body>
  <jsp:useBean id="connetti" scope="session" class="pdtb.Database" /> 
 <h3>Database</h3>
 <div style="text-align:center">
	<%
	Database dbase = new Database("iceberg",request.getParameter("username"),request.getParameter("password"));
	dbase.connetti();
	if(dbase.isConnesso()==false) {
		String site = "errore_collegamento.html";
		response.setStatus(response.SC_MOVED_TEMPORARILY);
   		response.setHeader("Location", site);
	}
	else {
	%>
	
		Mi sono collegato al database <%=dbase.isConnesso()%> <br />
		<h4> tentativo di retrieve della tabella utenti </h4> <br /> <br />
		<%
		Vector vettore = dbase.eseguiQuery("select * from utenti;"); 
		%>

		<%
		for(int i=0;i<vettore.size();i++) {
			String[] record = (String[]) vettore.elementAt(i);
		%>
		Utente <%=i+1%>: <br />
		Id: <%=record[0]%> <br />
	 	Nome: <%=record[1]%> <br />
		Cognome: <%=record[2]%> <br />
		Numero-Tel: <%=record[3]%> <br />
		<br />
		<br />
		<%
		}
	}
		%>
 <br />
 </div>
 </body>
 </html>
