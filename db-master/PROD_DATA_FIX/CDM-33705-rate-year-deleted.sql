/*
   Issue Description: CDM-33705
   Category/ Module  : Subsidy rate
   Root cause: An error in subsidy rate which prevent from creating subsidu rate
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/ 

/*The iisue was happening because of edit in rejected record.The rejected record will change its status to review , but supervisor not able to approve it due to overlapping date issue.
Hence making this record back to rejected status and web code fix to prevent from editing the rejected record
*/
update adoptioncaserevision 
set 
approvalstatustypekey =3046 ,
updatedby ='CDM-33705',
updatedon =now() 
where 
adoptionrevisionid  ='cc42dcff-f783-4aed-83c4-5063fc5f68e1';