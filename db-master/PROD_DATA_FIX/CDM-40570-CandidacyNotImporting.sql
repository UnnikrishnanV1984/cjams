/*
Issue Description: User needs the Traditional eligibility data as shown in ticket
Category/Module: Bug
Root cause: Users cannot save Traditional eligibility data in old plans after recent update
Fix provided: DB query to edit service plan and show the traditional eligibility data
Code/Data fix ticket#: CDM-40570
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: CIDM - 9172
Reason why no related code fix: Codefix already deployed
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Modifying serviceplan record
update serviceplan 
set serviceplancandidacy = '{"candidates": [], "candidatestraditional": [{"id": "4080341", "ebp": {"notes": null, "utilized": null, "utilizedtypes": null, "additionalinfo": null, "noadditionalinfo": "No", "isebpreferralmade": "No"}, "name": "CAMERON ALEXANDER ELLIS ", "details": "None", "candidacy": "0", "disablefield": false, "candidacydate": "2024-07-29T20:28:00.899Z", "imminentrisks": ["NONE"]}, {"id": "3807811", "ebp": {"notes": null, "utilized": null, "utilizedtypes": null, "additionalinfo": null, "noadditionalinfo": "No", "isebpreferralmade": "No"}, "name": "NASZIR KY-MANI HERRING ", "details": "Complex Psychological or Behavioral Needs | DJS Involvement | Prior Child Welfare Experience", "candidacy": "1", "disablefield": true, "candidacydate": "2024-07-29T20:27:55.511Z", "imminentrisks": null}]}'::jsonb,
involvedpersons = '{"persons":[{"name":"CAMERON ALEXANDER ELLIS ","id":"4080341","imminentrisks":["NONE"],"comment":null,"disabledit":false,"livingininformalkinship":null,"enablelivinginink":false,"previousriskreasonids":["NONE"],"ebp":{"isebpreferralmade":"No","utilized":null,"utilizedtypes":null,"additionalinfo":null,"noadditionalinfo":"No","notes":null}},{"name":"NASZIR KY-MANI HERRING ","id":"3807811","imminentrisks":["CPBN","DJSI","PCWE"],"comment":null,"disabledit":false,"livingininformalkinship":null,"enablelivinginink":false,"previousriskreasonids":["CPBN"],"ebp":{"isebpreferralmade":"No","utilized":null,"utilizedtypes":null,"additionalinfo":null,"noadditionalinfo":"No","notes":null}}]}',
updatedby = 'CDM-40570', updatedon = now()
where serviceplanid = '3fd0077d-b182-46aa-b96b-5e27173ca327' and activeflag = 1;

--Reverting approved version to draft in snapshothist
update snapshothist
set activeflag = 0, updatedby = 'CDM-40570', updatedon = now()
where id in ('edd8f7a4-52f1-4af3-9e12-e57347aed7a2', '64ecff87-9108-48ef-8996-fcb06c492a91', '6ecc2863-e5e9-4061-8c47-2707b7b48155')
and activeflag = 1;