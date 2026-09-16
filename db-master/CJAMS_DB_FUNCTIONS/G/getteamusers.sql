 DROP FUNCTION IF EXISTS cjams.getteamusers(uuid, character varying, character varying);
 DROP FUNCTION IF EXISTS cjams.getteamusers(uuid, character varying, character varying, boolean);

CREATE OR REPLACE FUNCTION cjams.getteamusers(v_teamid uuid, securityusersid character varying, filtertypekey character varying, v_inactivelist boolean default false, v_inactiveuseractivecaselist boolean default false)
 RETURNS TABLE(userid character varying, teamname character varying, workloads integer, username character varying, agencykey character varying, email character varying, permissiongroupname character varying, userrole character varying, loadnumber character varying, available character varying, issupervisor boolean, homelocationcode character varying, worklocationcode character varying, juridiction character varying, cjamspid bigint, totalcases bigint, rolecode character varying)
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 01/17/2023 Veera/Umasankar - Modified Proc for FTDM User story -- CIDM-5888
-- 01/10/2024 Palani/Manasa - Modified Proc for Query Optimization -- CIDM-8304
------------------------------------------------------------------------------------------------------------



declare v_parentteamid uuid = null;
declare v_teamtypekey character varying ='';
declare v_securityuserid character varying ='';
declare v_teamname character varying = '';
declare v_countyid  uuid = null;
BEGIN

		v_securityuserid := securityusersid;
	


	if (filtertypekey = 'worker') then
       
	 
       	SELECT  tm.teamid ,t.teamtypekey,t.parentteamid  into v_teamid,v_teamtypekey,v_parentteamid
        FROM    teammemberassignment tma 
        INNER JOIN  teammember tm 
            ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
        inner join team t on t.teamid = tm.teamid  and t.activeflag =1
        WHERE  t.teamid =v_teamid
		-- tma.SecurityUsersId = v_securityuserid
        AND   tma.activeflag =1 limit 1;
       
       RETURN Query
        Select tm.securityusersid,t.teamname, cast (coalesce(rt.workload,0) as int),
        cast(up.firstname || ' ' || up.lastname as character varying) username ,tm.agency,up.email, null ::character varying , 
        cast(tm.rolename as character varying),tm.loadnumber,
        cast(case coalesce(up.unavailableflag,false) when true then 'No' else 'Yes' end  as character varying)  useravailable
        ,supervisor,tm.zipcode,tm.zipcodeplus,tm.juridiction,up.cjamspid,  cast(coalesce(cc.casecount,0) as bigint),
        r.roletypecode
        from 
        (SELECT distinct  tma.securityusersid,tma.teammemberid,tm.roletypekey ,
         cast(tty.teamtypekey as character varying) agency
        ,tm.teamid, tm.loadnumber,replace(tmrt.description ,','||tmrt.teamtypekey,'') rolename,
        coalesce(tmrt.isupervisor,false)supervisor , upa.zipcode,upa.zipcodeplus,upa.county as juridiction
        FROM teammemberassignment tma
        INNER join teammember tm
        	ON tm.teammemberid = tma.teammemberid  AND tm.activeflag= 1
        INNER join team t on t.teamid = tm.teamid and t.activeflag =1 
        INNER join teammemberroletype  tmrt 
       		 ON tmrt.roletypekey = tm.roletypekey  AND tmrt.activeflag= 1
        left join teamtype tty on tty.teamtypekey = tmrt.teamtypekey 
       		 AND tty.activeflag= 1
        LEFT JOIN UserProfileAddress upa
         	ON upa.securityusersid = tma.securityusersid  AND upa.activeflag= 1
       -- INNER join routingcONfig rc    	ON rc.targetrolekey  = tm.roletypekey   AND rc.activeflag= 1
        WHERE v_teamid  in ( tm.teamid   , t.parentteamid) 
        AND tma.activeflag =1  
       )  tm
        inner join  userprofile up 
            ON up.securityusersid = tm.securityusersid AND (up.activeflag= 1 or v_inactivelist is true
            or (v_inactiveuseractivecaselist is true and up.activeflag = 0 and (select count(1) > 0 from caseassignment ca where ca.toworkeridno = up.securityusersid and ca.activeflag = 1
            and (ca.enddate is null or ca.enddate >= now()))))
        inner join team t on t.teamid = tm.teamid and t.activeflag= 1
        LEFT JOIN (
            	select routedusersid,count(1) casecount 
            	from intakeservicerequest
                 where isrouted =true
                  and activeflag=1
                 and routedusersid in (select t2.securityusersid from teammemberassignment t2 inner join teammember t3 on t2.teammemberid=t3.teammemberid
                 where teamid =v_teamid )
                 group by routedusersid) CC
                on cc.routedusersid = up.securityusersid
        left join (SELECT uwc.securityusersid, uwc.workload FROM cjams.getuserworkloadcount() uwc) rt on 
             rt.securityusersid = tm.securityusersid 
        left join( select distinct  r.roletypekey , rt.roletypecode from role r inner join roletype rt on 
                 rt.shortname = r.name and rt.activeflag =1 and r.activeflag =1) r on
                 r.roletypekey = tm.roletypekey
		--WHERE  up.securityusersid NOT IN (v_securityuserid)
        order by  username asc , coalesce(rt.workload,0) ;   
    
   ELSEIF (filtertypekey = 'ldss') then
   
      SELECT   t.parentteamid  into  v_parentteamid
        FROM    teammemberassignment tma 
            INNER JOIN  teammember tm  ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
            INNER JOIN team t on t.teamid = tm.teamid  and t.activeflag =1
        WHERE  t.teamid = v_teamid
        AND   t.activeflag =1;
        
       	SELECT   t.teamtypekey into v_teamtypekey
        FROM    teammemberassignment tma 
            INNER JOIN  teammember tm   ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
            INNER JOIN team t on t.teamid = tm.teamid  and t.activeflag =1
        WHERE  tma.SecurityUsersId = v_securityuserid
        AND   tma.activeflag =1;
	RETURN Query
	
        Select tm.securityusersid,t.teamname, cast (coalesce(rt.workload,0) as int),
       cast(up.firstname || ' ' || up.lastname||
        coalesce((select ' ('|| countyname || ')'  from county c where c.countyid  = t.countyid::uuid   and c.activeflag = 1 limit 1),''
		 )as character varying) username ,tm.agency,up.email, null::character varying,
        cast(tm.rolename as character varying),tm.loadnumber,
        cast(case coalesce(up.unavailableflag,false) when true then 'No' else 'Yes' end  as character varying)  useravailable
        ,supervisor,tm.zipcode,tm.zipcodeplus,tm.juridiction,up.cjamspid,  cast(coalesce(cc.casecount,0) as bigint),
        r.roletypecode
        from 
        (SELECT distinct  tma.securityusersid,tma.teammemberid,tm.roletypekey ,
         cast(tty.teamtypekey as character varying) agency
        ,tm.teamid, tm.loadnumber,replace(tmrt.description ,','||tmrt.teamtypekey,'') rolename,
        coalesce(tmrt.isupervisor,false)supervisor , upa.zipcode,upa.zipcodeplus,upa.county as juridiction
        FROM teammemberassignment tma
        INNER join teammember tm      	ON tm.teammemberid = tma.teammemberid  AND tm.activeflag= 1
        INNER join team t on t.teamid = tm.teamid and t.activeflag =1 
        INNER join teammemberroletype  tmrt 	 ON tmrt.roletypekey = tm.roletypekey  AND tmrt.activeflag= 1 and CASE WHEN filtertypekey ='ldss' THEN tmrt.isupervisor = true ELSE true END
        INNER join teamtype tty on tty.teamtypekey = tmrt.teamtypekey AND tty.activeflag= 1 --and tty.teamtypekey IN ('LDSS',v_teamtypekey) 
        LEFT JOIN UserProfileAddress upa 	ON upa.securityusersid = tma.securityusersid  AND upa.activeflag= 1
        INNER join routingcONfig rc   	ON rc.targetrolekey  = tm.roletypekey   AND rc.activeflag= 1
        WHERE t.countyid::uuid = v_teamid  ---v_teamid  IN ( tm.teamid   , t.parentteamid) 
        AND tma.activeflag =1  )  tm
        inner join  userprofile up     ON up.securityusersid = tm.securityusersid AND up.activeflag= 1
        inner join team t on t.teamid = tm.teamid and t.activeflag= 1
        LEFT JOIN (
            select routedusersid,count(1) casecount
            from intakeservicerequest
                 where isrouted =true
                  and activeflag=1
                 and routedusersid in (select t2.securityusersid from teammemberassignment t2 inner join teammember t3 on t2.teammemberid=t3.teammemberid
                 where teamid =v_teamid )
                 group by routedusersid) CC
                on cc.routedusersid = up.securityusersid
        left join (SELECT uwc.securityusersid, uwc.workload FROM cjams.getuserworkloadcount() uwc) rt on 
             rt.securityusersid = tm.securityusersid 
        left join( select distinct  r.roletypekey , rt.roletypecode from role r inner join roletype rt on 
                 rt.shortname = r.name and rt.activeflag =1 and r.activeflag =1) r on
                 r.roletypekey = tm.roletypekey
		WHERE  up.securityusersid NOT IN (v_securityuserid)				 
        order by  username asc , coalesce(rt.workload,0)  ;  
       
   
   ELSEIF (filtertypekey ='ftdm') then 
    
         SELECT  t.teamtypekey,t.parentteamid, t.teamname  into v_teamtypekey,v_parentteamid , v_teamname
        FROM    team t 
        WHERE  t.teamid = v_teamid
        AND   t.activeflag =1;

        select countyid::uuid into v_countyid from team where teamid =v_teamid;

        raise notice ' v_teamname THEN >>>>>>> %',v_teamname;


    if (v_teamname = 'FTDM Facilitator') then

        raise notice ' v_teamname 148 THEN >>>>>>> %',v_teamname;

           	RETURN Query

       select distinct vus.securityusersid , v_teamname, cast (coalesce(rt.workload,0) as int),cast(vus.firstname || ' ' || vus.lastname as character varying) username
       , 'CW':: character varying,vus.email ,  p2.permissiongroupname:: character varying, 'FTDM Facilitator':: character varying,'FTDM Facilitator':: character varying,
       vus.useravailable, false,
       upa.zipcode,upa.zipcodeplus,upa.county as juridiction,vus.cjamspid, cast(coalesce(cc.casecount,0) as bigint), null :: character varying
       from userresource u
        -- inner join muser m2 on m2.id = u.userid and m2.activeflag =1
        inner join v_userprofile vus on vus.userid =u.userid
        -- inner join userprofile vu on vu.securityusersid = vus.securityusersid
        LEFT JOIN UserProfileAddress upa
         ON upa.securityusersid = vus.securityusersid  AND upa.activeflag= 1
        inner join permissiongroup p2 on p2.permissiongroupid  = u.permissiongroupid
        left join (SELECT uwc.securityusersid, uwc.workload FROM cjams.getuserworkloadcount() uwc) rt on
             rt.securityusersid = vus.securityusersid
         LEFT JOIN (
            select routedusersid,count(1) casecount
            from intakeservicerequest
                 where isrouted =true
                  and activeflag=1
                 and routedusersid in (select t2.securityusersid from teammemberassignment t2 inner join teammember t3 on t2.teammemberid=t3.teammemberid
                 where teamid =v_teamid )
                 group by routedusersid) CC
                on cc.routedusersid = vus.securityusersid
        where  vus.securityusersid NOT IN (v_securityuserid) and u.roleid = '5987' and u.activeflag=1 and vus.countyid=v_countyid
        order by  username asc ;


    ELSEIF (v_teamname = 'Qualified Individual') then
                   raise notice ' v_teamname 149 THEN >>>>>>> %',v_teamname;

           	RETURN Query

        select distinct vus.securityusersid , v_teamname, cast (coalesce(rt.workload,0) as int),cast(vus.firstname || ' ' || vus.lastname as character varying) username
        , 'CW':: character varying,vus.email ,  p2.permissiongroupname:: character varying, 'Qualified Individual':: character varying,'Qualified Individual':: character varying,
        vus.useravailable, false,
        upa.zipcode,upa.zipcodeplus,upa.county as juridiction,vus.cjamspid, cast(coalesce(cc.casecount,0) as bigint), null :: character varying
        from userresource u
        --inner join muser m2 on m2.id = u.userid and m2.activeflag =1
        inner join v_userprofile vus on vus.userid = u.userid
        -- inner join userprofile vu on vu.securityusersid = vus.securityusersid
        LEFT JOIN UserProfileAddress upa
         ON upa.securityusersid = vus.securityusersid  AND upa.activeflag= 1
        inner join permissiongroup p2 on p2.permissiongroupid  = u.permissiongroupid
        left join (SELECT uwc.securityusersid, uwc.workload FROM cjams.getuserworkloadcount() uwc) rt on
             rt.securityusersid = vus.securityusersid
         LEFT JOIN (
            select routedusersid,count(1) casecount
            from intakeservicerequest
                 where isrouted =true
                  and activeflag=1
                 and routedusersid in (select t2.securityusersid from teammemberassignment t2 inner join teammember t3 on t2.teammemberid=t3.teammemberid
                 where teamid =v_teamid )
                 group by routedusersid) CC
                on cc.routedusersid = vus.securityusersid
        where  vus.securityusersid NOT IN (v_securityuserid) and u.roleid = '5988'  and u.activeflag=1 and vus.countyid =v_countyid
        order by  username asc ;

        
    ELSEIF (v_teamname = 'FTDM/QI Supervisor') then
                   raise notice ' v_teamname 150 THEN >>>>>>> %',v_teamname;

           	RETURN Query

        select distinct vus.securityusersid , v_teamname, cast (coalesce(rt.workload,0) as int),cast(vus.firstname || ' ' || vus.lastname as character varying) username
        , 'CW':: character varying,vus.email ,  p2.permissiongroupname:: character varying, 'FTDM/QI Supervisor':: character varying,'FTDM/QI Supervisor':: character varying,
        vus.useravailable, false,
        upa.zipcode,upa.zipcodeplus,upa.county as juridiction,vus.cjamspid, cast(coalesce(cc.casecount,0) as bigint), null :: character varying
        from userresource u
        -- inner join muser m2 on m2.id = u.userid and m2.activeflag =1        
        inner join v_userprofile vus on vus.userid = u.userid
        -- inner join userprofile vu on vu.securityusersid = vus.securityusersid
        LEFT JOIN UserProfileAddress upa
         ON upa.securityusersid = vus.securityusersid  AND upa.activeflag= 1
        inner join permissiongroup p2 on p2.permissiongroupid  = u.permissiongroupid
        left join (SELECT uwc.securityusersid, uwc.workload FROM cjams.getuserworkloadcount() uwc) rt on
             rt.securityusersid = vus.securityusersid
         LEFT JOIN (
            select routedusersid,count(1) casecount
            from intakeservicerequest
                 where isrouted =true
                  and activeflag=1
                 and routedusersid in (select t2.securityusersid from teammemberassignment t2 inner join teammember t3 on t2.teammemberid=t3.teammemberid
                 where teamid =v_teamid )
                 group by routedusersid) CC
                on cc.routedusersid = vus.securityusersid
        where  vus.securityusersid NOT IN (v_securityuserid) and u.roleid = '5989' and u.activeflag=1 and vus.countyid =v_countyid
        order by  username asc ; 

   end if;
    ELSE
             SELECT  t.teamtypekey,t.parentteamid, t.teamname, tm.loadnumber  into v_teamtypekey,v_parentteamid , v_teamname
        FROM    teammemberassignment tma 
        INNER JOIN  teammember tm 
            ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
        inner join team t on t.teamid = tm.teamid  and t.activeflag =1
        WHERE  t.teamid = v_teamid
        AND   t.activeflag =1;


	RETURN Query
	
        Select tm.securityusersid,t.teamname, cast (coalesce(rt.workload,0) as int),
        cast(up.firstname || ' ' || up.lastname as character varying) username ,tm.agency,up.email, null ::character varying,
        cast(tm.rolename as character varying),tm.loadnumber,
        cast(case coalesce(up.unavailableflag,false) when true then 'No' else 'Yes' end  as character varying)  useravailable
        ,supervisor,tm.zipcode,tm.zipcodeplus,tm.juridiction,up.cjamspid,  cast(coalesce(cc.casecount,0) as bigint),
        r.roletypecode
        from 
        (SELECT distinct  tma.securityusersid,tma.teammemberid,tm.roletypekey ,
         cast(tty.teamtypekey as character varying) agency
        ,tm.teamid, tm.loadnumber,replace(tmrt.description ,','||tmrt.teamtypekey,'') rolename,
        coalesce(tmrt.isupervisor,false)supervisor , upa.zipcode,upa.zipcodeplus,upa.county as juridiction
        FROM teammemberassignment tma
        INNER join teammember tm
        	ON tm.teammemberid = tma.teammemberid  AND tm.activeflag= 1
        INNER join team t on t.teamid = tm.teamid and t.activeflag =1 
        INNER join teammemberroletype  tmrt 
       		 ON tmrt.roletypekey = tm.roletypekey  AND tmrt.activeflag= 1 
        INNER join teamtype tty on tty.teamtypekey = tmrt.teamtypekey 
       		 AND tty.activeflag= 1 AND tty.teamtypekey = v_teamtypekey
        LEFT JOIN UserProfileAddress upa
         	ON upa.securityusersid = tma.securityusersid  AND upa.activeflag= 1
        INNER join routingcONfig rc  
        	ON rc.targetrolekey  = tm.roletypekey   AND rc.activeflag= 1
        WHERE v_teamid  in ( tm.teamid   , t.parentteamid) 
        AND tma.activeflag =1  )  tm
        inner join  userprofile up 
            ON up.securityusersid = tm.securityusersid AND up.activeflag= 1
        inner join team t on t.teamid = tm.teamid and t.activeflag= 1
        LEFT JOIN (
            	select routedusersid,count(1) casecount 
            	from intakeservicerequest
                 where isrouted =true
                 and activeflag=1
                 and routedusersid in (select t2.securityusersid from teammemberassignment t2 inner join teammember t3 on t2.teammemberid=t3.teammemberid
                 where teamid =v_teamid )
                 group by routedusersid) CC
                on cc.routedusersid = up.securityusersid 
        left join (SELECT uwc.securityusersid, uwc.workload FROM cjams.getuserworkloadcount() uwc) rt on 
             rt.securityusersid = tm.securityusersid 
        left join( select distinct  r.roletypekey , rt.roletypecode from role r inner join roletype rt on 
                 rt.shortname = r.name and rt.activeflag =1 and r.activeflag =1) r on
                 r.roletypekey = tm.roletypekey
		WHERE  up.securityusersid NOT IN (v_securityuserid)				 
        order by  username asc , coalesce(rt.workload,0)  ;  
       
       
    
    END IF;  
  end;
 


$function$
;
