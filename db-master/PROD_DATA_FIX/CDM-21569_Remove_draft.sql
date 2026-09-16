/*
-- Ticket: CDM-21569  - 
-- Issue Description: Remove draft
-- Customer Email ID: michelle.sears@montgomerycountymd.gov
-- Closed  on:        2021-01-22 
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select  activeflag ,updatedby ,updatedon
	from cjams.intakeservreqchildremoval
	where intakeservreqchildremovalid ='eab056d2-90ab-4d3d-aa13-6369862832d6' ;
--where removalid in (251498);

select activeflag ,updatedby ,updatedon
	from cjams.intakeservreqchildremovalreason
	where intakeservreqchildremovalid ='eab056d2-90ab-4d3d-aa13-6369862832d6' ;

	
	
UPDATE cjams.intakeservreqchildremovalreason   SET 
                activeflag = 0, 
                updatedby = 'CDM-21569',
                updatedon = now() 
where intakeservreqchildremovalid ='eab056d2-90ab-4d3d-aa13-6369862832d6' ;

UPDATE cjams.intakeservreqchildremoval   SET 
                activeflag = 0, 
                updatedby = 'CDM-21569',
                updatedon = now() 
where intakeservreqchildremovalid ='eab056d2-90ab-4d3d-aa13-6369862832d6' ;
