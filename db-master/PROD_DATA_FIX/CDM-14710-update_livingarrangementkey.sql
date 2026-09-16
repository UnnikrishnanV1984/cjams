-- CDM-14710
-- updating the living arrangement type key from 'Father's Home' to 'FH'
update livingarrangement
set livingarrangementtypekey = 'FH', 
	updatedon = now(),
	updatedby = 'CDM-14710'
where livingarrangementtypekey = 'Father''s Home';