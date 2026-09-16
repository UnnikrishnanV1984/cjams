--Requesting to EXIT Placement AGAIN (re-using same placement id) as Case worker
select * from routingintake('9afee869-3aba-4b8e-9a7a-0f4fe538a40c','262f71d0-64d5-4eaf-bd7a-b0901803706c','PLTR',15,'','',false,false,false,'Placement Exit Submitted for review','Placement Exit Submitted for review','9365e5b5-836f-4357-b03e-680f2abd5c2a','',1);

--Inserting record in to placementrevision table with provided enddate.
select * from placementrevisionupdate('9afee869-3aba-4b8e-9a7a-0f4fe538a40c',null,null,null,null,'05/14/2020','09:09','PLCC','admin data fix','PLCCGR',0,'262f71d0-64d5-4eaf-bd7a-b0901803706c',null);

--Approve placement EXIT Request as Supervisor
SELECT * FROM routingintake('9afee869-3aba-4b8e-9a7a-0f4fe538a40c','b65af552-0e15-483e-9f1b-d6ffdd2ebced','PLTR',16,'admin data fix','',false,false,false,'Child Placement Approved','Child Placement Approved','9365e5b5-836f-4357-b03e-680f2abd5c2a','',1);