/*
   Issue Description: CDM-16903
   Category/ Module  : court screen
   Root cause: user requeseted to update 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/* This is old date : 2021-02-23 05:00:00 */

update intakeservreqcourtorder set courtorderdate = '2021-02-24 05:00:00', updatedby = 'CDM-16903', updatedon = now()
where intakeservreqcourtorderid = '4e2c4412-faa8-4332-8100-7d394c320d21';


