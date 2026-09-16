-- CDM-26387 - Wrong Hearing Client
/*
-- Issue Description: 
	1. User requested to change the client Elijah (cjamspid:3964439) to Immanuel (cjamspid:3957873)

-- Category/ Module: Court Hearing
-- Root cause: User Request
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select 	personid, * from hearingclients 
where 	personid = '92c0dba1-9205-4a92-8bec-336a1e983f26' 
		and activeflag = 1
		and courthearingid in (select intakeservicerequestcourthearingid from intakeservicerequestcourthearing where intakeservicerequestpetitionid = 'eec30ceb-6f4f-428a-a635-bfabbc538a65');

update 	hearingclients
set 	personid = '88881475-05d2-4326-863c-c63b37494ab3',
		updatedby = 'CDM-26387',
		updatedon = now()
where 	personid = '92c0dba1-9205-4a92-8bec-336a1e983f26'
		and activeflag = 1
		and courthearingid in (select intakeservicerequestcourthearingid from intakeservicerequestcourthearing where intakeservicerequestpetitionid = 'eec30ceb-6f4f-428a-a635-bfabbc538a65');
	