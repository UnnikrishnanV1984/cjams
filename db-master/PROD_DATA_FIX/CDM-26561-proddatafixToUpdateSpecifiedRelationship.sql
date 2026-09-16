/*
   Issue Description: CDM-26561
   Category/ Module  : Prod data fix to update Relationship ID
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update specifiedrelative set specifiedrelativerelationshipid = 1001 where 
toclientid = 4068770 and removalid = 192177;