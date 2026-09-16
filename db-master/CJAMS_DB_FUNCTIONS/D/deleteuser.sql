drop function if exists cjams.deleteuser(v_email character varying);
CREATE OR REPLACE FUNCTION cjams.deleteuser(v_email character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
	declare v_teamid uuid ;
	v_teammemberid uuid ;
    v_securityusersid  uuid ;
    v_muser_id number;
	v_message character varying;
	 
	 
	BEGIN
	v_message:= 'Success';
    select securityusersid into v_securityusersid from userprofile where email=v_email;
    Select teammemberid into v_teammemberid from teammemberassignment where securityusersid::uuid=v_securityusersid::uuid;
    v_message:= v_message || 'v_teammemberid ' || v_teammemberid;
	Select teamid into v_teamid from teammember where teammemberid::uuid=v_teammemberid::uuid;
    v_message:= v_message || 'v_teamid ' || v_teamid;
    Select id into v_muser_id from muser where securityusersid::uuid=v_securityusersid::uuid;
    v_message:= v_message || 'v_muser_id ' || v_muser_id;
   
    delete from userresource where userid=v_muser_id;
    v_message:= v_message || 'userresource Deleted  ';
   
     
    delete from teammemberassignment where securityusersid::uuid=v_securityusersid::uuid;
    v_message:= v_message || 'teammemberassignment Deleted  ';
   
   
    delete from teammember where teammemberid::uuid=v_teammemberid::uuid;
     v_message:= v_message || 'teammember Deleted  ';
    delete from team where teamid::uuid = v_teamid::uuid;
     v_message:= v_message || 'team Deleted  ';
   

    delete from rolemapping where principalid = v_muser_id;
    v_message:= v_message || 'rolemapping Deleted  ';
     
    delete from userprofileaddress where securityusersid::uuid=v_securityusersid::uuid;
    v_message:= v_message || 'userprofileaddress Deleted  ';
    delete from userprofilephonenumber where securityusersid::uuid=v_securityusersid::uuid;
    v_message:= v_message || 'userprofilephonenumber Deleted  ';
    delete from muser where securityusersid::uuid=v_securityusersid::uuid;
    v_message:= v_message || 'userprofilephonenumber Deleted  ';
    delete from securityusers where securityusersid::uuid=v_securityusersid::uuid;
    v_message:= v_message || 'securityusers Deleted  ';
    delete from userreference where securityusersid::uuid=v_securityusersid::uuid;
    v_message:= v_message || 'userreference Deleted  ';
	delete from userprofile where securityusersid::uuid=v_securityusersid::uuid;
    v_message:= v_message || 'userprofile Deleted  ';

    

    return v_message;
END  
$function$
;