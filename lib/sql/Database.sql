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
        CREATE TABLE Articles (
            articleId int NOT NULL AUTO_INCREMENT, PRIMARY KEY (articleId),
            heading Text NOT NULL,
            author VARCHAR(2000),
            article MEDIUMTEXT,
            arttime Time,
            artdate Date,
            mins int NOT NUll,
            userpic VARCHAR(5000),
            headerpic VARCHAR(5000),
            userid VARCHAR(200) NOT NUll,
            views int NOT NUll,
            FOREIGN KEY(userid) REFERENCES Users(userid)            
        );

   

--   //Create Courses Table
        CREATE TABLE Courses (
            courseid int NOT NULL AUTO_INCREMENT, PRIMARY KEY (courseid),
            title VARCHAR(500) NOT NULL,
            description VARCHAR(2000) NOT NULL,
            coursepic VARCHAR(5000) NOT NULL,   
            price int NOT NULL           
        );        

--   //Create Lesson Table
        CREATE TABLE Lessons (
            lessonid int NOT NULL AUTO_INCREMENT, PRIMARY KEY (lessonid),
            title VARCHAR(500) NOT NULL,
            description MEDIUMTEXT,
            videoUrl VARCHAR(5000) NOT NULL,
            typeOf VARCHAR(500) NOT NULL,
            time time,
            date date, 
            courseid int NOT NULL, 
            FOREIGN KEY(courseid) REFERENCES Courses (courseid)           
        );         



--   // I Created This Table to Verify Whether The User Has Logged In From This Computer Computer 
--   //Create Usercomputer Table 
        CREATE TABLE usercomputer (
            usercompidprimary int NOT NULL AUTO_INCREMENT, PRIMARY KEY (usercompidprimary),
            computerid VARCHAR(100) NOT NULL, 
            userid VARCHAR(200) NOT NULL,
            FOREIGN KEY(userid) REFERENCES Users(userid),   
            UNIQUE (userid)        
        );  



--   //Create Usercomputer Table 
        CREATE TABLE Admins(
            adminId int NOT NULL AUTO_INCREMENT, PRIMARY KEY (adminId),
            nameOf VARCHAR(1000) NOT NULL,            
            adminUsername VARCHAR(1000) NOT NULL, 
            passwd VARCHAR(1000) NOT NULL       
        );              


--   //Create Templates Table
        CREATE TABLE Templates (
            templateid int NOT NULL AUTO_INCREMENT, PRIMARY KEY (templateid),
            title Text NOT NULL,
            description MEDIUMTEXT,
            time Time,
            date Date,
            picture VARCHAR(5000) Not Null,
            folderUrl VARCHAR(5000) Not Null,
            userid VARCHAR(200) NOT NUll,
            FOREIGN KEY(userid) REFERENCES Users(userid)            
        ); 



--   //Create Templates Table
        CREATE TABLE ChatMessages (
            chatid int NOT NULL AUTO_INCREMENT, PRIMARY KEY (chatid), 
            usersname VARCHAR(5000) NOT NULL,           
            msg MEDIUMTEXT,
            pictureMsg VARCHAR(5000) NOT NULL,
            time Time,
            date Date,
            userPicture VARCHAR(5000) Not Null,
            userid VARCHAR(200) NOT NUll,
            FOREIGN KEY(userid) REFERENCES Users(userid)            
        );               



--   //Create VerifiedUsers Table
        CREATE TABLE VerifiedUsers (
            verifyid int NOT NULL AUTO_INCREMENT, PRIMARY KEY (verifyid), 
            email VARCHAR(5000) NOT NULL,UNIQUE (email),            
            verificationCode VARCHAR(20) NOT NULL       
        ); 