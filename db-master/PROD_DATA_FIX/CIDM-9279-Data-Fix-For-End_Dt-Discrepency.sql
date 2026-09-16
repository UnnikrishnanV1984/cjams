-- CIDM-9279: Data fix for Start date and end date discrepancy in tb_client_eligibility table
/*
Summary:	Data fix for Start date and end date discrepancy in TBClinetEligibilty table (aprox 250 records affected)
Assignee:	AnilKumar Dharni
CJAMS Child Apps:	Title IV-E
CJAMS Id/Referral Id:	NA
Environment:	Staging
Focus Area:	Title IV-E
Steps to Reproduce:	Bulk data fix
*/

-- Closed Removal and End date null in tb_client_eligibility
UPDATE
    cjams.tb_client_eligibility
SET
    end_dt = rm.exitdate,
    update_user_id = 'CIDM-9279', 	
	update_ts = now()
FROM
    intakeservreqchildremoval rm
WHERE
    cjams.tb_client_eligibility.removal_id = rm.removalid
    AND rm.activeflag = 1
    AND cjams.tb_client_eligibility.delete_sw = 'N'
    and (
        rm.exitdate is not null
        and cjams.tb_client_eligibility.end_dt is null
    );

-- End Date descripenacies
UPDATE
    cjams.tb_client_eligibility
SET
    end_dt = rm.exitdate,
    update_user_id = 'CIDM-9279', 	
	update_ts = now()
FROM
    intakeservreqchildremoval rm
WHERE
    cjams.tb_client_eligibility.removal_id = rm.removalid
    and rm.activeflag = 1
    and cjams.tb_client_eligibility.delete_sw = 'N'
    and rm.exitdate :: date <> cjams.tb_client_eligibility.end_dt :: date;