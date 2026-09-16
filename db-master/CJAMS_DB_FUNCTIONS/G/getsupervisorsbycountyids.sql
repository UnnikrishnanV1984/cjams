CREATE OR REPLACE FUNCTION cjams.getsupervisorsbycountyids(v_countyid uuid[])
RETURNS json
LANGUAGE plpgsql
AS $function$   

------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vigneshwar Kumar
-- Date Created : 06/28/2022 
-- Revision(s)
------------------------------------------------------------------------     
DECLARE   
l_users json;

BEGIN     
	 
	select json_agg(e) 
		into l_users
	from (	
			select mu.securityusersid,
				up.firstname,
				up.lastname,
				up.fullname,
				c.countyname,
				mu.email,
				r.roletypekey				
			from team t 
				join teammember tm on tm.teamid = t.teamid 
					and tm.activeflag = 1 
				join teammemberassignment tma on tma.teammemberid = tm.teammemberid 
					and tma.activeflag = 1
				join muser mu on mu.securityusersid = tma.securityusersid 
					and mu.activeflag = 1 
				join rolemapping rm on rm.principalid::int = mu.id 
					and rm.activeflag = 1 
				join role r on r.id = rm.roleid::int 
				join userprofile up on up.securityusersid = mu.securityusersid 
					and up.activeflag = 1
				join county c on c.countyid = t.countyid::uuid
					and c.activeflag = 1
			where t.countyid::uuid = any ($1)
				and r.roletypekey in ('CWSP', 'CWCW')		
		)e ;
	 
		RETURN l_users;
END;

$function$
;