-- CIDM-5147 - Provider Payment is not showing in the Payments Tab
/*
-- Issue Description: 
   Provider Payments are not showing on the Adoption Case Payments Tab
   
-- Adoption Case ID: 221040016044
-- Client ID: 200908652	(Avalynn Stevens) - 030a0e20-85a5-450a-8b51-cc6efe211074

-- Adoption Case ID: 221040016043
-- Client ID: 200908677	(Coralynn Stevens) - bccd2a5a-0a44-4c8a-b6c1-439b33ad77df

-- Category/ Module: Adoption (Case Management) 
-- Root cause: Private Adoption cases, ths flow is currently NOT working in CJAMS.  
-- Fix Provided: Datafix has been provided to display the Adoption Payments on the Payment Tab.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Adoption Case ID: 221040016044
-- Client ID: 200908652	(Avalynn Stevens) - 030a0e20-85a5-450a-8b51-cc6efe211074
select personid, adoptioncaseid, actortypekey, updatedon, updatedby  
	from adoptioncaseactor 
where adoptioncaseactorid  = '724fcb2c-d359-4ed2-a048-980357faefdf'
	and activeflag = 1 ;

update adoptioncaseactor
set actortypekey = 'CHILD', -- 'PVTADPCHILD'
	updatedon = now(), 
	updatedby = 'CIDM-5147' 
where adoptioncaseactorid  = '724fcb2c-d359-4ed2-a048-980357faefdf'
	and activeflag = 1 ;

-- Adoption Case ID: 221040016043
-- Client ID: 200908677	(Coralynn Stevens) - bccd2a5a-0a44-4c8a-b6c1-439b33ad77df
select personid, adoptioncaseid, actortypekey, updatedon, updatedby  
	from adoptioncaseactor 
where adoptioncaseactorid  = 'bab51161-0bbb-4739-b13d-9decba9acc0b'
	and activeflag = 1 ;

update adoptioncaseactor
set actortypekey = 'CHILD', -- 'PVTADPCHILD'
	updatedon = now(), 
	updatedby = 'CIDM-5147' 
where adoptioncaseactorid  = 'bab51161-0bbb-4739-b13d-9decba9acc0b'
	and activeflag = 1 ;


-- Additional case fix
-- Adoption Case ID: 231040082847
-- Client ID: 201173381	(Dillan Issac Wilkins) - f5daa620-d6bd-4e79-9526-0aa4082765d0
select personid, adoptioncaseid, actortypekey, updatedon, updatedby  
	from adoptioncaseactor 
where adoptioncaseactorid  = 'a9b400c0-2975-4465-bb23-321e3ef71a6a'
	and activeflag = 1 ;

update adoptioncaseactor
set actortypekey = 'CHILD', -- 'PVTADPCHILD'
	updatedon = now(), 
	updatedby = 'CIDM-5147' 
where adoptioncaseactorid  = 'a9b400c0-2975-4465-bb23-321e3ef71a6a'
	and activeflag = 1 ;


