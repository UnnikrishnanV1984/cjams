-- CJAMS-60158 - Incorrect dates entered
/*
-- Issue Description: 
    Adoption case 3301084 / Client 4399234 Madison Vansickle , Please do the following data fixes
    1. For Annual Review - 07/15/25 - Modify below
    Adoptive parent1 and 2  dates to be changed to 05/30/2024 to 05/30/2025 and LDSS Director Signature date on approval - to be changed from  6/20/2024  to 6/20/2025
    2. Delete Annual Review Deletion
    Annual Review - 07/14/2026 - to be deleted
-- Category/ Module: Adoption Subsidy (Adoption Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
--API: adoptioniverenewal
update adoptioniverenewal
set fatheragreementdate = '2025-05-30 04:00:00.000',--2024-05-30 04:00:00.000
	motheragreementdate = '2025-05-30 04:00:00.000',--2024-05-30 04:00:00.000
	designeeagreementdate = '2025-06-20 04:00:00.000',--2024-05-30 04:00:00.000
	updatedon = now(),
	updatedby = 'CJAMS-60158'
where adoptioniverenewalid ='8b927e0d-54a8-447d-ada5-c35421b4c807';

--removal of Annual Review - 07/14/2026 
/*
select fatheragreementdate ,motheragreementdate ,designeeagreementdate ,activeflag ,* from adoptioniverenewal where adoptioniverenewalid ='34e74363-d93c-4c21-ba4a-1fdf7b36c44a';
select * from routing r where objectid  ='34e74363-d93c-4c21-ba4a-1fdf7b36c44a';
*/

update adoptioniverenewal 
set activeflag=0, 
	updatedby='CJAMS-60158',
	updatedon=now() 
where adoptioniverenewalid='34e74363-d93c-4c21-ba4a-1fdf7b36c44a' and activeflag=1;

update routing 
set activeflag=0, 
	updatedby='CJAMS-60158',
	updatedon=now() 
where objectid='34e74363-d93c-4c21-ba4a-1fdf7b36c44a' and activeflag=1;