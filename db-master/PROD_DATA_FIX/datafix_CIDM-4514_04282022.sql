-- CIDM-4514 - Request to restrict CPS Case
/*
-- Issue Description: 
	User Request to Request to restrict CPS: 221020190877
	Grant access to Jenifer DuBosq and Denise Conway. 

-- Category/ Module: Intake Referral (Intake Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS: 221020190877
/*
Approved Access:
-- 1. Denise Conway, SSA Executive Director - 876f8461-732d-40ef-8a45-e35e2f8d2fc9
-- 2. Jenifer Dubosq, Supervisor, 82f5d82d-7a9c-4dd9-9d48-eb9683acca2d
*/
	
-- CPS ID# 221020190877 - 467d5186-0832-45b5-83a8-aba7fb97c79c (SERVICE)
-- Before
select restricteditemsid, objecttypekey, objectid, accessuserid, updatedby, updatedon 
	from restricteditems
where objectid = '467d5186-0832-45b5-83a8-aba7fb97c79c'
	and activeflag = 1 ;

-- 1. Denise Conway, SSA Executive Director - 876f8461-732d-40ef-8a45-e35e2f8d2fc9
INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'SERVICE', '467d5186-0832-45b5-83a8-aba7fb97c79c', 
		'876f8461-732d-40ef-8a45-e35e2f8d2fc9', '', 
		false, false, false, 
		'CIDM-4514', 'CIDM-4514', now(), now(), 1
	);

-- 2. Jenifer Dubosq, Supervisor, 82f5d82d-7a9c-4dd9-9d48-eb9683acca2d
INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'SERVICE', '467d5186-0832-45b5-83a8-aba7fb97c79c', 
		'82f5d82d-7a9c-4dd9-9d48-eb9683acca2d', '', 
		false, false, false, 
		'CIDM-4514', 'CIDM-4514', now(), now(), 1
	);
