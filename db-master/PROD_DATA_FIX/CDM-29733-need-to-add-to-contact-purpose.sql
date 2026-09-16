-- CDM-29733 - Reason for Visit change to Monthly Visit
/*
-- Issue Description: User requested to change the Worker Visit to Monthly Visit  
-- Case ID: 202007901085
-- Root cause: Data Issue (Exception scenario)
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/


update
    ProgressNote
set
    progressnotereasontypekey = 'MV,TSR',
    updatedby = 'CDM-29733',
    updatedon = now()
where
    progressnoteid = '8c65e9a8-d7f9-441f-b354-6a2e5d642f38';