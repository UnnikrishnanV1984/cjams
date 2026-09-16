/*
Issue Description: CJAMS-58422: New Sailpoint Team Needed
                   Dashboard:Allegany County needs a following sailpoint changes: 
                   1)Rename the current unit "Intake & CPS Administration" to "CPS"a.Maintain all workers in the unit so the security monitors can update workers in the unit as needed. 
                   2)Create a new unit titled "Intake" a.Our security monitors will add the following staff to the new unit once create
Category/Module: Workload
Root cause: Request to update current unit and add new team in sailpoint
Fix provided: Data fix has been done to update Dashboard:Allegany County needs a following sailpoint changes: 1)Rename the current unit "Intake & CPS Administration" to "CPS"a.Maintain all workers in the unit so the security monitors can update workers in the unit as needed. 2)Create a new unit titled "Intake" a.Our security monitors will add the following staff to the new unit once create.
Data/Code fix ticket#: CJAMS-58422
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: These are changes are for adding new Team and updating the exisiting team.
                                Data fix is sufficient to resolve it.
*/

/****Rename the current unit "Intake & CPS Administration" to "CPS"****/

update team
set teamName='CPS',
    description = 'CPS',
    updatedby = 'CJAMS-58422',
    updatedon = now()
where teamid='86b1426d-675d-4a17-b94b-2f5120122541';

/****Create a new unit titled "Intake"****/

INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES(gen_random_uuid(), 1, 'Intake', '1427_10', 'CW', 'Intake', NULL, NULL, '3254e9ef-08da-4cd7-8aa1-083896ed9bec', 'CJAMS-58422', now(), 'CJAMS-58422', now(),now(), NULL, NULL, NULL, NULL, NULL, '3254e9ef-08da-4cd7-8aa1-083896ed9bec', NULL);
