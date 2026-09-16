-- FUNCTION: cjams.submitvendorapproval(json)

DROP FUNCTION IF EXISTS cjams.submitvendorapproval(json);
CREATE OR REPLACE FUNCTION cjams.submitvendorapproval(
	searchobj json)
    RETURNS character varying
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$

DECLARE 

  v_timestamp timestamp;
  v_returnstatus character varying;
  v_routingstatus character varying;
  v_vendorid character varying;
  v_securityuserid character varying;
 v_vendorapplicantid uuid;
  v_teamid uuid;
  v_roletypekey character varying;
  v_routingstatustypekey character varying;
  v_sourcerolekey character varying;
  v_targetrolekey character varying;
  v_fromteamtypekey character varying;
  v_toteamtypekey character varying;
  v_isotheragency int;
 v_routing_rec record;  
  v_routingid uuid;
  v_msg character varying;
  v_username character varying;
 v_addupdatepaymentinfo character varying; 
 v_tosecurityuserid character varying;
 v_jursidiction character varying;
  -- v_juri record;

BEGIN 
v_vendorapplicantid := searchobj ->> 'vendorapplicantid';
v_vendorid := searchobj ->> 'vendorid';
v_securityuserid := searchobj ->> 'securityuserid';
v_jursidiction := searchobj ->> 'jurisdiction';
v_tosecurityuserid := searchobj ->> 'tosecurityuserid';
v_timestamp := now()::timestamp with time zone;


raise notice 'v_vendorapplicantid%',v_vendorapplicantid;
IF (v_vendorapplicantid is not null) then 
select addupdatepaymentinfo into v_addupdatepaymentinfo from addupdatepaymentinfo(searchobj);
update tb_vendor_applicant set status='Submitted for Approval' where vendorapplicantid=(v_vendorapplicantid)::uuid;
 SELECT tm.teamid,  tm.roletypekey  into v_teamid,v_roletypekey
			FROM    teammemberassignment tma 
			INNER JOIN  teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
			WHERE  tma.SecurityUsersId = v_securityuserid AND   tma.activeflag =1;
SELECT routingstatustypekey,sourcerolekey,targetrolekey,
							 ftmrt.teamtypekey , ttmrt.teamtypekey  ,
                             CASE ftmrt.teamtypekey WHEN ttmrt.teamtypekey THEN 0 ELSE 1 END isotheragency
							 into v_routingstatustypekey, v_sourcerolekey,v_targetrolekey,v_fromteamtypekey,v_toteamtypekey,v_isotheragency
                             FROM routingconfig  rc
                    		 INNER JOIN teammemberroletype ftmrt   on  ftmrt.roletypekey  = rc.sourcerolekey AND ftmrt.activeflag =1
                    		 INNER JOIN teammemberroletype ttmrt   on  ttmrt.roletypekey  = rc.targetrolekey AND ttmrt.activeflag =1
					 		 WHERE  eventcode = 'VNDR' AND  sourcerolekey =v_roletypekey  
                             AND rc.activeflag =1;
							 
							 SELECT  COALESCE(up.lastname,'') || ',' || COALESCE(up.firstname,'')  
			    INTO  v_username
			    FROM userprofile up 
				WHERE up.securityusersid = v_securityuserid;      
	
	/*select tma.securityusersid,COALESCE(up.firstname,'') || ' ' || COALESCE(up.lastname,'')   from userprofile up 
							inner join teammemberassignment tma on tma.securityusersid = up.securityusersid
							inner join teammember tm on tm.teammemberid=tma.teammemberid
							inner join routingconfig rc on rc.targetrolekey=tm.roletypekey and rc.activeflag=1 
							and rc.sourcerolekey=v_sourcerolekey and rc.targetrolekey=v_targetrolekey
							where rc.eventcode='VNDR' and tm.teamid=v_teamid and tma.activeflag=1 
							and tm.isdefaultroute=1 and unavailableflag=false order by up.insertedon limit 1*/
				
				
				  SELECT routingid into v_routingid
			            FROM routing r WHERE tosecurityusersid = v_tosecurityuserid
			            AND activeflag =1
			            AND r.objectid  = v_vendorid
			            ORDER BY insertedon desc limit 1;
						
						UPDATE routing SET activeflag =0 ,remarks ='Vendor application submitted',updatedon= v_timestamp 
						WHERE routingid = v_routingid;  
						
						  INSERT INTO routing(
									eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
									FROMroleid, toroleid,objectid , routingstatustypeid,
									insertedby,  updatedby,insertedon,updatedon,  
									servicerequestnumber,routeddescription)
		
						VALUES( 'VNDR', v_securityuserid,
								v_tosecurityuserid   , v_teamid,
								v_sourcerolekey, v_targetrolekey,
								v_vendorid,15,
								v_securityuserid,v_securityuserid,
								v_timestamp,v_timestamp, null,'Vendor application submitted');
							 v_msg := 'New vendor request #'|| v_vendorid ||' Submitted for Approval by ' || v_username;
							
		/*for v_juri in	select tma.securityusersid from team  t
                 inner join teammember tm on tm.teamid=t.teamid and tm.activeflag=1
                 inner join teammemberassignment tma on tma.teammemberid= tm.teammemberid and tma.activeflag=1
                where countyid=v_jursidiction and teamtypekey='FNS' and tm.roletypekey='FNSFS' and t.activeflag=1*/
                
                --loop
							
			SELECT send_notIFication INTO v_returnstatus FROM send_notIFication(v_tosecurityuserid
		                                                                      ,v_securityuserid, v_tosecurityuserid,
						'System', 'High', v_msg,
						 v_msg , v_vendorid);
			


v_returnstatus:='success';

else


v_returnstatus:='Failure';
end if;
	

return v_returnstatus;

END;

$BODY$;

ALTER FUNCTION cjams.submitvendorapproval(json)
    OWNER TO welfareadmin;
	
	