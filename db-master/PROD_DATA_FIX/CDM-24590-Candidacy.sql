/* 
 Issue Description: CDM-24590
 Category/ Module  : Showing duplicate records on Candidancy Determination
 Customer Email ID: diane.marshall@maryland.gov
 Root cause: Data fix to remove duplicate records on Candidancy Determination
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: Need to do data fix
*/

update 
  serviceplan 
set 
  serviceplancandidacy = '{
  "candidates": [
    {
      "id": "3224365",
      "name": "DEVONTE LEON HODGE ",
      "candidacy": "1",
      "candidacydate": "2022-10-27T12:59:05.994Z"
    },
    {
      "id": "3320794",
      "name": "SEQUOIA LASHAE HODGE ",
      "candidacy": "1",
      "candidacydate": "2022-10-27T12:59:05.994Z"
    },
    {
      "id": "3726640",
      "name": "SERENITY LOVE HODGE ",
      "candidacy": "1",
      "candidacydate": "2022-10-27T12:59:05.994Z"
    }
  ],
  "candidatestraditional": []
}', 
  updatedby = 'CDM-24590', 
  updatedon = now() 
where 
  objectid = 'e699ce02-f832-4d90-af51-6ad87fa3a38d' 
  and serviceplanid = 'b8f0b12f-78b0-4b64-9df1-e328cab00552';
