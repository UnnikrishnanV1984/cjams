DROP FUNCTION IF EXISTS cjams.addpgresourcebyresource(character varying, json); 
CREATE OR REPLACE FUNCTION cjams.addpgresourcebyresource(v_pgname character varying, v_resources json)                                                                                           
  RETURNS text
  LANGUAGE plpgsql                                                                                                                                                         
AS $function$                                                                                                                                                             
                                                                                                                                                                           
 declare 
 v_permissiongroupid uuid; 
 v_rec json;
 v_resourceid uuid;

 BEGIN   

     select p.permissiongroupid into v_permissiongroupid from permissiongroup p where p.permissiongroupname = v_pgname::varchar; 

     for v_rec in select * from json_array_elements(v_resources)
     loop
          
          RAISE NOTICE 'v_rec%',v_rec;

          select r.id into v_resourceid from cjams.resource r where r.resourcename = v_rec ->> 'resourcename' and r.resourceid = v_rec ->> 'resourceid';

          RAISE NOTICE 'v_resourceid%',v_resourceid;

          INSERT INTO cjams.pgresource
          (permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled)
          VALUES(v_permissiongroupid, v_resourceid, 1, 'RBAC', now(), 'RBAC', now(), (v_rec ->> 'isallowed')::boolean, (v_rec ->> 'isvisible')::boolean, (v_rec ->> 'isenabled')::boolean);
          
          RAISE NOTICE 'pgresource inserted for %',v_resourceid;
     
      END LOOP;  

return 'Success';                                                                                                                   
                                                                                                                                                                        
end;                                                                                                                                                                    
                                                                                                                                                                           
$function$;                                                                                                                                                                

--  select p2.permissiongroupname, p2.permissiongroupid,
-- (select json_agg(e) from (select resource.resourceid , resource.resourcename, pgresource .isallowed , pgresource .isenabled , pgresource.isvisible from pgresource join resource on pgresource.resourceid = resource.id where pgresource.permissiongroupid = p2.permissiongroupid and pgresource .activeflag = 1 and resource.activeflag = 1)e)
--  from permissiongroup p2 
--  where p2.permissiongroupname = 'Client Demographic search - PGRead';
