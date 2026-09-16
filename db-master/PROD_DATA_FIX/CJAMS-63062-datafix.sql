/*
   Issue Description: :open family assignment on close CPS IR
   Category/ Module  :  Assignments
   Root cause: Data fix is requested to remove the records from assignments
   Fix: Data fix is done to remove the records from assignments
   Pull request# for code fix: 
   Reason why no related code fix: This is data specific issue so no code fix is required
*/


update caseassignment
set updatedby = 'CJAMS-63062',
	updatedon = now(),
	activeflag = 0
where caseassignmentid in ('6ed0e263-34bb-42bd-8e43-fdfba7ae7584','c30113e5-43e4-4bf2-ad92-11b1858427b4')
and activeflag=1;