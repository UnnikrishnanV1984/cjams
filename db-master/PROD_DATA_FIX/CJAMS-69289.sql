/*
Issue Description: CJAMS-69289 - Annual review
Category/Module: Child Welfare - GAP Annual Review
Root cause: Worker entered the annual review in error.
Fix provided: Data fix has been done to delete the 9/14/2026 annual review for
   Anthony Martinez Hernandez (CJAMS PID# 4166740) under Case# 3283090.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User data entry error, not an application defect.
Backup before update/delete:
*/

update gapannualreview
set
    activeflag = 0,
    updatedby = 'CJAMS-69289',
    updatedon = now ()
where
    gapannualreviewid = '05a5266a-f232-4fc3-8000-e76235459285'
    and gapid = '412769e1-9798-4fad-a810-992d78e2be9f'
    and activeflag = 1;

update routing
set
    activeflag = 0,
    updatedby = 'CJAMS-69289',
    updatedon = now ()
where
    objectid = '05a5266a-f232-4fc3-8000-e76235459285'
    and eventcode = 'GAYR'
    and activeflag = 1;