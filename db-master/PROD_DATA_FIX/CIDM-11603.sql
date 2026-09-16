/*
Issue Description: CIDM-11603 - Rejected status removal for 3215426 - Jayda Permanency plan
Category/ Module: Permanency Plan
Root cause: On 07/17/2026 the Reunification permanency plan for JAYDA SUE TAYLOR (CJAMS PID# 3391401)
            was routed for review by Rhonda Gardner and then rejected by the supervisor
            Tawana Nolan. The rejection created an active routing row with eventcode 'PPLR' and
            routingstatustypeid = 17. getpermanencyplanhistory derives the displayed status from the
            most recent active 'PPLR' routing row, so the plan shows as 'Rejected' on the
            Permanency Plan history screen.
Fix provided: 1. Rejected routing entry deactivated so the plan no longer displays as Rejected.
                 The pre-existing active 'PPLR' routing row from 2013 (routingstatustypeid = 16)
                 becomes the most recent active row, so the status reverts to 'Approved'.
              2. Permanency Plan End Date cleared, along with the associated End Reason.
Regression Impacts: N/A - changes are scoped to a single permanencyplanid for one child.
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error

*/


-- 1. Remove the Rejected status by deactivating the rejection routing entry
UPDATE cjams.routing
	SET activeflag = 0,
		updatedby = 'CIDM-11603',
		updatedon = now()
WHERE routingid = '9561fcaf-aacc-4905-931a-173d1f11c8b3'
	AND objectid = '3d0cfe9f-427b-4811-9a08-3312adac3d61'
	AND eventcode = 'PPLR'
	AND routingstatustypeid = 17
	AND activeflag = 1 ;


-- 2. Remove the Permanency Plan End Date and the associated End Reason
UPDATE cjams.permanencyplan
	SET enddate = NULL,
		reason = NULL,
		updatedby = 'CIDM-11603',
		updatedon = now()
WHERE permanencyplanid = '3d0cfe9f-427b-4811-9a08-3312adac3d61'
	AND intakeservicerequestactorid = 'caa5e63d-9872-45e0-9420-008f58acd62f'
	AND servicecaseid = '4fd4f931-f4bc-4a91-8ace-c244f28817e8'
	AND activeflag = 1 ;