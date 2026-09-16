-- Datafix for CARES & CSES Rejection due to NOT NUMERIC Parent Work Phone Number 
-- To remove Special character from School Name
-- CIS CLIENT ID: 470057330
-- Parent CLIENT ID: 2120777 - 67aa280b-6f9b-46b1-9090-5fec7071f387
 
-- Before
select personid, workphone, updatedby, updatedon
	from personemployment
where activeflag = 1
	and personemploymentid = '91f7d79b-29b1-4ba9-9413-0f0b3b4acb4f'
	and activeflag = 1 ;

-- Update
update personemployment
	set workphone = '3017221007'
where activeflag = 1	
	and personemploymentid = '91f7d79b-29b1-4ba9-9413-0f0b3b4acb4f'
	and activeflag = 1 ;

   
-- After
select personid, workphone, updatedby, updatedon
	from personemployment
where activeflag = 1
	and personemploymentid = '91f7d79b-29b1-4ba9-9413-0f0b3b4acb4f'
	and activeflag = 1 ;

