/*
 * CDM-34769 - Removal of CJAM Referral 231010526967
 * Customer Email ID:mae.wilkes@maryland.gov
 * Environment: Production
 * Removal of CJAM Referral 231010526967
 * remove/delete the draft Intake (# I231010526967) as requested.
 * 
 */		

update intakedastaging set activeflag =0, updatedby = 'CDM-34769', updatedon = now() where intakenumber ='I231010526967' and activeflag =1; 
update intakedastatus set activeflag =0, updatedby = 'CDM-34769', updatedon = now() where intakenumber ='I231010526967' and activeflag =1; 
