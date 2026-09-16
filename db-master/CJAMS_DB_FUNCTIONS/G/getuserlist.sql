DROP FUNCTION IF EXISTS cjams.getuserlist(page integer, size integer, searchcol character varying, searchval character varying, sortcol character varying, sortby character varying);


CREATE OR REPLACE FUNCTION cjams.getuserlist(page integer, size integer, searchcol character varying, searchval character varying, sortcol character varying, sortby character varying)
 RETURNS TABLE(totalcount bigint, id bigint, securityusersid character varying, email character varying, displayname character varying, userphoto text, teamname character varying, gender character varying, zipcode character varying, county character varying, phonenumber character varying, role character varying,teammemberid uuid,ssn character varying,teamid uuid,supervisorid character varying,activeflagData int4,descriptionpos text )
 LANGUAGE plpgsql
AS $function$

DECLARE searchstring character varying;
DECLARE totalcount integer;
DECLARE p_offset integer;

DECLARE limitstring character varying;
  
BEGIN    

searchstring:='';
limitstring:='';
 if(searchcol!='' and  searchval !='' and searchcol != 'activeflagData' ) then
        -- if (searchcol='role') then searchcol:= ' description '; end if;
--           if (searchcol='email') then searchcol:= ' u.email '; end if;
--           if (searchcol='displayname') then searchcol:= ' up.displayname '; end if;
--           if (searchcol='county') then searchcol:= ' upa.county '; end if;
--           if (searchcol='zipcode') then searchcol:= '  upa.intakeservicerequestplantypekey  '; end if;
--             if (searchcol='gender') then searchcol:= '  gt.typedescription  '; end if;
   searchstring:=' WHERE lower( cast('|| searchcol   || ' as character varying)) ilike ''' || lower(searchval) || '%'' '; 
 END IF;

 if(searchcol!='' and  searchval !='' and searchcol = 'activeflagData' ) then
   searchstring:=' WHERE activeflag' || ' in (' || searchval || ')'; 
 END IF;

 if(sortcol!='') then
	-- if (sortcol='role') then sortcol:= ' r.description ';
--         elseif (sortcol='email') then sortcol:= ' u.email ';
--         elseif (sortcol='displayname') then sortcol:= ' up.displayname ';
--         elseif (sortcol='county') then sortcol:= ' upa.county ';
--         elseif (sortcol='zipcode') then sortcol:= '  upa.intakeservicerequestplantypekey  '; 
--         end if;
 else
	sortcol:= ' displayname ';
	sortby:= ' asc ';
 end if;

 IF size > 0  Then
	p_offset:= (page - 1) * size;
	limitstring:= ' LIMIT ' || size ||'  OFFSET ' || p_offset;
 ELSE
	limitstring:= '';
 END IF;
 
 --RAISE NOTICE 'order_by % ', searchstring;
    
    RETURN QUERY 

 execute 'select count(1) over(),* from
(select 
u.id, u.securityusersid, u.email--, r.description as role
, up.displayname, up.userphoto, t.teamname, gt.typedescription AS gender,
(select zipcode from userprofileaddress where securityusersid = u.securityusersid and userprofileaddresstypekey = ''P'' and activeflag = 1 limit 1),
(select county from userprofileaddress where securityusersid = u.securityusersid and userprofileaddresstypekey = ''P'' and activeflag = 1 limit 1),
(select phonenumber from userprofilephonenumber where securityusersid = u.securityusersid and userprofiletypekey = ''cell'' and activeflag = 1 limit 1),
(select r.description as role from rolemapping rm join role r on r.id = rm.roleid where principalid = cast(u.id as varchar) and rm.activeflag = 1 and r.activeflag = 1 order by r.id desc limit 1),tm.teammemberid,up.ssn,t.teamid,up.supervisorid,up.activeflag,tm.description as descriptionpos
from muser u 
join userprofile up on up.securityusersid = u.securityusersid
LEFT JOIN gendertype gt ON gt.gendertypekey = up.gendertypekey AND gt.activeflag =1
LEFT JOIN teammemberassignment tma ON tma.securityusersid = up.securityusersid AND tma.activeflag =1
LEFT JOIN teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
LEFT JOIN team t ON t.teamid = tm.teamid AND t.activeflag =1

) as a
' || searchstring || '
ORDER BY  ' || sortcol || ' ' ||  sortby ||' ' || limitstring;



END;

$function$
;
