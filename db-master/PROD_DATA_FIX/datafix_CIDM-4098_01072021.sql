-- CIDM-4098 - Overlapping Removals Baltimore City (Stage 3 - 11/03/2021)
/*
-- Issue Description: 
   Datafix to delete the duplicate Baltimore City removals
    
-- Category/ Module: Child Removal (Case Management) 
-- Root cause: Data Issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 1)
-- Client ID: 4327395	ZALIA	M	LEE-ANDERSON	00f62c71-32bd-45be-a742-e7338b26009f
-- Removals 
-- 252948	2021-10-04 00:00:00		05418c96-13c4-4031-bc69-d085098a3f33
-- 252931	2021-10-04 00:00:00		3b5efc93-cc72-47b6-914a-0fea0be936ac - Delete 

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252931
	and rm.personid = '00f62c71-32bd-45be-a742-e7338b26009f'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252931
	and rm.personid = '00f62c71-32bd-45be-a742-e7338b26009f'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '3b5efc93-cc72-47b6-914a-0fea0be936ac'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '3b5efc93-cc72-47b6-914a-0fea0be936ac'
	and ro.activeflag = 1 ;	
	
-- No Placements

-- OOH
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '45986e76-d8f1-4ee2-85c7-97b997300dd0' 
	and personid = '00f62c71-32bd-45be-a742-e7338b26009f'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2021-10-04 00:00:00', 
	updatedby = 'CIDM-4098',
	updatedon = now() 		
where personprogramid = '45986e76-d8f1-4ee2-85c7-97b997300dd0' 
	and personid = '00f62c71-32bd-45be-a742-e7338b26009f'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252931
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 252931
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252931
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252931
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;	
	


-- 2)
-- Client ID: 3671575	OMAR		JOHNSON	043ca0be-c152-4deb-bd1f-0c2c9b05db75
-- Removals 
-- 252915	2021-09-14 00:00:00	2021-09-16 16:00:00	013f65ca-ffb4-4dfe-90c0-fe289cd74295
-- 252743	2021-09-14 00:00:00						2a81d610-a34b-42f0-b572-4da711811a14 -- Delete

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252743
	and rm.personid = '043ca0be-c152-4deb-bd1f-0c2c9b05db75'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252743
	and rm.personid = '043ca0be-c152-4deb-bd1f-0c2c9b05db75'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '2a81d610-a34b-42f0-b572-4da711811a14'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '2a81d610-a34b-42f0-b572-4da711811a14'
	and ro.activeflag = 1 ;	
	
-- No Placements

-- No changes OOH
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252743
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 252743
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252743
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252743
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;	
	
-- 3)
-- Client ID: 200497862	DIAMONTE	R.	WILSON	11237cd3-e1cb-47f4-b770-16b220820c4f
-- Removals 
-- 252853	2021-09-29 00:00:00		6be303bf-78cc-4ac6-92dc-761bdaca8421
-- 252841	2021-09-29 00:00:00		87e564e7-e91d-492f-8c8d-b7811ebcc026 - Delete 

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252841
	and rm.personid = '11237cd3-e1cb-47f4-b770-16b220820c4f'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252841
	and rm.personid = '11237cd3-e1cb-47f4-b770-16b220820c4f'
	and rm.activeflag = 1 ;
	
-- No Routing
	
-- No Placements

-- OOH - No changes
	
-- No IV-E 

-- 4) 
-- Client ID: 4266817	IYONA	K	ROSE	26f74bb1-f3be-41d8-a2fe-cc758205253f
-- Removals 
-- 252902	2021-10-06 00:00:00		a9e313da-8672-48f4-a809-d2ed4a394eb1
-- 252876	2021-10-06 00:00:00		912c15ca-5d8d-4157-9124-159324a31d72 - Delete 

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252876
	and rm.personid = '26f74bb1-f3be-41d8-a2fe-cc758205253f'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252876
	and rm.personid = '26f74bb1-f3be-41d8-a2fe-cc758205253f'
	and rm.activeflag = 1 ;
	
-- No Routing
	
-- No Placements

-- OOH - No changes
	
-- No IV-E 

-- 5)
-- Client ID: 200148775	TRAVIS		CARTER	29152dee-fb01-4dc7-811a-52766799ac99
-- Removals 
-- 251154	2020-09-08 00:00:00	2020-10-09 16:37:46	e28b9ad0-74c3-4065-9520-286d36811a8a -- Delete 
-- 251119	2020-09-08 00:00:00	2020-10-09 11:57:00	87283658-90b8-4f41-80b3-c24b71ac159b

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251154
	and rm.personid = '29152dee-fb01-4dc7-811a-52766799ac99'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 251154
	and rm.personid = '29152dee-fb01-4dc7-811a-52766799ac99'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '3b5efc93-cc72-47b6-914a-0fea0be936ac'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '3b5efc93-cc72-47b6-914a-0fea0be936ac'
	and ro.activeflag = 1 ;	
	
-- No Placements

-- OOH
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'ae431a98-8ec1-4e4d-aa14-bae983d0b672' 
	and personid = '29152dee-fb01-4dc7-811a-52766799ac99'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CIDM-4098',
	updatedon = now() 		
where personprogramid = 'ae431a98-8ec1-4e4d-aa14-bae983d0b672' 
	and personid = '29152dee-fb01-4dc7-811a-52766799ac99'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 251154
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 251154
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 251154
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 251154
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;	

-- 6)
-- Client ID: 3626924	ADRIEL	R	RIVERS	2b98fc6b-5c5c-41bd-8a7f-1350d45768d8
-- Removals 
-- 251559	2020-09-02 00:00:00	2020-12-18 11:54:45	2f6bb262-4bdc-4855-98ac-f265e4c29dd1 - Delete 
-- 250888	2020-09-02 00:00:00	2020-12-18 17:17:35	6acd8ea3-dcbc-4710-9db8-c8134877929a

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251559
	and rm.personid = '2b98fc6b-5c5c-41bd-8a7f-1350d45768d8'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 251559
	and rm.personid = '2b98fc6b-5c5c-41bd-8a7f-1350d45768d8'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '2f6bb262-4bdc-4855-98ac-f265e4c29dd1'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '2f6bb262-4bdc-4855-98ac-f265e4c29dd1'
	and ro.activeflag = 1 ;	
	
-- No Placements

-- OOH - No changes
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 251559
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 251559
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 251559
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 251559
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;	

-- 7)
-- Client ID: 200816272	Skylar		Gaithers	2d1ccafd-9ba4-47d4-88ab-7112198abcd1
-- Removals 
-- 252947	2021-10-04 00:00:00		c155f4cf-83e0-4aab-9ced-77d1a0949b58
-- 252934	2021-10-04 00:00:00		586565a8-499b-4cdc-8634-95665eebe892 - Delete	

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252934
	and rm.personid = '2d1ccafd-9ba4-47d4-88ab-7112198abcd1'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252934
	and rm.personid = '2d1ccafd-9ba4-47d4-88ab-7112198abcd1'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '586565a8-499b-4cdc-8634-95665eebe892'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '586565a8-499b-4cdc-8634-95665eebe892'
	and ro.activeflag = 1 ;	
	
-- No Placements

-- OOH - No changes
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252934
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 252934
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252934
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252934
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;


-- 8)
-- Client ID: 4483654	JAYDA		GREEN	2f301725-7ca8-4bc8-8212-4c5fc83682c4
-- Removals 
-- 252916	2021-09-14 00:00:00	2021-09-16 16:00:00	283156ba-cb9d-4d91-917d-0d9db189918f
-- 252744	2021-09-14 00:00:00						96184279-6097-4bc6-9742-af4eb6b809f0 - Delete 

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252744
	and rm.personid = '2f301725-7ca8-4bc8-8212-4c5fc83682c4'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252744
	and rm.personid = '2f301725-7ca8-4bc8-8212-4c5fc83682c4'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '96184279-6097-4bc6-9742-af4eb6b809f0'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '96184279-6097-4bc6-9742-af4eb6b809f0'
	and ro.activeflag = 1 ;	
	
-- No Placements

-- OOH - No changes
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252744
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 252744
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252744
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252744
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;


-- 9)
-- Client ID: 3357897	LYDELL	KAREEM	CRAIG	3e579292-b15d-431b-9037-7a34d330cf3a
-- Removals 
-- 252285	2021-05-28 00:00:00	2021-06-04 00:00:00	8aec78d9-d241-43dc-80a9-354170628c9f
-- 252234	2021-05-28 00:00:00	2021-06-04 15:22:00	1455df02-1587-43e4-a225-0e56c637818a - Delete 


-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252234
	and rm.personid = '3e579292-b15d-431b-9037-7a34d330cf3a'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252234
	and rm.personid = '3e579292-b15d-431b-9037-7a34d330cf3a'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '1455df02-1587-43e4-a225-0e56c637818a'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '1455df02-1587-43e4-a225-0e56c637818a'
	and ro.activeflag = 1 ;	
	
-- No Placements

-- OOH
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '737d420a-e0f4-4c67-8a4a-59bd59e9b656' 
	and personid = '3e579292-b15d-431b-9037-7a34d330cf3a'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CIDM-4098',
	updatedon = now() 		
where personprogramid = '737d420a-e0f4-4c67-8a4a-59bd59e9b656' 
	and personid = '3e579292-b15d-431b-9037-7a34d330cf3a'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252234
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 252234
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252234
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252234
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;	


-- 10)
-- Client ID: 3545554	KASHA	N	WILLIAMS-LAWSON	46c32cbe-19bf-401b-bbf5-5e40497a48f4
-- Removals 
-- 252857	2021-09-30 00:00:00		1b9599da-a363-4689-9fc0-5f8d3aeb6c58
-- 252848	2021-09-30 00:00:00		fdbde50f-5d93-4818-85f7-c7bb21e99993 - Delete 

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252848
	and rm.personid = '46c32cbe-19bf-401b-bbf5-5e40497a48f4'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252848
	and rm.personid = '46c32cbe-19bf-401b-bbf5-5e40497a48f4'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'fdbde50f-5d93-4818-85f7-c7bb21e99993'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'fdbde50f-5d93-4818-85f7-c7bb21e99993'
	and ro.activeflag = 1 ;	
	
-- No Placements

-- OOH - No Changes
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252848
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 252848
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252848
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252848
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;


-- 11)
-- Client ID: 200804562	Miyo'Ko		Mack	4cc81bd8-20db-40fe-bfe6-7c697d3a209b
-- Removals 
-- 252833	2021-09-16 00:00:00		2e84246b-aebd-4e6e-aa64-ab38f69b30c9
-- 252804	2021-09-16 00:00:00		4fb309fd-0c78-4933-bafd-c59b660d898d - Delete 

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252804
	and rm.personid = '4cc81bd8-20db-40fe-bfe6-7c697d3a209b'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252804
	and rm.personid = '4cc81bd8-20db-40fe-bfe6-7c697d3a209b'
	and rm.activeflag = 1 ;
	
-- No Routing
	
-- No Placements

-- OOH - No changes
	
-- No IV-E 


-- 12)
-- Client ID: 200802359	Janee		Woodhouse	4e4a7317-8c91-41f7-9469-26ee839185ec
-- Removals 
-- 252878	2021-09-21 00:00:00	2021-10-04 19:00:00	9a7fff19-06db-4517-b726-89b7121a4bc1
-- 252771	2021-09-21 00:00:00		38823818-6f47-4ad9-a420-c805b564d74d - Delete 

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252771
	and rm.personid = '4e4a7317-8c91-41f7-9469-26ee839185ec'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252771
	and rm.personid = '4e4a7317-8c91-41f7-9469-26ee839185ec'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '38823818-6f47-4ad9-a420-c805b564d74d'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '38823818-6f47-4ad9-a420-c805b564d74d'
	and ro.activeflag = 1 ;	
	
-- No Placements

-- OOH
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid in ( '0e4d7f86-54d1-4362-bef0-7f2431fbd54b', '0235b707-f46d-4b65-95f6-b2da453ca176' )
	and personid = '4e4a7317-8c91-41f7-9469-26ee839185ec'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CIDM-4098',
	updatedon = now() 		
where personprogramid in ( '0e4d7f86-54d1-4362-bef0-7f2431fbd54b', '0235b707-f46d-4b65-95f6-b2da453ca176' )
	and personid = '4e4a7317-8c91-41f7-9469-26ee839185ec'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252771
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 252771
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252771
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252771
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;


-- 13)
-- Client ID: 4098886	ANAI		SAUNDERS	56de7624-3a7d-46d1-b6ba-889cecda58e1
-- Removals 
-- 251562	2021-01-02 00:00:00	2021-02-04 17:00:20	05fe1653-1685-4440-8730-7933642eab84 - Delete 
-- 251395	2021-01-02 00:00:00	2021-02-04 17:00:00	d7f1873a-0572-438e-a787-3c3e048bc24b

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251562
	and rm.personid = '56de7624-3a7d-46d1-b6ba-889cecda58e1'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 251562
	and rm.personid = '56de7624-3a7d-46d1-b6ba-889cecda58e1'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '05fe1653-1685-4440-8730-7933642eab84'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '05fe1653-1685-4440-8730-7933642eab84'
	and ro.activeflag = 1 ;	
	
-- No Placements

-- OOH
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '32746562-0d6d-4964-8e68-1f040f7fca6f'
	and personid = '56de7624-3a7d-46d1-b6ba-889cecda58e1'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CIDM-4098',
	updatedon = now() 		
where personprogramid = '32746562-0d6d-4964-8e68-1f040f7fca6f'
	and personid = '56de7624-3a7d-46d1-b6ba-889cecda58e1'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 251562
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 251562
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 251562
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 251562
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;	
	
	
-- 14)
-- Client ID: 3239103	LATASIA		MOSLEY	5996570f-8140-4c87-af3b-4fa62e999a80 
-- Removals 
-- 252930	2011-06-24 00:00:00		adc4beac-edb2-46a4-8363-4f0424ebf0c1 - Delete 
-- 145751	2011-06-24 00:00:00	2012-01-09 00:00:00	6dd2712c-9a8e-4ee1-a282-77852ef13cdd

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252930
	and rm.personid = '5996570f-8140-4c87-af3b-4fa62e999a80'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252930
	and rm.personid = '5996570f-8140-4c87-af3b-4fa62e999a80'
	and rm.activeflag = 1 ;
	
-- No Routing
	
-- No Placements

-- OOH - No changes
	
-- No IV-E 
	
-- 15)
-- Client ID: 3979845	DA'KARI	NAIZER	KERINS	73ae696b-c094-45b1-980d-ec5318bbb6c0
-- Removals 
-- 250459	2020-06-10 00:00:00	2021-02-19 19:00:00	2386501a-e8b2-4365-b7a8-40dbb6c86d41 - Delete
-- 200009	2020-06-10 00:00:00	2021-02-19 16:30:00	beb890b6-1165-4b13-800b-aaab711f3939

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250459
	and rm.personid = '73ae696b-c094-45b1-980d-ec5318bbb6c0'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 250459
	and rm.personid = '73ae696b-c094-45b1-980d-ec5318bbb6c0'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '2386501a-e8b2-4365-b7a8-40dbb6c86d41'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '2386501a-e8b2-4365-b7a8-40dbb6c86d41'
	and ro.activeflag = 1 ;	
	
-- No Placements

-- OOH - No Changes
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 250459
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 250459
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 250459
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 250459
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;	
	
	
-- 16)
-- Client ID: 4405756	DARIN		JOHNSON	8016c862-deca-4a39-86bd-0107c362296f
-- Removals 
-- 252624	2021-08-25 00:00:00		bd9454d1-c695-4c31-b2a0-8e08d30591b1
-- 252623	2021-08-25 00:00:00		4236ac65-d189-4fc1-8578-3b68bd776fdd - Delete 

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252623
	and rm.personid = '8016c862-deca-4a39-86bd-0107c362296f'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252623
	and rm.personid = '8016c862-deca-4a39-86bd-0107c362296f'
	and rm.activeflag = 1 ;
	
-- No Routing
	
-- No Placements

-- OOH - No changes
	
-- No IV-E 

-- 17)
-- Client ID: 200802352	Jai		Woodhouse	80ff336d-3d7a-4440-ba5c-0e4e158931fd
-- Removals 
-- 252871	2021-09-21 00:00:00	2021-10-04 19:00:00	c41bfb76-da14-4a38-ae45-fbda75cedef4
-- 252772	2021-09-21 00:00:00		4adf32d3-570b-4425-9bdd-11ff61214ccb - Delete

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252772
	and rm.personid = '80ff336d-3d7a-4440-ba5c-0e4e158931fd'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252772
	and rm.personid = '80ff336d-3d7a-4440-ba5c-0e4e158931fd'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '4adf32d3-570b-4425-9bdd-11ff61214ccb'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '4adf32d3-570b-4425-9bdd-11ff61214ccb'
	and ro.activeflag = 1 ;	
	
-- No Placements

-- OOH
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '740d2a48-dc1d-4033-9eb9-73c5671f4919'
	and personid = '80ff336d-3d7a-4440-ba5c-0e4e158931fd'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CIDM-4098',
	updatedon = now() 		
where personprogramid = '740d2a48-dc1d-4033-9eb9-73c5671f4919'
	and personid = '80ff336d-3d7a-4440-ba5c-0e4e158931fd'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252772
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 252772
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252772
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252772
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;	
	
-- 18)
-- Client ID: 4362429	BRENDAN		ARMBRUSTER	8bcf54e9-74d6-4bf5-9a37-9414ee6cb854
-- Removals 
-- 252994	2021-10-22 00:00:00		ed3aec40-4477-450b-90d1-25e9cfd300c1
-- 252969	2021-10-22 00:00:00		f8cfb011-7b5e-4870-9736-fe48f563bb24 - Delete 

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252969
	and rm.personid = '8bcf54e9-74d6-4bf5-9a37-9414ee6cb854'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252969
	and rm.personid = '8bcf54e9-74d6-4bf5-9a37-9414ee6cb854'
	and rm.activeflag = 1 ;
	
-- No Routing
	
-- No Placements

-- OOH - No changes
	
-- No IV-E 


-- 19)
-- Client ID: 3469931	LA'KALA	C	MCFADDEN	8f318d35-bb3a-4e64-af30-1dd808742735
-- Removals 
-- 252872	2021-09-02 00:00:00		1ebfc905-54e5-47bd-a1ef-1bae5e163029
-- 252733	2021-09-02 00:00:00		c1589977-8019-4fc5-831f-6a9607ff7830 - Delete 

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252733
	and rm.personid = '8f318d35-bb3a-4e64-af30-1dd808742735'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252733
	and rm.personid = '8f318d35-bb3a-4e64-af30-1dd808742735'
	and rm.activeflag = 1 ;

-- No Routing
	
-- No Placements

-- OOH - No changes
	
-- No IV-E 



-- 20)
-- Client ID: 200648664	Lucy		Rideau	95e3448b-d5a0-424c-8dca-9acc1fdcc088
-- Removals 
-- 251928	2021-04-01 00:00:00	2021-04-13 17:23:51	899d6143-a4dc-42c6-8d88-812eaebfd6d9 - Delete
-- 251864	2021-04-01 00:00:00	2021-04-13 15:00:00	5ebaf7a3-580e-4292-8357-7f3d35a48d49

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251928
	and rm.personid = '95e3448b-d5a0-424c-8dca-9acc1fdcc088'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 251928
	and rm.personid = '95e3448b-d5a0-424c-8dca-9acc1fdcc088'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '899d6143-a4dc-42c6-8d88-812eaebfd6d9'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '899d6143-a4dc-42c6-8d88-812eaebfd6d9'
	and ro.activeflag = 1 ;	
	
-- No Placements

-- OOH
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'c02be002-a375-43bc-b301-a3ad18548385'
	and personid = '95e3448b-d5a0-424c-8dca-9acc1fdcc088'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CIDM-4098',
	updatedon = now() 		
where personprogramid = 'c02be002-a375-43bc-b301-a3ad18548385'
	and personid = '95e3448b-d5a0-424c-8dca-9acc1fdcc088'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 251928
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 251928
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 251928
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 251928
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;	
	
-- 21)
-- Client ID: 3675469	REGINALD	LEON	JOHNSON	a74fd520-6d33-4888-b2c2-858353f7ed28
-- Removals 
-- 252913	2021-09-14 00:00:00	2021-09-16 16:00:00	a45c146c-5432-4e82-959f-2f0ed91e99d6
-- 252745	2021-09-14 00:00:00		a5007c80-2b8e-48b3-a536-70d92e49bd77 - Delete

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252745
	and rm.personid = 'a74fd520-6d33-4888-b2c2-858353f7ed28'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252745
	and rm.personid = 'a74fd520-6d33-4888-b2c2-858353f7ed28'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'a5007c80-2b8e-48b3-a536-70d92e49bd77'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'a5007c80-2b8e-48b3-a536-70d92e49bd77'
	and ro.activeflag = 1 ;	
	
-- No Placements

-- OOH - No Changes
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252745
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 252745
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252745
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252745
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

-- 22)
-- Client ID: 3433291	FAITH	DOMINIQUE	JOHNSON	bef611e8-bf82-4719-af4b-1dd112c0d48d
-- Removals 
-- 252813	2021-09-17 00:00:00		126e58a4-3b2e-47bf-b536-dc84fe0d1103
-- 252749	2021-09-17 00:00:00		a61d3a05-7a4a-4ba3-bdf5-64a7e7eb6dfd - Delete

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252749
	and rm.personid = 'bef611e8-bf82-4719-af4b-1dd112c0d48d'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252749
	and rm.personid = 'bef611e8-bf82-4719-af4b-1dd112c0d48d'
	and rm.activeflag = 1 ;

-- No Routing
	
-- No Placements

-- OOH - No changes
	
-- No IV-E 

-- 23)
-- Client ID: 3758300	MATTHEW		RIVERS	c369c979-ad86-4c35-8668-14a7f92e9726
-- Removals 
-- 251561	2020-09-02 00:00:00	2020-12-18 11:55:21	8c4577ac-1426-46da-ba92-c6ecbe056231 - Delete 
-- 250904	2020-09-02 00:00:00	2020-12-18 17:18:41	e28a8fff-cb21-4091-8573-0cf219afe874

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251561
	and rm.personid = 'c369c979-ad86-4c35-8668-14a7f92e9726'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 251561
	and rm.personid = 'c369c979-ad86-4c35-8668-14a7f92e9726'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '8c4577ac-1426-46da-ba92-c6ecbe056231'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '8c4577ac-1426-46da-ba92-c6ecbe056231'
	and ro.activeflag = 1 ;	
	
-- No Placements

-- OOH - No Changes
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 251561
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 251561
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 251561
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 251561
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

-- 24)
-- Client ID: 3332838	DEQWAN		JACKSON	cbcc18a1-0457-4dae-b983-ae03ed36ad6b
-- Removals 
-- 252286	2021-05-28 00:00:00	2021-06-04 00:00:00	e62ad660-2611-480e-b719-603fe84bc8f3
-- 252283	2021-05-28 00:00:00	2021-06-04 00:00:00	0ce4f7c5-e2dc-4e83-b400-c42e715f3572 -- Delete

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252283
	and rm.personid = 'cbcc18a1-0457-4dae-b983-ae03ed36ad6b'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252283
	and rm.personid = 'cbcc18a1-0457-4dae-b983-ae03ed36ad6b'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '0ce4f7c5-e2dc-4e83-b400-c42e715f3572'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = '0ce4f7c5-e2dc-4e83-b400-c42e715f3572'
	and ro.activeflag = 1 ;	
	
-- No Placements

-- OOH
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '7eb66d9f-b770-411c-a076-be4d107d792d'
	and personid = 'cbcc18a1-0457-4dae-b983-ae03ed36ad6b'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CIDM-4098',
	updatedon = now() 		
where personprogramid = '7eb66d9f-b770-411c-a076-be4d107d792d'
	and personid = 'cbcc18a1-0457-4dae-b983-ae03ed36ad6b'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252283
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 252283
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252283
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252283
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;	

-- 25)
-- Client ID: 200648663	Layla		Rideau	d7a16fb5-de09-4a63-a38f-851dbbfa4a02
-- Removals 
-- 252013	2021-04-01 00:00:00	2021-04-13 16:37:38	c7d38065-7c9d-4c92-b3c8-c8bd250d1f23 -- Delete
-- 251861	2021-04-01 00:00:00	2021-04-13 17:24:27	78b6eb6f-617f-484d-ad3e-db2d331077aa

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252013
	and rm.personid = 'd7a16fb5-de09-4a63-a38f-851dbbfa4a02'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252013
	and rm.personid = 'd7a16fb5-de09-4a63-a38f-851dbbfa4a02'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'c7d38065-7c9d-4c92-b3c8-c8bd250d1f23'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'c7d38065-7c9d-4c92-b3c8-c8bd250d1f23'
	and ro.activeflag = 1 ;	
	
-- No Placements

-- OOH
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'ccc539de-7ae9-4ee3-a9c2-f22ece4cf7d6'
	and personid = 'd7a16fb5-de09-4a63-a38f-851dbbfa4a02'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CIDM-4098',
	updatedon = now() 		
where personprogramid = 'ccc539de-7ae9-4ee3-a9c2-f22ece4cf7d6'
	and personid = 'd7a16fb5-de09-4a63-a38f-851dbbfa4a02'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252013
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 252013
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252013
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252013
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;	
	
-- 26)
-- Client ID: 4209867	GEORGE		CREWS	ec07704a-4bfc-466f-8107-f0412717565b
-- Removals 
-- 251239	2019-03-11 00:00:00	2020-11-19 18:03:45	a4fc0dda-43cd-4b3d-bb47-482c2ec7c1f5 - Delete
-- 195228	2019-03-11 00:00:00	2020-11-19 16:00:00	fc5e4fd5-7d9f-41bd-8988-4f1fb746106f

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251239
	and rm.personid = 'ec07704a-4bfc-466f-8107-f0412717565b'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 251239
	and rm.personid = 'ec07704a-4bfc-466f-8107-f0412717565b'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'a4fc0dda-43cd-4b3d-bb47-482c2ec7c1f5'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'a4fc0dda-43cd-4b3d-bb47-482c2ec7c1f5'
	and ro.activeflag = 1 ;	
	
-- No Placements

-- OOH - No Changes
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 251239
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 251239
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 251239
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 251239
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;
	
-- 27)
-- Client ID: 3088195	SHABREA	ZAIRE	BEY	f0a2a794-f8a8-4ddf-bc97-e60f9b4120fc
-- Removals 	
--	250898	2020-09-11 00:00:00	2020-09-25 09:30:00	8ba26718-a5e6-4437-a604-5395f5f23437
-- Delete
-- 250971	2020-09-11 00:00:00	2020-09-25 09:30:55	2c434be6-e27e-4451-8e78-80d5c94ebf34
-- 250866	2020-09-11 00:00:00		f34046b7-c556-4fa6-9a4f-15b565f748d3

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid in (250971, 250866)
	and rm.personid = 'f0a2a794-f8a8-4ddf-bc97-e60f9b4120fc'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid in (250971, 250866)
	and rm.personid = 'f0a2a794-f8a8-4ddf-bc97-e60f9b4120fc'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  in ( '2c434be6-e27e-4451-8e78-80d5c94ebf34', 'f34046b7-c556-4fa6-9a4f-15b565f748d3')
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  in ( '2c434be6-e27e-4451-8e78-80d5c94ebf34', 'f34046b7-c556-4fa6-9a4f-15b565f748d3')
	and ro.activeflag = 1 ;	
	
-- No Placements

-- OOH
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '2f8efffa-12c7-4a19-93e3-2d2ec0f74767'
	and personid = 'f0a2a794-f8a8-4ddf-bc97-e60f9b4120fc'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CIDM-4098',
	updatedon = now() 		
where personprogramid = '2f8efffa-12c7-4a19-93e3-2d2ec0f74767'
	and personid = 'f0a2a794-f8a8-4ddf-bc97-e60f9b4120fc'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id in (250971, 250866)
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id in (250971, 250866)
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id in (250971, 250866)
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id in (250971, 250866)
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;	
	
-- 28)
-- Client ID: 4233544	MARLOW		TELFER	fffbfc8a-a578-499a-963c-222597e5cbc7
-- Removals 	
-- 252925	2021-03-31 00:00:00	2021-07-22 12:00:00	bde9c831-8f47-489b-9489-c44e27a8b268 - Delete
-- 251839	2021-03-31 00:00:00	2021-07-22 14:00:00	0bff5eb8-a77f-4784-a30d-11630965b862

-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 252925
	and rm.personid = 'fffbfc8a-a578-499a-963c-222597e5cbc7'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid = 252925
	and rm.personid = 'fffbfc8a-a578-499a-963c-222597e5cbc7'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'bde9c831-8f47-489b-9489-c44e27a8b268'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'bde9c831-8f47-489b-9489-c44e27a8b268'
	and ro.activeflag = 1 ;	
	
-- Placements
select alternateid, placementtypekey, startdatetime, enddatetime, altproviderid, updatedby, updatedon
	from placement 
where intakeservreqchildremovalid = 'bde9c831-8f47-489b-9489-c44e27a8b268'
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid	= '0bff5eb8-a77f-4784-a30d-11630965b862',
	updatedby = 'CIDM-4098',
	updatedon = now() 	
where intakeservreqchildremovalid = 'bde9c831-8f47-489b-9489-c44e27a8b268'
	and activeflag = 1 ;
	

-- OOH - No Changes
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 252925
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id = 252925
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252925
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id = 252925
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;
	

-- 29)
-- Client ID: 3947162	DENIYA		MCCULLOUGH	005eb8d0-ce40-4cb1-b052-1031f12bb6d8
-- Removals 
-- 179987	2016-05-09 00:00:00	2019-10-31 00:00:00	42693e94-fcc8-4283-a0fa-1994b89f7574
-- Delete
-- 250890	2016-05-09 00:00:00	2020-09-15 09:00:00	84c1d80e-c1b8-4adc-a6d3-810ba91b0d20
-- 197645	2019-10-31 00:00:00	2020-07-01 09:00:00	7b69fd40-a629-44d1-8dce-5b0c4145ac26
	
-- Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid in (250890, 197645)
	and rm.personid = '005eb8d0-ce40-4cb1-b052-1031f12bb6d8'
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4098',
	rm.updatedon = now() 		
where rm.removalid in (250890, 197645)
	and rm.personid = '005eb8d0-ce40-4cb1-b052-1031f12bb6d8'
	and rm.activeflag = 1 ;
	
-- Routing
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  in ('84c1d80e-c1b8-4adc-a6d3-810ba91b0d20', '7b69fd40-a629-44d1-8dce-5b0c4145ac26')
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4098',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  in ('84c1d80e-c1b8-4adc-a6d3-810ba91b0d20', '7b69fd40-a629-44d1-8dce-5b0c4145ac26')
	and ro.activeflag = 1 ;	
	
-- Placements
select alternateid, placementtypekey, startdatetime, enddatetime, altproviderid, updatedby, updatedon
	from placement 
where intakeservreqchildremovalid 
		in ( '84c1d80e-c1b8-4adc-a6d3-810ba91b0d20', '7b69fd40-a629-44d1-8dce-5b0c4145ac26' )
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid	= '42693e94-fcc8-4283-a0fa-1994b89f7574',
	updatedby = 'CIDM-4098',
	updatedon = now() 	
where intakeservreqchildremovalid
		in ( '84c1d80e-c1b8-4adc-a6d3-810ba91b0d20', '7b69fd40-a629-44d1-8dce-5b0c4145ac26' )
	and activeflag = 1 ;


-- OOH
select startdate, enddate, programkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid in ('2ce48db0-a5a9-4566-b418-f79346c7724b', 'ade27fb1-f959-4313-8d07-a22475f9931c')
	and personid = '005eb8d0-ce40-4cb1-b052-1031f12bb6d8'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0, 
	updatedby = 'CIDM-4098',
	updatedon = now() 		
where personprogramid in ('2ce48db0-a5a9-4566-b418-f79346c7724b', 'ade27fb1-f959-4313-8d07-a22475f9931c')
	and personid = '005eb8d0-ce40-4cb1-b052-1031f12bb6d8'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
-- IV-E
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id in (250890, 197645)
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where removal_id in (250890, 197645)
	and delete_sw = 'N' ;

select eligibility_id, status_cd,  delete_sw, update_ts, update_user_id
	from tb_eligibility_period 
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id in (250890, 197645)
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;

update tb_eligibility_period
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CIDM-4098'
where eligibility_id 
	in ( select eligibility_id
			from tb_client_eligibility 
		 where removal_id in (250890, 197645)
			and delete_sw = 'N'
		)
	and delete_sw = 'N'	;	
	