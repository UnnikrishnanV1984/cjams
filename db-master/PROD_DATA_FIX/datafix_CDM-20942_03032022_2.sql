-- CDM-20942 - Request to restrict Intake and CPS
/*
-- Issue Description: 
	User Request to Request to restrict Intake I221010247611, I211010215699 & CPS 221020190877
	
-- Category/ Module: Intake Referral (Intake Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Intake Number: I221010247611 (INTAKE)

/*
Approved Access:
1. Denise Conway, SSA Executive Director - 876f8461-732d-40ef-8a45-e35e2f8d2fc9
2. Robin Stokes, BCDSS Case worker - a7bb4468-3dac-4b4c-baf6-14c26a4468a2
3. Lisa Naumann, BCDSS Supervisor - 558ca1e7-d0b1-47ef-9193-42ac458b68c5
4. Kimberly Allen, BCDSS Unit Manager - 6d5cd107-0abc-4a90-8508-632ee11513bb
5. Taavon Bazemore, BCDSS Program Manager - ce5b8c8a-64f7-4a9b-b4eb-f05a7dfe0934
6. LaShawn Bruce - 33c054c9-7d5c-4ad9-8292-df171da08c8d
*/

-- Before
select restricteditemsid, objecttypekey, objectid, accessuserid, updatedby, updatedon 
	from restricteditems
where objectid = 'I221010247611'
	and activeflag = 1 ;


INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'INTAKE', 'I221010247611', 
		'876f8461-732d-40ef-8a45-e35e2f8d2fc9', '', 
		false, false, false, 
		'CDM-20942', 'CDM-20942', now(), now(), 1
	);
	
INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'INTAKE', 'I221010247611', 
		'a7bb4468-3dac-4b4c-baf6-14c26a4468a2', '', 
		false, false, false, 
		'CDM-20942', 'CDM-20942', now(), now(), 1
	);

INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'INTAKE', 'I221010247611', 
		'558ca1e7-d0b1-47ef-9193-42ac458b68c5', '', 
		false, false, false, 
		'CDM-20942', 'CDM-20942', now(), now(), 1
	);

INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'INTAKE', 'I221010247611', 
		'6d5cd107-0abc-4a90-8508-632ee11513bb', '', 
		false, false, false, 
		'CDM-20942', 'CDM-20942', now(), now(), 1
	);

INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'INTAKE', 'I221010247611', 
		'ce5b8c8a-64f7-4a9b-b4eb-f05a7dfe0934', '', 
		false, false, false, 
		'CDM-20942', 'CDM-20942', now(), now(), 1
	);


INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'INTAKE', 'I221010247611', 
		'33c054c9-7d5c-4ad9-8292-df171da08c8d', '', 
		false, false, false, 
		'CDM-20942', 'CDM-20942', now(), now(), 1
	);

-- Before
select restricteditemsid, objecttypekey, objectid, accessuserid, updatedby, updatedon 
	from restricteditems
where objectid = 'I221010247611'
	and activeflag = 1 ;

	
-- CPS ID# 221020190877 - 467d5186-0832-45b5-83a8-aba7fb97c79c (SERVICE)
-- Before
select restricteditemsid, objecttypekey, objectid, accessuserid, updatedby, updatedon 
	from restricteditems
where objectid = '467d5186-0832-45b5-83a8-aba7fb97c79c'
	and activeflag = 1 ;


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
		'CDM-20942', 'CDM-20942', now(), now(), 1
	);

INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'SERVICE', '467d5186-0832-45b5-83a8-aba7fb97c79c', 
		'a7bb4468-3dac-4b4c-baf6-14c26a4468a2', '', 
		false, false, false, 
		'CDM-20942', 'CDM-20942', now(), now(), 1
	);


INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'SERVICE', '467d5186-0832-45b5-83a8-aba7fb97c79c', 
		'558ca1e7-d0b1-47ef-9193-42ac458b68c5', '', 
		false, false, false, 
		'CDM-20942', 'CDM-20942', now(), now(), 1
	);


INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'SERVICE', '467d5186-0832-45b5-83a8-aba7fb97c79c', 
		'6d5cd107-0abc-4a90-8508-632ee11513bb', '', 
		false, false, false, 
		'CDM-20942', 'CDM-20942', now(), now(), 1
	);


INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'SERVICE', '467d5186-0832-45b5-83a8-aba7fb97c79c', 
		'ce5b8c8a-64f7-4a9b-b4eb-f05a7dfe0934', '', 
		false, false, false, 
		'CDM-20942', 'CDM-20942', now(), now(), 1
	);


INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'SERVICE', '467d5186-0832-45b5-83a8-aba7fb97c79c', 
		'33c054c9-7d5c-4ad9-8292-df171da08c8d', '', 
		false, false, false, 
		'CDM-20942', 'CDM-20942', now(), now(), 1
	);

-- After
select restricteditemsid, objecttypekey, objectid, accessuserid, updatedby, updatedon 
	from restricteditems
where objectid = '467d5186-0832-45b5-83a8-aba7fb97c79c'
	and activeflag = 1 ;


-- Intake Number: I211010215699 (INTAKE)
/*
76fbc521-91ed-4cf6-a066-c29f2ff4b42f	andrea.dixon@maryland.gov
d3ed46a3-e946-48f6-83b5-75972c2e3047	jenna.smith@maryland.gov
*/
-- Before
select restricteditemsid, objecttypekey, objectid, accessuserid, updatedby, updatedon 
	from restricteditems
where objectid = 'I211010215699'
	and activeflag = 1 ;

INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'INTAKE', 'I211010215699', 
		'76fbc521-91ed-4cf6-a066-c29f2ff4b42f', '', 
		false, false, false, 
		'CDM-20942', 'CDM-20942', now(), now(), 1
	);

INSERT INTO cjams.restricteditems
	(	restricteditemsid, objecttypekey, objectid, 
		accessuserid, description, 
		isadd, isedit, isdelete, 
		insertedby, updatedby, insertedon, updatedon, activeflag
	)
values
	(	gen_random_uuid(), 'INTAKE', 'I211010215699', 
		'd3ed46a3-e946-48f6-83b5-75972c2e3047', '', 
		false, false, false, 
		'CDM-20942', 'CDM-20942', now(), now(), 1
	);

-- After
select restricteditemsid, objecttypekey, objectid, accessuserid, updatedby, updatedon 
	from restricteditems
where objectid = 'I211010215699'
	and activeflag = 1 ;
