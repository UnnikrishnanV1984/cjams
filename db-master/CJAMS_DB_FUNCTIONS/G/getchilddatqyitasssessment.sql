
DROP FUNCTION IF EXISTS cjams.getchilddatqyitasssessment(v_objectid UUID);

CREATE OR REPLACE FUNCTION cjams.getchilddatqyitasssessment(v_objectid UUID)
RETURNS JSONB AS $$
--------------------------------------------------------------------------------------------------
-- 04/25/2024 prasanna sai kommineni - CIDM-10420 Quick Youth Indicators for Trafficking (QYIT)
-- 04/30/2024 prasanna sai kommineni - CIDM-10420 Quick Youth Indicators for Trafficking (QYIT)- UPDATED other child (not in household)
-----------------------------------------------------------------------------------------------------
BEGIN
    RETURN (
        SELECT jsonb_agg(result)
        FROM (
            SELECT 
                p.personid, 
                p.firstname, 
                p.middlename, 
                p.lastname, 
                p.dob, 
                p.cjamspid
            FROM intakeservicerequestactor s
            LEFT JOIN person p 
                ON p.personid = s.personid 
                AND p.activeflag = 1
            WHERE (s.servicecaseid = v_objectid::uuid OR s.intakeserviceid =v_objectid::uuid)
              AND (
                (s.intakeservicerequestpersontypekey IN ('AV', 'CHILD','OTHCHNH','OTHERCHILD') ) 
              )
              AND s.activeflag = 1 group by p.personid
        ) result
    );
END;
$$ LANGUAGE plpgsql;