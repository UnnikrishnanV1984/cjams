/*
   Issue Description: CDM-33187
   Category/ Module  :  
   Root cause:user requeseted to update provider id  
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update adoptioncaserevision set provider_id=5018376,updatedby = 'CDM-33187',
updatedon = now()
where adoptionrevisionid='4fbb2fce-0c11-4a3a-b76e-ec3ddd126046';