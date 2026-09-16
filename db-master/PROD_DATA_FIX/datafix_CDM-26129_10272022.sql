-- CDM-26129 - Delete a document
/*
-- Issue Description: 
	User request to delete Document from CPS case
	CPS-AR: CW2932249 - 22eed544-91b2-4ab4-b975-57dfd468fdf0
	Document Name : 2380672.pdf

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- ef30ca0a-eaf6-4b4c-9a58-9de287cd8535	2380672.pdf	March 2019 AR Abuse Police Report-MSP 
select originalfilename, filename, activeflag, updatedby, updatedon 
	from documentproperties
where documentpropertiesid = 'ef30ca0a-eaf6-4b4c-9a58-9de287cd8535'
	and activeflag = 1 ;

update documentproperties
set activeflag = 0,
	updatedby = 'CDM-26129',
	updatedon = now()
where documentpropertiesid = 'ef30ca0a-eaf6-4b4c-9a58-9de287cd8535'
	and activeflag = 1 ;

select documentpropertiesid, activeflag, updatedby, updatedon
	from documentattachment
where documentpropertiesid = 'ef30ca0a-eaf6-4b4c-9a58-9de287cd8535'
	and activeflag = 1 ;
	
update documentattachment
set activeflag = 0,
	updatedby = 'CDM-26129',
	updatedon = now()
where documentpropertiesid = 'ef30ca0a-eaf6-4b4c-9a58-9de287cd8535'
	and activeflag = 1 ;
	