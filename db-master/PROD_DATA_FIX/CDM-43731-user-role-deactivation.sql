/*
   Issue Description:  CDM-43731 Mallory Sutphin - msutphin@ccysb.org is no longer needs CJAMS access, she is an external user so we are unable to remove her access:
   Category/ Module  :  Assignments
   Root cause:User request to Deactivate CJAMS_CWSUPERVISOR role of Mallory Sutphin - msutphin@ccysb.org 
   Code fix ticket#: NA
   Reason why no related code fix: This is a known sail point issue and data fix will resolve it.
   Status of the code fix if already submitted and expected prod fix date: NO
   Backup before update/ delete: NA
*/

update rolemapping 
set activeflag = 0,
    updatedby = 'CDM-43731',
    updatedon = now()
where principalid='32326'
and activeflag =1;    