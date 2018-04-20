package com.EWSFunctionalTest.testConfigs;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
 
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
 
public class EWSDataBaseConnection {
    private Connection connection = null;
    private static final Logger logger = LoggerFactory.getLogger("com.intuit.karate");
 
    public EWSDataBaseConnection() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
 
    public Connection getDatabaseConnection(String dbUrl) {
        //System.out.println("Query"+Query);
        try {
            connection = DriverManager.getConnection(dbUrl);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }
 
    public void closeDatabaseConnection(Connection con) throws SQLException {
        logger.info("Database connection is closed now");
        this.connection = con;
        connection.close();
    }
}