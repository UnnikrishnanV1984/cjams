/*
   Issue Description: CDM-37253
   Category/ Module  : Prod data fix to remove pending records
   Root cause: User Request to remove the CPS AR Case# 241021702322 from users 'Assessments Pending Approval' Dashboard. 
   Resolution: Applied prod data fix for removing the case from the dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


select activeflag,remarks,routingid, * from routing where servicerequestnumber = '241021702322' and activeflag=1;

select * from routing where routingid='efdb08a9-5991-47f9-9813-957411e6cbb7';


update routing set activeflag = 0, updatedby = 'CDM-37253', updatedon = now()
where routingid = 'efdb08a9-5991-47f9-9813-957411e6cbb7' and activeflag = 1;
  	