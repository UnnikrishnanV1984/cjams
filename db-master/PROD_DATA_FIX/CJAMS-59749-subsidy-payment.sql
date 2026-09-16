/*
   Issue Description: CJAMS-59749
   Category/ Module  : Finance payments
   Root cause: Enddate in the adoptioncase table is not matched with adoptioncaseagreement table.
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update adoptioncaseagreementrate
set approvaldate = now(), updatedon = now(), updatedby='CJAMS-59749'
where adoptionagreementrateid = 'ee651580-c741-4fa1-904e-78ef870117fd';

update adoptioncase
set enddate = '2027-03-21 00:00:00', updatedon = now(), updatedby='CJAMS-59749'
where adoptioncaseid='8bb88766-3549-4fd4-ae26-fcf86ac0502e';