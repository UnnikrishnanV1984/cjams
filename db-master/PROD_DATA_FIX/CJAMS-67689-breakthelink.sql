/*
  Issue Description:  CJAMS-67689
   Category/ Module: permanency plan - Provider information
   Root cause:  wrong placement was updated and provider details were missing in the break the link window
   Fix Provided: Data fix has been provided by updating the right placement id so that provider details will be generated in the window
   Pull request# for code fix: 
   Reason why no related code fix:NA 
*/


update permanencyplan
set placementid='cdebf8a3-28d6-424a-8ab6-620b46991f7c', updatedby='CJAMS-67689', updatedon=now()
where permanencyplanid = '613bfc59-fb87-4b4e-aee3-31d6fb50988a' and placementid='9b0a400d-b78b-4645-af3a-c7ec9022e9be';