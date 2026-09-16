/*
   Issue Description: CDM-16969
   Category/ Module  :  
   Root cause: Removing Removal End date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- 2021-07-18 11:40:27
update intakeservreqchildremoval set exitdate = null, updatedby = 'CDM-16969', updatedon = now() where intakeservreqchildremovalid = '3341626e-65ab-4971-87f6-5a33ead0ec83';
