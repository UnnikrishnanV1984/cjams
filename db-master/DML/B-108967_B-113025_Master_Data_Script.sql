-- B-108967 - Suspension of Guardianship Subsidy
-- B-113025 - Adoption Suspension Enhancement
/*
Reason: Child entered out of home placement (system generated)
*/

-- GAP Suspension 
select sequencenumber, suspensionreasontypekey, typedescription, updatedby, updatedon 
	from suspensionreasontype 
where activeflag = 1
	and suspensionreasontypekey = 'DC' ;

update suspensionreasontype
set typedescription = 'Death of Child (Case to be closed immediately)',
	updatedby = 'B-108967',
	updatedon = now()
where activeflag = 1
	and suspensionreasontypekey = 'DC' ;


select sequencenumber, suspensionreasontypekey, typedescription, updatedby, updatedon
	from suspensionreasontype 
where activeflag = 1
	and suspensionreasontypekey  = 'COHP' ;

update suspensionreasontype
set typedescription = 'Child Entered out of Home Placement (system generated)',
	updatedby = 'B-108967',
	updatedon = now()
where activeflag = 1
	and suspensionreasontypekey  = 'COHP' ;


-- Adoption Suspension 
select ref_key, value_text, description, updatedby, updatedon 
	from referencevalues 
where referencetypeid = 107 
	and ref_key = 'COHP'
	and activeflag = 1 ;

update referencevalues 
set value_text = 'Child Entered out of home placement (system generated)',
	description = 'Child Entered out of home placement (system generated)',
	updatedby = 'B-113025',
	updatedon = now()
where referencetypeid = 107 
	and ref_key = 'COHP'
	and activeflag = 1 ;

