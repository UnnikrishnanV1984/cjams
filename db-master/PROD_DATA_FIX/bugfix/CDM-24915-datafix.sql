
/*
   Issue Description: CDM-24041
   Category/ Module  : Child Removal
   Root cause: Child has two Removals. One got approved and one in Review. The removal status of the "Review" record
              is being overwritten by the approved.
   Fix: Reassigning a new higher removal id to the Review record. 

   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    
*/

update intakeservreqchildremoval
set removalid = nextval('removal_id'::regclass),
	 updatedby = 'CDM-24915', 
	 updatedon = now()
where intakeservreqchildremovalid = '559bfdff-a564-461f-b627-ebd1a7833dea' ;

update intakeservreqchildremoval_history
set  removalid = ( select removalid from intakeservreqchildremoval where intakeservreqchildremovalid = '559bfdff-a564-461f-b627-ebd1a7833dea'),
	 updatedby = 'CDM-24915', 
	 updatedon = now()
where intakeservreqchildremovalid = '559bfdff-a564-461f-b627-ebd1a7833dea';
