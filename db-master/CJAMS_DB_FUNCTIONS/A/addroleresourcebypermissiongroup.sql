DROP FUNCTION IF EXISTS cjams.addroleresourcebypermissiongroup(character varying, json); 
CREATE OR REPLACE FUNCTION cjams.addroleresourcebypermissiongroup(v_rolename character varying, v_permissiongroups json)                                                                                           
  RETURNS text
  LANGUAGE plpgsql                                                                                                                                                         
AS $function$                                                                                                                                                             
                                                                                                                                                                           
 declare 
 v_roleid int; 
 v_rec text;
 v_permissiongroupid uuid;

 BEGIN   

     select id into v_roleid from role where role.name = v_rolename::varchar;   

     for v_rec in select * from json_array_elements_text(v_permissiongroups)
     loop
          
          RAISE NOTICE 'v_rec%',v_rec;

          select permissiongroup.permissiongroupid into v_permissiongroupid from cjams.permissiongroup where permissiongroup.permissiongroupname = v_rec;

          RAISE NOTICE 'v_permissiongroupid%',v_permissiongroupid;

          INSERT INTO cjams.role_resource
          (roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype)
          Values
          (v_roleid, v_permissiongroupid, 1, 'RBAC', now(), 'RBAC', now(), true, true, true, 1);
          
          RAISE NOTICE 'role_resource inserted for %',v_permissiongroupid;
     
      END LOOP;  

return 'Success';                                                                                                                   
                                                                                                                                                                        
end;                                                                                                                                                                    
                                                                                                                                                                           
$function$;                                                                                                                                                                

-- select role.name, role.id ,
-- (select json_agg(permissiongroup.permissiongroupname) from permissiongroup join role_resource on permissiongroup.permissiongroupid = role_resource.resourceid where role_resource.roleid = role.id and role_resource.activeflag = 1)
-- from "role" 
-- where role.id = 133
