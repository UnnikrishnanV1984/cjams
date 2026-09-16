-- CDM-26758-Contact Note
/*
   File Name: CDM-26758-serviceplan-RemoveRepeatingChild
-- Issue Description: 
    For the case 3241478  - Children names repeating multiple times in Service Plan, need to remove the Multiple Entries
    Customer Email ID:william.offer@maryland.gov
  
-- Resolution: Updated the serviceplancandidacy, updatedby Columns

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

update
	serviceplan
set
	serviceplancandidacy = '{"candidates": [
      {
        "id": "3507782",
        "name": "CORY HUTSON",
        "candidacy": "0",
        "candidacydate": "2022-11-16T16:23:51.266Z"
      },
      {
        "id": "3685499",
        "name": "NATHAN BROWN",
        "candidacy": "0",
        "candidacydate": "2022-11-16T16:23:51.267Z"
      },
      {
        "id": "200920227",
        "name": "Nathan William Hutson ",
        "candidacy": "0",
        "candidacydate": "2022-11-16T16:31:23.394Z"
      }
]}',
	updatedby = 'CDM-26758',
	updatedon = now()
where
	serviceplanid = '7478dc10-1d6b-4c50-ac13-14d996b9ac56';

update
	snapshothist sn
set
	updatedby = 'CDM-26758',
	updatedon = now(),
	snapshotdata = jsonb_set(sn.snapshotdata::jsonb, '{serviceplancandidacy}', '{"candidates": [
      {
        "id": "3507782",
        "name": "CORY HUTSON",
        "candidacy": "0",
        "candidacydate": "2022-11-16T16:23:51.266Z"
      },
      {
        "id": "3685499",
        "name": "NATHAN BROWN",
        "candidacy": "0",
        "candidacydate": "2022-11-16T16:23:51.267Z"
      },
      {
        "id": "200920227",
        "name": "Nathan William Hutson ",
        "candidacy": "0",
        "candidacydate": "2022-11-16T16:31:23.394Z"
      }
]}')
where
	sn.id = 'ed78a775-5fe6-4fad-bde1-7351062aaaec' ;