/*
Issue:I251013258454:The 'child fatality' button on the Maltreatment Type tab needs to be marked No. 
Root Cause: User request/Error, TI251013258454:The child fatality button is selected as "yes";
The child, Kaijah Kelly (PID 3971485) has a date of death listed as 5/10/2017. 
The referral was received on 4/4/2025 and did not reference her death, only allegations for her surviving sibling. The child fatality button needs to be selected as "no", as this is not a fatality investigation.Fix Provided (Data Fix Only):Updated intakesnapshot table .
Data/Code fix ticket#:
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: this was a one time data correction specific  to a single referral.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update intakesnapshot
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"no"'),'{sdm,ischildfatality}','false'),
 updatedby = 'CJAMS-62045',  updatedon =now()
where intakenumber = 'I251013258454' and activeflag = 1;

update intakedastaging
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"no"'),'{sdm,ischildfatality}','false'),
updatedby = 'CJAMS-62045',  updatedon =now()
where intakenumber='I251013258454' and activeflag=1;