-- Datafix for CARES & CSES Rejection due to NOT NUMERIC Parent Work Phone Number 
-- CIS CLIENT ID: 454057689
-- Parent CLIENT ID: 4383263 - c463cbc2-fb5e-42fe-aa0b-1db69ea830a3
 
-- Before
select personid, workphone, updatedby, updatedon
	from personemployment
where activeflag = 1
	and personemploymentid = '12e08ddd-371e-47d1-95e3-71141cb23aae'
	and activeflag = 1 ;

-- Update
update personemployment
	set workphone = NULL,
		updatedby = 'DFX03052021',
		updatedon = now()
where activeflag = 1	
	and personemploymentid = '12e08ddd-371e-47d1-95e3-71141cb23aae'
	and activeflag = 1 ;

-- After
select personid, workphone, updatedby, updatedon
	from personemployment
where activeflag = 1
	and personemploymentid = '12e08ddd-371e-47d1-95e3-71141cb23aae'
	and activeflag = 1 ;

