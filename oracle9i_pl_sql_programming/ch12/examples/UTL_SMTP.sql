REM UTL_SMTP.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates the use of the UTL_SMTP package.

DECLARE
  v_FromAddr VARCHAR2(50) := 'Oracle';
  v_ToAddr VARCHAR2(50) := 'YOUR_EMAIL_ADDRESS';
  v_Message VARCHAR2(200);
  
  -- Address of an SMTP server.  On Unix systems, 'localhost'
  -- will often work.
  v_MailHost VARCHAR2(50) := 'localhost';
  v_MailConnection UTL_SMTP.Connection;
BEGIN
  -- Message to be sent.  The message fields (from, subject, etc.)
  -- should be separated by carriage returns, which is CHR(10) on
  -- most systems.
  v_Message := 
    'From: ' || v_FromAddr || CHR(10) ||
    'Subject: Hello from PL/SQL!' || CHR(10) ||
    'This message sent to you courtesy of the UTL_SMTP package.';

  -- Open the connection to the server.
  v_MailConnection := UTL_SMTP.OPEN_CONNECTION(v_MailHost);
  
  -- Using SMTP messages, send the email.
  UTL_SMTP.HELO(v_MailConnection, v_MailHost);
  UTL_SMTP.MAIL(v_MailConnection, v_FromAddr);
  UTL_SMTP.RCPT(v_MailConnection, v_ToAddr);
  UTL_SMTP.DATA(v_MailConnection, v_Message);
  
  -- Close the connection.
  UTL_SMTP.QUIT(v_MailConnection);
END;
/
