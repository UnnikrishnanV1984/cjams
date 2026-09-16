-- CDM-24576 - Worker Name
/*
   File Name: CDM-24576-personprogramarea-updatetheupdatedby
-- Issue Description: 
    For the case 221030017987 - Everytime Brittany Brendel open or end date a program assignment it is getting updated with some one's name in this case
	it was updated by Hollie Vonstein instead of Brittany Brendel
    Customer Email ID:brittany.brendel@maryland.gov
  
-- Resolution: Updated the updatedby to Brittany Brendel(dfdc212e-0829-4b69-beae-72e34226bb03) in the personprogramarea table for the personprogramid

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/
update
	personprogramarea
set
	updatedby = 'dfdc212e-0829-4b69-beae-72e34226bb03',
	updatedon = now()
where
	personprogramid = 'eddbfaef-fd42-4a36-bcae-820dd0d3b2b7'
	and objectid = '73416641-c0cc-4fba-92e3-1d7d1b6cf3a6';