/*
Issue:251022994329:The 'child fatality' button on the Maltreatment Type tab needs to be marked yes. The child has a date of death entered but the child fatality button will not change to yes. 
Root Cause:the child fatality and specific data filled were not updated due to manual oversight during referral entry.
Fix Provided (Data Fix Only):Updated intakesnapshot table .
Data/Code fix ticket#: CJAMS-61357
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: this was a one time data correction specific  to a ssingle referral.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update intakesnapshot
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
 updatedby = 'CJAMS-61357',  updatedon =now()
where intakenumber = 'I251013221625' and activeflag = 1;

update intakeservicerequestsdm
set ischildfatality = true,
   updatedby = 'CJAMS-61357',  updatedon =now()
where intakeserviceid='c6700cca-a51a-46cc-9135-0963cf5e6d3a' and activeflag =1;

update intakedastaging
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
updatedby = 'CJAMS-61357',  updatedon =now()
where intakenumber='I251013221625' and activeflag=1;