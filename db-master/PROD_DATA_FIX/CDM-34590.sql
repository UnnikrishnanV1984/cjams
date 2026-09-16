  /* 
    Issue Description: CDM-34590
   Category/ Module  : workload
   Root cause:actiontype in intakeservicerequest tbale is null  . 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

 update intakeservicerequest set actiontype='AR'  ,updatedon=now(),updatedby ='CDM-34590'
 where servicerequestnumber='231021167354'
 and intakeserviceid='b1de0769-9618-4317-84aa-8b981772b823';