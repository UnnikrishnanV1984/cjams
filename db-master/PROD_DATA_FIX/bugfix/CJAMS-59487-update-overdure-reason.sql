/*
Issue Description:251022973315:Closed case needs corrected Over Due Reason dropdowns for late contact.
Category/Module: Overdue Reason
Root cause:Data Entry error and fix needed to correct overdue drop down reason as Case not assigned timelySupervisor Delays.
Fix provided: Data fix to update the over due reason as Case not assigned timelySupervisor Delays.
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User error
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VCNT',
    cpsresponsetimerreason2 = 'VSDT',
    cpsresponsetimerreason4 = 'OCNT',
    cpsresponsetimerreason5 = 'OSDT',
    cpsresponsetimerreason7 = 'CCNT',
    cpsresponsetimerreason8 = 'CSDT',
    updatedon = now(),
    updatedby = 'CJAMS-59487'
where cpsresponsetimeractionsid = '11677fb6-c317-4604-a6b0-18ea2dd32710'
and intakeserviceid = 'a230b550-9dbc-4e1d-97e7-7c73d4cb8198';