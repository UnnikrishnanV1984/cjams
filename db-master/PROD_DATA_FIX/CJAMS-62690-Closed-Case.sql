/*
   Issue Description: :Case is closed by assignment is still active.
   Category/ Module  :  Case Issue
   Root cause: partial datafix was made on this migrated adoption case by CDM-18135 back in 2021 to close the adoption case but case assignment was still open.
   Fix: updated the case assignment table with the correct case assignment date.
   Pull request# for code fix: 
   Reason why no related code fix: 
*/


update caseassignment
set activeflag = 0,
	updatedby = 'CJAMS-62690',
	updatedon = now()
where caseassignmentid in ('f8acdda4-9d3e-417a-8474-297a2307d89b','c99ee6dc-8856-4cb2-80fc-1b5f7d4b83bc')
and activeflag = 1;

update caseassignment
set enddate = '2021-10-31 00:00:00', --2022-05-19 16:11:12
	updatedby = 'CJAMS-62690',
	updatedon = now()
where caseassignmentid = 'a1becb56-9edc-4f81-974e-f714ca272dd8'
and activeflag = 1;