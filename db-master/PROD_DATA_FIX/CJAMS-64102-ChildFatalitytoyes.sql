/*
Issue:241022957065 :The 'child fatality' button on the Maltreatment Type tab needs to be marked yes. The child has a date of death entered but the child fatality button will not change to yes. 
Root Cause:the child fatality and sspicious dta filed were not updated due to manual oversight during referral entry.
Fix Provided (Data Fix Only):Updated intakesnapshot table .
Data/Code fix ticket#: CJAMS-64102
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: this was a one time data correction specific  to a ssingle referral.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update intakesnapshot
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
 updatedby = 'CJAMS-64102',  updatedon =now()
where intakenumber = 'I241013197857' and activeflag = 1;


update intakeservicerequestsdm
set ischildfatality = true,
   updatedby = 'CJAMS-64102',  updatedon =now()
where intakeserviceid='45477be1-c811-4178-966f-5d7d515a99cc' and activeflag =1;

update intakedastaging
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
updatedby = 'CJAMS-64102',  updatedon =now()
where intakenumber='I241013197857' and activeflag=1;