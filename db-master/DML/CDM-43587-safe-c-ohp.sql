
/*
    Issue Description: CDM-43587-safe-c-ohp
    Category/ Module  :  Assessments (safecohp)
    Root cause: CIDM-9712 assessment optimization ticket updated the audit columns, the updatedon column is used by the UI to display it as assessment completion date.
    Fix Provided: Repopulate the updatedon from the assessmentsubmission table for all safeCOhp assessments.
    Pull request# for code fix: 
    Reason why no related code fix: 
    Status of the code fix if already submitted and expected prod fix date: 
*/
update assessment a
set updatedon = sub.updatedon
from (
    select distinct assessmentid, updatedon from assessmentsubmission where assessmentid in (
    select assessmentid from assessment a
    join assessmenttemplate ast 
    on a.assessmenttemplateid = ast.assessmenttemplateid and ast."name" = 'safeCOhp'
    and a.updatedby = 'CIDM-9712') 
) as sub
where a.assessmentid = sub.assessmentid;