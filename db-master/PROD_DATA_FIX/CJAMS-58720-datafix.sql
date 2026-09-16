/*
Issue Description: Data fix to to remove the incorrect person record from the case.
Category/Module: Bug
Root cause: Data fix to to remove the incorrect person record from the case.
Fix provided: Fix has been promoted to remove the incorrect person record from the case.
Data/Code fix ticket#: CJAMS-58720
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/

update intakeservicerequestactor 
      set activeflag = 0,
          updatedby = 'CJAMS-58720', 
          updatedon = now()
      where personid = '9a251356-3749-4718-b18d-c6ded0081461' 
      and actorid = 'a5d960fa-4ab4-49e0-a181-a2da8a820ebb'
      and activeflag = 1;

update actor 
    set activeflag = 0,
        updatedby = 'CJAMS-58720', 
        updatedon = now()
    where personid = '9a251356-3749-4718-b18d-c6ded0081461' 
    and actorid = 'a5d960fa-4ab4-49e0-a181-a2da8a820ebb'
    and activeflag = 1;

update personrole 
   set activeflag = 0,
       updatedby = 'CJAMS-58720', 
       updatedon = now()
    where personid = '9a251356-3749-4718-b18d-c6ded0081461' 
    and personroleid = '2c74480e-07a6-4ba8-a8b7-72dcf0048597'
    and activeflag = 1;

update personroletype
    set activeflag = 0,
       updatedby = 'CJAMS-58720', 
       updatedon = now()
    where personroleid = '2c74480e-07a6-4ba8-a8b7-72dcf0048597'
    and activeflag = 1;

update actorrelationship
   set activeflag = 0,	
       updatedby = 'CJAMS-58720',  
       updatedon = now()
    where intakenumber = 'I251013252054' 
    and activeflag = 1;

update cjams.personprogramarea 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-58720'
	where personid = '9a251356-3749-4718-b18d-c6ded0081461'
    and activeflag = 1;
