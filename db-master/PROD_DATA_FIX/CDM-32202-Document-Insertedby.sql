 /*
   Issue Description: CDM-32202
   Category/ Module  : Prod data fix to update correct inserted user details 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/ 
--  ab4d06e8-494c-47e9-adec-8bf7dc1d2bee    ba8e461b-eeb7-4266-aea0-cc8766b6ca8c    4f8fcf6e-0160-48d7-8aaa-69ac61856bdf
 
 update documentproperties set insertedby = 'ba8e461b-eeb7-4266-aea0-cc8766b6ca8c', updatedby = 'CDM-32202', updatedon = now()
where documentpropertiesid in 
('4f8fcf6e-0160-48d7-8aaa-69ac61856bdf');

 update documentattachment 
 set insertedby = 'ba8e461b-eeb7-4266-aea0-cc8766b6ca8c', updatedby = 'CDM-32202', updatedon = now()
where documentpropertiesid in 
('4f8fcf6e-0160-48d7-8aaa-69ac61856bdf');

