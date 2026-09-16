/*
Issue:251023376387:The 'child fatality' button on the Maltreatment Type tab needs to be marked yes.
Root Cause:user error, case was closed on 02/23/2026 and the worker selected the Child Fatality as No in the SDM.
Fix Provided (Data Fix Only): Data fix is done to update the child fatality from No to Yes .
Data/Code fix ticket#: CJAMS-65819
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: this was a one time data correction specific  to a single referral.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update intakesnapshot
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
 updatedby = 'CJAMS-65819',  updatedon =now()
where intakenumber = 'I251013627954' and activeflag = 1;


update intakeservicerequestsdm
set ischildfatality = true,
   updatedby = 'CJAMS-65819',  updatedon =now()
where intakeserviceid='c4b61832-80be-4541-8fca-bb2b554398d8' and activeflag =1;

update intakedastaging
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
updatedby = 'CJAMS-65819',  updatedon =now()
where intakenumber='I251013627954' and activeflag=1;