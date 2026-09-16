/*
   Issue Description: CDM-28811
   Category/ Module  : SEN DIDNT OPEN SERVICE CASE
   Root cause:I231010468048:Intake approved for screened in SEN assessment and did not generate a service case
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

select * from cjams.createservicecase('d6abe4f3-c223-4e18-8393-5c820c024bb9', null, 1, '47dc653d-9089-4b47-b40e-0168ef6c2321', 'intake', '');