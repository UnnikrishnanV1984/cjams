

/*
Issue Description: Plan of Safe Care - accidentally created
Category/Module: POSC
Root cause: User requested to remove the In-Progress active POSC
Fix provided: Data fix done to remove the In-Progress active POSC.
Data/Code fix ticket#: CJAMS-67850
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/
update safecareplan
set activeflag=0,
updatedon=now() where safecareplanid='fe7c81df-8af6-4ec8-8c12-1cfcdc0917e9' and activeflag=1;