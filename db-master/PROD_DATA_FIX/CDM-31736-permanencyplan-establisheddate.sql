/*
   Issue Description: CDM-31736
   Category/ Module  :Permanancyplan
   Root cause: User requested to update  establisheddate . 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update permanencyplan set establisheddate = '2021-03-15 04:00:00', updatedby ='CDM-31736',updatedon =now() where permanencyplanid ='0c2f15bb-a788-4863-a569-83c7e6b39fbc';