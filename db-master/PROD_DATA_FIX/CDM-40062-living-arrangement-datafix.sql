/*
    Issue description: CDM-40062
    -- Category/Module: Living Arrangement (Case Management)
    -- Root cause: User error
    -- Pull request: N/A
    -- Reason why no related fix: N/A
    -- Status of the cdoe fix if already submitted and expected prod fix date: N/A
*/

update placement
set activeflag = 0, updatedby = 'CDM-40062', updatedon = now()
where placementid = 'b700d871-336e-4179-aaf7-9d4b7a921937' and activeflag = 1;

update placementrevision
set activeflag = 0, updatedby = 'CDM-40062', updatedon = now()
where placementid = 'b700d871-336e-4179-aaf7-9d4b7a921937' and activeflag = 1;

update livingarrangement
set activeflag = 0, updatedby = 'CDM-40062', updatedon = now()
where placementid = 'b700d871-336e-4179-aaf7-9d4b7a921937' and activeflag = 1;

update routing
set activeflag = 0, updatedby = 'CDM-40062', updatedon = now()
where objectid = 'b700d871-336e-4179-aaf7-9d4b7a921937' and activeflag = 1;