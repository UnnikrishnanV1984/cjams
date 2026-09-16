
/*
Issue:261023750236:The 'child fatality' button on the Maltreatment Type tab needs to be marked yes.
Root Cause: This is not a defect. As per system design, the Child Fatality can not be updated and user is requesting to update the answer to Yes as child DOD is entered.
Fix Provided (Data Fix Only): Data fix is done to update the child fatality from No to Yes .
Data/Code fix ticket#: CJAMS-67700
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: this was a one time data correction specific  to a single referral.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update intakesnapshot
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
 updatedby = 'CJAMS-67700',  updatedon =now()
where intakenumber = 'I261014021164' and activeflag = 1;


update intakeservicerequestsdm
set ischildfatality = true,
   updatedby = 'CJAMS-67700',  updatedon =now()
where intakeserviceid='070e2378-96bb-4b5b-8af8-3765d3635724' and activeflag =1;

update intakedastaging
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
updatedby = 'CJAMS-67700',  updatedon =now()
where intakenumber='I261014021164' and activeflag=1;