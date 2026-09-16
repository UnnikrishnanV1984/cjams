/*
   Issue Description: CDM-43695
   Category/ Module  : Stuck approval
   Root cause: The YTP approval for case number 3043134 is stuck in supervisor's approval box. This assessment for the YTP has been approved by the assigned supervisor. 
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/
/*select activeflag,routingstatustypeid,updatedon,* from routing where servicerequestnumber = '3043134' --and activeflag = 1 
and objectid = '141090ab-81f9-4176-8ca8-60fede95a074' and eventcode = 'YTP'
and routingstatustypeid = 15;
*/
update routing set activeflag = 0, updatedby = 'CDM-43695', updatedon = now() where routingid = '1da057e8-b2f5-4f4f-b58c-83435e468146';
