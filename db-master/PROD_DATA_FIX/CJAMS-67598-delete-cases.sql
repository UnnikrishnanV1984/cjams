/*
   Issue Description: CJAMS-67598
   Root cause: User requested to delete the cases from to be assigned dashboard
   Fix Provided : Data fix is done to delete the cases from to be assigned dashboard
   Pull request# for code fix:  N/A
*/

update routing 
set routingstatustypeid =4, 
	isreviewrequest =false, 
	updatedby ='CJAMS-67598', 
	updatedon =now()
where servicerequestnumber ='211030011661' and activeflag =1;

update routing 
set routingstatustypeid =4, 
	isreviewrequest =false, 
	updatedby ='CJAMS-67598', 
	updatedon =now()
where servicerequestnumber ='211030011660' and activeflag =1;

update routing 
set routingstatustypeid =4, 
	isreviewrequest =false, 
	updatedby ='CJAMS-67598', 
	updatedon =now()
where servicerequestnumber ='251030497980' and activeflag =1;