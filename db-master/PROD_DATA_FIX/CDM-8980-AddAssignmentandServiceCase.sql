-- CDM-8980 - Create new service cases and add assignment for the case

select * from createservicecase('ad9f3f30-1f64-44b2-a634-f1f28cbc09b6', null, 1, '5441e371-06f7-410f-bae0-e96ae5fcab22') ;

INSERT INTO caseassignment
(fromworkeridno, toworkeridno, insertedby, updatedby, 
insertedon, updatedon, objecttypekey, objectid,responsibilitytypekey,startdate, effectivedate , effectivetime, 
fromteamid,toteamid,remarks,statustypekey,toldssid,fromldssid,assignmenttype)
VALUES('11c49ec3-6a5b-4b09-a78a-ccaab244de50','5441e371-06f7-410f-bae0-e96ae5fcab22','CDM-8980','CDM-8980',
'2021-01-06 13:40:18','2021-01-06 13:40:18','servicecase','600d908d-1a38-4bd8-8a14-b9517b46854f','family','2021-01-06 13:40:18','2021-01-06 13:40:18','2021-01-06 13:40:18',
'a88ea485-4e05-4c71-9765-18c5f71a6ba2','a88ea485-4e05-4c71-9765-18c5f71a6ba2',
null,null,'b26afb64-6b7f-462e-8074-cfdc9cce04c4',
'b26afb64-6b7f-462e-8074-cfdc9cce04c4','W');