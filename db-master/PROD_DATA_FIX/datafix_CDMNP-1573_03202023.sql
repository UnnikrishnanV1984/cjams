-- CDMNP-1573 - Opening support tickets
/*
-- Issue Description: 
    Move Approved Tickets to unapproved status for the ones which not created JIRA ID
	
-- Category/ Module: Contact Support Ticket
-- Root cause: Issue on ESMS 
-- Fix Provided: Datafix was promoted to update the Contact Support Ticket as Pending.  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select supportlogid, jirarequestsent, updatedby, updatedon, jirarequestno, supportno 	
	from defecttracking.supportlog
where activeflag = 1
	and jiraenv = 'Production'
	and coalesce(jirarequestsent, 'Pending') in ( 'Approve', 'Approved')
	and application  = 'PROV'
	and jirarequestno is null
	-- and insertedon::date >= '2023-01-01'::date 
	and supportno in  
		(	'S20220297045055', 'S20220297045053', 'S20220297045050', 'S20220297045047', 'S20220297045040',
			'S20220276044470', 'S20220222043066', 'S20220208042654', 'S20220193042255', 'S20220193042228',
			'S20220189042176', 'S20220181042009', 'S20220181042006', 'S20220181041988', 'S20220179041911',
			'S20220179041910', 'S20220179041897', 'S20220175041825', 'S20220169041712', 'S20220165041582',
			'S20220164041557', 'S20220159041447', 'S20220159041445', 'S20220152041288', 'S20220152041281',
			'S20220152041280', 'S20220147041179', 'S20220144041078', 'S20220144041072', 'S20220132040797',
			'S20220130040685', 'S20220124040510', 'S2022081039162', 'S2022040037704', 'S2022040037702',
			'S2022027037298'
		);
	
update defecttracking.supportlog
set jirarequestsent = NULL,
	updatedby  = 'CDMNP-1573',
	updatedon  = now()
where activeflag = 1
	and jiraenv = 'Production'
	and coalesce(jirarequestsent, 'Pending') in ( 'Approve', 'Approved')
	and application  = 'PROV'
	and jirarequestno is null
	-- and insertedon::date >= '2023-01-01'::date 
	and supportno in  
		(	'S20220297045055', 'S20220297045053', 'S20220297045050', 'S20220297045047', 'S20220297045040',
			'S20220276044470', 'S20220222043066', 'S20220208042654', 'S20220193042255', 'S20220193042228',
			'S20220189042176', 'S20220181042009', 'S20220181042006', 'S20220181041988', 'S20220179041911',
			'S20220179041910', 'S20220179041897', 'S20220175041825', 'S20220169041712', 'S20220165041582',
			'S20220164041557', 'S20220159041447', 'S20220159041445', 'S20220152041288', 'S20220152041281',
			'S20220152041280', 'S20220147041179', 'S20220144041078', 'S20220144041072', 'S20220132040797',
			'S20220130040685', 'S20220124040510', 'S2022081039162', 'S2022040037704', 'S2022040037702',
			'S2022027037298'
		);