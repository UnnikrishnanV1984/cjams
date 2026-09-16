drop FUNCTION if exists cjams.getusercounty(v_servicecasenumber bigint);
drop function if exists cjams.getusercounty(v_objecttype character varying, v_objectid bigint);

-- CREATE OR REPLACE FUNCTION cjams.getusercounty(v_objecttype character varying, v_objectid bigint)
--  RETURNS TABLE(countyid uuid, countyname character varying, state character varying, regionid uuid, statecountycode character varying, caseassignmentid uuid, fromworkeridno character varying, toworkeridno character varying, 
--         objectid uuid, objecttypekey character varying )
--  LANGUAGE plpgsql
-- AS $function$

-- begin
	
-- 	if(lower(v_objecttype) = 'servicecase') then
-- 		raise notice 'test';
-- 		RETURN  QUERY 
-- 		select c.countyid , c.countyname, c.state, c.regionid, c.statecountycode, 
-- 			ca.caseassignmentid, ca.fromworkeridno, ca.toworkeridno, ca.objectid , ca.objecttypekey
-- 		from caseassignment ca  
-- 		join county c on c.countyid:: character varying = ca.toldssid::character varying
-- 		join servicecase s on ca.objectid = s.servicecaseid
-- 		where s.servicecasenumber = v_objectid and lower(ca.responsibilitytypekey) = 'family' and ca.activeflag = 1
-- 		order by ca.insertedon desc
-- 		limit 1;
-- 	end if;

-- 	if (lower(v_objecttype) = 'adoption') then
-- 		raise notice 'adoption';
	
-- 		RETURN  QUERY 
-- 		select c.countyid , c.countyname, c.state, c.regionid, c.statecountycode, 
-- 			ca.caseassignmentid, ca.fromworkeridno, ca.toworkeridno, ca.objectid , ca.objecttypekey
-- 		from caseassignment ca  
-- 		join county c on c.countyid:: character varying = ca.toldssid::character varying
-- 		join adoptioncase a on ca.objectid = a.adoptioncaseid 
-- 		where a.adoptioncasenumber = v_objectid and lower(ca.responsibilitytypekey) = 'family' and ca.activeflag = 1
-- 		order by ca.insertedon desc
-- 		limit 1;
-- 	end if;
-- END;

-- $function$
-- ;