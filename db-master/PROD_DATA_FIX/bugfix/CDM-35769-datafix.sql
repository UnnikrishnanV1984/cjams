/*
   Issue Description: CDM-35769-error in the investigative findings
   Category/ Module  :Assessments: Other
   Root cause: Error in Investigation Finding/Gerald Lansdowne need to be removed
   Fix Privided: data fix removed Gerald from the Investigations Findings screen
*/
-- remove Gerald Lansdowne (PID# 200937667) from the Investigation Findings screen
update
    investigationallegation
set
    activeflag = 0,
    updatedby = 'CDM-35769',
    updatedon = now()
where
    investigationallegationid = 'b79e67c2-ebf9-4cdb-a4a2-1e18ac98d98e'
    and allegationid = '19233c90-707c-482c-93c8-b33738685fc6';
