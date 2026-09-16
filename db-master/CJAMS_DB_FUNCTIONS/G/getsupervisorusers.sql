DROP FUNCTION IF Exists getsupervisorusers(character varying);

CREATE OR REPLACE FUNCTION getsupervisorusers(v_securityusersid character varying)
 RETURNS TABLE(userid character varying, teammemberid uuid, roletypekey character varying, agency character varying, teamid uuid, loadnumber character varying, rolename text, supervisor boolean, firstname character varying, lastname character varying)
 LANGUAGE plpgsql
AS $function$


DECLARE 
        
 declare v_teamid uuid = null;
declare v_teamtypekey character varying ='';
declare v_countyid character varying='';

	
	
BEGIN 

   SELECT  tm.teamid ,t.teamtypekey,t.countyid  into v_teamid,v_teamtypekey,v_countyid
        FROM    teammemberassignment tma 
        INNER JOIN  teammember tm 
            ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
        inner join team t on t.teamid = tm.teamid  and t.activeflag =1
        WHERE  tma.SecurityUsersId = v_securityusersid
        AND   tma.activeflag =1;


return query
	
SELECT distinct  tma.securityusersid ,tma.teammemberid,tm.roletypekey ,
         cast(tty.teamtypekey as character varying) agency
        ,tm.teamid, tm.loadnumber,replace(tmrt.description ,','||tmrt.teamtypekey,'') rolename,
        coalesce(tmrt.isupervisor,false)supervisor ,up.firstname,up.lastname
         
        FROM teammemberassignment tma
        INNER join teammember tm
       		 ON tm.teammemberid = tma.teammemberid  AND tm.activeflag= 1
       inner join team t on t.teamid=tm.teamid and 	t.activeflag=1 	 
        INNER join teammemberroletype  tmrt 
       		 ON tmrt.roletypekey = tm.roletypekey  AND tmrt.activeflag= 1
        	 and tmrt.isupervisor   = true 
        left join teamtype tty on tty.teamtypekey = tmrt.teamtypekey 
       		 AND tty.activeflag= 1
       		 left join userprofile up on up.securityusersid=tma.securityusersid and up.activeflag=1
     
        
        WHERE tm.roletypekey ='ASSP' and t.countyid=v_countyid
        AND tma.activeflag =1;
        
  




END;

$function$

