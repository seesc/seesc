package com.esc.db;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;

public class EscDB {
   static DataSource ds;
   static{
      try {
      Context initContext = new InitialContext();
      Context envContext  = (Context)initContext.lookup("java:/comp/env");
      ds = (DataSource)envContext.lookup("jdbc/myoracle");
      }catch (Exception e) {
         e.printStackTrace();
      }
   }
   
      public static Connection getConn() throws Exception{
         return ds.getConnection();
         
      }
}