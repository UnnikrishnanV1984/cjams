/* 
   Issue Description: CJAMS-66779
   Category/ Module  : No Services Case Created
   Root cause: Issue is not replicable in stage3 ,we are able to create a case on screen in of an intake it might have caused due to system slowness
               We are keeping the intake back for supervisor approval , so they can screen in and create a case
   Fix provided: Data fix has been done modify the routing record and also supervisor status so that supervisor can screenin the intake 
   Is cose fix required : N , Since we are able to create cases on screen in of an intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update routing
set activeflag =1,
routingstatustypeid =1,
supervisordecision =null,
updatedby ='CJAMS-66779',
updatedon =now()
where routingid='967afee0-92bd-40c7-9cf9-66efb42df8a4';
