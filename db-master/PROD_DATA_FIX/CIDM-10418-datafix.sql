/*
   Issue Description: CIDM-10418
   Category/ Module  : Persons: Household
   Root cause: Data Fix has been done to update the reported date. 
   The date is getting updated similarly for both Information & Referral with Intake dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequest set reporteddate = '2024-10-03 00:00:00.000',
updatedby = 'CIDM-10418', updatedon = now()
where IntakeNumber = 'I251013252073';

update intakeservicerequest set reporteddate = '2024-11-04 00:00:00.000',
updatedby = 'CIDM-10418', updatedon = now()
where IntakeNumber = 'I251013252589';

update intakeservicerequest set reporteddate = '2024-12-04 00:00:00',
updatedby = 'CIDM-10418', updatedon = now()
where IntakeNumber = 'I251013256949';