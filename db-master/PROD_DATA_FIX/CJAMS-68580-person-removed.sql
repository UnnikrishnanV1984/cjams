/*
   Issue Description: CJAMS-68580 
   Category/ Module: persons
   Root cause: User requested to data fix to remove PID# 4152575 Shellyann HENRY from CPS IR 261023811828 in all persons,Contacts and assessment tabs
   Fix Provided: Data fix was done by removing PID# 4152575 Shellyann HENRY from CPS IR 261023811828, in all persons,Contacts and assessment tabs
   Code Fix: Not Needed
*/



-- select activeflag, intakeserviceid,* from actor where actorid ='f94b345f-1c08-428d-9fde-1c97ac69ed35';

update actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-68580'
where actorid = 'f94b345f-1c08-428d-9fde-1c97ac69ed35' and activeflag=1;

--  select activeflag,intakeserviceid, * from intakeservicerequestactor i where intakeservicerequestactorid ='3ecf1a75-0cef-408a-9f13-ea935fd5be1f';

update intakeservicerequestactor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-68580'
where intakeservicerequestactorid = '3ecf1a75-0cef-408a-9f13-ea935fd5be1f' and activeflag=1;

-- select activeflag,* from personprogramarea where personid ='368303a9-8094-47c6-b099-d453445c86a1';

update personprogramarea
set activeflag=0,
updatedon = now(),
updatedby = 'CJAMS-68580'
where objectid='3edcfd1a-499a-485f-87df-6a018bada27d' and personprogramid='de03e46e-48c9-4cba-b3d4-8589088b9258' and activeflag=1;

-- select activeflag, intakeserviceid,* from personrole p where personid ='368303a9-8094-47c6-b099-d453445c86a1';

update personrole 
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-68580'
where personroleid = '504af2e6-bee4-47b2-9715-ecb2e3ad5bf7' and activeflag=1;

-- select activeflag, * from personroletype p2 where personroleid ='504af2e6-bee4-47b2-9715-ecb2e3ad5bf7';

update personroletype
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-68580'
where personroletypeid = '929fb0c7-f7ac-45a1-bbc3-78956aef74b5' and activeflag=1;

-- select activeflag,intakeserviceid,* from actorrelationship where intakeservicerequestactorid = '3ecf1a75-0cef-408a-9f13-ea935fd5be1f' and activeflag=1;

update actorrelationship
set activeflag=0,
updatedon = now(),
updatedby = 'CJAMS-68580'
where intakeservicerequestactorid = '3ecf1a75-0cef-408a-9f13-ea935fd5be1f' and activeflag=1;

-- select focusperson,* from progressnote where intakeserviceid='3edcfd1a-499a-485f-87df-6a018bada27d' and activeflag=1; progressnoteid='43997452-d3f4-4b8e-9b64-693a39729339';

update progressnote 
set activeflag=0, 
updatedon=now(),
updatedby='CJAMS-68580'
where intakeserviceid='3edcfd1a-499a-485f-87df-6a018bada27d' and activeflag=1;