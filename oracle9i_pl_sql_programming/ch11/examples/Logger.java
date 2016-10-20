// Logger.java
// Chapter 11, Oracle9i PL/SQL Programming by Scott Urman
// This class will record information about connects and disconnects
// in the connect_audit table.

import java.sql.*;
import oracle.jdbc.driver.*;

public class Logger {
  public static void LogConnect(String userID)
    throws SQLException {
    // Get default JDBC connection
    Connection conn = new OracleDriver().defaultConnection();

    String insertString =
      "INSERT INTO connect_audit (user_name, operation, timestamp)" +
      "  VALUES (?, 'CONNECT', SYSDATE)";

    // Prepare and execute a statement that does the insert
    PreparedStatement insertStatement =
      conn.prepareStatement(insertString);
    insertStatement.setString(1, userID);
    insertStatement.execute();
  }

  public static void LogDisconnect(String userID)
    throws SQLException {
    // Get default JDBC connection
    Connection conn = new OracleDriver().defaultConnection();

    String insertString =
      "INSERT INTO connect_audit (user_name, operation, timestamp)" +
      "  VALUES (?, 'DISCONNECT', SYSDATE)";

    // Prepare and execute a statement that does the insert
    PreparedStatement insertStatement =
      conn.prepareStatement(insertString);
    insertStatement.setString(1, userID);
    insertStatement.execute();
  }
}
