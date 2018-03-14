
import java.sql.Connection;
import java.io.IOException;

import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicHeader;
import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.util.EntityUtils;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.json.JSONObject;
import org.json.JSONTokener;
import org.json.JSONException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Main {

	 static final String USERNAME     = "jason_daou@me.com";
	    static final String PASSWORD     = "RtH-teP-eXU-T9CyASPzqJkVSXhq5rCwDdbZfHG1";
	    static final String LOGINURL     = "https://login.salesforce.com";
	    static final String GRANTSERVICE = "/services/oauth2/token?grant_type=password";
	    static final String CLIENTID     = "3MVG9CEn_O3jvv0z3Xm.V.MzAcNNTuReJDz4NrP6zGIuHRj.ra3ICw3zKo6XmevbtAocPQaxgcnfoXFWRWxQE";
	    static final String CLIENTSECRET = "8187518326608010771";
	    private static Header oauthHeader;
	    private static Header prettyPrintHeader = new BasicHeader("X-PrettyPrint", "1");
	    private static String baseUri;
    
	public static void main(String[] args) {
		String loginURL = LOGINURL + 
                GRANTSERVICE + 
                "&client_id=" + CLIENTID + 
                "&client_secret=" + CLIENTSECRET +
                "&username=" + USERNAME +
                "&password=" + PASSWORD;

// Login requests must be POSTs
HttpPost httpPost = new HttpPost(loginURL);
HttpResponse response = null;
DefaultHttpClient httpclient = new DefaultHttpClient();

try {
  // Execute the login POST request
  response = httpclient.execute(httpPost);
} catch (ClientProtocolException cpException) {
  // Handle protocol exception
} catch (IOException ioException) {
  // Handle system IO exception
}

// verify response is HTTP OK
final int statusCode = response.getStatusLine().getStatusCode();
if (statusCode != HttpStatus.SC_OK) {
  System.out.println("Error authenticating to Force.com: "+statusCode);
  // Error is in EntityUtils.toString(response.getEntity()) 
  return;
}
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			// Register a driver for the MySQL database
			Class.forName("com.mysql.jdbc.Driver");
			// Create a url for accessing the MySQL
			// database CarDB
			String url = "jdbc:mysql://localhost:3306/deloitte";
			// user and password to access the database
			String username = "root";
			String password = "root";
			// User the DriverManager to get a Connection to the database
			conn = DriverManager.getConnection(url, username, password);
			// Create a  PreparedStatement
			String query = "Select * from SourceData;";
			stmt = conn.prepareStatement(query);
			// Executing the SQL with PreparedStatement object
			// execute() method
			Boolean result = stmt.execute();
			ResultSet resultSet = null;
			// if result true it is a ResultSet
			if (result) {
				resultSet = stmt.getResultSet();
			}
			// As cursor is at the before first row position
			// we use the next() method to
			// test and read the first row in the ResultSet.
			if (resultSet.next()) {
				// Then we use a loop to retrieve rows and column data
				// and creates a html coded table output
				//		    System.out.println("<table border='1' >");
				//		    System.out.println("<tr>");
				//		    System.out.print("<th>regNo</th>");
				//		    System.out.println("<th>cartype</th>");
				//		    System.out.println("<th>model</th>");
				//		    System.out.println("<th>day<br/>Price</th>");
				//		    System.out.println("<th>Cost</th>");
				//		    System.out.println("</tr>");
				do {
					//		     System.out.println("<tr>");
					//		     System.out.print("<td>" + resultSet.getString("regNo") + "</td>");
					//		     System.out.println("<td>" + resultSet.getString("cartype") + "</td>");
					//		     System.out.println("<td>" + resultSet.getInt("model") + "</td>");
					//		     System.out.println("<td>" + resultSet.getDouble("dayPrice") + "</td>");
					//		     System.out.println("<td>" + resultSet.getDouble("TotalCost") + "</td>");
					//		     System.out.println("</tr>");
					System.out.println(resultSet.getString("CID"));
					createLeads(resultSet);
				} while (resultSet.next());
				//System.out.println("</table>");
			}
		} catch (ClassNotFoundException ex) {
			//Logger.getLogger(SQLAlter.class.getName()).log(Level.SEVERE, null, ex);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				// Close the Statement, which also close the ResultSet
				stmt.close();
				conn.close();
			} catch (Exception xe) {
				xe.printStackTrace();
			}
		}
	}
public static void createLeads(ResultSet resultSet) {
    System.out.println("\n_______________ Lead INSERT _______________");

    String uri = baseUri + "/sobjects/Lead/";
    
    try {
        //create the JSON object containing the new lead details.
    JSONObject newCase = new JSONObject();
    	newCase.put("AID", resultSet.getString("AID"));
    	newCase.put("CID", resultSet.getString("CID")); 
    	newCase.put("Name", resultSet.getString("Name"));

        //Construct the objects needed for the request
        HttpClient httpClient = HttpClientBuilder.create().build();

        HttpPost httpPost = new HttpPost(uri);
        httpPost.addHeader(oauthHeader);
        httpPost.addHeader(prettyPrintHeader);
        // The message we are going to post
        StringEntity body = new StringEntity(newCase.toString(1));
        body.setContentType("application/json");
        httpPost.setEntity(body);

        //Make the request
        HttpResponse response = httpClient.execute(httpPost);

        //Process the results
        int statusCode = response.getStatusLine().getStatusCode();
        if (statusCode == 201) {
            String response_string = EntityUtils.toString(response.getEntity());
            JSONObject json = new JSONObject(response_string);
            // Store the retrieved lead id to use when we update the lead.
            String leadId = json.getString("id");
            System.out.println("New Lead id from response: " + leadId);
        } else {
            System.out.println("Insertion unsuccessful. Status code returned is " + statusCode);
        }
    } catch (JSONException e) {
        System.out.println("Issue creating JSON or processing results");
        e.printStackTrace();
    } catch (IOException ioe) {
        ioe.printStackTrace();
    } catch (NullPointerException npe) {
        npe.printStackTrace();
    } catch (SQLException sqle) {
    	sqle.printStackTrace();
    }
    
}
}
