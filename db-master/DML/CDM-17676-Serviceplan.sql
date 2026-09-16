/*
   Issue Description: CDM-17676
   Category/ Module  : updating service plan on snapshot
   Root cause: updating service plan on snapshot
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
  snapshothist sn
set
  updatedby = 'CDM-17676',
  updatedon = now(),
  snapshotdata = jsonb_set(sn.snapshotdata::jsonb, '{serviceplancandidacy}', '{"candidates": [
      {
        "id": "200301762",
        "name": "Howard Grant Brown III",
        "candidacy": "1",
        "candidacydate": "2022-12-22T16:23:51.266Z"
      }
]}')
where
  sn.id = 'c36d1971-2289-4553-9003-da3fae2120f7';