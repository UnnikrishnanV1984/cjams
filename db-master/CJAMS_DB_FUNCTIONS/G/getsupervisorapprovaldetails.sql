DROP FUNCTION IF EXISTS cjams.getsupervisorapprovaldetails(character varying);
DROP FUNCTION IF EXISTS cjams.getsupervisorapprovaldetails(character varying, character varying, integer);
DROP FUNCTION IF EXISTS cjams.getsupervisorapprovaldetails(character varying, character varying, integer, integer);
DROP FUNCTION IF EXISTS cjams.getsupervisorapprovaldetails(character varying, integer, integer);
CREATE OR REPLACE FUNCTION cjams.getsupervisorapprovaldetails(intakenumber character varying, isExpungementSuperUser integer DEFAULT 0,isexpunged integer DEFAULT 0::integer)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------------------------- 
-- Revision(s)
-- 08/29/2022 Vineet Tirodkar - To fix Intake approval history issue (CDM-24664)
-- 01/19/2024 Sreekanth Marrikant - Added fromsecurityusersid, activeflag to output (CIDM-8286) 
---06/06/2024  Vinesh- Screened in time not accurrate (CDM-39122)
-- 11/17/2025 Amiya Pradhan - CIDM-10890 - CJAMS Manual & Automation Expungement Enhancement - for Sexual Abuse CPS Intakes and Cases
-------------------------------------------------------------------------------------------- 
DECLARE
    v_intakenumber character varying;
    v_result json;
    v_result1 json;
	v_intakeserviceid uuid;
	v_isexpunged integer := 0;
        	
BEGIN
    
    v_intakenumber := intakenumber;

	v_isexpunged = 0;
	IF isExpungementSuperUser = 1 THEN	
		v_isexpunged = isexpunged;
	END IF;

IF v_isexpunged = 1 THEN 
-- fully expunged 
SELECT json_agg(a) into v_result1 FROM 
    (
        SELECT isr.servicerequestnumber from expunge.intakeservicerequest_expunge isr where isr.intakenumber = v_intakenumber and activeflag = 1
    ) a ;

	SELECT json_agg(pe) into v_result FROM 
		(
			select 
				(select rs.typedescription from routingstatustype rs where rs.sequencenumber = r.routingstatustypeid ) as status,
				r.fromsecurityusersid as fromid,
				(select fullname from userprofile u where u.securityusersid = r.fromsecurityusersid) as fromname,
				(select fullname from userprofile u 
					where u.securityusersid 
						= (case when r.routingstatustypeid = 1 then r.tosecurityusersid else r.updatedby end)) as name,
				upa.county,
				upa.address,
				concat(coalesce(upa.city,''), (case when upa.city is not null then ', ' else '' end),
				coalesce(upa.state,''), (case when upa.state is not null then ', ' else '' end),	
				coalesce(upa.zipcode,'')) as address2,
				(case when r.toroleid = 'CWSP' then 'Supervisor' when r.toroleid = 'CWCW' then 'Case Worker' end) as role,
				r.objectid as intakenumber,
				r.insertedon as date,
				r.eventcode,
				coalesce(r.approveddate  ,r.updatedon   )   as dateupdated,
				r.activeflag,
				rst.typedescription as typedescription,
				r.intakerecommendation as intakerecommendation,
				r.supervisordecision as supdecision
				
			from routing r 
				left outer join userprofileaddress upa on r.tosecurityusersid = upa.securityusersid
				inner join routingstatustype rst on rst.sequencenumber = r.routingstatustypeid
			where r.objectid = v_intakenumber  
			order by r.insertedon
		) pe; 
		
	if (v_result is null) then
        v_result = v_result1;
    end if; 	
	
    return v_result;

ELSEIF v_isexpunged = 2 THEN 
-- partially expunged 
SELECT json_agg(a) into v_result1 FROM 
    (
        SELECT servicerequestnumber from intakeservicerequest isr where isr.intakenumber = v_intakenumber and activeflag = 1 
		UNION ALL 
		SELECT isr.servicerequestnumber as servicerequestnumber from expunge.intakeservicerequest_expunge isr where isr.intakenumber = v_intakenumber and activeflag = 1
    ) a ;

	SELECT json_agg(pe) into v_result FROM 
		(
			select 
				(select rs.typedescription from routingstatustype rs where rs.sequencenumber = r.routingstatustypeid ) as status,
				r.fromsecurityusersid as fromid,
				(select fullname from userprofile u where u.securityusersid = r.fromsecurityusersid) as fromname,
				(select fullname from userprofile u 
					where u.securityusersid 
						= (case when r.routingstatustypeid = 1 then r.tosecurityusersid else r.updatedby end)) as name,
				upa.county,
				upa.address,
				concat(coalesce(upa.city,''), (case when upa.city is not null then ', ' else '' end),
				coalesce(upa.state,''), (case when upa.state is not null then ', ' else '' end),	
				coalesce(upa.zipcode,'')) as address2,
				(case when r.toroleid = 'CWSP' then 'Supervisor' when r.toroleid = 'CWCW' then 'Case Worker' end) as role,
				r.objectid as intakenumber,
				r.insertedon as date,
				r.eventcode,
				coalesce(r.approveddate  ,r.updatedon   )   as dateupdated,
				r.activeflag,
				rst.typedescription as typedescription,
				r.intakerecommendation as intakerecommendation,
				r.supervisordecision as supdecision
				
			from routing r 
				left outer join userprofileaddress upa on r.tosecurityusersid = upa.securityusersid
				inner join routingstatustype rst on rst.sequencenumber = r.routingstatustypeid
			where r.objectid = v_intakenumber  
			order by r.insertedon
		) pe; 
		
	if (v_result is null) then
        v_result = v_result1;
    end if; 	
	
    return v_result;
ELSE 
-- original query
SELECT json_agg(a) into v_result1 FROM 
    (
        SELECT servicerequestnumber from intakeservicerequest isr where isr.intakenumber = v_intakenumber and activeflag = 1
    ) a ;

	SELECT json_agg(pe) into v_result FROM 
		(
			select 
				(select rs.typedescription from routingstatustype rs where rs.sequencenumber = r.routingstatustypeid ) as status,
				r.fromsecurityusersid as fromid,
				(select fullname from userprofile u where u.securityusersid = r.fromsecurityusersid) as fromname,
				(select fullname from userprofile u 
					where u.securityusersid 
						= (case when r.routingstatustypeid = 1 then r.tosecurityusersid else r.updatedby end)) as name,
				upa.county,
				upa.address,
				concat(coalesce(upa.city,''), (case when upa.city is not null then ', ' else '' end),
				coalesce(upa.state,''), (case when upa.state is not null then ', ' else '' end),	
				coalesce(upa.zipcode,'')) as address2,
				(case when r.toroleid = 'CWSP' then 'Supervisor' when r.toroleid = 'CWCW' then 'Case Worker' end) as role,
				r.objectid as intakenumber,
				r.insertedon as date,
				r.eventcode,
				coalesce(r.approveddate  ,r.updatedon   )   as dateupdated,
				r.activeflag,
				rst.typedescription as typedescription,
				r.intakerecommendation as intakerecommendation,
				r.supervisordecision as supdecision
				
			from routing r 
				left outer join userprofileaddress upa on r.tosecurityusersid = upa.securityusersid
				inner join routingstatustype rst on rst.sequencenumber = r.routingstatustypeid
			where r.objectid = v_intakenumber  
			order by r.insertedon
		) pe; 
		
	if (v_result is null) then
        v_result = v_result1;
    end if; 	
	
    return v_result;
END IF;  

END;
 
$function$;
;