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
		(	'S20220193042254', 'S20220192042214', 'S20220182042023', 'S20220181042007', 
			'S20220160041488', 'S20220138040928', 'S20210356036421', 'S20210355036365', 'S20210354036353',
			'S20210335035734', 'S20210307034776', 'S20210300034446', 'S20210265033163', 'S20210251032770',
			'S20210245032639', 'S20210147029157', 'S2021049024755', 'S2021049024731', 'S2021043024474',
			'S2021043024470', 'S2021032023758', 'S2021027023477', 'S2021025023349', 'S2021022023228',
			'S2021022023177', 'S2021021023112', 'S20200353021870', 'S20200353021869', 'S20200353021868',
			'S20200353021863', 'S20200353021862', 'S20200353021858', 'S20200352021760', 'S20200352021745',
			'S20200352021744', 'S20200346021445', 'S20200345021369', 'S20200343021233', 'S20200343021231',
			'S20200342021118', 'S20200340021117', 'S20200335020856', 'S20200335020847', 'S20200335020846',
			'S20200335020845', 'S20200335020844', 'S20200335020843', 'S20200335020842'
		);
	
update defecttracking.supportlog
set jirarequestsent = NULL,
	updatedby  = 'CDMNP-1573-R1',
	updatedon  = now()
where activeflag = 1
	and jiraenv = 'Production'
	and coalesce(jirarequestsent, 'Pending') in ( 'Approve', 'Approved')
	and application  = 'PROV'
	and jirarequestno is null
	-- and insertedon::date >= '2023-01-01'::date 
	and supportno in  
		(	'S20220193042254', 'S20220192042214', 'S20220182042023', 'S20220181042007', 
			'S20220160041488', 'S20220138040928', 'S20210356036421', 'S20210355036365', 'S20210354036353',
			'S20210335035734', 'S20210307034776', 'S20210300034446', 'S20210265033163', 'S20210251032770',
			'S20210245032639', 'S20210147029157', 'S2021049024755', 'S2021049024731', 'S2021043024474',
			'S2021043024470', 'S2021032023758', 'S2021027023477', 'S2021025023349', 'S2021022023228',
			'S2021022023177', 'S2021021023112', 'S20200353021870', 'S20200353021869', 'S20200353021868',
			'S20200353021863', 'S20200353021862', 'S20200353021858', 'S20200352021760', 'S20200352021745',
			'S20200352021744', 'S20200346021445', 'S20200345021369', 'S20200343021233', 'S20200343021231',
			'S20200342021118', 'S20200340021117', 'S20200335020856', 'S20200335020847', 'S20200335020846',
			'S20200335020845', 'S20200335020844', 'S20200335020843', 'S20200335020842'
		);