/*
Issue Description:CJAMS-61227 GAP suspension
Category/Module: GAP Suspension 
Root cause: 3249434:GAP subsidy suspension cannot be approved due to the previously Rejected supsension with same date in the system.
            Code fix has already been done for this issue as the part of CDM-44449 .This will be available in the next minor release.
            We need to provide temporary data fix so that user can approve the latest suspension by deleting the rejected suspension records.
Fix provided: Data fix has been done remove the Rejected suspension record for the approval flow to work as expected.
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CDM-44449
Reason why no related code fix: N/A
*/




update gapsuspension
set activeflag = 0,
    updatedby = 'CJAMS-61227',
    updatedon = now()
where gapsuspensionid in ('84a81db1-7e37-41c2-a363-646ecf58a658','9c460a09-0436-4a03-abf0-e75d2f08a37f')      
and activeflag = 1;

update gapsuspensionrevision
set activeflag = 0,
    updatedby = 'CJAMS-61227',
    updatedon = now()
where suspensionid in ('84a81db1-7e37-41c2-a363-646ecf58a658','9c460a09-0436-4a03-abf0-e75d2f08a37f')
and activeflag = 1; 

update routing
set activeflag = 0,
    updatedby = 'CJAMS-61227',
    updatedon = now()
where objectid in ('84a81db1-7e37-41c2-a363-646ecf58a658','9c460a09-0436-4a03-abf0-e75d2f08a37f')
and activeflag = 1;