/*
Issue:251030527250:The 'child fatality' button on the Maltreatment Type tab needs to be marked yes. The child has a date of death entered but the child fatality button will not change to yes. 
Root Cause:the child fatality and sspicious dta filed were not updated due to manual oversight during referral entry.
Fix Provided (Data Fix Only):Updated intakesnapshot table .
Data/Code fix ticket#: CJMAS-61406
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: this was a one time data correction specific  to a ssingle referral.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update intakesnapshot
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
 updatedby = 'CJAMS-61406',  updatedon =now()
where intakenumber = 'I251013311024' and activeflag = 1;

update intakeservicerequestsdm
set ischildfatality = true,
   updatedby = 'CJAMS-61406',  updatedon =now()
where intakeserviceid='e97dc5ec-a1f4-47ea-a97b-9af1a77fd339' and activeflag =1;

update intakedastaging
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
updatedby = 'CJAMS-61406',  updatedon =now()
where intakenumber='I251013311024' and activeflag=1;
