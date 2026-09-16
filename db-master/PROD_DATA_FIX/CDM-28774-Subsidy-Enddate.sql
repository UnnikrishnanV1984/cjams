/*
   Issue Description: CDM-28643
   Category/ Module  :  Gap agreemnet
   Root cause: user wants to  update the subsidy end date to 12/22/2023
   Pull request# for data fix:  8041
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/
update gapratesrevision set rateenddate = '2023-12-22 15:00:00', updatedby = 'CDM-28774', updatedon = now() 
where gaprateid = '018c6c3c-bf3e-4098-92e3-20fa3e19cbc8';

update gapagreementrate set enddate = '2023-12-22 15:00:00', updatedby = 'CDM-28774', updatedon = now() 
where gapagreementrateid = '018c6c3c-bf3e-4098-92e3-20fa3e19cbc8';