DROP FUNCTION IF EXISTS cjams.getuserroles(character varying, character varying); 
CREATE OR REPLACE FUNCTION cjams.getuserroles(securityusersid character varying, v_path character varying)                                                                                          
  RETURNS TABLE(roles json, resources json)
  LANGUAGE plpgsql
  AS $function$

  declare v_securityusersid character varying;                                                                                                                                  
 BEGIN                                                                                                                                                                    
    v_securityusersid:= securityusersid;                                                                                                                                      
                                                                                                                                                                           
    Return Query  
       SELECT
            (SELECT json_agg(v)
                FROM (
                    select role.name,role.description from muser  inner join  rolemapping rm on rm.principalid::int = muser.id
                        inner join role on role.id = rm.roleid
                    where muser.securityusersid::varchar = v_securityusersid and rm.activeflag=1 and rm.teamtypekey = 'CW'
                    ) v  
            ) as roles, --Role information
            (select json_object_agg(res.resourceid, res.uservalues) from
                (select r.resourceid,
                        (SELECT row_to_json(v)
                            FROM (
                            select userresource.isallowed, userresource.isvisible,userresource.isenabled
                            ) v  
                        ) as uservalues
                from userresource
                    inner join muser on muser.id = userresource.userid and muser.activeflag = 1
                    inner join permissiongroup pg on userresource.permissiongroupid = pg.permissiongroupid and pg.activeflag = 1
                    inner join pgresource  on pg.permissiongroupid::uuid = pgresource.permissiongroupid::uuid and pgresource.activeflag = 1
                    inner join "resource" as r on r.id::uuid=pgresource.resourceid::uuid
                where muser.securityusersid = v_securityusersid and r.resourceid is not null and userresource.activeflag = 1--User exception is giving permissiongroup directly to user
                      AND case when v_path is not null then r.resourceid like '%' || v_path || '%' else true end
                union all --Role with permision group and resources                                                                                                                                        
                select r.resourceid,
                        (SELECT row_to_json(v)
                            FROM (
                            select pgresource.isallowed, pgresource.isvisible,pgresource.isenabled
                            ) v  
                        )
                from muser
                    inner join  rolemapping rm on rm.principalid::int = muser.id and rm.activeflag=1 and rm.teamtypekey = 'CW'
                    inner join role_resource on  role_resource.roleid = rm.roleid and role_resource.activeflag = 1
                    inner join permissiongroup pg on role_resource.resourceid = pg.permissiongroupid and pg.activeflag = 1
                    inner join pgresource  on pg.permissiongroupid::uuid = pgresource.permissiongroupid::uuid and pgresource.activeflag = 1
                    inner join "resource" as r on r.id::uuid=pgresource.resourceid::uuid
                where muser.securityusersid = v_securityusersid and r.resourceid is not null
                      AND case when v_path is not null then r.resourceid like '%' || v_path || '%' else true end
                union all --resource directly to Role                                                                                                                                        
                select r.resourceid,
                        (SELECT row_to_json(v)
                            FROM (
                            select role_resource.isallowed, role_resource.isvisible,role_resource.isenabled
                            ) v  
                        )
           from muser
               inner join  rolemapping rm on rm.principalid::int = muser.id and rm.activeflag=1 and rm.teamtypekey = 'CW'
               inner join role_resource on  role_resource.roleid = rm.roleid and role_resource.activeflag = 1
               inner join "resource" as r on r.id::uuid=role_resource.resourceid::uuid
           where muser.securityusersid = v_securityusersid and r.resourceid is not null
                    AND case when v_path is not null then r.resourceid like '%' || v_path || '%' else true end
                union all --Resources directly to User
                select r.resourceid,
                        (SELECT row_to_json(v)
                            FROM (
                            select userresource.isallowed, userresource.isvisible,userresource.isenabled
                            ) v  
                        )
                from userresource
                    inner join muser on muser.id = userresource.userid
                    inner join "resource" as r on r.id::uuid=userresource.resourceid::uuid
                where muser.securityusersid = v_securityusersid and r.resourceid is not null and userresource.activeflag = 1
                     AND case when v_path is not null then r.resourceid like '%' || v_path || '%' else true end    
                ) as res
            ) as resources
        ;                                                                                                                                              
                                                                                                                                   
                                                                                                                                                                           
                                                                                                                                                                           
end;                                                                                                                                                                    
                                                                                                                                                                           
$function$;

