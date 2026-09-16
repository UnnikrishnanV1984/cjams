

/*
Issue Description: Adding DB Indexes for PROD DB Slowness
Category/Module: Hotfix
Root cause: iscaseexpunged proc is slow.
Fix provided: Added indexes to improve the performance of the iscaseexpunged procedure.
Data/Code fix ticket#: CIDM-11090
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Hotfix
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/

CREATE INDEX "intakeservicerequest_intakeserviceid_IDX" ON cjams.intakeservicerequest (intakeserviceid,isexpunged);
CREATE INDEX "expungementreport_expungementtypekey_IDX" ON cjams.expungementreport (expungementtypekey,intakeserviceid);
CREATE INDEX "expungementreport_intakeserviceid_IDX" ON cjams.expungementreport (intakeserviceid);
CREATE INDEX "intakedastatus_intakenumber_IDX" ON cjams.intakedastatus (intakenumber,isexpunged);
