/*
Issue Description: Closure needed, this is a migrated case. Needs to be closed and removed from caseload
Category/Module: Error
Root cause: Old service case still active and needed to be closed
Fix provided: DB queries end case assignment and close the case
Data/Code fix ticket#: CDM-41237
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Ending assignment in caseassignment
update caseassignment
set enddate = '2015-07-22 00:00:00', updatedby = 'CDM-41237', updatedon = now()
where caseassignmentid = '907f63ec-b9c1-46a5-b9f7-874b686e2f41' and activeflag = 1;

--Closing the case in servicecasedisposition
update servicecasedisposition
set intakeserreqstatustypekey = 'Closed', dispositioncode = 'Closed', "comments" = 'Dev Closed', updatedby = 'CDM-41237', updatedon = now()
where servicecasedispositionid = 'b5532781-0261-49c3-8579-7a58305a755a' and activeflag = 1;

--Updating case closure in routing
update routing
set routingstatustypeid = 8, updatedby = 'CDM-41237', updatedon = now()
where routingid = 'ec879ae5-a157-49fe-bf61-e0c942971775' and activeflag = 1;