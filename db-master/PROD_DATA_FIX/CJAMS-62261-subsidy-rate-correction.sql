/*
Issue Description: CJAMS-62261 Subsidy Rate Date
Category/Module: Subsidy rate 
Root cause: needful to change the end date of the subsidy rate slab as follows
            Client ID: 4190755 (REIGN SMITH)
            Provider ID: 5096150 (Brenda Smith)
            Subsidy Rate Start & End Date: 09/03/2025 - 07/28/2026
Fix provided: Data fix done to end date the subsidy rate slab to  07/28/2026 and trigger the payment batch
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:This is a per the system design and we need data fix to resolve it.
*/


update gapagreementrate
set enddate = '2026-07-28 00:00:00',
    updatedby = 'CJAMS-62261',
    updatedon = now()
where gapagreementrateid = 'f24a9112-beae-479f-9f87-59f1491f23d1'
and activeflag = 1;

update gapratesrevision
set rateenddate = '2026-07-28 00:00:00',
    approvaldate = now(), /*Triggering Payment batch*/
    updatedby = 'CJAMS-62261',
    updatedon = now() 
where gaprateid = 'f24a9112-beae-479f-9f87-59f1491f23d1'
and activeflag = 1;
