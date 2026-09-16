/*
  Issue Description:  CJAMS-66886
   Category/ Module: services-other--Incorrect/New person created and a new case created. Needs connected to correct history & person.
   Root cause: user requested to do data fix as
1. I261013991280 - Replace the incorrect person(204862164) with the correct person (204265221)
2. Intake# I261013997110 - Disconnect and delete the Service case# 261030670060
3. Replacing the incorrect person(204862164) with B.Baker PID#204265221 for Intake#I261013997110
4. Link intake # I261013997110 with the existing service case # 251030599323.
   fix provided: Datafix has been done as requested by user for modifying person and also connecting case to intake
   Pull request# for code fix: 
   Reason why no related code fix:user error
*/
------------------------------------------------------
 --2.----Disconnected intake with case
 ----------------------------------------------------
UPDATE intakeservicerequest 
SET servicecaseid = null,
    updatedon = now(),
    updatedby = 'CJAMS-66886'
WHERE 
  servicecaseid ='b57591fc-90fb-43ff-a545-d0637835f926'
   and activeflag =1;  
 -----------------------------
  --2.---Deleted service case
 ------------------------------
 update servicecase 
set activeflag =0, 
    updatedby = 'CJAMS-66886', 
    updatedon = now() 
where 
    servicecaseid ='b57591fc-90fb-43ff-a545-d0637835f926' and activeflag =1;


update caseassignment 
set activeflag = 0, 
   updatedby = 'CJAMS-66886', 
   updatedon = now() 
where 
  objectid ='b57591fc-90fb-43ff-a545-d0637835f926' and activeflag = 1 ;

update servicecasedisposition 
	set activeflag = 0, 
	    updatedby = 'CJAMS-66886', 
	    updatedon = now() 
	where 
	    servicecaseid ='b57591fc-90fb-43ff-a545-d0637835f926';
	  
 
 update routing 
set activeflag = 0, 
    updatedby = 'CJAMS-66886', 
    updatedon = now() 
where 
    objectid ='b57591fc-90fb-43ff-a545-d0637835f926'
    and activeflag = 1;
   
update actor 
set activeflag = 0, 
    updatedby = 'CJAMS-66886', 
    updatedon = now() 
    where 
        servicecaseid ='b57591fc-90fb-43ff-a545-d0637835f926'
        and activeflag = 1;
    
       

update intakeservicerequestactor 
set activeflag = 0, 
    updatedby = 'CJAMS-66886', 
    updatedon = now() 
where 
     servicecaseid ='b57591fc-90fb-43ff-a545-d0637835f926'
    and activeflag = 1;
   
   
update personprogramarea 
set activeflag =0,
updatedby ='CJAMS-66886',
updatedon =now()
 where personprogramid in ('a13a14ea-ca51-4fe4-9239-1f5e2261f4ea' ,'d79af25c-a99f-4427-821f-79d609e2e2ac','512fb880-ad60-4e47-ab0b-98555f010cae')
and activeflag =1;

update servicecaserequest 
set activeflag =0,
updatedby ='CJAMS-66886',
updatedon =now()
where servicecaseid ='b57591fc-90fb-43ff-a545-d0637835f926' and activeflag =1;

   -----------------------------------------------------------------------------------------------
  ---1. I261013991280 - Replace the incorrect person(204862164) with the correct person (204265221)
   ---------------------------------------------------------------------------------------------

   UPDATE cjams.intakeservicerequestactor
SET updatedby='CJAMS-66886', updatedon=now(), personid='2412fc01-8a71-49e6-9cfe-dab18bd78758'
WHERE intakeservicerequestactorid in ('0f9c7314-2484-41c2-a1c4-2bbcdb765815' , '76e4052d-52e1-4c2c-b4d9-6865d3a81b28')
and actorid='255e0856-befa-4f59-8e8e-9505e9cd2d88';

UPDATE cjams.actor
SET updatedby='CJAMS-66886', updatedon=now(), personid='2412fc01-8a71-49e6-9cfe-dab18bd78758'
WHERE actorid='255e0856-befa-4f59-8e8e-9505e9cd2d88';


-----------------------------------------------------------------------------------------------
---3. Replacing the incorrect person(204862164) with B.Baker PID#204265221 for Intake#I261013997110
------------------------------------------------------------------------------------------------

UPDATE cjams.intakeservicerequestactor
SET updatedby='CJAMS-66886', updatedon=now(), personid='2412fc01-8a71-49e6-9cfe-dab18bd78758'
WHERE  actorid in ('d90dae12-b4d7-40bb-8fe1-3d2aa62382ba','b883873c-4e36-4adb-86d0-ec6d866be8af');

UPDATE cjams.actor
SET updatedby='CJAMS-66886', updatedon=now(), personid='2412fc01-8a71-49e6-9cfe-dab18bd78758'
WHERE actorid in ('d90dae12-b4d7-40bb-8fe1-3d2aa62382ba','b883873c-4e36-4adb-86d0-ec6d866be8af');

----------------------------------------------------------------------------------------------
---4. Link intake # I261013997110 with the existing service case # 251030599323 and make sure all the details are updates as per the intake.

------------------------------------------------------------------------------------------------


select * from createservicecase('a33f2c39-6c0c-4165-bd6b-6d25e04354bf', 'adf7c7ad-2b9c-41fb-9e80-c604dcae3ee9',0,'8e3e83ca-0693-4fe5-af19-62ac4a60b5b8',null,'ASSGN','intake',null);

