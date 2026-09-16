

/*
   Issue Description: CDM-24247
   Category/ Module  :  CASE PLAN
   Root cause: user requeseted to update approved date
   Pull request# for code fix: 
   Reason why no related code fix: user error
*/

-- here there are using updatedon is for approval date and updatedby as the worker name 

update cjams.snapshothist set updatedon ='2022-02-08 16:31:34.000'

where objectid ='f7a9a626-cd26-4442-b461-e039b2d4110a'and id ='eec431bd-0ef0-403c-a516-8bdce09721a9';