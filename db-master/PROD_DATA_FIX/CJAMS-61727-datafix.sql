/*
Issue Description: CJAMS-61727: Recorded Maltreatment Bug
Category/Module: GAP Subsidy
Root cause: Data fix needed to unselect 'Provider Involved Maltreatment' in the maltreatment allegation and 
SDM tabs for case# 251023094532
Fix provided: Data fix has been done to unselect 'Provider Involved Maltreatment' in the maltreatment allegation and 
SDM tabs for case# 251023094532
Data/Code fix ticket#: CJAMS-61727
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: To be Decided
Reason why no related code fix: This is a know issue and agreement start date is fetched from latest court order for GAP agreement 
                                but it is not getting updated in the subsidy rate. Data fix should fix it.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update intakeservicerequestsdm
set islicenseddaycare = false,
    ismaltreatment = false,
    updatedby = 'CJAMS-61727',
    updatedon = now()
where intakeserviceid = '493fe5f9-c039-4794-8d84-ff79af73a7e2'
and intakeservicerequestsdmid = '8cfc340d-5a8d-4fcb-96cc-60552886768d';

UPDATE cjams.investigationallegation
SET isproviderinvolved=0,
updatedby='CJAMS-61727',
updatedon=now()
WHERE investigationid='9e949448-b1da-4d42-9ea1-dff915757caa';