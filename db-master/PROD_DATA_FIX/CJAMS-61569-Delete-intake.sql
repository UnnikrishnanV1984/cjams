/*
   Issue Description: CJAMS-61569 Please delete 3 pending intakes from user Agatha Chukwuezi's workload - she has been suspended in Sailpoint I211010225784 I202000365571 I202000165328 
   Category/ Module  :  Intake 
   Root cause: User Requested to delete intake I211010225784 I202000365571 I202000165328  as the user Agatha Chukwuezi's is deactivated in the sailpoint
   Fix Provided: Data fix has been done to delete the intake I211010225784 I202000365571 I202000165328 
   Regression Impacts: N/A
   Is code fix Needed : No 
   Reason why no code fix is needed: User requested to delete the intake and data fix should resolve it.
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-61569'
where intakenumber in ('I211010225784', 'I202000365571', 'I202000165328') and activeflag=1;

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-61569'
where intakenumber in ('I211010225784', 'I202000365571', 'I202000165328') and activeflag=1;