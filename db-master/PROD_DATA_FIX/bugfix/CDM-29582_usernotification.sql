/*
   Issue Description: CDM-29582
   Category/ Module  : Report from wrong jurisdiction
   Root cause: REMOVE THIS CASE FROM HER SYSTEM ALERTS.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update usernotification set updatedby = 'CDM-29582', updatedon = now(), activeflag ='0' where usernotificationid  = 'c630647d-5eb2-446f-82ad-b1124aa714cb';

update usernotificationmap set updatedby = 'CDM-29582', updatedon = now(), activeflag = '0' where tosecurityusersid = '74542e14-b26d-4824-ac24-dae0b75fc8e0'
and usernotificationid = 'c630647d-5eb2-446f-82ad-b1124aa714cb';