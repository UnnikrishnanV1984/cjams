
/*
Issue Description: Primary Sign Date and the Director Sign Date incorrect
Root cause: Please carry out data fix to change the Primary Caregiver & Director Sign date as 01/29/2026,Case ID: 2020014301277,PID ID: 4419092(RALEIGH CHAPPELL)
Data/Code fix ticket#: CJAMS-68465
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data fix only, no code changes required
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update gapannualreview
set cgprimarydate ='2026-01-29 04:00:00.000',directorsigndate ='2026-01-29 04:00:00.000', 
updatedby = 'CJAMS-68465', updatedon = now()
where gapannualreviewid = '08d1a9f6-05e3-446f-a8ee-f024e1d3be36';