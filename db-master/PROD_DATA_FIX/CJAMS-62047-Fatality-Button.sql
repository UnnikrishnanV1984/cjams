/*
Issue:I251013295898:The 'child fatality' button on the Maltreatment Type tab needs to be marked No. 
Root Cause: User request/Error, The child fatality button is selected as "yes";
 however, this referral is not related to a fatality investigation. The child, Hunter Evans (PID 204116402), has a date of death listed as 10/1/2023. 
 The referral was received on 5/28/2025 and did not reference his death, only allegations for his surviving sibling. 
Fix Provided (Data Fix Only):Updated intakesnapshot table .
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
 updatedby = 'CJAMS-62047',  updatedon =now()
where intakenumber = 'I251013295898' and activeflag = 1;

update intakedastaging
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"no"'),'{sdm,ischildfatality}','false'),
updatedby = 'CJAMS-62047',  updatedon =now()
where intakenumber='I251013295898' and activeflag=1;