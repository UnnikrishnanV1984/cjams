Drop function if exists cjams.placementrevisionupdatenew(character varying, timestamp without time zone, character varying, character varying, character varying, timestamp without time zone, character varying, character varying, character varying, character varying, integer, character varying, timestamp without time zone, character varying);
Drop function if exists cjams.placementrevisionupdatenew(character varying,  timestamp without time zone, character varying, character varying, character varying, timestamp without time zone,  character varying, character varying,  character varying,  character varying, integer, character varying, timestamp without time zone, character varying , character varying , character varying , character varying);
Drop function if exists cjams.placementrevisionupdatenew(character varying,  timestamp without time zone, character varying, character varying, character varying, timestamp without time zone,  character varying, character varying,  character varying,  character varying, integer, character varying, timestamp without time zone, character varying , boolean , boolean , character varying);
Drop function if exists cjams.placementrevisionupdatenew(character varying, timestamp without time zone, character varying,  character varying,  character varying, timestamp without time zone, character varying,  character varying,  character varying,  character varying, integer,character varying, timestamp without time zone,  character varying , boolean, boolean, character varying,boolean);
CREATE OR REPLACE FUNCTION cjams.placementrevisionupdatenew(v_placementid character varying, v_startdate timestamp without time zone, v_starttime character varying, v_voidreasontypekey character varying, v_voidremarks character varying, v_enddate timestamp without time zone, v_endtime character varying, v_exittypekey character varying, v_remarks character varying, v_exitreasontypekey character varying, v_isvoid integer, securityuserid character varying, v_voiddate timestamp without time zone, v_leastrestrictiveplacement character varying DEFAULT NULL::character varying, v_placementluggage boolean DEFAULT NULL::boolean, v_plluggagepurchased boolean DEFAULT NULL::boolean, v_plluggagecomments character varying DEFAULT NULL::character varying,v_placementdisposableortrashbag boolean DEFAULT NULL::boolean,v_exitluggage boolean DEFAULT NULL::boolean , v_exitluggageprovided boolean DEFAULT NULL::boolean, v_exitluggagecomments character varying DEFAULT NULL::character ,v_exitdisposableortrashbag boolean DEFAULT NULL::boolean)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 08/08/2022 Pratap - Modifications to capture Least Restrictive Placement for the child information (B-126654)
-- 08/02/2023 Vineet Tirodkar - Modifications to update status as 'Review' (CDM-32894)
-- 03/29/2024 --To bring back the 14 parameter SP for Provider Placement Vacancy update issue - (CIDM-8560)
-- 07/18/2024 Smitha Somasekharan - Modifications for luggage indicator n placement userstory -(CIDM-9031-B-195080)
--01/06/2025 Smitha Somasekharan -Modifications for luggage question update userstory- (CIDM-10008-b-210234)
--2/26/2025 Smitha Somasekharan -Modifications for luggage question update userstory- (CIDM-10220-b-214910)
------------------------------------------------------------------------------------------------------------	

DECLARE
 
