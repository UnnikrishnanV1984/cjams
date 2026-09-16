/*
Issue: CJAMS-64645 Adoption subsidy not allowing child to be removed
Category/Module: Adoption Subsidy
Root cause: User is unable to do the placement as the system created an auto suspension with start date is 30 days from the removal start date i.e, 01/19/2026. 
            Data fix is needed to update the suspension start date with 12/19/2025.
            Case #: 3264009
            Client Name: KOURTNEY METZGER
            CJAMS PID # 3914362
Fix provided:  Data fix has been done to update the suspension start date with 12/19/2025.
Data/Code fix ticket#: CJAMS-64645
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is as per the system Design and Data fix is needed to resolve it.
*/


update adoptioncasesuspensionrevision
set suspensionbegindate = '2025-12-19 00:00:00.000',
    updatedby = 'CJAMS-64645',
    approvaldate = now(),
    updatedon = now()
where adoptionsuspensionid in ('7feb3e0f-2fef-4f7f-9af5-4c91ea7479f3')
and activeflag=1;

update adoptioncasesuspension
set suspensionbegindate = '2025-12-19 00:00:00.000',
    updatedby = 'CJAMS-64645',
    updatedon = now()
where adoptionsuspensionid in ('7feb3e0f-2fef-4f7f-9af5-4c91ea7479f3')
and activeflag=1;