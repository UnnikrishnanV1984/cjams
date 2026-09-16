/*
   Issue Description: CDM-33187
   Category/ Module  :  
   Root cause:user requeseted to update provider id with 5018376
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update adoptioncaserevision set provider_id=5018376,updatedby = 'CDM-33187',
updatedon = now() where adoptionrevisionid='f7d3c50c-704c-43ca-93b2-11a3416e22be';


update adoptioncaseagreement set parent1providerid=5018376 ,updatedby='CDM-33187',updatedon=now()
where adoptionagreementid ='342b1dd6-3bb2-4ca0-8372-edd86e555ebd';