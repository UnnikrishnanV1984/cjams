/*

Root Cause:user error,  user incorrectly select the Child Fatality & Near-Death/Serious Physical Injury incorrectly
Fix Provided (Data Fix Only): Data fix is done to update the child fatality from No to Yes and Near-Death/Serious Physical Injury from yes to NO .
Data/Code fix ticket#: CJAMS-67375
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: this was a one time data correction specific  to a single referral.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/




--Child Fatality - from No to Yes
update intakesnapshot
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
 updatedby = 'CJAMS-67375',  updatedon =now()
where intakenumber = 'I261014007017' and activeflag = 1;


update intakeservicerequestsdm
set ischildfatality = true,
   updatedby = 'CJAMS-67375',  updatedon =now()
where intakeserviceid='30a80b81-a87a-4c0a-85f3-31ad6b4229bf' and activeflag =1;

update intakedastaging
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
updatedby = 'CJAMS-67375',  updatedon =now()
where intakenumber='I261014007017' and activeflag=1;