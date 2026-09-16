/*
   Issue Description: :Case is closed by assignment is still active.
   Category/ Module  :  Case Issue
   Root cause: partial datafix was made on this migrated adoption case back in 2021 to close the adoption case but case assignment was still open.
   Fix: updated the case assignment table with the correct case assignment date.
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

--3277331
update caseassignment
set activeflag = 0,
	updatedby = 'CJAMS-62693',
	updatedon = now()
where caseassignmentid in ('813aa4b8-aa53-4a36-9984-cf6281eacb7c',
'3274bd83-82c1-4239-9cd4-eb3869ea7104')
and activeflag = 1;

update caseassignment
set enddate = '2021-04-30 08:12:26', --2022-05-19 14:47:32
	updatedby = 'CJAMS-62693',
	updatedon = now()
where caseassignmentid = '3fbc5f76-7a0c-4e0a-82b5-913b16b2d0ad'
and activeflag = 1;