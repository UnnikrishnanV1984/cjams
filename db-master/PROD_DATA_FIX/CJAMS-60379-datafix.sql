/*
Issue Description: CJAMS 60379: Duplicate and older duplicate intake referrals that need to be deleted
Category/Module: Intake removal
Root cause: CW10098663 & I251013313814 Created in error, needs to be removed from dashboard 
Data/Code fix ticket#: CJAMS-60379
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update intakedastaging
set activeflag=0, updatedby='CJAMS-60379', updatedon=now()
where intakenumber in ('CW10098663','I251013313814') and activeflag=1;

update intakedastatus
set activeflag=0, updatedby='CJAMS-60379', updatedon=now()
where intakenumber in ('CW10098663','I251013313814') and activeflag=1;

update routing 
set activeflag = 1,updatedby='CJAMS-60379', updatedon=now()
where objectid in ('CW10098663','I251013313814') and activeflag=1;

update intakeservicerequest 
set activeflag=0, updatedby='CJAMS-60379', updatedon=now()
where intakenumber in ('CW10098663','I251013313814') and activeflag=1;


