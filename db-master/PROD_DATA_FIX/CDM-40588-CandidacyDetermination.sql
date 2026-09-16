/*
Issue Description: Please do the needful Data fix as needed (service plan)
Category/Module: Error
Root cause: Users cannot save Traditional eligibility data in old plans after recent update
Fix provided: DB query to edit service plan and show the traditional eligibility data
Code/Data fix ticket#: CDM-40588
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: CIDM-9172
Reason why no related code fix: Codefix already deployed
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Modifying serviceplan record
update serviceplan
set
serviceplancandidacy = '{"candidates": [], "candidatestraditional": [{"id": "4457413", "ebp": {"notes": null, "utilized": null, "utilizedtypes": null, "additionalinfo": null, "noadditionalinfo": "No", "isebpreferralmade": "No"}, "name": "WILLA WEINREICH ", "details": "None", "candidacy": "0", "disablefield": false, "candidacydate": "2024-07-29T14:53:42.125Z", "imminentrisks": ["NONE"]}, {"id": "4457412", "ebp": {"notes": null, "utilized": null, "utilizedtypes": null, "additionalinfo": null, "noadditionalinfo": "No", "isebpreferralmade": "No"}, "name": "SEBASTIAN WEINREICH ", "details": "None", "candidacy": "0", "disablefield": false, "candidacydate": "2024-07-29T14:53:41.367Z", "imminentrisks": ["NONE"]}, {"id": "4457411", "ebp": {"notes": null, "utilized": null, "utilizedtypes": null, "additionalinfo": null, "noadditionalinfo": "No", "isebpreferralmade": "No"}, "name": "ELIAS WEINREICH ", "details": "None", "candidacy": "0", "disablefield": false, "candidacydate": "2024-07-29T14:53:40.432Z", "imminentrisks": ["NONE"]}, {"id": "200896903", "ebp": {"notes": null, "utilized": null, "utilizedtypes": null, "additionalinfo": null, "noadditionalinfo": "No", "isebpreferralmade": "No"}, "name": "ZAYAH Pearl Weinreich ", "details": "Prior Child Welfare Experience", "candidacy": "1", "disablefield": true, "candidacydate": "2024-07-29T14:53:30.147Z", "imminentrisks": null}]}'::jsonb,
involvedpersons = '{"persons":[{"name":"WILLA WEINREICH ","id":"4457413","imminentrisks":["NONE"],"comment":null,"disabledit":false,"livingininformalkinship":null,"enablelivinginink":false,"previousriskreasonids":["NONE"],"ebp":{"isebpreferralmade":"No","utilized":null,"utilizedtypes":null,"additionalinfo":null,"noadditionalinfo":"No","notes":null}},{"name":"SEBASTIAN WEINREICH ","id":"4457412","imminentrisks":["NONE"],"comment":null,"disabledit":false,"livingininformalkinship":null,"enablelivinginink":false,"previousriskreasonids":["NONE"],"ebp":{"isebpreferralmade":"No","utilized":null,"utilizedtypes":null,"additionalinfo":null,"noadditionalinfo":"No","notes":null}},{"name":"ELIAS WEINREICH ","id":"4457411","imminentrisks":["NONE"],"comment":null,"disabledit":false,"livingininformalkinship":null,"enablelivinginink":false,"previousriskreasonids":["NONE"],"ebp":{"isebpreferralmade":"No","utilized":null,"utilizedtypes":null,"additionalinfo":null,"noadditionalinfo":"No","notes":null}},{"name":"ZAYAH Pearl Weinreich ","id":"200896903","imminentrisks":["PCWE"],"comment":null,"disabledit":false,"livingininformalkinship":null,"enablelivinginink":false,"previousriskreasonids":["NONE"],"ebp":{"isebpreferralmade":"No","utilized":null,"utilizedtypes":null,"additionalinfo":null,"noadditionalinfo":"No","notes":null}}]}',
updatedby = 'CDM-40588', updatedon = now()
where serviceplanid = 'f35b08b4-0a8f-45b6-bdb7-5ba358785906' and activeflag = 1;

--Deactivating approved versions in snapshothist
update snapshothist
set activeflag = 0, updatedby = 'CDM-40588', updatedon = now()
where id in ('a43ab48d-5e39-45b1-bf77-8270d7e0a4b3', '1d4de8ea-f855-4bc6-8a39-6d455f1be725', '61c5e968-e715-4ae5-b19e-4680963e5bb2')
and activeflag = 1;