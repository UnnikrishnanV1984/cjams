-- B-151829 - Closing Multiple Open Permanency Plans (CIDM-6350)
-- Datafix To Close the Multiple Open Permanency Plans 

-- *****  Dependency ******
/*
Please deploy the below Stored procedure prior to this script run (datafix_CIDM-6350_01062023.sql)

1) cpsresponsetimerupdate.sql
															  )
*/

select a.al_sqlcode, a.as_mess
from cjams.sp_permanency_plan_datafix('CIDM-6350'::character varying) a ;

