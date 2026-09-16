/*
 * CDM-34780 - Referral
 * Customer Email ID:jill.taylor1@maryland.gov
 * Customer Name:Jill Taylor
 * Focus Area:Services: Other
 * Description - Dashboard:Referral # I23101011295503 needs to be deleted. Caseworker entered referral in child welfare when it should have been entered in adult services.
 * 
 */		

update intakedastaging set activeflag =0, updatedby = 'CDM-34780', updatedon = now() where intakenumber ='I231011295503' and activeflag =1; 
update intakedastatus set activeflag =0, updatedby = 'CDM-34780', updatedon = now() where intakenumber ='I231011295503' and activeflag =1; 
