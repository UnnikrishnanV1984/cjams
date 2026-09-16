-- CDM-26518- Wrong programmers name added
/*
   File Name: CDM-26518-personprogramarea-UpdateWrongProgrammersName
-- Issue Description: 
    For the case 221030019621  - In the program Assignments see the Wrong person KeVonya Moment as updatedby instead of Ronda Lewis
    Customer Email ID:ronda.lewis@maryland.gov
  
-- Resolution: Updated the updatedby Column in the personprogramarea table for the case 221030019621

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

-- 9bcabe07-8793-448a-a08a-5fb1a1163beb --KeVonya Moment
-- 299210ac-c6df-4985-a02b-bdeda0cdad67 -- Ronda Lewis
 update
	personprogramarea
set
	updatedby = '299210ac-c6df-4985-a02b-bdeda0cdad67',
	updatedon = now()
where
	personprogramid = '49d06d0c-0888-447d-b4f7-7435418bbd10'