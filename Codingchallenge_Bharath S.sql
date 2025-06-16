create database CrimeManagement

CREATE TABLE Crime (
CrimeID INT PRIMARY KEY,
IncidentType VARCHAR(255),
IncidentDate DATE,
Location VARCHAR(255),
Description TEXT,
Status VARCHAR(20)
);

CREATE TABLE Victim (
VictimID INT PRIMARY KEY,
CrimeID INT,
Name VARCHAR(255),
ContactInfo VARCHAR(255),
Injuries VARCHAR(255),
Age INT,
FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);

CREATE TABLE Suspect (
SuspectID INT PRIMARY KEY,
CrimeID INT,
Name VARCHAR(255),
Description TEXT,
CriminalHistory TEXT,
SuspectAge INT,
FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);

INSERT INTO Crime (CrimeID, IncidentType, IncidentDate, Location, Description, Status)
VALUES
(1, 'Robbery', '2023-09-15', '123 Main St, Cityville', 'Armed robbery at a convenience store', 'Open'),
(2, 'Homicide', '2023-09-20', '456 Elm St, Townsville', 'Investigation into a murder case', 'Under Investigation'),
(3, 'Theft', '2023-09-10', '789 Oak St, Villagetown', 'Shoplifting incident at a mall', 'Closed');

INSERT INTO Victim (VictimID, CrimeID, Name, ContactInfo, Injuries,Age)
VALUES
(1, 1, 'John Doe', 'johndoe@example.com', 'Minor injuries',30),
(2, 2, 'Jane Smith', 'janesmith@example.com', 'Deceased',31),
(3, 3, 'Alice Johnson', 'alicejohnson@example.com', 'None',32);

INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, CriminalHistory,SuspectAge)
VALUES
(1, 1, 'Robber 1', 'Armed and masked robber', 'Previous robbery convictions',39),
(2, 2, 'Unknown', 'Investigation ongoing', NULL,20),
(3, 3, 'Suspect 1', 'Shoplifting suspect', 'Prior shoplifting arrests',45);


1. Select all open incidents.

   select * from crime where status ='Open'

2. Find the total number of incidents.

   select count(*)  'Total incidents' from Crime

 3.List all unique incident types.

   select distinct IncidentType from Crime 

 4.Retrieve incidents that occurred between '2023-09-01' and '2023-09-10'.

   select * from crime where IncidentDate between '2023-09-01' and '2023-09-10'

 5. List persons involved in incidents in descending order of age.

   select Name,Age from Victim order by Age desc

 6. Find the average age of persons involved in incidents.

    select avg(Age) from Victim

 7. List incident types and their counts, only for open cases.

   select IncidentType,count(*)  from crime where  Status='Open' group by IncidentType
    
8. Find persons with names containing 'Doe'.

   select * from Victim  where  Name like  '%Doe%'
   
9. Retrieve the names of persons involved in open cases and closed cases.

   select v.name from Victim v inner join Crime c on c.CrimeID=v.CrimeID where status='Open' or status='Closed'

10. List incident types where there are persons aged 30 or 35 involved.

     select v.name,v.Age from Victim v inner join Crime c on  c.CrimeID=v.CrimeID where Age=30 or Age=35

11. Find persons involved in incidents of the same type as 'Robbery'.

    select v.name from Victim v inner join Crime c on  c.CrimeID=v.CrimeID where IncidentType='Robbery'

12. List incident types with more than one open case.

     select incidenttype,count(*) as opencase
     from crime
     where status = 'Open'
     group by incidenttype
     having count(*) > 1;
   
13. List all incidents with suspects whose names also appear as victims in other incidents.

    select c.crimeid,c.incidenttype,s.name as suspectname
    from suspect s
    inner join crime c on s.crimeid = c.crimeid
    where s.name in (
    select name from victim
    where crimeid != s.crimeid
  )

14. Retrieve all incidents along with victim and suspect details.

   select c.CrimeID,c.IncidentType,c.IncidentDate,
   c.Location,c.Description,c.Status,v.name,s.name
   from Crime c 
   inner join 
   Victim v on c.CrimeID=v.CrimeID 
   inner join Suspect s on s.CrimeID=c.CrimeID

15. Find incidents where the suspect is older than any victim.

   select c.CrimeID,c.IncidentType,c.IncidentDate,
   c.Location,c.Description,c.Status,v.Age,s.SuspectAge
   from Crime c 
   inner join 
   Victim v on c.CrimeID=v.CrimeID 
   inner join Suspect s on s.CrimeID=c.CrimeID where v.Age<s.SuspectAge

16. Find suspects involved in multiple incidents

    select s.name from Suspect s inner join Crime c on s.CrimeID =c.crimeID group by s.name 
    having count(s.CrimeID)>1

17. List incidents with no suspects involved
    
    select c.* from crime c left join suspect s on c.crimeid = s.crimeid
    where s.suspectid is null

    
18. List all cases where at least one incident is of type 'Homicide' and all other incidents are of type 'Robbery'.

    select crimeid
    from crime
    group by crimeid
    having incidenttype = 'Homicide' >= 1
    and  incidenttype ='Robbery'
   
19.Retrieve a list of all incidents and the associated suspects, showing suspects for each incident, or 'No Suspect' if there are none.

    select c.crimeid, c.incidenttype, s.name 
    from crime c left join suspect s on c.crimeid = s.crimeid

20. List all suspects who have been involved in incidents with incident types 'Robbery' or 'Assault'
    
    select s.Name from Suspect s 
    inner join Crime c on
    s.CrimeID=c.CrimeID where c.IncidentType='Robbery' or c.IncidentType='Assault'
   

    
    



   
   
    