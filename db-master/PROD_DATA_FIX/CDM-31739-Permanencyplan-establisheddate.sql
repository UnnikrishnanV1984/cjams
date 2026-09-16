/*
   Issue Description: CDM-31736
   Category/ Module  :Permanancyplan
   Root cause: User requested to update  establisheddate . 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update permanencyplan set establisheddate = '2021-03-15 04:00:00',updatedby ='CDM-31739',updatedon =now() where permanencyplanid = 'f710dff3-9774-4c2a-a090-e5c806fb572d';