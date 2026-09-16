/*
   Issue Description: CDM-42351 Personal number showing incorrectly
   Category/ Module  :  Assignments
   Root cause: In posc and assignment incorrect phone number is updated due to know integration issue and sailpoint and data fix will be needed to fix this.
   Fix provided : Data fix has been promoted to update the phone number in userprofile and safecare plan
   Code fix ticket#: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A

*/


update userprofilephonenumber 
set phonenumber = '(410) 971-4767',
    updatedby = 'CDM-42351',
    updatedon = now()
where securityusersid = 'f7cdf0e8-575f-49ac-9e28-3f26d725d9de';


update safecareplan 
set persondetails =jsonb_set(persondetails::jsonb,'{ldss,phoneno}','"(410) 971-4767"'), 
    updatedon = now() 
where objectid ='6b089d3a-36d1-4104-86cb-573c9755177d' and objecttypekey='servicecase';