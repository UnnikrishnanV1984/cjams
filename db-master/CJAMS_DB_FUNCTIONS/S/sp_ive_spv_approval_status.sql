DROP FUNCTION  IF EXISTS cjams.sp_ive_spv_approval_status(approval_id uuid, approval_status character varying, v_placementtype character varying, pagenumber bigint, pagesize bigint, approved_user CHARACTER varying);
CREATE OR REPLACE FUNCTION cjams.sp_ive_spv_approval_status(approval_id uuid, approval_status character varying, v_placementtype character varying, pagenumber bigint, pagesize bigint, approved_user CHARACTER varying, userid character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------
-- CIDM-8279(B-186246) Foster Care Maintenance Payments User Story (PI24-Q1_S01)
-- CIDM-8270 (B-186247) - GAP Subsidy Payments User Story (PI24-Q1_S01)
-- CIDM-8283 (B-186246) Adoption Subsidy Payment User Story (PI24-Q1_S01)
-- CIDM-10235 - Veera 02-27-2025 Insertedby, Updatedby column fix
-------------------------------------------------------------------------------
declare
v_approval_id uuid;
v_approval_status character varying;
v_picklist_value_cd character varying;
v_client_id bigint;
v_eligibility_id integer;
v_approved_user CHARACTER VARYING;
v_userid character varying;
vs_last_apporved_staus character varying;
vs_sqnm_sw character varying;

begin
v_approval_id = approval_id;
v_approval_status = approval_status;
v_approved_user = approved_user;
v_userid = userid;
------------------------------------foster care-----------------------------------------
if(v_placementtype = 'Fostercare') then

UPDATE tb_eligibility_period tep 
SET approvalstatus = v_approval_status, approvedby = v_approved_user ,approvedon = now() , update_user_id = v_userid, update_ts = now()
where tep.approvalid = v_approval_id::varchar 
	returning tep.eligibility_id, tep.status_cd, tep.sqnm_sw 
	into v_eligibility_id, v_picklist_value_cd, vs_sqnm_sw;

if(lower(v_approval_status) = 'approved') then 
	UPDATE tb_client_eligibility tce SET eligibility_status_cd=v_picklist_value_cd, update_ts = now() WHERE tce.eligibility_id=v_eligibility_id;
else 
	-- Logic to Revert the last approved IV-E status in case of Rejection
	-- Look for last Approved determination 
	
	if vs_sqnm_sw <> 'I' then -- NOT Initial Determination
	
		select btrim(tep.status_cd)
			into vs_last_apporved_staus 
		from tb_eligibility_period tep
		where tep.eligibility_id = v_eligibility_id 
			and tep.approvalid <> v_approval_id::varchar 
			and tep.delete_sw = 'N'
			and lower(tep.approvalstatus) = 'approved'
		order by tep.create_ts desc	
		limit 1;
		
		-- If Approved not found, look for most reecnt which is NOT in 'rejected' and 'pending' status
		if vs_last_apporved_staus is null or btrim(vs_last_apporved_staus) = '' then 
			select btrim(tep.status_cd)
				into vs_last_apporved_staus 
			from tb_eligibility_period tep
			where tep.eligibility_id = v_eligibility_id 
				and (case when tep.approvalid is null then true else tep.approvalid <> v_approval_id::varchar end)  
				and tep.delete_sw = 'N'
				and lower(coalesce(tep.approvalstatus, '')) not in ('rejected','pending')
				and (tep.sqnm_sw is null or btrim(tep.sqnm_sw) = '')
				and btrim(tep.status_cd) in ('2909','2913','2914')    	  
			order by tep.create_ts desc	
			limit 1;
		end if;
		
	else -- Initial Determination
		-- Look only for Initial Migrated Determination
		select btrim(tep.status_cd)
			into vs_last_apporved_staus 
		from tb_eligibility_period tep,
			tb_eligibility_events tee
		where tep.eligibility_period_id = tee.eligibility_period_id
			and tep.eligibility_id = v_eligibility_id 
			and (case when tep.approvalid is null then true else tep.approvalid <> v_approval_id::varchar end)  
			and tep.approvalid is null 
			and tep.delete_sw = 'N'
			and tee.delete_sw = 'N'
			and lower(coalesce(tep.approvalstatus, '')) not in ('rejected','pending')
			and (tep.sqnm_sw is null or btrim(tep.sqnm_sw) = '')
			and btrim(tee.type_cd) = '2923' -- 	Initial Determination
			and btrim(tep.status_cd) in ('2909','2913','2914')    	  
		order by tep.create_ts desc	
		limit 1;
	
	end if;	

	-- Else set Pending
	if vs_last_apporved_staus is null or btrim(vs_last_apporved_staus) = '' then
		vs_last_apporved_staus := '2909'; -- Pending
	end if;	

	-- Update tb_client_eligibility status for Finance 
	Update tb_client_eligibility
	set eligibility_status_cd = vs_last_apporved_staus,
		update_ts = now(), 
		update_user_id = v_approved_user 
	where eligibility_id = v_eligibility_id 
		and delete_sw = 'N' ;
end if;
------------------------------------Gap-----------------------------------------
elseif(v_placementtype = 'Gap') then

-- UPDATE tb_eligibility_period tep SET approvalstatus = v_approval_status, approvedby = v_approved_user ,approvedon = now() where tep.approvalid = v_approval_id::varchar returning tep.eligibility_id, tep.status_cd into v_eligibility_id, v_picklist_value_cd;
UPDATE tb_eligibility_period tep 
SET approvalstatus = v_approval_status, approvedby = v_approved_user ,approvedon = now() , update_user_id = v_userid, update_ts = now()
where tep.approvalid = v_approval_id::varchar 
	returning tep.eligibility_id, tep.status_cd, tep.sqnm_sw 
	into v_eligibility_id, v_picklist_value_cd, vs_sqnm_sw;

if(lower(v_approval_status) = 'approved') then 
UPDATE tb_client_eligibility tce SET eligibility_status_cd=v_picklist_value_cd, update_ts = now() WHERE tce.eligibility_id=v_eligibility_id;
else 
	-- Logic to Revert the last approved IV-E status in case of Rejection
	-- Look for last Approved determination 
	
	if vs_sqnm_sw <> 'I' then -- NOT Initial Determination
	
		select btrim(tep.status_cd)
			into vs_last_apporved_staus 
		from tb_eligibility_period tep
		where tep.eligibility_id = v_eligibility_id 
			and tep.approvalid <> v_approval_id::varchar 
			and tep.delete_sw = 'N'
			and lower(tep.approvalstatus) = 'approved'
		order by tep.create_ts desc	
		limit 1;
		
		-- If Approved not found, look for most reecnt which is NOT in 'rejected' and 'pending' status
		if vs_last_apporved_staus is null or btrim(vs_last_apporved_staus) = '' then 
			select btrim(tep.status_cd)
				into vs_last_apporved_staus 
			from tb_eligibility_period tep
			where tep.eligibility_id = v_eligibility_id 
				and (case when tep.approvalid is null then true else tep.approvalid <> v_approval_id::varchar end)  
				and tep.delete_sw = 'N'
				and lower(coalesce(tep.approvalstatus, '')) not in ('rejected','pending')
				and (tep.sqnm_sw is null or btrim(tep.sqnm_sw) = '')
				and btrim(tep.status_cd) in ('2909','2913','2914')    	  
			order by tep.create_ts desc	
			limit 1;
		end if;
		
	else -- Initial Determination
		-- Look only for Initial Migrated Determination
		select btrim(tep.status_cd)
			into vs_last_apporved_staus 
		from tb_eligibility_period tep,
			tb_eligibility_events tee
		where tep.eligibility_period_id = tee.eligibility_period_id
			and tep.eligibility_id = v_eligibility_id 
			and (case when tep.approvalid is null then true else tep.approvalid <> v_approval_id::varchar end)  
			and tep.approvalid is null 
			and tep.delete_sw = 'N'
			and tee.delete_sw = 'N'
			and lower(coalesce(tep.approvalstatus, '')) not in ('rejected','pending')
			and (tep.sqnm_sw is null or btrim(tep.sqnm_sw) = '')
			and btrim(tee.type_cd) = '2923' -- 	Initial Determination
			and btrim(tep.status_cd) in ('2909','2913','2914')    	  
		order by tep.create_ts desc	
		limit 1;
	
	end if;	

	-- Else set Pending
	if vs_last_apporved_staus is null or btrim(vs_last_apporved_staus) = '' then
		vs_last_apporved_staus := '2909'; -- Pending
	end if;	

	-- Update tb_client_eligibility status for Finance 
	Update tb_client_eligibility
	set eligibility_status_cd = vs_last_apporved_staus,
		update_ts = now(), 
		update_user_id = v_approved_user 
	where eligibility_id = v_eligibility_id 
		and delete_sw = 'N' ;
end if;
------------------------------------Adoption-----------------------------------------
elseif(v_placementtype = 'Adoption') then

UPDATE tb_eligibility_period tep 
SET approvalstatus = v_approval_status, approvedby = v_approved_user ,approvedon = now() , update_user_id = v_userid, update_ts = now()
where tep.approvalid = v_approval_id::varchar 
	returning tep.eligibility_id, tep.status_cd, tep.sqnm_sw 
	into v_eligibility_id, v_picklist_value_cd, vs_sqnm_sw;

if(lower(v_approval_status) = 'approved') then 
	UPDATE tb_client_eligibility tce SET eligibility_status_cd=v_picklist_value_cd, update_ts = now() WHERE tce.eligibility_id=v_eligibility_id;
else 
	-- Logic to Revert the last approved IV-E status in case of Rejection
	-- Look for last Approved determination 
	
	if vs_sqnm_sw <> 'I' then -- NOT Initial Determination
	
		select btrim(tep.status_cd)
			into vs_last_apporved_staus 
		from tb_eligibility_period tep
		where tep.eligibility_id = v_eligibility_id 
			and tep.approvalid <> v_approval_id::varchar 
			and tep.delete_sw = 'N'
			and lower(tep.approvalstatus) = 'approved'
		order by tep.create_ts desc	
		limit 1;
		
		-- If Approved not found, look for most recent which is NOT in 'rejected' and 'pending' status
		if vs_last_apporved_staus is null or btrim(vs_last_apporved_staus) = '' then 
			select btrim(tep.status_cd)
				into vs_last_apporved_staus 
			from tb_eligibility_period tep
			where tep.eligibility_id = v_eligibility_id 
				and (case when tep.approvalid is null then true else tep.approvalid <> v_approval_id::varchar end)  
				and tep.delete_sw = 'N'
				and lower(coalesce(tep.approvalstatus, '')) not in ('rejected','pending')
				and (tep.sqnm_sw is null or btrim(tep.sqnm_sw) = '')
				and btrim(tep.status_cd) in ('2909','2913','2914')    	  
			order by tep.create_ts desc	
			limit 1;
		end if;
		
	else -- Initial Determination
		-- Look only for Initial Migrated Determination
		select btrim(tep.status_cd)
			into vs_last_apporved_staus 
		from tb_eligibility_period tep,
			tb_eligibility_events tee
		where tep.eligibility_period_id = tee.eligibility_period_id
			and tep.eligibility_id = v_eligibility_id 
			and (case when tep.approvalid is null then true else tep.approvalid <> v_approval_id::varchar end)  
			and tep.approvalid is null 
			and tep.delete_sw = 'N'
			and tee.delete_sw = 'N'
			and lower(coalesce(tep.approvalstatus, '')) not in ('rejected','pending')
			and (tep.sqnm_sw is null or btrim(tep.sqnm_sw) = '')
			and btrim(tee.type_cd) = '2923' -- 	Initial Determination
			and btrim(tep.status_cd) in ('2909','2913','2914')    	  
		order by tep.create_ts desc	
		limit 1;
	
	end if;	

	-- Else set Pending
	if vs_last_apporved_staus is null or btrim(vs_last_apporved_staus) = '' then
		vs_last_apporved_staus := '2909'; -- Pending
	end if;	

	-- Update tb_client_eligibility status for Finance 
	Update tb_client_eligibility
	set eligibility_status_cd = vs_last_apporved_staus,
		update_ts = now(), 
		update_user_id = v_approved_user 
	where eligibility_id = v_eligibility_id 
		and delete_sw = 'N' ;
end if;

elseif(v_placementtype = 'Adoptionapplicability') then

UPDATE tb_ive_adoption_audit tiaa SET  approvalstatus=v_approval_status where approvalid = v_approval_id returning tiaa.cjamspid into v_client_id;

UPDATE adoptionapplicabilityinfo SET  ivestatus = v_approval_status where clientid = v_client_id;

end if;
return 'success';
end
 $function$
;