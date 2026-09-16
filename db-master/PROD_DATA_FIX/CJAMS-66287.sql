/*
  Issue Description: CJAMS-66287
   Category/ Module  :  CJAMS issue
   Root cause: User request to Data fix remove the intake from the dashboard
   Fix provided: Data fix has been done to remove Pending In Progress Intakes from Jae Curtis Dashboard 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/
update IntakeDAStaging set status = 'Complete', updatedby = 'CJAMS-66287', updatedon = now() 
where intakenumber in ('I241013024089','I241012466875','I241012849509','I261014012346','I261013971520','I261014010900','I261013940651','I261014005384','I241013149577','I261013947397','I261013981395','I261013954031','I251013215144',
'I241013159434','I241013139488','I261013897251','I241013196526','I241013140805','I241013196543','I251013219725','I241013134499','I241012741665') and activeflag = 1;
