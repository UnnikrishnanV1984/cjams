-- Datafix for CARES Rejection due Invalid Zip number (CHCR-CLIENT-SCHOOL-ZIP) 
-- To remove Special character from School Name
-- CIS CLIENT ID: 464042653

-- Before
select educationname, updatedby, updatedon
  from personeducation
where personeducationid = '7b6f053d-9a9e-41d9-8a98-90d5a6f243d5'
  and personid = '3d5038e5-6730-4cae-bde2-59bc30d6c4ad' 
  and activeflag = 1 ;

-- Update
update personeducation
	set educationname = 'St. Vincent''s Diagnostic On Campus School',
		updatedby = 'CARES_REJ1221',
		updatedon = now()
where personeducationid = '7b6f053d-9a9e-41d9-8a98-90d5a6f243d5'
  and personid = '3d5038e5-6730-4cae-bde2-59bc30d6c4ad' 
  and activeflag = 1 ;
    
-- After
select educationname, updatedby, updatedon
  from personeducation
where personeducationid = '7b6f053d-9a9e-41d9-8a98-90d5a6f243d5'
  and personid = '3d5038e5-6730-4cae-bde2-59bc30d6c4ad' 
  and activeflag = 1 ;

  