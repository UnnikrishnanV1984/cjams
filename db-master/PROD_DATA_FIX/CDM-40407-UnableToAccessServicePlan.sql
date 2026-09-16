/*
Issue Description: User needs the Traditional eligibility data as shown in ticket
Category/Module: Bug
Root cause: Users cannot edit old service plans after recent update
Fix provided: DB query to edit service plan and show the traditional eligibility data
Code/Data fix ticket#: CDM-40407
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Page working as intended
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating serviceplan to add eligibility data
update serviceplan
set
serviceplancandidacy = '{"candidates": [], "candidatestraditional": [{"id": "200869442", "ebp": {"notes": null, "utilized": null, "utilizedtypes": null, "additionalinfo": null, "noadditionalinfo": "No", "isebpreferralmade": "No"}, "name": "Eric Bryan Alan Dickinson ", "details": "None", "candidacy": "0", "disablefield": false, "candidacydate": "2024-07-17T04:08:25.323Z", "imminentrisks": ["NONE"]}]}'::jsonb,
involvedpersons = '{"persons":[{"name":"Eric Bryan Alan Dickinson ","id":"200869442","imminentrisks":["NONE"],"comment":null,"disabledit":false,"livingininformalkinship":null,"enablelivinginink":false,"previousriskreasonids":["NONE"],"ebp":{"isebpreferralmade":"No","utilized":null,"utilizedtypes":null,"additionalinfo":null,"noadditionalinfo":"No","notes":null}}]}',
updatedby = 'CDM-40407', updatedon = now()
where serviceplanid = '175c2ea6-213c-46d9-bf7e-d26455809be0' and activeflag = 1;