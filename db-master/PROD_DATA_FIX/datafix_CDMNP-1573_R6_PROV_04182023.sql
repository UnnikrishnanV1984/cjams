-- CDMNP-1573 - Opening support tickets
/*
-- Issue Description: 
    To update supportlog Table Required columns for pending PROV Tickets
	
-- Category/ Module: Contact Support Ticket
-- Root cause: These tickets are created prior to addition of the new Required column "program"
-- Fix Provided: Datafix was promoted to update supportlog Table Required columns
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update supportlog Table Required columns
-- Before 
select count(*) 
	from defecttracking.supportlog s  
where coalesce(jirarequestsent, 'Pending') = 'Pending'
	and application = 'PROV'
	and activeflag  = 1
	and ( "program" is null or btrim("program") = '' ) 	
	and ( jirarequestno is null or btrim(jirarequestno ) = '' ) ;

update defecttracking.supportlog
set updatedby  = 'CDMNP-1573-R6',
	updatedon  = now(),
	program = (case when (program is null or btrim(program) = '' ) then
					'Other'
			   else
					program
			   end)	
where coalesce(jirarequestsent, 'Pending') = 'Pending'
	and application = 'PROV'
	and activeflag  = 1
	and ( "program" is null or btrim("program") = '' ) 
	and ( jirarequestno is null or btrim(jirarequestno ) = '' ) ; 
	
-- After 
select count(*) 
	from defecttracking.supportlog s  
where coalesce(jirarequestsent, 'Pending') = 'Pending'
	and application = 'PROV'
	and activeflag  = 1
	and ( "program" is null or btrim("program") = '' ) 	
	and ( jirarequestno is null or btrim(jirarequestno ) = '' ) ;
	