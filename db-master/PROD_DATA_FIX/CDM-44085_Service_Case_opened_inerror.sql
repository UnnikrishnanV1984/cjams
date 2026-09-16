/*
Issue Description: Closure needed,:Service case opened due to apparent CJAMS bug. There are no persons listed so decision tab cannot close case. 
Category/Module: Error
Root cause: 221030016361,Service case opened due to apparent CJAMS bug. There are no persons listed so decision tab cannot close case. 
Fix provided: DB queries end case assignment and close the case
Data/Code fix ticket#: CDM-44085
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: system error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

/*
select servicecaseid,* from servicecase where servicecasenumber = '221030016361';
--servicecaseid:f611b2d2-4143-4246-bae4-5b172aed071c
select activeflag,updatedby,* from caseassignment where objectid = 'f611b2d2-4143-4246-bae4-5b172aed071c';
select servicecasedispositionid,servicecaseid,* from  servicecasedisposition where servicecaseid = 'f611b2d2-4143-4246-bae4-5b172aed071c';
*/

update servicecasedisposition
set intakeserreqstatustypekey = 'Closed',
	dispositioncode = 'Closed',
	"comments" = 'Dev Closed', 
	updatedby = 'CDM-44085', 
	updatedon = now()
where servicecasedispositionid = '397cdc67-1c7e-4514-aeab-66a370031dbb'
and activeflag = 1;

UPDATE cjams.servicecase 
SET statustypekey ='Closed', dispositioncode = 'Closed', updatedby = 'CDM-44085',updatedon = now() 
where servicecaseid ='f611b2d2-4143-4246-bae4-5b172aed071c' and activeflag = 1;