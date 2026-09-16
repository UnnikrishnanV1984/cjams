/*
   Issue Description: CJAMS-67889
   Category/ Module  : person
   Root cause: User is trying to updated the citizenship status of the person CJAMS PID# 204770010 Noah Kalil Wilson
   Fix Provided: Data fix was provided by updating the citizenship status of the person CJAMS PID# 204770010 Noah Kalil Wilson
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update person
set citizenalenageflag =1, updatedby='CJAMS-67889', updatedon = now() 
where personid='b98bcbba-0018-4785-b3fb-bf99e13321f1' and activeflag=1;