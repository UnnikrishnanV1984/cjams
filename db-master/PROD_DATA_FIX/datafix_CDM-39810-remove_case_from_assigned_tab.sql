
/* 
 Issue Description: CDM-39810
 Category/ Module  : to be assigned service case need to be removed from the user dashboard.
 Assign service case ---> To be Assigned
 SERVICE CASE :  231030055132
 Customer Email ID: kristen.hahn1@maryland.gov
 Root cause:  Data fix to remove service case from the user dashboard
 Status type key should be ASSGN for SERVICE CASE :  231030055132
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: Need to do data fix
*/

update servicecase set statustypekey  = 'ASSGN', updatedon = now(), updatedby = 'CDM-39810' 
where servicecaseid = '116b16bd-6fd3-4bee-b00a-5ae22d7addfd' and servicecasenumber ='231030055132';