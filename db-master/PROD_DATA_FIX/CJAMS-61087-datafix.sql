/*
Issue Description: CJAMS-61087
Category/Module: Delete Note Request
Root cause: User requested to remove the marked contact note (Contact ID: 15188132)
Fix provided: Data fix has been done to to remove the marked contact note (Contact ID: 15188132)
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Data fix needed to correct the user entry error
*/

UPDATE progressnote 
  SET activeflag = 0, 
      updatedby = 'CJAMS-61087' , 
      updatedon = now()
WHERE progressnoteid = 'e0d47323-9ca7-4aab-bed9-27bbdfab5906'  
   and activeflag=1;

update progressnotedetail  
   set activeflag = 0,  
       updatedby = 'CJAMS-61087',  
       updatedon = now()
WHERE progressnoteid ='e0d47323-9ca7-4aab-bed9-27bbdfab5906' 
   and activeflag=1;

update contactparticipant
  SET activeflag = 0, 
      updatedby = 'CJAMS-61087' , 
      updatedon = now()
WHERE progressnoteid = 'e0d47323-9ca7-4aab-bed9-27bbdfab5906' 
   and activeflag = 1;

update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CJAMS-61087',
	updatedon = now()
where progressnoteid = 'e0d47323-9ca7-4aab-bed9-27bbdfab5906'
	and activeflag = 1 ;