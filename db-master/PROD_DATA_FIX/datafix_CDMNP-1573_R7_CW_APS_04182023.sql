-- CDMNP-1573 - Opening support tickets
/*
-- Issue Description: 
    To update supportlog Table Required columns for pending CW & APS Tickets
	
-- Category/ Module: Contact Support Ticket
-- Root cause: These tickets are created prior to addition of the new Required column "program"
-- Fix Provided: Datafix was promoted to update supportlog Table Required columns
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update supportlog Table Required columns
-- CW
-- Before 
select count(*) 
	from defecttracking.supportlog s  
where coalesce(jirarequestsent, 'Pending') = 'Pending'
	and application <> 'PROV'
	and activeflag  = 1
	and ( jirarequestno is null or btrim(jirarequestno ) = '' )
	and (
			("program" is null or btrim("program") = '' )
			or ( subject is null or btrim(subject ) = '' )
			or ( severity is null or btrim(severity ) = '' )
			or ( priority is null or btrim(priority ) = '' )
			or ( issuetype is null or btrim(issuetype ) = '' )
		);

update defecttracking.supportlog
set updatedby  = 'CDMNP-1573-R7',
	updatedon  = now(),
	subject = (case when (subject is null or btrim(subject) = '') then 
					coalesce(substring(notes,1,47) || '...' , '??')
				else 
					subject 
				end),
	severity = (case when (severity is null or btrim(severity) = '') then 
					'Medium'
				else
					severity
				end),
	priority = (case when (priority is null or btrim(priority) = '') then
					'3' -- Medium
				else
					priority
				end),
	issuetype = (case when (issuetype is null or btrim(issuetype) = '') then 
					'528' -- Bug/Issue/Defect
				else
					issuetype
				end),
	program = (case when (program is null or btrim(program) = '') then
					'In-Home'
			   else
					program
			   end)	
where coalesce(jirarequestsent, 'Pending') = 'Pending'
	and application <> 'PROV'
	and activeflag  = 1
	and ( jirarequestno is null or btrim(jirarequestno ) = '' )
	and (
			("program" is null or btrim("program") = '' )
			or ( subject is null or btrim(subject ) = '' )
			or ( severity is null or btrim(severity ) = '' )
			or ( priority is null or btrim(priority ) = '' )
			or ( issuetype is null or btrim(issuetype ) = '' )
		);
	
-- After 
select count(*) 
	from defecttracking.supportlog s  
where coalesce(jirarequestsent, 'Pending') = 'Pending'
	and application <> 'PROV'
	and activeflag  = 1
	and ( jirarequestno is null or btrim(jirarequestno ) = '' )
	and (
			("program" is null or btrim("program") = '' )
			or ( subject is null or btrim(subject ) = '' )
			or ( severity is null or btrim(severity ) = '' )
			or ( priority is null or btrim(priority ) = '' )
			or ( issuetype is null or btrim(issuetype ) = '' )
		);
		
		
-- APS
-- Before 
select count(*) 
	from cjams.supportlog s  
where coalesce(jirarequestsent, 'Pending') = 'Pending'
	and activeflag  = 1
	and ( "program" is null or btrim("program") = '' ) 	
	and ( jirarequestno is null or btrim(jirarequestno ) = '' ) ;

update cjams.supportlog
set updatedby  = 'CDMNP-1573-R7',
	updatedon  = now(),
	program = (case when (program is null or btrim(program) = '' ) then
					'APS'
			   else
					program
			   end)	
where coalesce(jirarequestsent, 'Pending') = 'Pending'
	and activeflag  = 1
	and ( "program" is null or btrim("program") = '' ) 	
	and ( jirarequestno is null or btrim(jirarequestno ) = '' ) ;

	
-- After 
select count(*) 
	from cjams.supportlog s  
where coalesce(jirarequestsent, 'Pending') = 'Pending'
	and activeflag  = 1
	and ( "program" is null or btrim("program") = '' ) 	
	and ( jirarequestno is null or btrim(jirarequestno ) = '' ) ;
			