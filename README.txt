Setup database for derby
1. In netbeans, go to services > databases > Java DB > Create Database
2. Put these in the dialog box:
Database Name: ConaShopDB
User Name: cona
Password: admin1
3. Once that is done, you should have a mysql connection pointing to: jdbc:derby://localhost:1527/ConaShopDB
4. Go to Files > ConaShop.ph (Project Folder)> conaDBDerby.sql. You should see a db script.
5. Right click and select Run File, select the database connection that was generated earlier.
6. If everything goes well, the DB should be made. You can check Services for the tables if they are present, and their attributes correspond to those in the script.