-- CDM-24184 - Manually Trigger Response Timer Condition on all the Open CPS-IR / CPS-AR Cases
/*
-- To fix the Person Substance Exposed Newborn Flag issue (CIDM-5306)
-- 1) Update the Person tbale with SEN information 
-- 2) Update the SDM table (intakeservicerequestsdm --> drugexposednewbornflag)
*/

-- *****  Dependency ******
/*
Please deploy the below DDL script and Stored procedure prior to this script run (datafix_CIDM-5306_08082022.sql)
 
1) CIDM-5306_Person_SEN_fix_DDLs.sql
2) sp_sen_person_datafix.sql
															  )
*/

select a.al_sqlcode, a.as_mess
from cjams.sp_sen_person_datafix('CIDM-5306'::character varying) a ;