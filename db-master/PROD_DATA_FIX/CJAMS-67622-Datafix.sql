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


update contactparticipant
set activeflag = 0, updatedby = 'CJAMS-67622', updatedon = now() 
where progressnoteid ='e878f68b-8b19-40f5-b297-10d1d665cfb5'   and activeflag = 1;


update progressnote
set focusperson = 
'{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"acbc1786-dc6e-4f09-bee1-7d3ca6f63c55","participantid":"acbc1786-dc6e-4f09-bee1-7d3ca6f63c55","firstname":"Megan","lastname":"Schroeder","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null},{"participanttypekey":"IP","intakeservicerequestactorid":"796bd075-564e-4bfd-92d2-77805a5779d5","participantid":"796bd075-564e-4bfd-92d2-77805a5779d5","firstname":"Zachary","lastname":"Schroeder","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}', updatedby='CJAMS-67622', updatedon=now() 
where progressnoteid ='e878f68b-8b19-40f5-b297-10d1d665cfb5'  and activeflag = 1;


update contactparticipant
set activeflag = 0, updatedby = 'CJAMS-67622', updatedon = now() 
where progressnoteid ='4491c356-3552-4a60-a38b-eea04e697cd3' and intakeservicerequestactorid = '6d70bf4c-684e-4f2f-a87e-9021c77c713c' and activeflag = 1;

update progressnote
set focusperson = null, updatedby='CJAMS-67622', updatedon=now() 
where progressnoteid ='4491c356-3552-4a60-a38b-eea04e697cd3' and activeflag = 1;

update contactparticipant
set activeflag = 0, updatedby = 'CJAMS-67622', updatedon = now() 
where progressnoteid ='2c6e480f-4c24-4b1a-9520-57237a38e03c' and intakeservicerequestactorid = '6d70bf4c-684e-4f2f-a87e-9021c77c713c' and activeflag = 1;

update progressnote
set focusperson = null, updatedby='CJAMS-67622', updatedon=now() 
where progressnoteid ='2c6e480f-4c24-4b1a-9520-57237a38e03c' and activeflag = 1;

update contactparticipant
set activeflag = 0, updatedby = 'CJAMS-67622', updatedon = now() 
where progressnoteid ='e0446c02-a063-4ecf-b09e-42f4e44c47fc' and intakeservicerequestactorid = '6d70bf4c-684e-4f2f-a87e-9021c77c713c' and activeflag = 1;

update progressnote
set focusperson = '{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"796bd075-564e-4bfd-92d2-77805a5779d5","participantid":"796bd075-564e-4bfd-92d2-77805a5779d5","firstname":"Zachary","lastname":"Schroeder","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null},{"participanttypekey":"IP","intakeservicerequestactorid":"acbc1786-dc6e-4f09-bee1-7d3ca6f63c55","participantid":"acbc1786-dc6e-4f09-bee1-7d3ca6f63c55","firstname":"Megan","lastname":"Schroeder","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}', updatedby='CJAMS-67622', updatedon=now() 
where progressnoteid ='e0446c02-a063-4ecf-b09e-42f4e44c47fc' and activeflag = 1;

update contactparticipant
set activeflag = 0, updatedby = 'CJAMS-67622', updatedon = now() 
where progressnoteid ='e73cd95b-16ed-4811-ab56-86c9460e5e2e' and intakeservicerequestactorid = '6d70bf4c-684e-4f2f-a87e-9021c77c713c' and activeflag = 1;

update progressnote
set focusperson = '{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"796bd075-564e-4bfd-92d2-77805a5779d5","participantid":"796bd075-564e-4bfd-92d2-77805a5779d5","firstname":"Zachary","lastname":"Schroeder","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null},{"participanttypekey":"IP","intakeservicerequestactorid":"acbc1786-dc6e-4f09-bee1-7d3ca6f63c55","participantid":"acbc1786-dc6e-4f09-bee1-7d3ca6f63c55","firstname":"Megan","lastname":"Schroeder","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}', updatedby='CJAMS-67622', updatedon=now() 
where progressnoteid ='e73cd95b-16ed-4811-ab56-86c9460e5e2e' and activeflag = 1;


update contactparticipant
set activeflag = 0, updatedby = 'CJAMS-67622', updatedon = now() 
where progressnoteid ='d6e4fea2-dd6d-467b-a9f5-6b4acc5749b7' and intakeservicerequestactorid = '6d70bf4c-684e-4f2f-a87e-9021c77c713c' and activeflag = 1;

update progressnote
set focusperson = '{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"796bd075-564e-4bfd-92d2-77805a5779d5","participantid":"796bd075-564e-4bfd-92d2-77805a5779d5","firstname":"Zachary","lastname":"Schroeder","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null},{"participanttypekey":"IP","intakeservicerequestactorid":"acbc1786-dc6e-4f09-bee1-7d3ca6f63c55","participantid":"acbc1786-dc6e-4f09-bee1-7d3ca6f63c55","firstname":"Megan","lastname":"Schroeder","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}', updatedby='CJAMS-67622', updatedon=now() 
where progressnoteid ='d6e4fea2-dd6d-467b-a9f5-6b4acc5749b7' and activeflag = 1;
