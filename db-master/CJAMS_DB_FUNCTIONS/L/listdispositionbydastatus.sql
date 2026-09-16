CREATE OR REPLACE FUNCTION cjams.listdispositionbydastatus(intakeservreqtypeid uuid, 
servicerequestsubtypeid uuid, 
intakeserviceid uuid,
statuskey character varying, recommendationtype character varying, 
roletypekey character varying)
 RETURNS TABLE(servicerequesttypeconfigiddispostionid uuid, servicerequesttypeconfigid uuid, dispositioncode character varying, description text, intakeserreqstatustypeid uuid)
 LANGUAGE plpgsql
AS $function$

DECLARE
	v_intakeservreqtypeid uuid;
	v_servicerequestsubtypeid uuid;
	v_intakeserviceid uuid;
	v_statuskey character varying;
	v_recommendationtype character varying;
	v_roletypekey character varying;
	v_configcount int;
	
begin
	v_intakeserviceid := intakeserviceid;
	v_intakeservreqtypeid := intakeservreqtypeid;
	v_servicerequestsubtypeid := servicerequestsubtypeid;
	v_statuskey := statuskey;
	v_recommendationtype := recommendationtype;
	v_roletypekey := roletypekey;
	
	
	if (v_intakeserviceid is not null) then
		select isr.intakeservreqtypeid, isr.intakeservicerequestclassid 
		into v_intakeservreqtypeid, v_servicerequestsubtypeid
		from Intakeservicerequest isr
		where isr.intakeserviceid = v_intakeserviceid  
		and isr.activeflag = 1;
	   
	elsif (v_intakeservreqtypeid != v_servicerequestsubtypeid) then
		select count(1) into v_configcount from Servicerequesttypeconfig srtc
		join servicerequesttypeconfigdispositioncode sdc ON sdc.Servicerequesttypeconfigid = srtc.Servicerequesttypeconfigid 
		and sdc.activeflag =1
		where (v_intakeservreqtypeid is null or srtc.intakeservreqtypeid =  v_intakeservreqtypeid )
		and srtc.servicerequestsubtypeid = v_servicerequestsubtypeid and srtc.activeflag = 1;
		if v_configcount = 0 then
			v_servicerequestsubtypeid = '00000000-0000-0000-0000-000000000000';
		end if;
	else
		v_servicerequestsubtypeid = '00000000-0000-0000-0000-000000000000';
	end if;
	
	RETURN  QUERY
	select distinct srtcd.servicerequesttypeconfigiddispostionid
	, srtcd.servicerequesttypeconfigid, srtcd.dispositioncode
	, srtcd.description, srtcd.intakeserreqstatustypeid
	from servicerequesttypeconfigdispositioncode srtcd 
	join intakeserreqstatustype isst on isst.intakeserreqstatustypeid = srtcd.intakeserreqstatustypeid
	join servicerequesttypeconfig srtc on srtc.servicerequesttypeconfigid = srtcd.servicerequesttypeconfigid
	join Intakeserreqstatustype isrst on isrst.intakeserreqstatustypeid = srtcd.intakeserreqstatustypeid
	where (v_intakeservreqtypeid is null OR srtc.intakeservreqtypeid = v_intakeservreqtypeid )
	and srtc.servicerequestsubtypeid = v_servicerequestsubtypeid
	and isrst.intakeserreqstatustypekey = v_statuskey
	and srtcd.recommendationtype = v_recommendationtype
	and srtcd.activeflag = 1 and srtc.activeflag = 1 and isst.activeflag = 1 and isrst.activeflag = 1
	and (srtcd.roletypekey = v_roletypekey or srtcd.roletypekey is null)
	and case when v_roletypekey = 'ASIW' or v_roletypekey = 'CWIW' then (srtcd.dispositioncode != 'OvrScrnout' and srtcd.dispositioncode != 'Ovrscrnin') else true end
	order by srtcd.description;
	/*select distinct srtcd.servicerequesttypeconfigiddispostionid
	, srtcd.servicerequesttypeconfigid, srtcd.dispositioncode
	, srtcd.description, srtcd.intakeserreqstatustypeid
	from servicerequesttypeconfigdispositioncode srtcd 
	join intakeserreqstatustype isst on isst.intakeserreqstatustypeid = srtcd.intakeserreqstatustypeid
	join servicerequesttypeconfig srtc on srtc.servicerequesttypeconfigid = srtcd.servicerequesttypeconfigid
	join Intakeserreqstatustype isrst on isrst.intakeserreqstatustypeid = srtcd.intakeserreqstatustypeid
	where srtc.intakeservreqtypeid = '432de723-f821-4bf2-9a8b-b2755fc5fd6d' 
	and srtc.servicerequestsubtypeid = '55639f0c-a066-48eb-ab77-f54cb0734a78'
    and isrst.intakeserreqstatustypekey = v_statuskey
	and srtcd.recommendationtype = v_recommendationtype
	and srtcd.activeflag = 1 and srtc.activeflag = 1 and isst.activeflag = 1 and isrst.activeflag = 1
	and (srtcd.roletypekey = 'JSSP' or srtcd.roletypekey is null)
	order by srtcd.description;*/
	
END;

$function$
;