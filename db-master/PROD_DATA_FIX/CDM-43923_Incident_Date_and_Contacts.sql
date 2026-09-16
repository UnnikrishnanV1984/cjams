/*
   Issue Description: CDM-43930
   Category/ Module  :  MALTREATMENT ALLEGATION, contact notes
   Root cause: System error: Incident date wasn't updated in the DB 
   Incident date was altered to 1/13/25 but case will not allow contacts to be noted for before 1/21/25.
   code fix: CIDM-10109
   Reason why no related code fix: user error
*/
/*
select servicecaseid,intakedaterecieved,reporteddate,reporterincidentdate,* from intakeservicerequest where intakenumber= 'I251013213920';
*/

update intakeservicerequest 
set reporterincidentdate = '2025-01-13',
	updatedby = 'CDM-43923',
	updatedon = now()
where intakenumber= 'I251013211946'
and activeflag = 1;