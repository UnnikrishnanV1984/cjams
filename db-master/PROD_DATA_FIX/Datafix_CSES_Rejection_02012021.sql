-- Datafix for CSES Rejection due to NOT NUMERIC Parent Work Phone Number 
-- CIS CLIENT ID: 492058984 (Child)
-- Parent CLIENT ID: 1005528 - ed45e8ce-1ea1-40f5-b423-2e512833afd3
 
-- Before
select personid, workphone, updatedby, updatedon
	from personemployment
where activeflag = 1
	and personemploymentid = '428f2afb-d1ec-4874-8310-783292e0e5f1'
	and activeflag = 1 ;

-- Update
-- old value [{"contactType":"","phoneNumber":null}]

update personemployment
	set workphone = NULL,
		updatedon = now(),
		updatedby = 'DFX02012021'
where activeflag = 1	
	and personemploymentid = '428f2afb-d1ec-4874-8310-783292e0e5f1'
	and activeflag = 1 ;

   
-- After
select personid, workphone, updatedby, updatedon
	from personemployment
where activeflag = 1
	and personemploymentid = '428f2afb-d1ec-4874-8310-783292e0e5f1'
	and activeflag = 1 ;

