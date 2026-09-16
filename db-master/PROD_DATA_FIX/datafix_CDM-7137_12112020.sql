-- CDM-7137 - Duplicate Payment
/*
-- Issue Description: 
	Datafix request to remove Exid Date of Placement for user to Void the placement
	Case ID: 3150206 - Client ID: 1421995
	Placement ID: 340850 (06/16/2020 to 09/23/2020) - f3f2cf0a-d8c3-4148-9cc7-8af16e6853f8
	Provider ID: 5061783 (Pressley Ridge Caroline St)
	Program ID: 11547 (Teen Mother Pgm - formerly Casey)
	
	  
-- Category/ Module: Placement (Case Management) 
-- Root cause: Currently users cannot edit the closed placements in CJAMS
-- Pull request# TBD
		We have user Story in the backlog; which will avoid this kind of datafixes in the future
		B-79801 - Users were not able to void and/or edit the placements in system and from history page
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Before
select alternateid, altproviderid, startdatetime, starttime, enddatetime, endtime, updatedby, updatedon
	from placement
where placementid = 'f3f2cf0a-d8c3-4148-9cc7-8af16e6853f8' 
	and activeflag = 1;

-- Update	
update placement  
	set enddatetime = null, 
		endtime = null, 
		updatedon = now(), 
		updatedby = 'CDM-7137'
where placementid = 'f3f2cf0a-d8c3-4148-9cc7-8af16e6853f8' 
	and activeflag = 1;

-- After
select alternateid, altproviderid, startdatetime, starttime, enddatetime, endtime, updatedby, updatedon
	from placement
where placementid = 'f3f2cf0a-d8c3-4148-9cc7-8af16e6853f8' 
	and activeflag = 1;