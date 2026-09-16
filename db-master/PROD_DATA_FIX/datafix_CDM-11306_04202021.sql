-- CDM-11306 - Expungement
/*
-- Issue Description: 
	User request to expunge the following CPS IRs:
	CW2713704:This case was unsubstantiated in 2011 & should have been expunged in 2016, per COMAR.
	CW2842744:This case was opened in 2015 & should of been expunged in 2021, per COMAR.
	CW2117336:This case should be expungement, as it is passed the expungement date per COMAR. 
	Case was open in 1988 & it should of been expunged in 2014.
       
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- CPS-IR  CW2713704 - aeaccfc7-b169-488c-83bd-3b42e0bdf7c9
-- AM CLIENT ID: 1244957 - b7c19f1b-84f6-47d8-9a11-6ec2a82195e7
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2713704'::character varying,
		null::date
	) ;


-- CPS-IR  CW2842744 - bded5fcb-a4d9-4b36-8968-29b296d94af5
-- AM CLIENT ID: 3419025 - 33de1d74-4c41-4389-9e8d-f6c7bfad205c
-- AM CLIENT ID: 3419029 - 4923bc4c-08ee-4567-8226-bf5f3a9e4e0f
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2842744'::character varying,
		null::date
	) ;


-- CPS-IR CW2117336 - 25894223-ee2d-4cfa-abb5-85d436dd628e
-- Converted CPS (Legacy data for MD CHESSIE)
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2117336'::character varying,
		null::date
	) ;
