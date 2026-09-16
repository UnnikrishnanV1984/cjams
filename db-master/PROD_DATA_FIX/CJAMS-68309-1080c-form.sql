/*
   Issue Description: CJAMS-68309
   Category/ Module: Documents > 1080c form
   Root Cause: User wants to unselect the physical abuse from the form 1080c
   Fix Provided: Data fix has been provided by unselecting the physical abuse from the form 1080c
   Pull request for code fix: 
   Reason why no related code fix: 
*/



update form1080c 
set physicalabuse =null, physicalabuseradio=null, updatedby ='CJAMS-68309', updatedon =now()
where form1080cid ='5681f1ae-9e7b-441e-a6c8-3958d2482ed6' and activeflag =1;