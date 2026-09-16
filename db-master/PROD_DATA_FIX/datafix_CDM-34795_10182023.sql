-- CDM-34795 - Foster Care Milestone
/*
-- Issue Description: 
	 User request to Change the Permanency Plan Start date for 2 clients 

-- Case ID: 3255906 - 05ef88f7-5840-4950-8687-8b6bb1a3010e - ashley.kerr@maryland.gov

-- New Start Date: 2022-07-08 04:00:00 

-- Client ID: 200298747	(Lilly Schultz) - 35dd547c-01d4-44cb-9c18-42d69f2b6d9c
-- Permanency Plan
-- 82dd76b8-12c8-4531-bfb2-6055a2f3ef4f	2022-08-22 04:00:00	2023-01-05 00:00:00	Reunification	ADOPTNR

-- Client ID: 200299633	(Luna Schultz) - d395cfea-8346-490a-929f-330d723dd396
-- Permanency Plan
-- fa2649b4-b0ef-402a-a02b-631fdcab4ffe	2022-08-18 04:00:00	2023-01-05 00:00:00	Reunification	ADOPTNR

-- Category/ Module: Permanency Plan(Case Management)
-- Root cause: User Error.
-- Fix Provided: Datafix has been promoted to update Start date as 07/08/2022 for the requested Permanency Plans.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To change the Permanency Plan Start date (CDM-34795)
select establisheddate, enddate, primarypermanencytype, concurrentpermanencytype, updatedby, updatedon
	from cjams.permanencyplan
where permanencyplanid in ('82dd76b8-12c8-4531-bfb2-6055a2f3ef4f', 'fa2649b4-b0ef-402a-a02b-631fdcab4ffe' )
	and activeflag = 1 ;

update cjams.permanencyplan 
set establisheddate = '2022-07-08 04:00:00',
	updatedby = 'CDM-34795',
	updatedon = now()
where permanencyplanid in ('82dd76b8-12c8-4531-bfb2-6055a2f3ef4f', 'fa2649b4-b0ef-402a-a02b-631fdcab4ffe' )
	and activeflag = 1 ;

select establisheddate, enddate, primarypermanencytype, concurrentpermanencytype, updatedby, updatedon
	from cjams.permanencyplanhistory
where permanencyplanid in ('82dd76b8-12c8-4531-bfb2-6055a2f3ef4f', 'fa2649b4-b0ef-402a-a02b-631fdcab4ffe' ) 
order by permanencyplanid, insertedon ;

update cjams.permanencyplanhistory 
set establisheddate = '2022-07-08 04:00:00',
	updatedby = 'CDM-34795',
	updatedon = now()
where permanencyplanid in ('82dd76b8-12c8-4531-bfb2-6055a2f3ef4f', 'fa2649b4-b0ef-402a-a02b-631fdcab4ffe' ) ;
