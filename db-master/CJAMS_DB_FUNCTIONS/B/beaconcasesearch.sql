--------------------------------------------------------------------------------------------------
-- 04/10/2025 prasanna sai kommineni - CIDM-9736 BEACON Interface

-----------------------------------------------------------------------------------------------------
DROP FUNCTION IF EXISTS cjams.beaconcasesearch(casenumber character varying);
CREATE OR REPLACE FUNCTION cjams.beaconcasesearch(casenumber character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$

DECLARE 
result json;
v_casenumber character varying;
v_result json;

BEGIN

v_casenumber:=casenumber;

select json_agg(a) INTO  v_result from(
select p.personid,p.firstname,p.middlename,p.lastname,p.cjamspid,p.dob,p.gendertypekey,p.ssnno,
sc.servicecaseid as caseobjectid,'servicecase' as caseobjecttype, sc.servicecasenumber as casenumber
from servicecase sc 
left join intakeservicerequestactor isa on isa.servicecaseid=sc.servicecaseid and isa.activeflag=1
 left join person p on  p.personid = isa.personid  and p.activeflag=1 
where sc.servicecasenumber=v_casenumber  AND COALESCE(p.ssnno, '') != '' group by p.personid ,sc.servicecaseid
union all
select p.personid,p.firstname,p.middlename,p.lastname,p.cjamspid,p.dob,p.gendertypekey,p.ssnno,
isr.intakeserviceid as caseobjectid,'servicerequest' as caseobjecttype, isr.servicerequestnumber as casenumber
from intakeservicerequest isr 
left join intakeservicerequestactor isa on isa.intakeserviceid=isr.intakeserviceid and isa.activeflag=1
 left join person p on  p.personid = isa.personid  and p.activeflag=1 
where isr.servicerequestnumber=v_casenumber AND COALESCE(p.ssnno, '') != '' group by p.personid ,isr.intakeserviceid
union all
select p.personid,p.firstname,p.middlename,p.lastname,p.cjamspid,p.dob,p.gendertypekey,p.ssnno,
ac.adoptioncaseid as caseobjectid,'adoptioncase' as caseobjecttype, ac.adoptioncasenumber as casenumber
from adoptioncase ac
 left join adoptioncaseactor aca on aca.adoptioncaseid=ac.adoptioncaseid  and aca.activeflag =1 
  left join person p on  p.personid = aca.personid and p.activeflag=1 
where ac.adoptioncasenumber=v_casenumber AND COALESCE(p.ssnno, '') != '' group by p.personid ,ac.adoptioncaseid )a;

RETURN v_result;
END;

$function$
;