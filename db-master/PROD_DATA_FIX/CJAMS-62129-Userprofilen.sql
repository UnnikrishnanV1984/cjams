/*
Issue:Dashboard:When workers go to send assessments to me for approval, my name appears in CJAMS twice, however neither selection routes the assessment to my inbox. I am not receiving any assessment approvals, which is affecting timely workflow. 
Root Cause:This user has two active accounts in userprofile, deactivate one. Recommended one to deactivate is erika.fenske1@maryland.gov.
Fix Provided (Data Fix Only):Data fix was done by Updated userprofile table.
Data/Code fix ticket#: CJAMS-62129
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/


update userprofile
set activeflag = 0,updatedby='CJAMS-62129',updatedon=now()
where securityusersid = '29a8e7ba-d1b1-4449-9674-362af8b3af81' and activeflag=1;

update muser set activeflag = 0,updatedby='CJAMS-62129',updatedon=now()
where securityusersid  in ('29a8e7ba-d1b1-4449-9674-362af8b3af81') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-62129', updatedon=now()  
where securityusersid in ('29a8e7ba-d1b1-4449-9674-362af8b3af81') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-62129', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('29a8e7ba-d1b1-4449-9674-362af8b3af81') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-62129', updatedon=now() 
where securityusersid in('29a8e7ba-d1b1-4449-9674-362af8b3af81') and activeflag =1;

update rolemapping set activeflag = 0,updatedby='CJAMS-62129',updatedon=now()
where id in('174211820') and activeflag = 1;

--no records
--update userresource set activeflag = 0,updatedby='CJAMS-62129',updatedon=now()
--where userid in ('174211820') and activeflag = 1;