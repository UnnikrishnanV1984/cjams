DROP FUNCTION IF EXISTS cjams.listdastatusbydatypesubtype(intakeservreqtypeid uuid, servicerequestsubtypeid uuid, roletypekey character varying);
 CREATE OR REPLACE FUNCTION cjams.listdastatusbydatypesubtype(intakeservreqtypeid uuid, servicerequestsubtypeid uuid, roletypekey character varying)
 RETURNS TABLE(intakeserreqstatustypeid uuid, intakeserreqstatustypekey character varying, description text)
 LANGUAGE plpgsql
AS $function$

DECLARE
	v_intakeservreqtypeid uuid;
	v_servicerequestsubtypeid uuid;
	v_roletypekey character varying;
	v_configcount int;
	
begin
	v_intakeservreqtypeid := intakeservreqtypeid;
	v_servicerequestsubtypeid := servicerequestsubtypeid;
	v_roletypekey := roletypekey;
	
	if (v_intakeservreqtypeid != v_servicerequestsubtypeid) then
		select count(1) into v_configcount from Servicerequesttypeconfig srtc
		join servicerequesttypeconfigdispositioncode sdc ON sdc.Servicerequesttypeconfigid = srtc.Servicerequesttypeconfigid 
		and sdc.activeflag =1
		where 
		(v_intakeservreqtypeid IS NULL OR srtc.intakeservreqtypeid =  v_intakeservreqtypeid  )  
		and srtc.servicerequestsubtypeid = v_servicerequestsubtypeid and srtc.activeflag = 1;
		if v_configcount = 0 then
			v_servicerequestsubtypeid = '00000000-0000-0000-0000-000000000000';
		end if;
	else
		v_servicerequestsubtypeid = '00000000-0000-0000-0000-000000000000';
	end if;
	
	RETURN  QUERY
	select distinct isst.intakeserreqstatustypeid, isst.intakeserreqstatustypekey, isst.description
	--, srtcd.roletypekey
	from servicerequesttypeconfigdispositioncode srtcd 
	join intakeserreqstatustype isst on isst.intakeserreqstatustypeid = srtcd.intakeserreqstatustypeid
	join servicerequesttypeconfig srtc on srtc.servicerequesttypeconfigid = srtcd.servicerequesttypeconfigid
	where (v_intakeservreqtypeid IS NULL OR srtc.intakeservreqtypeid =  v_intakeservreqtypeid  ) 
	and srtc.servicerequestsubtypeid = v_servicerequestsubtypeid
	and srtcd.activeflag = 1 and srtc.activeflag = 1 and isst.activeflag = 1 
	and (srtcd.roletypekey = v_roletypekey or srtcd.roletypekey is null)
	order by isst.description;

END;

$function$
;
