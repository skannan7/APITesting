package com.EWSFunctionalTest.testConfigs;
 
import org.awaitility.core.ConditionTimeoutException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
 
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.TimeUnit;
 
import static org.awaitility.Awaitility.given;
 
public class EWSDatabaseRetrieveData {
 
    private Connection connection;
    private Statement st;
    private ResultSet rs;
    private static final Logger logger = LoggerFactory.getLogger("com.intuit.karate");
 
    public EWSDatabaseRetrieveData(Connection connect) {
        this.connection = connect;
    }
 
    public List<Map<String, Object>> executeDatabaseQueryUsingPolling(String query) throws SQLException {
        try {
            st = connection.createStatement();
 
            given().pollDelay(10, TimeUnit.SECONDS).pollInterval(10, TimeUnit.SECONDS).
                    await().atMost(60, TimeUnit.SECONDS).until(new Callable<Boolean>() {
                @Override
                public Boolean call() throws Exception {
                    rs = st.executeQuery(query);
                    return rs.isBeforeFirst();
                }
            });
            return convertResultSetToList(rs);
        } catch (ConditionTimeoutException e) {
            logger.info("Database Query did not return any results, and the following error occurred : " + e.getMessage());
            throw e;
        } finally {
            st.close();
        }
    }
    

    
    private List<Map<String, Object>> convertResultSetToList(ResultSet rs) throws SQLException {
        ResultSetMetaData md = rs.getMetaData();
        int columns = md.getColumnCount();
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        while (rs.next()) {
            Map<String, Object> row = new HashMap<String, Object>(columns);
            for (int i = 1; i <= columns; ++i) {
 
                row.put(md.getColumnName(i), rs.getObject(i));
            }
            list.add(row);
        }
        return list;
    }
}
    
    