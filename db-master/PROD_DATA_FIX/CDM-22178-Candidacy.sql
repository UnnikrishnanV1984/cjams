/*
   Issue Description: CDM-22178
   Category/ Module  : Prod data fix to view candidacy information in  pdf
   Pull request# for code fix:5814
   Reason why no related code fix: User wants to display Candidacy information  in pdf
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE snapshothist set snapshotdata = jsonb_set(snapshotdata::jsonb, '{serviceplancandidacy}', '{"candidates": [{ "id": "1870733","name": "GAGE MICHAEL WOLFE ","candidacy": "1","candidacydate": null},{ "id": "2145864","name": "KIRA WOLFE ","candidacy": "1","candidacydate": null}]}'),
 updatedby ='CDM-22178',updatedon =now() 
where  objectid  = 'd2746068-225c-4b7c-8804-06003dae91e9' and activeflag = '1';