/*
   Issue Description: CDM-30996
   Category/ Module  :  intake Approval
   Pull request# for code fix:8873 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update     
     routing 
set 
     routingstatustypeid = 2 ,
     updatedon = '2020-08-14 02:55:00',
     updatedby ='a57c752f-d1a9-456c-a304-09dc1578f0e8'
where  
    objectid = 'I202000573622' ;
