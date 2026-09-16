/*
-- CDM-23281- 

-- Issue Description: 
 Shwoing duplicate records on Candidancy Determination
  
-- Customer Email ID: luz.escobar@montgomerycountymd.gov

-- Root cause: Data fix to remove duplicate records on Candidancy Determination
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

----{"candidates": [{"id": "200838007", "name": "Daniela Bonilla ", "candidacy": "0", "candidacydate": "2022-06-16T16:18:38.212Z"}, {"id": "200843663", "name": "Natasha Bonilla ", "candidacy": "0", "candidacydate": "2022-06-16T16:18:38.212Z"}, {"id": "200843653", "name": "Dylan A Bonilla Rodriguez ", "candidacy": "0", "candidacydate": "2022-06-16T16:18:38.212Z"}, {"id": "200843656", "name": "Adrianne G Bonilla Rodriguez ", "candidacy": "0", "candidacydate": "2022-06-16T16:18:38.212Z"}, {"id": "200838007", "name": "Daniela Bonilla ", "candidacy": "0", "candidacydate": "2022-06-16T16:18:38.212Z"}, {"id": "200843663", "name": "Natasha Bonilla ", "candidacy": "0", "candidacydate": "2022-06-16T16:18:38.212Z"}, {"id": "200843653", "name": "Dylan A Bonilla Rodriguez ", "candidacy": "0", "candidacydate": "2022-06-16T16:18:38.212Z"}, {"id": "200843656", "name": "Adrianne G Bonilla Rodriguez ", "candidacy": "0", "candidacydate": "2022-06-16T16:18:38.212Z"}, {"id": "200838007", "name": "Daniela Bonilla ", "candidacy": "0", "candidacydate": "2022-06-16T16:18:38.212Z"}, {"id": "200843663", "name": "Natasha Bonilla ", "candidacy": "0", "candidacydate": "2022-06-16T16:18:38.212Z"}, {"id": "200843653", "name": "Dylan A Bonilla Rodriguez ", "candidacy": "0", "candidacydate": "2022-06-16T16:18:38.212Z"}, {"id": "200843656", "name": "Adrianne G Bonilla Rodriguez ", "candidacy": "0", "candidacydate": "2022-06-16T16:18:38.212Z"}], "candidatestraditional": [{"id": "200838007", "name": "Daniela Bonilla ", "candidacy": "0", "candidacydate": "2022-06-16T16:18:46.676Z"}, {"id": "200838007", "name": "Daniela Bonilla ", "candidacy": "0", "candidacydate": "2022-06-16T16:18:46.676Z"}, {"id": "200843663", "name": "Natasha Bonilla ", "candidacy": "0", "candidacydate": "2022-06-21T13:40:54.794Z"}, {"id": "200843653", "name": "Dylan A Bonilla Rodriguez ", "candidacy": "0", "candidacydate": "2022-06-21T13:40:55.483Z"}, {"id": "200843656", "name": "Adrianne G Bonilla Rodriguez ", "candidacy": "0", "candidacydate": "2022-06-21T13:40:56.542Z"}, {"id": "200838007", "name": "Daniela Bonilla ", "candidacy": "0", "candidacydate": "2022-06-16T16:18:46.676Z"}]} -----


update serviceplan set serviceplancandidacy  = '{
  "candidates": [
    {
      "id": "200838007",
      "name": "Daniela Bonilla ",
      "candidacy": "0",
      "candidacydate": "2022-06-16T16:18:38.212Z"
    },
    {
      "id": "200843663",
      "name": "Natasha Bonilla ",
      "candidacy": "0",
      "candidacydate": "2022-06-16T16:18:38.212Z"
    },
    {
      "id": "200843653",
      "name": "Dylan A Bonilla Rodriguez ",
      "candidacy": "0",
      "candidacydate": "2022-06-16T16:18:38.212Z"
    },
    {
      "id": "200843656",
      "name": "Adrianne G Bonilla Rodriguez ",
      "candidacy": "0",
      "candidacydate": "2022-06-16T16:18:38.212Z"
    }
  ],
  "candidatestraditional": [
    {
      "id": "200838007",
      "name": "Daniela Bonilla ",
      "candidacy": "0",
      "candidacydate": "2022-06-16T16:18:46.676Z"
    },
    {
      "id": "200843663",
      "name": "Natasha Bonilla ",
      "candidacy": "0",
      "candidacydate": "2022-06-21T13:40:54.794Z"
    },
    {
      "id": "200843653",
      "name": "Dylan A Bonilla Rodriguez ",
      "candidacy": "0",
      "candidacydate": "2022-06-21T13:40:55.483Z"
    },
    {
      "id": "200843656",
      "name": "Adrianne G Bonilla Rodriguez ",
      "candidacy": "0",
      "candidacydate": "2022-06-21T13:40:56.542Z"
    }
  ]
}', updatedby = 'CDM-23281', updatedon = now() 
where serviceplanid in ('8aac8477-7d80-48f1-85cf-54a29740fccc','f8f9856d-dae2-4b7d-b7ee-77a802c1d8f6','7e45e68d-9533-4c10-b9ed-950b9738b759');