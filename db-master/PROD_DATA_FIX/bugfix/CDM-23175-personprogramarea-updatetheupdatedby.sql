-- CDM-23175 - wrong name
/*
   File Name: CDM-23175-personprogramarea-updatetheupdatedby
-- Issue Description: 
    For the case 3290231 - child's program assignment updated by Andrea Hollern but the systems shows Jacqueline Arguenta
    Customer Email ID:andrea.hollern@maryland.gov
  
-- Resolution: Updated the updatedby to Andrea Hollern(a89a5d3b-82d1-43b3-a441-383d6a206023) in the personprogramarea table for the personprogramid

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

update personprogramarea set updatedby = 'a89a5d3b-82d1-43b3-a441-383d6a206023', updatedon = now()
where personprogramid = '0d329636-df0b-4d87-b56d-4e3db931dc83';