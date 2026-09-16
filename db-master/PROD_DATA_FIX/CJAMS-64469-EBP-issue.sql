/*
Issue: CJAMS-64469 EBP status issue
Category/Module: EBP
Root cause: Incorrect EBP status has been entered for the client and data fix needed to correct it.
            Service Plan: Mackall Family Service plan, Dated: 08/14/2024 - 12/28/2024

            Client ID: 200851000 (Kiani Mackall)

            Candidacy Determination Criteria  - Complex Psychological or Behavioral Needs

            Need to make "EBP Referral Made? *" as - No

            Reason as - Not available at LDSS

            Need the data fix on the Service Plan, Candidacy Determination History and In-Home Services Print.
Fix provided: Data fix has been done to correct the EBP referral information for the client 200851000 as requested by the user.
Data/Code fix ticket#: CJAMS-64469
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error and code fix should resolve it.
*/


--updating serviceplan
update serviceplan
set serviceplancandidacy = jsonb_set(
		jsonb_set(
			jsonb_set(
				jsonb_set(serviceplancandidacy, '{candidates, 0, ebp, utilized}', 'null', true),
			'{candidates, 0, ebp, utilizedtypes}', 'null', true),
		'{candidates, 0, ebp, noadditionalinfo}', '"NAL"', true),
	'{candidates, 0, ebp, isebpreferralmade}', '"No"', true),
	updatedby = 'CJAMS-64469', updatedon = now()
where serviceplanid = '5f5ac770-2b68-48f1-bcd4-c5cf7014214d' and activeflag = 1;

--updating snapshothist
update snapshothist
set snapshotdata = jsonb_set(
		jsonb_set(
			jsonb_set(
				jsonb_set(
					jsonb_set(
						jsonb_set(
							jsonb_set(
								jsonb_set(
									jsonb_set(snapshotdata, '{candidatesObj, candidates, 0, ebp, utilized}', 'null', true),
								'{candidatesObj, candidates, 0, ebp, utilizedtypes}', 'null', true),
							'{candidatesObj, candidates, 0, ebp, noadditionalinfo}', '"NAL"', true),
					'{candidatesObj, candidates, 0, ebp, isebpreferralmade}', '"No"', true),
				'{serviceplancandidacy, candidates, 0, ebp, utilized}', 'null', true),
			'{serviceplancandidacy, candidates, 0, ebp, utilizedtypes}', 'null', true),
		'{serviceplancandidacy, candidates, 0, ebp, noadditionalinfo}', '"NAL"', true),
	'{serviceplancandidacy, candidates, 0, ebp, isebpreferralmade}', '"No"', true),
	'{candidatesObj, candidates, 0, ebp, notes}', 'null', true),
	updatedby = 'CJAMS-64469', updatedon = now()
where id in ('85bb92e6-085f-485f-a8c6-b4ddab438052') 
and objectid = '5f5ac770-2b68-48f1-bcd4-c5cf7014214d'
and activeflag = 1;