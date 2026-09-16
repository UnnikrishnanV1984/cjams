/*
Issue Description: CJAMS-64001: incorrect suspension date
Category/Module: Payments/ Adoption suspension
Root cause: Data entry error and  User requested to change the Suspension Begin Date from 12/07/2025 to 11/8/2025 on the Suspension of Payments screen for
            Case Number : 3202249
            Client Name :JAMES BROWNSTOKES
            CJAMS PID # 3256232
Fix provided: Data fix has been done to to change the Suspension Begin Date from 12/07/2025 to 11/8/2025 on the Suspension of Payments screen
Data/Code fix ticket#: CJAMS-64001
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error and user requested for the data fix.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update adoptioncasesuspensionrevision
set suspensionbegindate = '2025-11-06 00:00:00.000',
    updatedby = 'CJAMS-64001',
    approvaldate = now(),
    updatedon = now()
where adoptionsuspensionid in ('a2b8edf3-618a-4376-bebe-839156c9ec22')
and activeflag=1;

update adoptioncasesuspension
set suspensionbegindate = '2025-11-06 00:00:00.000',
    updatedby = 'CJAMS-64001',
    updatedon = now()
where adoptionsuspensionid in ('a2b8edf3-618a-4376-bebe-839156c9ec22')
and activeflag=1;
