/*
   Issue Description: CDM-27658
   Category/ Module  : 221020283271Name: Amaha Beileis not showing on my tree anymore.
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update intakeservicerequest set actiontype='IR',updatedon = now(), updatedby = 'CDM-27658' where servicerequestnumber  = '221020283271';