/*
  Issue Description: CJAMS-67854
   Category/ Module  :  CJAMS issue
   Root cause: User request to Data fix remove the intake from the dashboard
   Fix provided: Data fix has been done to remove Pending In Progress Intakes from janine.mortagah@maryland.gov Dashboard 
   Is code fix required: N -  its working fine for other intakes
   Reason why no related code fix: Not replicable in staging environment
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/
update IntakeDAStaging set status = 'Complete', updatedby = 'CJAMS-67854', updatedon = now() 
where intakenumber in ('I231011688911','I251013302955','I251013310790','I221010308596','I261013983281','I261013982987') and activeflag = 1;