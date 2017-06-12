<%@page import="java.sql.*,javax.sql.*,java.util.*,java.util.Date,java.text.*"%>
<%
try{
String option="";
if(request.getParameter("option") != null){
option=request.getParameter("option");
}
String filename="";
String filecontent="";

 filename=request.getParameter("filename");


ResultSet rs, rs1;

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "root");
Statement st=con.createStatement();

if(option.equals("S"))
{
     filecontent=request.getParameter("filecontent");
  rs = st.executeQuery("select * from filedetails where filename='" + filename + "'");
  rs.last();
  int rowCnt = rs.getRow();
  if(rowCnt == 0)
  {
    Date dt = new Date();
    SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String dates=formatter.format(dt);

    int i=st.executeUpdate("insert into filedetails(filename,filecontent,createddate) values('"+filename+"','"+filecontent+"','"+dates+"')");   
  }
  else
  {
    int i=st.executeUpdate("update filedetails set filecontent='"+filecontent+"' where filename='"+filename+"'");
  }

   //rs1 = st.executeQuery("select * from filedetails order by createddate desc");
}
else if (option.equals("D"))
{
   int i=st.executeUpdate("delete from filedetails where filename='"+filename+"'");
   //rs1 = st.executeQuery("select * from filedetails order by createddate desc");
}

  rs1 = st.executeQuery("select * from filedetails order by createddate desc");
	    String JSONData = null;
           
            while (rs1.next()) 
            {
                
		if(JSONData == null)
		{		
		 JSONData = "[{ \"Filename\" : \"" + rs1.getString("filename") + "\", ";
		 JSONData = JSONData + " \"FileContent\" : \"" + rs1.getString("filecontent") + "\" }";
		}
		else
		{
		 JSONData = JSONData + ",{ \"Filename\" : \"" + rs1.getString("filename") + "\", ";
		 JSONData = JSONData + " \"FileContent\" : \"" + rs1.getString("filecontent") + "\" }";
		}
            }
             
            if(JSONData == null)
            {
                JSONData = "[]";
            }
             else{
	    JSONData = JSONData.replaceAll("\n","\\\\n") + "]";
            }
	    response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
             
            out.println(JSONData);
}
catch(Exception e)
{
   out.print(e);
   e.printStackTrace();
}

%>