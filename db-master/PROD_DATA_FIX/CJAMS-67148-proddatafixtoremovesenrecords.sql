/*
   Issue Description: CJAMS-67148
   Category/ Module  : Prod data fix to remove incorrect SEN Request removals
   Root cause: CDM-44800
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



-- Removing unwanted Routing records
UPDATE routing r SET  activeflag = 0,  updatedby = 'CJAMS-67148', updatedon = now()
FROM senselectiondetails sd
WHERE r.objectid = sd.senselectiondetailsid::character varying
  AND r.eventcode = 'SENCHECK'
  AND r.activeflag = 1 AND sd.approvalstatus in ('Created','Changed')
  AND r.insertedon::date >= '2026-04-16'
  AND sd.insertedon::date >= '2026-04-16' AND r.routingstatustypeid = 15;
  
update senselectiondetails set activeflag = 0 ,  updatedby = 'CJAMS-67148', updatedon = now() 
where insertedon::date >= '04-16-2026' and birthinghospital is null and activeflag = 1;
 
 

delete from senselectiondetails_history where insertedon::date >= '04-16-2026' and birthinghospital is  null ;