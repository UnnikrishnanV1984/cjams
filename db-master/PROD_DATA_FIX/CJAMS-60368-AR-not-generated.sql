
/*
Issue Description: 3223180:Provider: Laurel Oaks (5062899) Client: La'Trell Brooks(3270683)The removal was corrected 06/25/2025 to push an A/R through for $600.00, on day placement. 
The A/R did not generate as expected in CJAMS.
Category/Module: Error
Root cause: CJAMS did not update the placement exit date in the placement validation table upon the exit date change supervisory approval.
Which is the trigger point for finance under over batch. 
Fix provided: Data fix has been provided to update the placement validation table date, so the under over batch will generate the missing AR. 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update tb_placement_validation pv
set update_ts = now(), 
    update_user_id = 'CJAMS-60368',
    placement_exit_dt = pl.enddatetime::date 
from placement pl     
where pv.placement_id = pl.alternateid 
    and pv.placement_id = 1816123
    and pv.delete_sw = 'N';
    