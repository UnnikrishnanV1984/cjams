/*
   Issue Description: CDM-39606
   Category/ Module  :
   Root cause: The Permanency Plan start date should be 2018-05-21 for Victor Baez.
                Updated the establisheddate to 2018-05-21 in permanencyplan table
   Pull request#
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update permanencyplan
set establisheddate='2018-05-21',updatedby='CDM-39606',updatedon=now()
where permanencyplanid='c5b7b87c-360c-41f9-b31b-c093e7368030';