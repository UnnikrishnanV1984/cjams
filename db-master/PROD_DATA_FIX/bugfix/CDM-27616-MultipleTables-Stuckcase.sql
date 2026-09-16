-- CDM-27616-Stuck case
/*
   File Name: CDM-27616-MultipleTables-Stuckcase
-- Issue Description: 
   For the User on the Dashboard:I202000370556 Stuck referral from 2020 and asked to delete.
   Customer Email ID: heather.bosley@maryland.gov

-- Resolution: Updated the activeflag to zero in update routing, intakedastatus, intakedastaging and intakesnapshot table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/


update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-27616'
where objectid = 'I202000370556';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-27616'
where intakenumber = 'I202000370556';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-27616'
where intakenumber = 'I202000370556';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-27616'
where intakenumber = 'I202000370556';