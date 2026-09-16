/*
Issue Description: Change subsidy rate
Category/Module: Bug
Root cause: Not a defect ,User entered incorrect subsidy rate date  and request for data fix.
Need to change the Subsidy rate start date to 04/02/2026 and run the batch to see if it generates system adjustment payments for missing 12 days 
Fix provided:Data fix is done to update the subsidy dates as requested
Data/Code fix ticket#: CJAMS-67902
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update gapagreementrate 
set startdate ='2026-04-02 00:00:00.000',
updatedby='CJAMS-67902',updatedon=now() 
where gapagreementrateid='94752749-aff1-47db-a5fb-783ae5ec9131' and activeflag =1;

update gapagreementrate
set updatedon = now(), updatedby = 'CJAMS-67902'
where gapagreementid = '9234f8fc-369c-4b19-9e72-6126b9ebfc8e'
and activeflag = 1 ;

update gapratesrevision  
set ratestartdate='2026-04-02 00:00:00.000',approvaldate = now(),
updatedby='CJAMS-67902',updatedon=now() 
where gaprateid='94752749-aff1-47db-a5fb-783ae5ec9131' and activeflag =1;

