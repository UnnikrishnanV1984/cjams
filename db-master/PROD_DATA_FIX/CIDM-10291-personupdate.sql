/*
Issue Description: CIDM-10126: Story to retain the client flag
Category/Module: Person
Root cause: Previous codefix to update the clientflag to 1 when adoption case is created.
Fix provided: DB query to update the client flag details to 2 for the adopted person which are not involved in any other case.
Data/Code fix ticket#: CIDM-10291
Regression Impacts: N/A
Is Code fix Required?: YES
Code fix ticket#: CIDM-10291
Reason why no related code fix: N/A
Backup before update/ delete:Query:
*/
--updating Person Table

UPDATE Person
SET updatedon = now(), updatedby = 'CIDM-10291', clientflag = 2
WHERE activeflag = 1 and coalesce(clientflag,2) = 1 and cjamspid in (
select distinct pr.cjamspid
from adoptioncase ad,
    adoptioncaseactor acr,
    person pr,
    intakeservicerequestactor isra
where ad.adoptioncaseid = acr.adoptioncaseid and acr.personid = pr.personid and pr.personid = isra.personid
    and ad.activeflag = 1 and acr.activeflag = 1 and pr.activeflag = 1 and coalesce(pr.clientflag,2) = 1
    and acr.actortypekey = 'ADOPTIVEPARENT' and isra.activeflag = 1 and isra.intakeservicerequestpersontypekey in ('COAPLCNT','APLCNT')
    and (select count(*) from actor ac where ac.personid = pr.personid and (coalesce(ac.intakenumber,'') ilike 'CW%'
                  or coalesce(ac.intakenumber,'') ilike 'I%' or ac.intakeserviceid is not null or ac.servicecaseid is not null) 
        ) = 0
);