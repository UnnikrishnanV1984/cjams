DROP FUNCTION if exists cjams.updatesdmtrafficking(casenumber character varying, sdmid uuid, securityusersid character varying,concerntraffic character varying,selecttraffic character varying);
DROP FUNCTION if exists  cjams.updatesdmtrafficking(casenumber character varying, sdmid uuid, securityusersid character varying,concerntraffic character varying,selecttraffic character varying,  v_servicecase boolean, intakeserviceid uuid, intakenumber character varying);

--Revision(s)
--  -01/23/2026 - Vamshikri.byreddy --CIDM-10829-SDM story- Capturing audit trail for service case

CREATE OR REPLACE FUNCTION cjams.updatesdmtrafficking(casenumber character varying, sdmid uuid, securityusersid character varying,concerntraffic character varying,selecttraffic character varying,  v_servicecase boolean DEFAULT false, intakeserviceid uuid DEFAULT NULL::uuid, intakenumber character varying DEFAULT NULL::character varying)
RETURNS text
LANGUAGE plpgsql
AS $function$

DECLARE
v_sdmid uuid;
v_casenumber character varying;
v_securityid character varying;
result character varying;
v_concerntraffic character varying;
v_selecttraffic character varying;
v_intakeserviceid uuid;
v_intakenumber character varying;

BEGIN
v_casenumber := casenumber;
v_securityid :=securityusersid;
v_sdmid :=sdmid;
v_selecttraffic :=selecttraffic;
v_concerntraffic := concerntraffic;
v_intakeserviceid := intakeserviceid;
v_intakenumber := intakenumber;

IF v_sdmid is not null THEN                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
    update intakeservicerequestsdm  set 
    confirmtrafficking =v_concerntraffic,
    selecttrafficking =v_selecttraffic,
    updatedby = v_securityid, 
    updatedon =now()
    where intakeservicerequestsdmid =v_sdmid;  
ELSE 
    insert into cjams.intakeservicerequestsdm(intakeserviceid, intakenumber, status, activeflag, insertedby, insertedon, confirmtrafficking, selecttrafficking)
    values(v_intakeserviceid,v_intakenumber, 16, 1, v_securityid, now(), v_concerntraffic, v_selecttraffic) returning intakeservicerequestsdmid INTO v_sdmid;
END IF;

insert into cjams.sdmtraffickingaudittrail(intakeservicerequestsdmid,updatedby,updatedon,objecttype,objectid,insertedby,insertedon,concernfortrafficking,selecttrafficking,objectkey)
values(v_sdmid,v_securityid,now(),
case when v_servicecase then 'Service Case' else 'CPS Case' end,
casenumber,v_securityid,now(),v_concerntraffic,v_selecttraffic,'trafficking');
result := 'SUCCESS';
RETURN result;
END 
$function$
;