/*
-- Issue Description: 
   User request to Remove duplicated system error Investigation findings
-- Category/ Module: Inverstigation Finding   
-- Root cause: 
-- Pull request :
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Reverting the changes for CDM-29787

update Investigationmaltreatment 
set activeflag = 1, updatedby ='CDM-30125', updatedon = now()
where maltreatmentid in ('2f3e2302-10ac-4a7f-91a2-0b6c4c2043f8','fe30784d-fb88-4efe-9ffc-e6c7063540dc');

update Investigationallegation
set activeflag = 1, updatedby ='CDM-30125', updatedon = now()
where maltreatmentid in ('2f3e2302-10ac-4a7f-91a2-0b6c4c2043f8','fe30784d-fb88-4efe-9ffc-e6c7063540dc');


-- Removing the correct finding records

update
    investigationallegation
set
    activeflag = 0,
    updatedby = 'CDM-30125',
    updatedon = now()
where
    investigationallegationid in (
        '3bed999a-bd43-4fc9-bb51-5137d78f3412',
        '0fe7d89a-3953-43cd-946b-3a09713e70bb'
    );
