/*
-- Issue Description: CDM-33399: Appeal
-- Category/ Module: Investigation Finding Expungment
-- Root cause: TDB 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update Investigationallegationmaltreators 
set intakeservicerequestactorid = '6f4a940f-193d-456c-af47-7720780c3023', updatedby = 'CDM-33399', updatedon = now()
where investigationallegationmaltreatorsid in ('4bbbdc74-0be9-4c89-8d0d-1ce31b97acbe','57aa55a8-b170-44c5-a194-d3ecd7b478ed')