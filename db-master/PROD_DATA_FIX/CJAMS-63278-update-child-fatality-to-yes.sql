/*
Issue:I251013310850:The fatality radio button is not selected; however, the DOD for the child Elijah Everett (204168095) has been entered. The fatality radio button needs to be "Yes." Screen URL:
Root Cause:The intake is already screen out  User requested to update the child fatality button from "no" to "yes".
Fix Provided (Data Fix Only):Updated the child fatality in sdm for the client Elijah Everett (204168095) .
Data/Code fix ticket#:
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Intake # I251013310850 has been screened out on 06/23/2025 and need data fix to update the Child Fatality to YES.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update intakesnapshot
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','false'),
 updatedby = 'CJAMS-63278',  updatedon =now()
where intakenumber = 'I251013310850' and activeflag = 1;

update intakedastaging
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','false'),
updatedby = 'CJAMS-63278',  updatedon =now()
where intakenumber='I251013310850' and activeflag=1;