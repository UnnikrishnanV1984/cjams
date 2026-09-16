/*
Issue Description: CJAMS-68373: incorrect suspension date
Category/Module: Payments/ Adoption suspension
Root cause: As per system design we cannot enter placement start date prior to Suspension begin date hence datafix is done  to change the Suspension Begin Date  to 06/08/2026 on the Suspension of Payments screen 
Fix provided: Data fix has been done to to change the Suspension  Begin Date  to 06/08/2026 on the Suspension of Payments screen
Data/Code fix ticket#: CJAMS-68373
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Expected behaviour
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update adoptioncasesuspensionrevision
set suspensionbegindate = '2026-06-08 00:00:00',
    updatedby = 'CJAMS-68373',
    approvaldate = now(),
    updatedon = now()
where adoptionsuspensionid in ('acf794f1-bcf9-4db1-a5f3-a3f428810baf')
and activeflag=1;

update adoptioncasesuspension
set suspensionbegindate = '2026-06-08 00:00:00',
    updatedby = 'CJAMS-68373',
    updatedon = now()
where adoptionsuspensionid in ('acf794f1-bcf9-4db1-a5f3-a3f428810baf')
and activeflag=1;