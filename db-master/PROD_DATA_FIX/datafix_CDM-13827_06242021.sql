-- CDM-13827 - Modifying finding
/*
-- Issue Description: 
	User request to update the Finding as 'Ruled Out' and expunge the CPS-IR CW2354093 (Converted Indicated)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: For Converted Investigations there is no option to change the Finding.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Change the Overrride Finding to Ruled Out (old value was Indicated)	
select overridefindingtypekey, updatedby, updatedon 
	from investigationallegationmaltreators
where investigationallegationmaltreatorsid = 'd1d27b10-6ce4-44cc-aa6c-38e770a1a7a6' 
	and activeflag = 1 ;

update investigationallegationmaltreators
set overridefindingtypekey = 'RO' ,
	updatedby = 'CDM-13827', 
	updatedon = now()
where investigationallegationmaltreatorsid = 'd1d27b10-6ce4-44cc-aa6c-38e770a1a7a6' 
	and activeflag = 1 ;


-- CPS-IR - CW2354093 - e6254cd6-a539-495f-ae33-4ba70a8e548e - Converted Indicated
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2354093'::character varying,
		null::date
	) ;

