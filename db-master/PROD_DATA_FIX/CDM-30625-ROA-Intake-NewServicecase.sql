/*
   Issue Description: CDM-30625
   Category/ Module  : ROA CPS INATKE
   Root cause: user requested to remove old service case and create new case 
   Pull request# for code fix: 8838
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Data fix is required.
*/

select * from createservicecase('0b3c9d1b-6104-4f6e-b30c-44365dd326fc', null, 1, 'fc251376-8745-4381-a750-6a617c748678', 'intake');


