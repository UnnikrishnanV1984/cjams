-- CDM-33316 - Validation
/*
-- Issue Description: 
   User cannot complete the placement validations for month of March, April, May and June 2023

-- Case ID: 3292645
-- Client ID: 2460994 (GABRIAL WOODS) - bfb1f0ea-7f80-4855-b24a-67e2253570a0
-- Private Organization: 6006089 (Brooksville Youth Academy)
-- Provider ID: 6006238	(Brooksville Youth Academy) - Residential Treatment Center

-- Placement ID: 1707581 - 2023-02-07 To 2023-07-01 - aa9e90aa-b6c7-4e5d-afff-ef0b96cb1aa8
-- Program ID: 50004177 - Gabriel Woods - 2023-07-01 To 2024-12-31 
-- June 2023 as Program Start date is 07-01-2023

-- Placement ID: 1704326 - 2023-07-01 To current - e48ab777-5dfe-4c42-b400-117a79a9586b
-- Program ID: 50003349	- Gabrial Woods	- 2023-02-07 To 2023-06-30 
-- March, April, May 2023

-- Category/ Module: Placement (Case Management) 
-- Root cause: Placement was retroactively exited, but one out of placement date range placement validation record was not deleted by the system (Partial transaction). 
-- Fix Provided: Datafix has been promoted to remove the requested pending Placement validations.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To remove the pending Placement Validations (CDM-33316)

-- Delete 
select validation_start_dt, delete_sw, * 
	from tb_placement_validation
where placement_id = 1704326
	and placement_validation_id in (2072533, 2072532, 2072531, 2072530, 2072529)
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request # S20230212052858.',
	update_ts = now(),
	update_user_id = 'CDM-33316'
where placement_id = 1704326
	and placement_validation_id in (2072533, 2072532, 2072531, 2072530, 2072529)
	and delete_sw = 'N' ;

