/*
-- Issue Description: 
	Need data fix to remove the client from the case 251030562691 from persons tab
CJAMS PID-204229209
     -- Root cause: User Request
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/


update actor 
set activeflag = 0, updatedby = 'CJAMS-67622', updatedon = now() 
where  personid ='37393457-5f46-4c81-9e6c-b1da4f11bc25' and  actorid = '8770da2f-f804-4549-bd0b-ab6a972781ab';

update intakeservicerequestactor 
set activeflag = 0, updatedby = 'CJAMS-67622', updatedon = now() 
where  actorid ='8770da2f-f804-4549-bd0b-ab6a972781ab' and intakeservicerequestactorid = '1d93026e-ddf5-459b-b372-569c1bb55a8d';


update personrole 
set activeflag = 0, updatedby = 'CJAMS-67622', updatedon = now() 
where  personid ='37393457-5f46-4c81-9e6c-b1da4f11bc25' and servicecaseid = '27951450-c6ec-4d74-98e5-6da035877323' ;

update personroletype 
set activeflag = 0, updatedby = 'CJAMS-67622', updatedon = now() 
where personroleid='473acae8-3e94-4631-9a84-565c7a471345' and activeflag = 1;



-------------------------------------------------


--Need to remove another CJAMS PID-204230039 

update actor 
set activeflag = 0, updatedby = 'CJAMS-67622', updatedon = now() 
where  personid ='e13c9fd6-612a-4d7f-8cd5-d4dfcd3b49b4' and  actorid = '129a6e84-5b44-465a-9fab-dd6f1fd5cb8d';

update intakeservicerequestactor 
set activeflag = 0, updatedby = 'CJAMS-67622', updatedon = now() 
where  actorid ='129a6e84-5b44-465a-9fab-dd6f1fd5cb8d' and intakeservicerequestactorid = '6d70bf4c-684e-4f2f-a87e-9021c77c713c';


    
update personrole 
set activeflag = 0, updatedby = 'CJAMS-67622', updatedon = now() 
where  personid ='e13c9fd6-612a-4d7f-8cd5-d4dfcd3b49b4' and servicecaseid = '27951450-c6ec-4d74-98e5-6da035877323' ;

update personroletype 
set activeflag = 0, updatedby = 'CJAMS-67622', updatedon = now() 
where personroleid='5469d5c8-fdf3-4c9c-99ee-3ef657740364' and activeflag = 1;


