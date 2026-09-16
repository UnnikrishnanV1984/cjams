-- CDM-31097 - Cannot add CPA home
/*
-- Issue Description: 
    User request to add CPA home on the closed Placement

-- Case ID: 3284230
-- Client ID: 3198053 (MORGAN BRIANA STALLINGS) - 80c60e85-d8aa-44d0-9485-7143eb29353d
-- Placement ID: 1645334 - 2023-04-05 To 2023-04-28 - 16411d46-2763-4dea-b3c6-3d3f9ef5f759
-- Private Organization: 5000668 (The Children's Choice Of Maryland, Inc.)
-- CPA Office: 5000718 (Childrens Choice Salisbury)
-- Program ID: 222 (Treatment Foster Care)                              	

-- Add CPA Home
-- Provider ID: 6006823	(Rebecca Stanley) - CPA Home
-- Entry date is 4/5/23 at 4:00pm. End date is 4/28/23 at 3:30pm.
   
-- Category/ Module: Placement (Case Management) 
-- Root cause: User Error (case worker did not updated the CPS Home Info prior to placement exit) 
-- Fix Provided: Datafix has been promoted to add the requested CPA Home entry.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, updatets, updateuserid 
	from placementcpahomes 
where placementid = '16411d46-2763-4dea-b3c6-3d3f9ef5f759'
	and activeflag = 1 ;
	
-- CIPPRCRS - Provider Issue: Provider Rejects Child Refused Service
insert into cjams.placementcpahomes
	(	placementcpahomeid, placementid, entrydt, entrytm, 
		exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
		createts, createuserid, updatets, updateuserid, activeflag, 
		altproviderid, altplacementid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '16411d46-2763-4dea-b3c6-3d3f9ef5f759', '2023-04-05 00:00:00', '2023-04-05 16:00:00', 
		'2023-04-28 00:00:00', '2023-04-28 15:30:00', 'CIPPRCRS', NULL,	'', 
		now(), 'CDM-31097', now(), 'CDM-31097', 1, 
		6006823, 1645334, NULL, NULL
	);
