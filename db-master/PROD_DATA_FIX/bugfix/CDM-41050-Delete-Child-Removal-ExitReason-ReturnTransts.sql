/*
   Issue Description: CDM-41050
   Category/ Module  : Data Fixes
   Root cause: removals are re-opened with the datafixes and missed nullifying the exit reasons.
   Fix provided : ran the query for updating the removalexitreason and returntrants to null
   Pull request# for code fix: 
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix: No
*/

update cjams.intakeservreqchildremoval
set 
	removalexitreason = NULL, -- TTONDA
	updatedby = 'CDM-41050',
	updatedon = now()
where removalid = 187034
	and activeflag = 1
	and exitdate is null;


update cjams.intakeservreqchildremoval_history
set 
	removalexitreason = NULL, -- TTONDA
	updatedby = 'CDM-41050',
	updatedon = now()
where intakeservreqchildremovalid = 'd7c80be5-f66d-4c7d-8521-b9f72264c1d5'
    and rowtype = 'REVISION'
    and activeflag = 1
	and exitdate is null;
--
update cjams.intakeservreqchildremoval
set 
	removalexitreason = NULL, -- REUNIF
	returntransts = null,
	updatedby = 'CDM-41050',
	updatedon = now()
where removalid = 281886
	and activeflag = 1
	and exitdate is null;

--
update cjams.intakeservreqchildremoval
set 
	removalexitreason = NULL, -- TTONDA
	updatedby = 'CDM-41050',
	updatedon = now()
where removalid = 195723
	and activeflag = 1
	and exitdate is null;