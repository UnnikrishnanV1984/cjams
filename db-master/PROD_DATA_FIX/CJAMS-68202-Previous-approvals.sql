/*
   Issue Description:CJAMS-68202-Previous-approvals
      Category/ Module  :delete approval inbox
   Root cause: Please carry out data fix to remove the marked cases from Approval Inbox (Case Pending Approval) of sara.glover@maryland.gov 
   Fix Provided: Data fix to remove case from pending approval inbox
*/

update routing 
set 
	servicerequestnumber='3216780',
	updatedby = 'CJAMS-68202',
	updatedon = now()
where routingid in ('438819ff-ee4f-4dd9-be24-a6eee4a12f41') and activeflag = 1;

update routing 
set 
	servicerequestnumber='3156296',
	updatedby = 'CJAMS-68202',
	updatedon = now()
where routingid in ('f6c71c43-cf0f-4f88-b18d-87cf72cb7125') and activeflag = 1;