v_intakeservicerequestactorid uuid;
v_entryddate timestamp without time zone;
v_exitdate timestamp without time zone;
v_intakeservreqchildremovalid uuid;
v_servicecaseid uuid;
v_tbplacementid int;
v_providerid int;
v_placement_structureid int;
v_rate_structureid int;
v_clientid bigint;
v_caseid character varying;
v_removalid bigint;
v_contract_program_id bigint;
v_isapproval int;
v_isapprovaldate timestamp without time zone;
v_placement_revision_id uuid;
v_placementid_placementrevision_id uuid;
v_isvoided  int;
l_response   character varying;
l_personid uuid;
v_count int;
l_assignedto character varying;
v_eventcode  character varying;
v_routingstatustypeid int;
p_startdate date;
p_starttime character varying;
BEGIN
/*Get Placement information to process financial tables */ 

	SELECT routingstatustypeid into v_count
    FROM routing WHERE  objectid=v_placementid;
   
  -- if v_count > 0  then 
	
   raise notice 'v_routingstatustypeid>>>>>>>>>>>> %',v_routingstatustypeid;
  
	 
		
			SELECT pl.alternateid, pl.intakeservicerequestactorid,
		   pl.startdatetime, pl.enddatetime,pl.intakeservreqchildremovalid,
		   pl.servicecaseid,pl.service_id ,pl.service_id,
		   pr.cjamspid ,irl.removalid,contract_id,
		   pl.isssaapproval,pl.ifcapprovaldate, sc.servicecasenumber,
           	   pl.alternateid,pl.isvoided,pr.personid,pl.insertedby,pl.startdatetime,pl.starttime
	INTO   v_tbplacementid,v_intakeservicerequestactorid,
		   v_entryddate,v_exitdate,v_intakeservreqchildremovalid, 
		   v_servicecaseid,v_placement_structureid,v_rate_structureid,
		   v_clientid,v_removalid,v_contract_program_id,
		   v_isapproval,v_isapprovaldate,v_caseid,
		   v_providerid,v_isvoided,l_personid,l_assignedto,p_startdate,p_starttime
	FROM placement pl  
	INNER JOIN servicecase sc ON sc.servicecaseid  =pl.servicecaseid AND sc.activeflag =1
	INNER JOIN  intakeservicerequestactor isra ON  pl.intakeservicerequestactorid = isra.intakeservicerequestactorid AND isra.activeflag =1
	INNER JOIN person pr ON pr.personid = isra.personid AND pr.activeflag =1
	INNER JOIN  Intakeservreqchildremoval irl ON irl.intakeservreqchildremovalid =pl.intakeservreqchildremovalid AND irl.activeflag =1
	LEFT JOIN tb_provider_contracts tbpc ON  tbpc.provider_id = pl.altproviderid AND tbpc.delete_sw ='N'
	WHERE pl.placementid::  character varying = v_placementid  AND pl.activeflag =1 LIMIT 1;

	raise notice 'v_routingstatustypeid>>>>>>>>>>>> %',v_routingstatustypeid;
	raise notice 'v_providerid>>>>>>>>>>>> %',v_providerid;
	raise notice 'v_tbplacementid>>>>>>>>>>>> %',v_tbplacementid;
	raise notice 'v_isapprovaldate>>>>>>>>>>>> %',v_isapprovaldate;
	raise notice 'v_isapproval>>>>>>>>>>>> %',v_isapproval;
 

     update  cjams.placementrevision  set activeflag=0,transactiondate = now()::date,approvaldate= now()::date,entrytime =coalesce(v_starttime,p_starttime,null),exittime= coalesce(v_endtime,null),
     exittypetypkey=null, exitreasontypkey = v_exitreasontypekey
     where placementid=v_placementid:: uuid ;
	    	
	INSERT INTO cjams.placementrevision
		( placementid, transactiondate, entrydate, entrytime, exitdate, 
		exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, 
		approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag,
		voidreasontypekey,voidremarks,exittypekey,remarks,isvoided,voiddate,requestedby,requesteddate, leastrestrictiveplacement,
		status,placementluggage,plluggagepurchased,plluggagecomments,placementdisposableortrashbag,exitluggage , exitluggageprovided, exitluggagecomments , exitdisposableortrashbag
 )
	VALUES(v_placementid:: uuid, now()::date, coalesce((v_startdate :: date),(p_startdate :: date),null), coalesce(v_starttime,p_starttime,null), (v_enddate :: date)
		, coalesce(v_endtime,null), null, v_exitreasontypekey, '', '3045', v_isapprovaldate, 1, now(),securityuserid, now(),  securityuserid, 1,
		v_voidreasontypekey , v_voidremarks , 
		v_exittypekey  ,v_remarks,v_isvoid,v_voiddate ,securityuserid,now(), v_leastrestrictiveplacement,
		'Review',v_placementluggage,v_plluggagepurchased,v_plluggagecomments,v_placementdisposableortrashbag,v_exitluggage , v_exitluggageprovided, v_exitluggagecomments ,v_exitdisposableortrashbag);


   --  END IF;
					
RETURN 'Success';
		
END;
$function$
;
