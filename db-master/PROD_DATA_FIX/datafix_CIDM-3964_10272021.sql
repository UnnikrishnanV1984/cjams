-- CIDM-3964 - E&E Logic flaw
/*
-- Issue Description: 
   Logic flaw in the current CARES/ENE inbound batch process and it takes long time to process the batch file
		   
-- Category/ Module: CJAMS - CARES/E&E Interface (Inbound Batch)
-- Root cause: Logic flawin updating 'statusflag' column in the 'caresclient' table
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD 
*/

-- Datafix to update caresclient table statusflag as processed for all the records 
select count(*) 
	from caresclient
where activeflag = 1
	and statusflag = 1 ;

update caresclient
set statusflag = 0,
	updatedby = 'CIDM-3964',
	updatedon = now()
where activeflag = 1
	and statusflag = 1 ;
