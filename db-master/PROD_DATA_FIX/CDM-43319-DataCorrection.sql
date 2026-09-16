/*
Issue Description: Please do the data fix on the EBP Referral Made section to the red inbox
Category/Module: Support
Root cause: Service Plan details cannot be edited once approved
Fix provided: DB queries to change the data entered in error
Data/Code fix ticket#: CDM-43319
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--updating serviceplan
update serviceplan
set serviceplancandidacy = jsonb_set(
		jsonb_set(
			jsonb_set(
				jsonb_set(serviceplancandidacy, '{candidates, 0, ebp, utilized}', 'null', true),
			'{candidates, 0, ebp, utilizedtypes}', 'null', true),
		'{candidates, 0, ebp, noadditionalinfo}', '"No"', true),
	'{candidates, 0, ebp, isebpreferralmade}', '"No"', true),
	updatedby = 'CDM-43319', updatedon = now()
where serviceplanid = 'b3eb872d-cf65-4d1a-bd38-1b9feaf09916' and activeflag = 1;

--updating snapshothist
update snapshothist
set snapshotdata = jsonb_set(
		jsonb_set(
			jsonb_set(
				jsonb_set(
					jsonb_set(
						jsonb_set(
							jsonb_set(
								jsonb_set(snapshotdata, '{candidatesObj, candidates, 0, ebp, utilized}', 'null', true),
							'{candidatesObj, candidates, 0, ebp, utilizedtypes}', 'null', true),
						'{candidatesObj, candidates, 0, ebp, noadditionalinfo}', '"No"', true),
					'{candidatesObj, candidates, 0, ebp, isebpreferralmade}', '"No"', true),
				'{serviceplancandidacy, candidates, 0, ebp, utilized}', 'null', true),
			'{serviceplancandidacy, candidates, 0, ebp, utilizedtypes}', 'null', true),
		'{serviceplancandidacy, candidates, 0, ebp, noadditionalinfo}', '"No"', true),
	'{serviceplancandidacy, candidates, 0, ebp, isebpreferralmade}', '"No"', true),
	updatedby = 'CDM-43319', updatedon = now()
where id in ('3dc912a6-9017-4b4a-9faf-51e107fe5c0e', 'c0a639d6-6931-4ad3-8000-6976cf620258') and activeflag = 1;