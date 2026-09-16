/* Issue Description:CDM-14229 - Removal record and updating end date as mentioned by user
   Category/ Module  :  child removal
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/



update intakeservreqchildremoval set exitdate = '2021-05-06 10:00:00', updatedby = 'CDM-14229', 
    updatedon = now()  where intakeservreqchildremovalid ='79d7658b-8dc3-4e26-955a-69d14b460415';
