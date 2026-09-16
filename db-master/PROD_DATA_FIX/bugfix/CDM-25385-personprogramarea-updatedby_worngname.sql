-- CDM-25385 - wrong name
/*
-- Issue Description: 
    For case # 2020031804192 Andrea Hollern opened a program assignment for a client and it is showing someone else opened it 
    instead of Andrea Hollern
  
-- Resolution: for the Personprogramid- e83f0220-d21c-4fc7-ad14-a59d8ad71418 the pervious value of updatedby was 5321bcf2-3dd0-49a5-94a4-580c0750348c
    and it was updated to a89a5d3b-82d1-43b3-a441-383d6a206023

-- Case ID: 2020031804192 

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

Data backup-- Previous values
--Personprogramid 								updated by
--e83f0220-d21c-4fc7-ad14-a59d8ad71418		5321bcf2-3dd0-49a5-94a4-580c0750348c
*/
update personprogramarea set updatedby = 'a89a5d3b-82d1-43b3-a441-383d6a206023', updatedon = now()
where personprogramid in ('e83f0220-d21c-4fc7-ad14-a59d8ad71418');