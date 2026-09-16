/*
Issue Description: Please do a data fix to uncheck the Unknown check-box.
Category/Module: Bug
Root cause: If unknown race option is checked then it disables other options
Fix provided: DB query uncheck unknown option and prepare report on similar cases
Code/Data fix ticket#: CDM-41201
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: None
Reason why no related code fix: Unknown should not be selected if race is known
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Removing unknown race from person
update person
set racetypekey = '[{"racetypekey":"BA"}]', updatedby = 'CDM-41201', updatedon = now()
where personid = '7df7575d-ea3d-4677-ad15-da407c7cfc63' and activeflag = 1;

--Removing unknown race from personracetypemap
update personracetypemap
set activeflag = 0, updatedby = 'CDM-41201', updatedon = now()
where personid = '7df7575d-ea3d-4677-ad15-da407c7cfc63' and racetypekey = 'UN' and activeflag = 1;