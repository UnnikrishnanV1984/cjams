/*
Issue Description: Filteing Contact Notes by Family Home did not display all the corresponding records.
Category/ Module: Bug
Root cause: Some recodrs had the wrong progressnotesubtypeid with Family Home description.
Fix provided: DB query to change the progressnotesubtypeid to the active one.
Code/Data fix ticket#: CDM-40343
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: CDM-40343
Reason why no related code fix: DB issue, code is fine
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update progressnote
set progressnotesubtypeid = '6f31a0fc-e8e1-4130-983e-87e5e08a9252', updatedby = 'CDM-40343', updatedon = now()
where activeflag = 1 and progressnoteid in (
'f5cc6711-eaeb-40cc-8cf0-48f7522e7cad',
'3318ca8c-5362-4941-a581-798c378131a4',
'e51bdaa4-2b1b-4b8a-a107-37a418920365',
'4e07cc8f-45f2-438c-a91c-30fb48f0abf6',
'5a23fd8c-54e5-44e4-b0bf-0a4df92746e6',
'b29a18d0-1036-4e28-9a73-b5622b4561ad',
'3020b50b-369a-4a7a-a097-0dc6c3dee049',
'185996a3-0d9d-4c83-b4b2-92e67ae59416',
'ca6b77ed-4add-42a9-a4d9-a5576f621fdc',
'cc83fc14-e893-4aa0-9d98-f2320cf71f7d',
'34e24ff3-fd72-43a8-9ae6-d7c2b89e725e',
'e4e82812-9f77-4e7f-9a3f-20ca4656ff16',
'f422dc70-1e48-4771-8cd9-12fcb1ef80ac',
'ade0fb9d-45be-4aa3-bdf0-adb0d289457b',
'78bb8618-d0d1-4098-b4dc-20a1f50521ec',
'7ab93200-8500-4d0c-a5b2-f44dcb9f852c',
'5e7eb6d8-75cc-410d-97f5-acd3250bd10a',
'2d2446f4-83d6-4b64-9f5c-aaae158afdf8');