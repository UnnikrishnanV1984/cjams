/*
Issue Description: Duplicate and incorrect annual review submitted and approved needs removed. 
Category/Module: Child Welfare - GAP Annual Review
Case ID: 3151627
Client ID: 2002779 (BRYSON GLOTFELTY)
Root cause: Worker error, not an application defect. The annual review appeared not to save, so it was entered
            again. That created two approved annual reviews under Bryson's GAP for the same review date of
            08/04/2026. The second one also had Jacob's answers, not Bryson's, and it was entered again
            correctly under Jacob's own GAP the next day.
Fix provided: Deactivated the duplicate annual review under Bryson's GAP (the last approved one, entered
              08/04/2026 19:42) along with its approval routing rows. Bryson's correct annual review and
              Jacob's own annual review are left untouched.
Data/Code fix ticket#: CJAMS-69672
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User data entry error, not an application defect.
Status of the code fix if already submitted and expected prod fix date: N/A - data fix only.


*/

update cjams.gapannualreview
set    activeflag = 0,
       updatedby  = 'CJAMS-69672',
       updatedon  = now()
where  gapannualreviewid = 'da318695-5bb2-4948-b792-7fb2ccd793b1'
and    gapid = 'cd2d7785-c322-4e3f-88d4-a54712b12cf0'
and    activeflag = 1;

update cjams.routing
set    activeflag = 0,
       updatedby  = 'CJAMS-69672',
       updatedon  = now()
where  objectid = 'da318695-5bb2-4948-b792-7fb2ccd793b1'
and    eventcode = 'GAYR'
and    activeflag = 1;