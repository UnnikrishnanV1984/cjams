/*
-- Issue Description: 
   User request to change the placement Exit Date 
   Verified in production, both child removal were ended on 06/09/2020 and both children are having an open provider placement with start date is 11/07/2018 and Provider ID: 5092585 (Adilah Kirton).

Need technical investigation as look like this is a migrated data from Chessie and the provider placement need to ended with 06/09/2020.

Client ID: 4298250 (MELCHIZEDEK MEREDITH)

-- Category/ Module: Placements  (Case Management) 
-- Root cause: TBD
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

/*  MELCHIZEDEK E MEREDITH */

update cjams.placement  
set enddatetime = '2020-06-09 00:00:00', 
	endtime = '00:00',
	updatedon = now(), 
	updatedby = 'CJAMS-68100'
where placementid = 'd73e0ca8-06ce-412f-ab2c-c556f115dcb5'
	and activeflag = 1 ;


update cjams.placementrevision  
set exitdate = '2020-06-09 00:00:00', 
	exittime = '00:00',
	updatedon = now(), 
	updatedby = 'CJAMS-68100'
where placementid = 'd73e0ca8-06ce-412f-ab2c-c556f115dcb5' 
	and exitdate is not null;

    ---------------

/*   NADIRA BASIR  */

update cjams.placement  
set enddatetime = '2020-06-09 00:00:00', 
	endtime = '00:00',
	updatedon = now(), 
	updatedby = 'CJAMS-68100'
where placementid =  'a6cb4771-0a6e-4c32-852d-ad7c59b8a9a8'
	and activeflag = 1 ;


update cjams.placementrevision  
set exitdate = '2020-06-09 00:00:00', 
	exittime = '00:00',
	updatedon = now(), 
	updatedby = 'CJAMS-68100'
where placementid =  'a6cb4771-0a6e-4c32-852d-ad7c59b8a9a8'
	and exitdate is not null;

-------------------   