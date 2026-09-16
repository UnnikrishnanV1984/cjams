/*
    Issue description: CDM-40014
    -- Category/Module: Living Arrangement (Case Management)
    -- Root cause: User error
    -- Pull request: N/A
    -- Reason why no related fix: N/A
    -- Status of the cdoe fix if already submitted and expected prod fix date: N/A
*/

update placement
set activeflag = 0, updatedby = 'CDM-40014', updatedon = now()
where placementid = '92cac632-c150-42d9-a358-b0dc8fb9d6b7' and activeflag = 1;

update placementrevision
set activeflag = 0, updatedby = 'CDM-40014', updatedon = now()
where placementid = '92cac632-c150-42d9-a358-b0dc8fb9d6b7' and activeflag = 1;

update livingarrangement
set activeflag = 0, updatedby = 'CDM-40014', updatedon = now()
where placementid = '92cac632-c150-42d9-a358-b0dc8fb9d6b7' and activeflag = 1;

update routing
set activeflag = 0, updatedby = 'CDM-40014', updatedon = now()
where objectid = '92cac632-c150-42d9-a358-b0dc8fb9d6b7' and activeflag = 1;

---

update placement
set activeflag = 0, updatedby = 'CDM-40014', updatedon = now()
where placementid = '66bcd50b-4d9d-48de-a90a-8271b52c543e' and activeflag = 1;

update placementrevision
set activeflag = 0, updatedby = 'CDM-40014', updatedon = now()
where placementid = '66bcd50b-4d9d-48de-a90a-8271b52c543e' and activeflag = 1;

update livingarrangement
set activeflag = 0, updatedby = 'CDM-40014', updatedon = now()
where placementid = '66bcd50b-4d9d-48de-a90a-8271b52c543e' and activeflag = 1;

update routing
set activeflag = 0, updatedby = 'CDM-40014', updatedon = now()
where objectid = '66bcd50b-4d9d-48de-a90a-8271b52c543e' and activeflag = 1;