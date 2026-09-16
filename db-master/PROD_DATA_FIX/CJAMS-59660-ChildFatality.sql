/*
Issue:251023054905:Child's death is noted under Person's Tab and is not allowing me to check the "Child Fatality" box under the SDM.
Root Cause:the child fatality and sspicious dta filed were not updated due to manual oversight during referral entry.
Fix Provided (Data Fix Only):Updated intakesnapshot table .
Data/Code fix ticket#: CJAMS-59660
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: this was a one time data correction specific  to a ssingle referral.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update intakesnapshot
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
 updatedby = 'CJAMS-59660',  updatedon =now()
where intakeserviceid = '269299ee-f82c-469b-ae56-5c8c35797b86' and activeflag = 1;


update intakeservicerequestsdm
set ischildfatality = true,
   updatedby = 'CJAMS-59660',  updatedon =now()
where intakeserviceid='269299ee-f82c-469b-ae56-5c8c35797b86' and activeflag =1;

update intakedastaging
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
updatedby = 'CJAMS-59660',  updatedon =now()
where intakenumber='I251013283725' and activeflag=1;