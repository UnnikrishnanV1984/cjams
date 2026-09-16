/*
   Issue Description: CDM-19316
   Category/ Module  : purchase auth won't go away
   Root cause: Case shows pending in approval box
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
--SELECT * FROM getpendingreviewda('4f77059e-7efa-4df8-b810-67408df11399',1,10, ''); 
 

delete from cjams.routing where objectid = '1811333' 
and routingid in ('a6be1031-c425-4416-a64f-7851fd2d9b05',
'8252b08d-d0f6-44db-99ae-7118f1d959f7',
'00dec8ca-37bf-4848-89e2-1b3d82390a6a',
'873370f5-36bd-4606-9597-2f99b2fb7fa3');