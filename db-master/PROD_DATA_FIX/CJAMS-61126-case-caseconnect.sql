/*
Issue:251023076797:Tried to case connect and it auto opened two cases. Please DISCONNECT and remove any thing from 251030545927 and 251030545926Investigations 251023074726, 251023076797 and 251023076798 should be connected to 251030490298
Root Cause:User request to delete servicecase and connecte servicase required CPS-IR
Fix Provided (Data Fix Only):Data fix was done by Updated actor table and inserted a record into routing table..
Data/Code fix ticket#: CJAMS-61126
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update servicecase 
set activeflag =0, 
    updatedby = 'CJAMS-61126', 
    updatedon = now() 
where 
    servicecaseid in ('14d9b297-704d-4a43-9f1b-e11d0bbe327d','b921e02f-3374-4303-9a59-c490d6e61053') and activeflag =1;
--no records

--update caseassignment 
--set activeflag = 0, 
--    updatedby = 'CJAMS-61126', 
--    updatedon = now() 
--where 
--   objectid  in ('14d9b297-704d-4a43-9f1b-e11d0bbe327d','b921e02f-3374-4303-9a59-c490d6e61053') and activeflag = 1 ;

	update servicecasedisposition 
	set activeflag = 0, 
	    updatedby = 'CJAMS-61126', 
	    updatedon = now() 
	where 
	    servicecaseid in ('14d9b297-704d-4a43-9f1b-e11d0bbe327d','b921e02f-3374-4303-9a59-c490d6e61053');

UPDATE intakeservicerequest 
SET servicecaseid = null,
    updatedon = now(),
    updatedby = 'CJAMS-61126'
WHERE 
  servicecaseid in ('14d9b297-704d-4a43-9f1b-e11d0bbe327d','b921e02f-3374-4303-9a59-c490d6e61053')
   and activeflag =1;  

  
update routing 
set activeflag = 0, 
    updatedby = 'CJAMS-61126', 
    updatedon = now() 
where 
    routingid  in ('89373792-26ca-440c-8709-c5a85e71a440','70b3f8ba-2069-43ef-a9ce-9a5e8f521875')
    and activeflag = 1;
    

update actor 
set activeflag = 0, 
    updatedby = 'CJAMS-61126', 
    updatedon = now() 
    where 
        servicecaseid  in ('14d9b297-704d-4a43-9f1b-e11d0bbe327d','b921e02f-3374-4303-9a59-c490d6e61053') 
        and activeflag = 1;
    
       

update intakeservicerequestactor 
set activeflag = 0, 
    updatedby = 'CJAMS-61126', 
    updatedon = now() 
where 
     servicecaseid  in ('14d9b297-704d-4a43-9f1b-e11d0bbe327d','b921e02f-3374-4303-9a59-c490d6e61053')
    and activeflag = 1; 
   
   
--    CPS IR # 251023076797 and CPS IR# 251023074726 these two cases need to be connected to Service case # 251030490298.
   
  UPDATE intakeservicerequest 
SET servicecaseid  = '22b88266-c277-4a19-abec-deb42f32e2ac',
    updatedon = now(),
    updatedby = 'CJAMS-61126'
WHERE 
  intakeserviceid  in ('17d40826-982c-46e5-a268-bf9dac12fdae')
   and activeflag =1;