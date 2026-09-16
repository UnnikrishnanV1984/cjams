-- CRB Outbound failure - SSN length more than 9 digits 
-- Generic Datafix to update replace hyphen & spaces

-- Before
select personidentifierid, personidentifiervalue, updatedby, updatedon
	from personidentifier 
where activeflag = 1
	and personidentifiervalue is not null
	and personidentifiertypekey = 'SSN'
	and length(btrim(personidentifiervalue)) > 9
	and position('-' in personidentifiervalue)  > 0 
	and etl_userid is NULL ;

-- Update	
update 	personidentifier
	set personidentifiervalue = replace(personidentifiervalue, '-', ''),
		updatedon = now(),
		updatedby = 'CRBDATAFX'
where activeflag = 1
	and personidentifiervalue is not null
	and personidentifiertypekey = 'SSN'
	and length(btrim(personidentifiervalue)) > 9
	and position('-' in personidentifiervalue)  > 0 
	and etl_userid is NULL ;
	
-- After	
select personidentifierid, personidentifiervalue, updatedby, updatedon
	from personidentifier 
where activeflag = 1
	and personidentifiervalue is not null
	and personidentifiertypekey = 'SSN'
	and length(btrim(personidentifiervalue)) > 9
	and position('-' in personidentifiervalue)  > 0 
	and etl_userid is NULL ;
	
-- Before
select personidentifierid, personidentifiervalue, updatedby, updatedon
	from personidentifier 
where activeflag = 1
	and personidentifiervalue is not null
	and personidentifiertypekey = 'SSN'
	and length(btrim(personidentifiervalue)) > 9
	and position(' ' in personidentifiervalue)  > 0 
	and etl_userid is NULL ;

-- Update	
update 	personidentifier
	set personidentifiervalue = replace(personidentifiervalue, ' ', ''),
		updatedon = now(),
		updatedby = 'CRBDATAFX'
where activeflag = 1
	and personidentifiervalue is not null
	and personidentifiertypekey = 'SSN'
	and length(btrim(personidentifiervalue)) > 9
	and position(' ' in personidentifiervalue)  > 0 
	and etl_userid is NULL ;

-- After	
select personidentifierid, personidentifiervalue, updatedby, updatedon
	from personidentifier 
where activeflag = 1
	and personidentifiervalue is not null
	and personidentifiertypekey = 'SSN'
	and length(btrim(personidentifiervalue)) > 9
	and position(' ' in personidentifiervalue)  > 0 
	and etl_userid is NULL ;
	

select personidentifierid, personidentifiervalue, updatedby, updatedon
	from personidentifier 
where activeflag = 1
	and personidentifiervalue is not null
	and personidentifiertypekey = 'SSN'
	and length(btrim(personidentifiervalue)) > 9 
	and etl_userid is NULL ;