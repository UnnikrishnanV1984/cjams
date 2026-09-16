/*
Issue Description: CJAMS-61984
Missing Reasons / Data Entry Errors
Category/Module: Missing Reasons
Root cause: User requested to update the AV LRR reason to "AV unavailable - Attempted face to face - 1-2 attempts."
Fix provided: As per user request, Data fix has been done to update the AV LRR reason(Legislative Reporting) to 
"Alleged victim Unavailable - Attempted face to face - 1-2 attempts."
Data/Code fix ticket#: CJAMS-61984
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: To be Decided
Reason why no related code fix: This is a know issue and agreement start date is fetched from latest court order for GAP agreement 
                                but it is not getting updated in the subsidy rate. Data fix should fix it.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V12F',
    updatedon = now(),
    updatedby = 'CJAMS-61288'
where cpsresponsetimeractionsid = '866cc437-a8c8-4762-981a-d92c7e1d416e'
and intakeserviceid = '7080c5fc-d774-4c5b-8043-b451500f1b9e';
