/*
   Issue Description: CJAMS-64412
   Category/ Module  : Wrong client added
   Root cause: user added wrong child to the intakecase
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


--For intake
update actor 
set activeflag =0, updatedby='CJAMS-64412', updatedon=now() 
where actorid in ('df57a5de-fb05-45a6-822f-da08c0920b22') and activeflag = 1;


update intakeservicerequestactor 
set activeflag =0, updatedby='CJAMS-64412', updatedon=now() 
where actorid ='df57a5de-fb05-45a6-822f-da08c0920b22' and activeflag = 1;

update cjams.personrole
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-64412'
where personroleid ='a75a02f5-9c77-467a-9a20-4c69248aaf03' and activeflag = 1;

update cjams.personroletype
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-64412'
where personroleid ='a75a02f5-9c77-467a-9a20-4c69248aaf03' and activeflag = 1;


--For servicecase
update actor 
set activeflag =0, updatedby='CJAMS-64412', updatedon=now() 
where actorid in ('216b083f-058f-47c5-8134-219cc01a2e7e') and activeflag = 1;


update intakeservicerequestactor 
set activeflag =0, updatedby='CJAMS-64412', updatedon=now() 
where actorid ='216b083f-058f-47c5-8134-219cc01a2e7e' and activeflag = 1;

update cjams.personrole
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-64412'
where personroleid ='c864a473-22aa-45ef-854b-0d33d844ff91' and activeflag = 1;

update cjams.personroletype
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-64412'
where personroleid ='c864a473-22aa-45ef-854b-0d33d844ff91' and activeflag = 1;

update personprogramarea 
set activeflag =0 , updatedby = 'CJAMS-64412', updatedon = now() 
where personprogramid='b134234d-cadc-4b02-8f93-17a28169eb18' and activeflag = 1;


-----Delete person from contact notes
update contactparticipant 
set activeflag = 0, updatedby ='CJAMS-64412', updatedon =now()
where contactparticipantid = '1cef6a31-1506-4dd8-b3d0-3ca3aaae4bff' and activeflag=1;


-----Delete person from POSC

update safecareplan 
set activeflag = 0,  updatedon = now()  --updatedby is UUID
where safecareplanid ='7766522f-ec92-4e9e-87cb-0dbfd1458ed4' and activeflag = 1;



------ Delete intakeservicerequestsdm record from sdm tab. 
update intakeservicerequestsdm 
set activeflag = 0,  updatedon = now() , updatedby ='CJAMS-64412'
where intakeservicerequestsdmid ='43b8d9f7-2c29-49b8-919a-7396e41e36c5' and activeflag = 1;