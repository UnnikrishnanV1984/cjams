/*
Issue: CJAMS-64077 Request to have four pending intakes deleted from Taylor Geib's dashboard
Category/Module: intake
Root cause: Intakes  I251013319368,I241012487498,I231010967758,I211010205375  is still in draft on Taylor Geib's dashboard . It is no longer needed and data fix needed to resolve it.
Fix provided: Data fix has been done to delete the intake I251013319368,I241012487498,I231010967758,I211010205375  from all intake related tables.
Data/Code fix ticket#: CJAMS-64077
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User requested to remove draft intake and data fix should resolve it.
*/



update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-64077'
where intakenumber in ('I251013319368','I241012487498','I231010967758','I211010205375') and activeflag=1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-64077'
where intakenumber in ('I251013319368','I241012487498','I231010967758','I211010205375') and activeflag=1;