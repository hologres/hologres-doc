# Connect to Hologres


## psql

## JDBC

<br />Hologres offer JDBC/ODBC Driver,that means you can use  JDBC to connect Hologres,steps are as floowing:
<a name="ZN0It"></a>

### Step 1:mvn
Download PostgreSQL JDBC Driver 42.xxx, and configurate mvn.
```
<dependencies>
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <version>42.2.8.jre6</version> 
                                             
        </dependency>
    </dependencies>
```


<a name="U3ms8"></a>
### step2:Connect Hologres
```java
public class HologresTest {

    private void jdbcExample() throws Exception {
        String url = "jdbc:postgresql://{ENDPOINT}:{PORT}/{DBNAME}?user={ACCESS_ID}&password={ACCESS_KEY}";
        Connection conn = DriverManager.getConnection(url);
        Statement st = conn.createStatement();
        String sql = "SELECT * FROM table where xxx limit 100";
        ResultSet rs = st.executeQuery(sql);
        String c1 = rs.getString(1);
    }
}
```