--Requesting to EXIT Placement AGAIN (re-using same placement id) as Case worker
select * from routingintake('94422d40-18c8-4ce5-b665-65773fc6fa3b','fda44521-a8bb-4f30-9fac-dcd8fa209f15','PLTR',15,'','',false,false,false,'Placement Exit Submitted for review','Placement Exit Submitted for review','9b38ff67-2daf-49d1-a2c1-806b73359802','',1);

--Inserting record in to placementrevision table with provided enddate.
select * from placementrevisionupdate('94422d40-18c8-4ce5-b665-65773fc6fa3b',null,null,null,null,'03/12/2020','09:09','PLCC','admin data fix','PLCCR',0,'fda44521-a8bb-4f30-9fac-dcd8fa209f15',null);

--Approve placement EXIT Request as Supervisor
SELECT * FROM routingintake('94422d40-18c8-4ce5-b665-65773fc6fa3b','a72ed886-4123-4088-8d2f-6394a37bc67c','PLTR',16,'admin data fix','',false,false,false,'Child Placement Approved','Child Placement Approved','9b38ff67-2daf-49d1-a2c1-806b73359802','',1);