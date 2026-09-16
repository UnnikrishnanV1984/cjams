/*
   Issue Description: CDM-38989
   Category/ Module  : case connect Servicecase
   Root cause: Connected Intake # I241012301282 to service case # 3245152
   Pull request# for code fix: 8757
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Data fix is required.
*/
select * from createservicecase('61b6f780-7531-4914-9e51-7a76ac8e6538', 'be3e32fb-7426-4004-8433-bed72dfcee73',0, 'd3ed46a3-e946-48f6-83b5-75972c2e3047','intake');