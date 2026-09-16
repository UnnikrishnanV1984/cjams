-- CDM-13910 - Unable to save modification
/*
-- Issue Description: 
	User request to update the Finding as 'Ruled Out' and expunge the CPS-IR CW2601556 (Converted Indicated)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: For Converted Investigations there is no option to change the Finding.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Change the Overrride Finding to Ruled Out (old value was Indicated)	
select overridefindingtypekey, updatedby, updatedon 
	from investigationallegationmaltreators
where investigationallegationmaltreatorsid 
	in ( '7d3d3571-c53b-4a09-a5ef-fbe4e0af777d',
		 'e7100cba-71d5-46da-92ba-75868e7e7313',
		 '55e01620-3110-4419-9864-6d0cd268db9d',
		 'c5172e23-7637-4866-9b18-c30f46d1e938'
		)
	and activeflag = 1 ;

update investigationallegationmaltreators
set overridefindingtypekey = 'RO' ,
	updatedby = 'CDM-13910', 
	updatedon = now()
where investigationallegationmaltreatorsid 
	in ( '7d3d3571-c53b-4a09-a5ef-fbe4e0af777d',
		 'e7100cba-71d5-46da-92ba-75868e7e7313',
		 '55e01620-3110-4419-9864-6d0cd268db9d',
		 'c5172e23-7637-4866-9b18-c30f46d1e938'
		)
	and activeflag = 1 ;

-- CPS-IR - CW2601556 - 533fff6e-8a06-422b-8cd3-7a30cf6aa305 - Converted Indicated
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2601556'::character varying,
		null::date
	) ;
