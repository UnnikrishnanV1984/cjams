/*
   Issue Description: CDM-42785
   Category/ Module  : Assessment
   Root cause: Assessment delete error due to incorrect variable value passing to api call.
   Code fix ticket #: CIDM-9821
   Reason why no related code fix: N/A

*/

UPDATE assessmentsubmission 
	SET activeflag = 0, updatedby = 'CDM-42785',updatedon = now() 
WHERE 
	assessmentid = '309e0d0d-a37a-41c8-9235-53a5ccf28a32' and activeflag = 1;

UPDATE assessmentcomments 
	SET activeflag = 0,updatedby = 'CDM-42785',updatedon = now() 
WHERE assessmentid = '309e0d0d-a37a-41c8-9235-53a5ccf28a32' and activeflag = 1;

UPDATE assessment 
	SET activeflag = 0,updatedby = 'CDM-42785',updatedon = now() 
WHERE assessmentid = '309e0d0d-a37a-41c8-9235-53a5ccf28a32' and activeflag = 1;
	
update routing 
	set activeflag = 0, updatedon = now(), updatedby = 'CDM-42785' 
where eventcode = 'ASST' and routingstatustypeid = 15 and activeflag = 1 
	and objectid = '309e0d0d-a37a-41c8-9235-53a5ccf28a32' :: character varying;
    
update cjams.usernotification 
	set activeflag = 0, updatedon = now(), updatedby = 'CDM-42785' 
   where objectid = '309e0d0d-a37a-41c8-9235-53a5ccf28a32' :: character varying and activeflag = 1;
