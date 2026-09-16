-- 10/18/2023 prasanna sai kommineni -- CIDM-9541 B-206485 : CW-Psychotropic Medications - Secondary Review
--


DROP FUNCTION IF EXISTS cjams.getcasenumberpsychotropic(caseworkerid character varying);
CREATE OR REPLACE FUNCTION cjams.getcasenumberpsychotropic(caseworkerid character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$

DECLARE 
result json;
v_caseworkerid character varying;
v_result json;

BEGIN

v_caseworkerid:=caseworkerid;

select json_agg(a) INTO  v_result from(select max(s.servicecasenumber)  as casenumber, (p.firstname || ' ' || p.lastname) as personname, 
-- coalesce (s.servicecasenumber ,isr1.servicerequestnumber,a.adoptioncasenumber  )
          p.cjamspid ,p.dob,p.gendertypekey,p.personid,max(c.objecttypekey) as objecttypekey,c.objectid,
          (select (firstname || ' ' || lastname) from person where personid in( select personid  from  intakeservicerequestactor 
        where (servicecaseid  in (c.objectid   ) or intakeserviceid in (c.objectid   )) and  activeflag =1
         and isheadofhousehold =true and activeflag =1  order by insertedon desc limit 1) order by insertedon desc limit 1) as HOH,
        ( select ca.toldssid  from caseassignment ca  where ca.toworkeridno=v_caseworkerid 
         and lower(ca.responsibilitytypekey) = 'family' and ca.activeflag = 1 order by ca.insertedon desc limit 1) as countyid,
--         max(coalesce(co.countyname,rf.value_text)) as county ,
--			   max(pa.county) as countyid ,
         STRING_AGG(DISTINCT rfv.description, ', ') as race,
         max(rf1.description) as ethnicity
          from caseassignment c 
          left join intakeservicerequest isr on isr.servicecaseid=c.objectid and isr.activeflag=1
          left join intakeservicerequestactor isa on isa.servicecaseid in (c.objectid ,isr.servicecaseid  ) and isa.activeflag =1
--          left join intakeservicerequest isr1 on isr1.intakeserviceid=c.objectid and isr1.activeflag=1
--          left join intakeservicerequestactor isa1 on isa1.intakeserviceid in (c.objectid ,isr1.intakeserviceid  ) and isa1.activeflag =1
--          left join adoptioncase a  on a.adoptioncaseid=c.objectid and a.activeflag =1 
--          left join adoptioncaseactor aca on aca.adoptioncaseid in (c.objectid,a.adoptioncaseid)  and aca.activeflag =1
          left join servicecase s on s.servicecaseid=c.objectid and s.activeflag =1 
          LEFT JOIN person p ON (p.personid = isa.personid ) AND p.activeflag = 1
--          left join personaddress pa on pa.personid =p.personid and pa.activeflag =1
--          left join referencevalues rf on rf.ref_key::character varying =pa.county and rf.activeflag=1 and rf.referencetypeid = '306'
--           left join county co on co.countyid = p.countytypekey ::uuid and co.activeflag =1
           left join racetype rt on rt.racetypekey = p.racetypekey  and rt.activeflag =1
           left join personracetypemap  prt on prt.personid=p.personid and prt.activeflag=1
           left join referencevalues rfv on rfv.ref_key::character varying =prt.racetypekey::varchar and rfv.activeflag=1 and rfv.referencetypeid = '171'
           left join referencevalues rf1 on rf1.ref_key=p.ethnicgrouptypekey and rf1.activeflag=1 and rf1.referencetypeid = '300'
          where c.toworkeridno=v_caseworkerid and c.activeflag =1   
          AND s.servicecasenumber IS NOT NULL
          and coalesce (c.statustypekey,'') not in ('Closed') and
          c.enddate is null and
          (isa.intakeservicerequestpersontypekey in('CHILD','OTHERCHILD','AV') ) 
--          or isa1.intakeservicerequestpersontypekey in('CHILD','OTHERCHILD','AV') or  aca.actortypekey in('CHILD','OTHERCHILD','AV'))
          group by p.personid , s.servicecasenumber ,c.objectid order by personname asc)a;


RETURN v_result;
END;

$function$
;