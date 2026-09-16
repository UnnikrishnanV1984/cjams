/*
   Issue Description: CDM-19004
   Category/ Module  : Updating dads Tpr date to 06/05/2017
   Root cause: user requeseted to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update tprdetails t set tprdecisiondate = '2017-06-05 00:00:00', updatedby = 'CDM-19004', updatedon = now where tprdetailsid ='39153406-af9b-47a3-aaf5-29c83cc6f800';