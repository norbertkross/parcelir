--   //THESE QUERIES WERE TESTED IN MYSQL. WATCHOUT FOR DIFFERENT SYNTAX FROM YOUR DATABASE      


CREATE DATABASE parcelir;

--   //Create User Table
        CREATE TABLE Users (
            userid int NOT NULL AUTO_INCREMENT,PRIMARY KEY (userid),
            name VARCHAR(500) NOT NULL,
            email VARCHAR(500) NOT NULL,
            password VARCHAR(1000) NOT NULL, 
            phonenumber VARCHAR(20) NOT NULL              
        );




--   //Create Notifications Table
        CREATE TABLE Admins (
            adminid int NOT NULL AUTO_INCREMENT, PRIMARY KEY (adminid),        
            email VARCHAR(200) NOT NULL,
            password VARCHAR(200) NUll
            
        );





--   //Create Articles Table
        CREATE TABLE ItemsData (
            delivid int NOT NULL AUTO_INCREMENT, PRIMARY KEY (delivid),                       
            senderName VARCHAR(200) NOT NUll,
            reciepientName VARCHAR(500) NOT NUll,
            smobile VARCHAR(15) NOT NUll,            
            rmobile VARCHAR(15) NOT NUll,
            destination VARCHAR(500) NOT NUll,
            itemName VARCHAR(1000) NOT NUll,
            itemsCost VARCHAR(500) NOT NUll,
            payOnDelivery VARCHAR(500) NOT NUll,  
            time time,
            date date,
            picture VARCHAR(1000),
            isDelivered VARCHAR(10),
            recieverPicture VARCHAR(1000)
        );

   
