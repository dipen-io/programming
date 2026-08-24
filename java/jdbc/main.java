class main() {
    public static void main(String[] args) {
       try {
           Class.forName("com.mysql.cj.jdbc.Driver"); // load the driver

           Connection conn  = DriverManager.getConection(
               "jdbc:mysql://localhost:3306/mysql", "username", "password"
           );
           Statement statement = conn.createStatement();
           String query = "select * from student"; // query but sting as jave

           Result res = statement.executeQury(query);
       }
       catch(Exception e) {
           e.printStackTrace();
       }
    }
}

// jar -> java archive (sharing code in java )
