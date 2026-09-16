
/*
Issue:251023022650:Please update referral I251013251857 associated with investigation 251023022650 (HOH: Kathleen A Amesbury). The identified victim in the investigation, Honor Jordan, did not survive her injuries and is now deceased. I am requesting that fatality button be changed from "no" to "yes", and the "suspicious death of a child box" be checked as well. 
Root Cause:the child fatality and sspicious dta filed were not updated due to manual oversight during referral entry.
Fix Provided (Data Fix Only):Updated intakesnapshot table .
Data/Code fix ticket#: CJAMS-59368
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: this was a one time data correction specific  to a ssingle referral.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update intakesnapshot
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
 updatedby = 'CJAMS-59438',  updatedon =now()
where intakeserviceid = 'e35abf95-dcdc-49b2-be1c-5a486c1d253b' and activeflag = 1;


update intakeservicerequestsdm
set ischildfatality = true,
   updatedby = 'CJAMS-59438',  updatedon =now()
where intakeserviceid='e35abf95-dcdc-49b2-be1c-5a486c1d253b' and activeflag =1;

update intakedastaging
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
updatedby = 'CJAMS-59438',  updatedon =now()
where intakenumber='I251013251857' and activeflag=1;
