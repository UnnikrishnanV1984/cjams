/*
   Issue Description: CDM-28909
   Category/ Module  :Program assignment need ending
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update CJAMS.personprogramarea 
set enddate = '2022-06-06 18:34:31', 
entityid= '221020209892' ,updatedon=now(), updatedby='CDM-28911'
where personprogramid in
('ab18657f-065e-4fed-a5b8-f301189c22dd','a6a23681-05a3-4ddc-a91f-e52f1ba31c4f','5a3feadc-fa30-4f81-a707-3793b33bf471','7db5ec0f-ca23-422d-99a3-93359285f838', 'd9a3c0dc-33b3-4276-bcfe-4762edb55a89', '3fb1263d-8597-473f-93a8-99708b317c25', 'b27bc2b6-83ec-4721-a54b-9be565ca981a', '59d8b9b6-9985-4820-b4f0-966c24892885');