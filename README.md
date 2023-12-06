# CS157-Team7

The project aims to create a website for San Jose State University students, implementing a relational database management system. The website will serve as a centralized platform for students to explore and review various student clubs on campus. The goal is to enable students to search for specific clubs, read reviews from other students, and interact by leaving comments. The platform will encompass clubs from different majors, allowing easy browsing for students. A 5-star rating system will be in place for students to evaluate clubs. The website will provide essential details such as contact information and location, helping students make informed decisions about joining a club. Clubs can manage their webpages, utilizing student feedback to make improvements and attract new members. The primary stakeholders are students and university club leads who will operate and benefit from the platform.

## Setup
### Requirements
- MySQL version:  8.1.0 or later
- Server version: Apache Tomcat/8.5.93
- JVM Version:    20.0.2+9-78
- IntelliJ IDEA
- MySQL Workbench
    
### Deployment
0. Install Java SDK https://www.java.com/en/
1. Set environmental variable JAVA_HOME=C:\Program Files (x86)\Java\jre-1.8
2. Install Apache Tomcat https://tomcat.apache.org/download-80.cgi
3. Install MySQL Workbench https://www.mysql.com/products/workbench/
4. Install MySQL Server https://dev.mysql.com/downloads/mysql/
5. Setup MySQL Server to use port number 3306, user 'root', and password 'root'
6. Clone CS157-Team7 repository
7. Open MySQL Workbench, connect to your MySQL server, and create a new schema called 'clubspartan'
8. Run query CS157-Team7/club_spartan.sql for the 'clubspartan' schema
9. Depending on your platform, either run CS157-Team7/tomcat/bin/startup.bat for Windows or startup.sh for Mac/Linux
10. Open http://localhost:8080/ in any browser
