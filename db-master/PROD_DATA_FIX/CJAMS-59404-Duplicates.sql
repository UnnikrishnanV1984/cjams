
/*
Issue:221030013654:This Safe C can be deleted as the caregiver is the OHP placement. This one and the unsafe one were approved within a few seconds of each other and is resulting in the name duplicating on the OHP Milestonde report.Wanda Nolt
Root Cause:Duplicate SAFE-C assessments were created and casued confusion in the OHP Milestone report due to ovelapping approval and an undeletable draft.
Fix Provided (Data Fix Only): as per data fix updated the 
assessment.
Data/Code fix ticket#: CJAMS-59404
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data-only issue; no logic/code changes required.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/


update
	assessment
set
	activeflag = 0,
	updatedby = 'CJAMS-59404' ,
	updatedon = now()
where
	assessmentid in ('a1cc25af-46d7-4d1f-87a3-df5a4d1c89f5' , '0ef086f3-f583-4c99-8ddc-9ded8a2d5011')
	and activeflag = 1;

update
	assessment_history
set
	activeflag = 0,
	updatedby = 'CJAMS-59404' ,
	updatedon = now()
where
	assessmenthistoryid in ('44ec246f-4828-4187-9032-2779223cbfd7' , 'f5836316-6faf-4a2f-9406-eb046d621317')
	and activeflag = 1;

update
	assessmentactor
set
	activeflag = 0,
	updatedby = 'CJAMS-59404' ,
	updatedon = now()
where
	assessmentactorid in ('1dd019c6-3e94-41f3-b4d7-e28699f83095' , '48aec35a-bd66-4043-9c36-3dbd2db668d3')
	and activeflag = 1;

update
	assessmentcomments
set
	activeflag = 0,
	updatedby = 'CJAMS-59404' ,
	updatedon = now()
where
	assessmentcommentsid in ('1811a4c3-0acd-4c9c-90b6-c5357c351d02' , '656dcd4a-6fce-457b-a171-373fa96bae85')
	and activeflag = 1;

update
	routing
set
	activeflag = 0,
	updatedby = 'CJAMS-59404' ,
	updatedon = now()
where
	routingid in ('5e13202b-6c15-4d0c-81f5-df13da3a5f70')
	and activeflag = 1;
