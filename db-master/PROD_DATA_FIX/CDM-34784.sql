/*
 * CDM-34784 - CJAMS Assistance Needed
 * Jessica Roundtree, LMSW
 * Screening Unit Supervisor
 * jessica.roundtree@maryland.gov
 * Component/s:Child Welfare
 * delete the following intakes as requested
 * I231011143027
 * I221010345432
 * 
 */		

select * from intakedastaging where intakenumber in ('I231011143027','I221010345432') and activeflag=1;
update intakedastaging set activeflag =0, updatedby = 'CDM-34784', updatedon = now() where 
intakenumber in ('I231011143027','I221010345432') and activeflag =1; 
update intakedastatus set activeflag =0, updatedby = 'CDM-34784', updatedon = now() where 
intakenumber in ('I231011143027','I221010345432') and activeflag =1; 
