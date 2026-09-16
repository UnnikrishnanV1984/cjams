/*
 * CDM-34988 - Delete In Progress Intake
 * Customer Email ID:kendra.hartlove@maryland.gov
 * Customer Name:Kendra Hartlove
 * Focus Area:Documents
 * Description - Dashboard:In need of in progress intake to be deleted - Intake Number I231011389466. Intake started 10/20/23 and not finished as it was a duplicate.
 * delete the in-progress Intake # I231011389466 as requested.
 *
 */

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34988'
where objectid in ('I231011389466') 
	and activeflag = 1 ;

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34988'
where intakenumber = 'I231011389466';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34988'
where intakenumber = 'I231011389466';	
