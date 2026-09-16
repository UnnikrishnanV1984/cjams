-- CDM-25396 -Program Assignment
/*
   File Name: CDM-25396-personprogramarea-programassignment-Reopened
-- Issue Description: 
    For the Case 221030018678 Program assignments 9-27-22 that Stacia entered for child and mother appears as another worker's  
    Customer Email ID:stacia.bradsher2@maryland.gov
  
-- Resolution: Updated the updatedby to Stacia Bradsher in the personprogramarea for the case 221030018678

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update
	cjams.personprogramarea
set
	updatedby = '55f2e5c8-38ed-4065-bd35-05fafcb427da' ,
	updatedon = now()
where
	personprogramid = '8d28e035-f841-44a2-a039-314b0d8755f3'
	and personid = '6b0b6872-feb7-4890-bb73-7c46ee25b74f';

update
	cjams.personprogramarea
set
	updatedby = '55f2e5c8-38ed-4065-bd35-05fafcb427da' ,
	updatedon = now()
where
	personprogramid = '9234c661-70d5-48cd-9b3e-c6f89f8cbccd'
	and personid = 'cfb1b373-06d6-4a52-a71d-f1f46b2c3c95';