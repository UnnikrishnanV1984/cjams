-- 10/18/2023 prasanna sai kommineni -- CIDM-9541 B-206485 : CW-Psychotropic Medications - Secondary Review
-- 03/09/2026 vamshikri.byreddy - CIDM-10987 B-236421 : CW-Psychotropic Secondary all request dashboard

DROP FUNCTION IF EXISTS cjams.psychotropicscreenindashboard(securityusersid character varying, roletypekey character varying, page integer , pagelimit integer,filterdatetype character varying  );


DROP FUNCTION IF EXISTS cjams.psychotropicscreenindashboard(securityusersid character varying, roletypekey character varying,filterdatetype character varying, page integer , pagelimit integer  , v_sortcolumn character varying , v_sortorder character varying,v_searchobj json  );
DROP FUNCTION IF EXISTS cjams.psychotropicscreenindashboard(securityusersid character varying, roletypekey character varying,filterdatetype character varying, page integer , pagelimit integer  , v_sortcolumn character varying , v_sortorder character varying,v_searchobj json,othersecurityusersid character varying );
DROP FUNCTION IF EXISTS cjams.psychotropicscreenindashboard(securityusersid character varying, roletypekey character varying,filterdatetype character varying, page integer, pagelimit integer, v_sortcolumn character varying, v_sortorder character varying,v_searchobj json,othersecurityusersid character varying, tabselected character varying);


CREATE OR REPLACE FUNCTION cjams.psychotropicscreenindashboard(securityusersid character varying, roletypekey character varying,filterdatetype character varying DEFAULT null, page integer DEFAULT 1::integer, pagelimit integer DEFAULT 10::integer, v_sortcolumn character varying DEFAULT NULL::character varying, v_sortorder character varying DEFAULT NULL::character varying,v_searchobj json DEFAULT NULL::json,othersecurityusersid character varying DEFAULT NULL::character varying, tabselected character varying DEFAULT NULL::character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
--------------------------------------------------------------------------------------------------
-- 08/11/2026 Manasa Kasula - CIDM-11602 Large file upload implementation
-----------------------------------------------------------------------------------------------------

declare 
v_pageoffset  int;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
 v_pagenumber  int;        
v_UserSID character varying;
v_OtherUserSID character varying;
v_filterdatetypeforrouting INTEGER[];
v_roletypekey character varying;
v_filterdatetype character varying;
v_result json;
v_objectid character varying[];
v_medication character varying;
v_clientname character varying;
v_dateprescribed date;
v_submittedby character varying;
v_submittedon date;
v_reviewstatus character varying;
v_pharmacist character varying;
v_psychiatrist character varying;
v_reviewdate date;
v_tabselected  character varying;
v_countyid character varying;
v_teamid character varying;

begin
v_medication := v_searchObj ->> 'Medication';
v_clientname := v_searchObj ->> 'Client Name';
v_dateprescribed:= v_searchObj ->> 'Prescription Date';
v_submittedby := v_searchObj ->> 'Submitted By';
v_submittedon := v_searchObj ->> 'Submitted On';
v_reviewstatus := v_searchObj ->> 'status';
v_pharmacist := v_searchObj ->> 'PHARMACIST';
v_psychiatrist:= v_searchObj ->> 'PSYCHIATRIST';
v_reviewdate:= v_searchObj ->> 'Review Date';
	 v_pageoffset:=page;
     if(v_pageoffset is null) then
     v_pageoffset:=1;
end if; 
v_pagenumber  :=  (page-1)*10;   
v_UserSID := securityusersid;
v_OtherUserSID :=othersecurityusersid;
v_tabselected :=tabselected;
v_roletypekey := roletypekey;
 v_filterdatetype:= filterdatetype;

if(v_filterdatetype='all')then
v_filterdatetypeforrouting =array [900,901,902,903,904,905,906,907,16,908];
end if;

if(v_filterdatetype='awaiting_assignment')then
v_filterdatetypeforrouting =array [902,900];
end if;

if(v_filterdatetype='information_incomplete')then
v_filterdatetypeforrouting =ARRAY[906];
end if;
if(v_filterdatetype='pending_peer_review')then
v_filterdatetypeforrouting =array [907];
end if;
if(v_filterdatetype='pending_pharmacist_review')then
v_filterdatetypeforrouting =array [901];
end if;

if(v_filterdatetype='pending_cap_review')then
v_filterdatetypeforrouting =array [903];
end if;

if(v_filterdatetype='return_worker')then
v_filterdatetypeforrouting =ARRAY[904];
end if;

if(v_filterdatetype='approved')then
v_filterdatetypeforrouting =array [16];
end if;

if(v_filterdatetype='rejected')then
v_filterdatetypeforrouting =ARRAY[905];
end if;

if(v_filterdatetype='initial_submission')then
v_filterdatetypeforrouting =ARRAY[908];
end if;

if(v_filterdatetype='coordinator_assignment_pending')then
v_filterdatetypeforrouting =ARRAY[902];
end if;

if(v_roletypekey='CWCW' AND v_tabselected is not null) then

select json_agg(a) INTO  v_result from (select  count(1) over(),ps.*,
max(concat (p.firstname ,' ',p.middlename ,' ' ,p.lastname) ) as clientname,
max(p.dob) as dob,
max(p.gendertypekey)  as gender,
max(p.cjamspid) as cjamspid,
max(co.countyname) as county ,
STRING_AGG(DISTINCT rfv.description, ', ') as race,
max(rf1.description) as ethnicity,
(select r5.insertedon from routing r5 where routingstatustypeid=908 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1) as submittedon,
max(up.firstname || ' ' || up.lastname) as submittedby,
MAX( COALESCE(rs.typedescription, 'Draft') ) AS reviewstatus,
max(r.tosecurityusersid )as edituser,
( select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying 
AND Case when (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid in (904)  order by rc.insertedon desc limit 1) is not null 
then r2.insertedon > (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid=904  order by rc.insertedon desc limit 1) else true end
order by r2.insertedon desc limit 1  ) as pharmacist,
( select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid::character varying 
AND Case when (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid in (904)  order by rc.insertedon desc limit 1) is not null 
then r3.insertedon > (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid=904  order by rc.insertedon desc limit 1) else true end
order by r3.insertedon desc limit 1  ) as psychiatrist,
(select coalesce (s.servicecasenumber,a.adoptioncasenumber,isr.servicerequestnumber) 
from cjams.psychotropicmedications  ps1
--left join intakeservicerequest isr on isr.servicecaseid=ps1.objectid::uuid and isr.activeflag=1
left join servicecase s on s.servicecaseid=ps1.objectid::uuid and s.activeflag =1 
left join adoptioncase a  on a.adoptioncaseid=ps1.objectid::uuid and a.activeflag =1 
left join intakeservicerequest isr  on isr.intakeserviceid=ps1.objectid::uuid and isr.activeflag =1 
where ps1.objectid=ps.objectid limit 1 ) as casenumber,
(select (firstname || ' ' || lastname) from person where personid in( select personid  from  intakeservicerequestactor 
where (servicecaseid=ps.objectid::uuid or intakeserviceid=ps.objectid::uuid )  and  activeflag =1
and isheadofhousehold =true  order by insertedon desc limit 1) order by insertedon desc limit 1) as HOH,
(select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY'
AND Case when (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid=904  order by rc.insertedon desc limit 1) is not null 
then r4.insertedon > (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid in (904)  order by rc.insertedon desc limit 1) else true end
order by r4.updatedon desc limit 1) as reviewdate,
(select json_agg(docs)  from (SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title,dp.additionalobjectid, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon, 
    (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),
    dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,dp.uploadstatus, dp.finalstatus,dp.activeflag,
    (SELECT row_to_json(x) AS documentattachment FROM(                                                                               
    SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
    (select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                   
    WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
    ) x)
from documentproperties dp where dp.additionalobjectid = ps.psychotropicid ::character varying  and dp.activeflag = 1 and dp.activeflag in (1,3,4,5)
)docs) as uploadedFiles
from cjams.psychotropicmedications  ps
left join routing r on r.objectid=ps.psychotropicid ::character varying and r.activeflag=1 and r.eventcode='PSY'
left join routingstatustype rs on rs.sequencenumber =r.routingstatustypeid
left join person p on p.personid =ps.personid ::uuid
-- left join personaddress pa on pa.personid =p.personid and pa.activeflag =1
--           left join referencevalues rf on rf.ref_key::character varying =pa.county and rf.activeflag=1 and rf.referencetypeid = '306'
          left join county co on co.countyid = ps.countytypekey ::uuid and co.activeflag =1
--           left join racetype rt on rt.racetypekey = p.racetypekey  and rt.activeflag =1
           left join personracetypemap  prt on prt.personid=p.personid and prt.activeflag=1
           left join referencevalues rfv on rfv.ref_key::character varying =prt.racetypekey::varchar and rfv.activeflag=1 and rfv.referencetypeid = '171'
          left join referencevalues rf1 on rf1.ref_key=p.ethnicgrouptypekey and rf1.activeflag=1 and rf1.referencetypeid = '300'
left join userprofile up on up.securityusersid=ps.insertedby
where (ps.insertedby=v_UserSID or r.tosecurityusersid=v_UserSID) and ps.activeflag=1  AND(CASE WHEN v_filterdatetype ='all' then (r.routingstatustypeid IN (900,901,902,903,904,905,906,907,908,16) OR COALESCE(r.routingstatustypeid, 1) = 1) else ( CASE WHEN v_filterdatetype ='draft' then COALESCE(r.routingstatustypeid, 1) = 1 else (CASE WHEN v_filterdatetypeforrouting IS  NULL THEN (r.routingstatustypeid IN (904) OR COALESCE(r.routingstatustypeid, 1) = 1) ELSE r.routingstatustypeid = ANY(v_filterdatetypeforrouting) END )END ) end)
AND Case when v_medication is not null then ps.medicationname ilike '%' || v_medication  || '%'else true end
AND Case when v_clientname is not null then CONCAT(p.firstname, ' ', COALESCE(NULLIF(p.middlename, ''), ''),  p.lastname) ilike '%' || v_clientname || '%' else true end
AND Case when v_dateprescribed is not null then ps.dateprescribed=v_dateprescribed::date else true end
AND Case when v_submittedby is not null then (up.firstname || ' ' || up.lastname) ilike '%' || v_submittedby || '%' else true end
AND Case when v_submittedon is not null then (select r5.insertedon from routing r5 where routingstatustypeid=900 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1)::date=v_submittedon::date else true end
AND Case when v_reviewstatus is not null then coalesce (rs.typedescription, 'Draft') ilike '%' || v_reviewstatus || '%' else true end
AND Case when v_pharmacist is not null then (select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying order by r2.insertedon desc limit 1  ) ilike '%' || v_pharmacist || '%' else true end
AND Case when v_psychiatrist is not null then (select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid ::character varying order by r3.insertedon desc limit 1  ) ilike '%' || v_psychiatrist || '%' else true end
AND Case when v_reviewdate is not null then (select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY' order by r4.updatedon desc limit 1)::date=v_reviewdate::date else true end

 group by ps.psychotropicid order by 			( CASE v_sortorder
      WHEN 'asc'
      THEN
        CASE v_sortcolumn
        WHEN 'Medication' THEN ps.medicationname
		WHEN 'Client Name' THEN MAX(CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname))
						WHEN 'Prescription Date' THEN (ps.dateprescribed ::timestamp)::character varying
						WHEN 'Submitted By' THEN max((up.firstname || ' ' || up.lastname))
						WHEN 'Submitted On' THEN ((select r5.insertedon from routing r5 where routingstatustypeid=900 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1)  ::timestamp)::character varying
						WHEN 'status' THEN max(coalesce (rs.typedescription, 'Draft') ) :: varchar
						WHEN 'PHARMACIST' THEN (select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying order by r2.insertedon desc limit 1  )
						WHEN 'PSYCHIATRIST' THEN (select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid ::character varying order by r3.insertedon desc limit 1  )
						WHEN 'Review Date' THEN ((select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY' order by r4.updatedon desc limit 1) ::timestamp)::character varying
        END
    END) ASC NULLS last,
    ( CASE v_sortorder
      WHEN 'desc' 
      THEN
        CASE v_sortcolumn 
        WHEN 'Medication' THEN ps.medicationname
		WHEN 'Client Name' THEN MAX(
		CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname))
						WHEN 'Prescription Date' THEN (ps.dateprescribed ::timestamp)::character varying
						WHEN 'Submitted By' THEN max((up.firstname || ' ' || up.lastname))
WHEN 'Submitted On' THEN ((select r5.insertedon from routing r5 where routingstatustypeid=900 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1)  ::timestamp)::character varying			
			WHEN 'status' THEN max(coalesce (rs.typedescription, 'Draft') ) :: varchar
						WHEN 'PHARMACIST' THEN (select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying order by r2.insertedon desc limit 1  )
						WHEN 'PSYCHIATRIST' THEN (select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid ::character varying order by r3.insertedon desc limit 1  )
WHEN 'Review Date' THEN ((select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY' order by r4.updatedon desc limit 1) ::timestamp)::character varying
        END
    END) desc NULLS last,
    ( CASE coalesce(v_sortorder,'')  
   WHEN   ''
      THEN
        CASE  coalesce(v_sortcolumn,'')   when '' then
        COALESCE(max(r.updatedon), COALESCE(ps.updatedon,ps.insertedon))
        END
    END) desc NULLS last  LIMIT  pagelimit OFFSET    v_pagenumber  )a ;

end if;

if(v_roletypekey='CWCW' AND v_tabselected is null) then

SELECT array_agg(objectid)  into v_objectid FROM routing WHERE 
    ((tosecurityusersid IN (v_UserSID) AND routingstatustypeid in (900,901,902,903,904,905,906,907,908,16)) 
    OR 
    ((tosecurityusersid is null or tosecurityusersid='') AND routingstatustypeid in( 908,902) ));

SELECT t.countyid,t.teamid INTO v_countyid,v_teamid from team t
join teammember tm on tm.teamid=t.teamid and tm.activeflag=1
join teammemberassignment tma on tma.teammemberid=tm.teammemberid and tma.activeflag=1
join muser mu on mu.securityusersid = tma.securityusersid and mu.activeflag=1
where mu.securityusersid = v_UserSID;
   

select json_agg(a) INTO  v_result from (select count(1) over(),ps.*,
max(concat (p.firstname ,' ',p.middlename ,' ' ,p.lastname) ) as clientname,
max(p.dob) as dob,
max(p.gendertypekey)  as gender,
max(p.cjamspid) as cjamspid,
max(co.countyname) as county ,
STRING_AGG(DISTINCT rfv.description, ', ') as race,
max(rf1.description) as ethnicity,
(select r5.insertedon from routing r5 where routingstatustypeid=908 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1) as submittedon,
max(up.firstname || ' ' || up.lastname) as submittedby,
max(rs.typedescription) as reviewstatus,
max(r.tosecurityusersid )as edituser,
( select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying 
AND Case when (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid in (904)  order by rc.insertedon desc limit 1) is not null 
then r2.insertedon > (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid=904  order by rc.insertedon desc limit 1) else true end
order by r2.insertedon desc limit 1  ) as pharmacist,
( select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid::character varying 
AND Case when (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid in (904)  order by rc.insertedon desc limit 1) is not null 
then r3.insertedon > (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid=904  order by rc.insertedon desc limit 1) else true end
order by r3.insertedon desc limit 1  ) as psychiatrist,
(select coalesce (s.servicecasenumber,a.adoptioncasenumber,isr.servicerequestnumber) 
from cjams.psychotropicmedications  ps1
--left join intakeservicerequest isr on isr.servicecaseid=ps1.objectid::uuid and isr.activeflag=1
left join servicecase s on s.servicecaseid=ps1.objectid::uuid and s.activeflag =1 
left join adoptioncase a  on a.adoptioncaseid=ps1.objectid::uuid and a.activeflag =1 
left join intakeservicerequest isr  on isr.intakeserviceid=ps1.objectid::uuid and isr.activeflag =1 
where ps1.objectid=ps.objectid limit 1 ) as casenumber,
(select (firstname || ' ' || lastname) from person where personid in( select personid  from  intakeservicerequestactor 
where (servicecaseid=ps.objectid::uuid or intakeserviceid=ps.objectid::uuid )  and  activeflag =1
and isheadofhousehold =true  order by insertedon desc limit 1) order by insertedon desc limit 1) as HOH,
(select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY'
AND Case when (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid=904  order by rc.insertedon desc limit 1) is not null 
then r4.insertedon > (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid in (904)  order by rc.insertedon desc limit 1) else true end
order by r4.updatedon desc limit 1) as reviewdate,
(select json_agg(docs)  from (SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title,dp.additionalobjectid, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon, 
    (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),
    dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,dp.uploadstatus, dp.finalstatus,dp.activeflag,
    (SELECT row_to_json(x) AS documentattachment FROM(                                                                               
    SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
    (select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                   
    WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
    ) x)
from documentproperties dp where dp.additionalobjectid = ps.psychotropicid ::character varying and dp.activeflag in (1,3,4,5)
)docs) as uploadedFiles
from cjams.psychotropicmedications  ps
left join routing r on r.objectid=ps.psychotropicid ::character varying and r.activeflag=1 and r.eventcode='PSY'
left join routingstatustype rs on rs.sequencenumber =r.routingstatustypeid
left join person p on p.personid =ps.personid ::uuid
-- left join personaddress pa on pa.personid =p.personid and pa.activeflag =1
--           left join referencevalues rf on rf.ref_key::character varying =pa.county and rf.activeflag=1 and rf.referencetypeid = '306'
-- left join county co on co.countyid = ps.countytypekey ::uuid and co.activeflag =1
--           left join racetype rt on rt.racetypekey = p.racetypekey  and rt.activeflag =1
           left join personracetypemap  prt on prt.personid=p.personid and prt.activeflag=1
           left join referencevalues rfv on rfv.ref_key::character varying =prt.racetypekey::varchar and rfv.activeflag=1 and rfv.referencetypeid = '171'
        left join referencevalues rf1 on rf1.ref_key=p.ethnicgrouptypekey and rf1.activeflag=1 and rf1.referencetypeid = '300'
left join userprofile up on up.securityusersid=ps.insertedby 
LEFT JOIN cjams.teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
LEFT JOIN cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
LEFT JOIN cjams.team t on t.teamid = tm.teamid and t.activeflag = 1 
left join cjams.county co on co.countyid::character varying = t.countyid and co.activeflag = 1 
where r.objectid =any(v_objectid) and up.teamtypekey ='CW' AND t.countyid = v_countyid  
and t.teamid = v_teamid::uuid 
 AND ( CASE WHEN v_filterdatetypeforrouting IS  NULL THEN (r.routingstatustypeid IN (900,901,902,903,904,905,906,907,908,16) ) ELSE r.routingstatustypeid = ANY(v_filterdatetypeforrouting) END ) 
AND ( CASE WHEN v_tabselected IS  not null THEN (r.tosecurityusersid IN (v_UserSID) ) ELSE true END ) 
AND Case when v_medication is not null then ps.medicationname ilike '%' || v_medication  || '%'else true end
AND Case when v_clientname is not null then CONCAT(p.firstname, ' ', COALESCE(NULLIF(p.middlename, ''), ''), p.lastname) ilike '%' || v_clientname || '%' else true end
AND Case when v_dateprescribed is not null then ps.dateprescribed=v_dateprescribed::date else true end
AND Case when v_submittedby is not null then (up.firstname || ' ' || up.lastname) ilike '%' || v_submittedby || '%' else true end
AND Case when v_submittedon is not null then (select r5.insertedon from routing r5 where routingstatustypeid=900 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1)::date=v_submittedon::date else true end
AND Case when v_reviewstatus is not null then coalesce (rs.typedescription, 'Draft') ilike '%' || v_reviewstatus || '%' else true end
AND Case when v_pharmacist is not null then (select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying order by r2.insertedon desc limit 1  ) ilike '%' || v_pharmacist || '%' else true end
AND Case when v_psychiatrist is not null then (select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid ::character varying order by r3.insertedon desc limit 1  ) ilike '%' || v_psychiatrist || '%' else true end
AND Case when v_reviewdate is not null then (select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY' order by r4.updatedon desc limit 1)::date=v_reviewdate::date else true end

group by ps.psychotropicid 
order by 			( CASE v_sortorder
      WHEN 'asc'
      THEN
        CASE v_sortcolumn
        WHEN 'Medication' THEN ps.medicationname
		WHEN 'Client Name' THEN MAX(
		CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname))
						WHEN 'Prescription Date' THEN (ps.dateprescribed ::timestamp)::character varying
						WHEN 'Submitted By' THEN max((up.firstname || ' ' || up.lastname))
						WHEN 'Submitted On' THEN ((select r5.insertedon from routing r5 where routingstatustypeid=900 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1)  ::timestamp)::character varying
						WHEN 'status' THEN max(coalesce (rs.typedescription, 'Draft') ) :: varchar
						WHEN 'PHARMACIST' THEN (select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying order by r2.insertedon desc limit 1  )
						WHEN 'PSYCHIATRIST' THEN (select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid ::character varying order by r3.insertedon desc limit 1  )
						WHEN 'Review Date' THEN ((select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY' order by r4.updatedon desc limit 1) ::timestamp)::character varying
        END
    END) ASC NULLS last,
    ( CASE v_sortorder
      WHEN 'desc' 
      THEN
        CASE v_sortcolumn 
        WHEN 'Medication' THEN ps.medicationname
		WHEN 'Client Name' THEN MAX(
		CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname))
						WHEN 'Prescription Date' THEN (ps.dateprescribed ::timestamp)::character varying
						WHEN 'Submitted By' THEN max((up.firstname || ' ' || up.lastname))
WHEN 'Submitted On' THEN ((select r5.insertedon from routing r5 where routingstatustypeid=900 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1)  ::timestamp)::character varying						WHEN 'status' THEN max(coalesce (rs.typedescription, 'Draft') ) :: varchar
						WHEN 'PHARMACIST' THEN (select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying order by r2.insertedon desc limit 1  )
						WHEN 'PSYCHIATRIST' THEN (select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid ::character varying order by r3.insertedon desc limit 1  )
WHEN 'Review Date' THEN ((select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY' order by r4.updatedon desc limit 1) ::timestamp)::character varying        END
    END) desc NULLS last,
   ( CASE coalesce(v_sortorder,'')  
   WHEN   ''
      THEN
        CASE  coalesce(v_sortcolumn,'')   when '' then
        COALESCE(max(r.updatedon), COALESCE(ps.updatedon,ps.insertedon))
        END
    END) desc NULLS last   LIMIT  pagelimit OFFSET    v_pagenumber)a ;

end if;

if(v_roletypekey in ('CWPSYCOORD','CWPSYPHARM','CWPSYPSYCH') ) then

SELECT array_agg(objectid)  into v_objectid FROM routing WHERE 
    ((tosecurityusersid IN (v_UserSID) OR (tosecurityusersid is null or tosecurityusersid='')) AND (routingstatustypeid in (900,901,902,903,904,905,906,907,908,16)));
   

select json_agg(a) INTO  v_result from (select count(1) over(),ps.*,
max(concat (p.firstname ,' ',p.middlename ,' ' ,p.lastname) ) as clientname,
max(p.dob) as dob,
max(p.gendertypekey)  as gender,
max(p.cjamspid) as cjamspid,
max(co.countyname) as county ,
STRING_AGG(DISTINCT rfv.description, ', ') as race,
max(rf1.description) as ethnicity,
(select r5.insertedon from routing r5 where routingstatustypeid=908 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1) as submittedon,
max(up.firstname || ' ' || up.lastname) as submittedby,
max(rs.typedescription) as reviewstatus,
max(r.tosecurityusersid )as edituser,
( select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying 
AND Case when (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid in (904)  order by rc.insertedon desc limit 1) is not null 
then r2.insertedon > (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid=904  order by rc.insertedon desc limit 1) else true end
order by r2.insertedon desc limit 1  ) as pharmacist,
( select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid::character varying 
AND Case when (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid in (904)  order by rc.insertedon desc limit 1) is not null 
then r3.insertedon > (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid=904  order by rc.insertedon desc limit 1) else true end
order by r3.insertedon desc limit 1  ) as psychiatrist,
(select coalesce (s.servicecasenumber,a.adoptioncasenumber,isr.servicerequestnumber) 
from cjams.psychotropicmedications  ps1
--left join intakeservicerequest isr on isr.servicecaseid=ps1.objectid::uuid and isr.activeflag=1
left join servicecase s on s.servicecaseid=ps1.objectid::uuid and s.activeflag =1 
left join adoptioncase a  on a.adoptioncaseid=ps1.objectid::uuid and a.activeflag =1 
left join intakeservicerequest isr  on isr.intakeserviceid=ps1.objectid::uuid and isr.activeflag =1 
where ps1.objectid=ps.objectid limit 1 ) as casenumber,
(select (firstname || ' ' || lastname) from person where personid in( select personid  from  intakeservicerequestactor 
where (servicecaseid=ps.objectid::uuid or intakeserviceid=ps.objectid::uuid )  and  activeflag =1
and isheadofhousehold =true  order by insertedon desc limit 1) order by insertedon desc limit 1) as HOH,
(select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY'
AND Case when (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid=904  order by rc.insertedon desc limit 1) is not null 
then r4.insertedon > (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid in (904)  order by rc.insertedon desc limit 1) else true end
order by r4.updatedon desc limit 1) as reviewdate,
(select json_agg(docs)  from (SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title,dp.additionalobjectid, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon, 
    (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),
    dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,dp.uploadstatus, dp.finalstatus,dp.activeflag,
    (SELECT row_to_json(x) AS documentattachment FROM(                                                                               
    SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
    (select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                   
    WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
    ) x)
from documentproperties dp where dp.additionalobjectid = ps.psychotropicid ::character varying and dp.activeflag in (1,3,4,5)
)docs) as uploadedFiles
from cjams.psychotropicmedications  ps
left join routing r on r.objectid=ps.psychotropicid ::character varying and r.activeflag=1 and r.eventcode='PSY'
left join routingstatustype rs on rs.sequencenumber =r.routingstatustypeid
left join person p on p.personid =ps.personid ::uuid
-- left join personaddress pa on pa.personid =p.personid and pa.activeflag =1
--           left join referencevalues rf on rf.ref_key::character varying =pa.county and rf.activeflag=1 and rf.referencetypeid = '306'
left join county co on co.countyid = ps.countytypekey ::uuid and co.activeflag =1
--           left join racetype rt on rt.racetypekey = p.racetypekey  and rt.activeflag =1
           left join personracetypemap  prt on prt.personid=p.personid and prt.activeflag=1
           left join referencevalues rfv on rfv.ref_key::character varying =prt.racetypekey::varchar and rfv.activeflag=1 and rfv.referencetypeid = '171'
        left join referencevalues rf1 on rf1.ref_key=p.ethnicgrouptypekey and rf1.activeflag=1 and rf1.referencetypeid = '300'
left join userprofile up on up.securityusersid=ps.insertedby
where r.objectid =any(v_objectid)   AND ( CASE WHEN v_filterdatetypeforrouting IS  NULL THEN (r.routingstatustypeid IN (900,901,902,903,904,905,906,907,908,16) ) ELSE r.routingstatustypeid = ANY(v_filterdatetypeforrouting) END ) 
AND ( CASE WHEN v_tabselected IS  not null THEN (r.tosecurityusersid IN (v_UserSID) ) ELSE true END ) 
AND Case when v_medication is not null then ps.medicationname ilike '%' || v_medication  || '%'else true end
AND Case when v_clientname is not null then CONCAT(p.firstname, ' ', COALESCE(NULLIF(p.middlename, ''), ''), p.lastname) ilike '%' || v_clientname || '%' else true end
AND Case when v_dateprescribed is not null then ps.dateprescribed=v_dateprescribed::date else true end
AND Case when v_submittedby is not null then (up.firstname || ' ' || up.lastname) ilike '%' || v_submittedby || '%' else true end
AND Case when v_submittedon is not null then (select r5.insertedon from routing r5 where routingstatustypeid=900 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1)::date=v_submittedon::date else true end
AND Case when v_reviewstatus is not null then coalesce (rs.typedescription, 'Draft') ilike '%' || v_reviewstatus || '%' else true end
AND Case when v_pharmacist is not null then (select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying order by r2.insertedon desc limit 1  ) ilike '%' || v_pharmacist || '%' else true end
AND Case when v_psychiatrist is not null then (select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid ::character varying order by r3.insertedon desc limit 1  ) ilike '%' || v_psychiatrist || '%' else true end
AND Case when v_reviewdate is not null then (select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY' order by r4.updatedon desc limit 1)::date=v_reviewdate::date else true end

group by ps.psychotropicid order by 			( CASE v_sortorder
      WHEN 'asc'
      THEN
        CASE v_sortcolumn
        WHEN 'Medication' THEN ps.medicationname
		WHEN 'Client Name' THEN MAX(
		CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname))
						WHEN 'Prescription Date' THEN (ps.dateprescribed ::timestamp)::character varying
						WHEN 'Submitted By' THEN max((up.firstname || ' ' || up.lastname))
						WHEN 'Submitted On' THEN ((select r5.insertedon from routing r5 where routingstatustypeid=908 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1)  ::timestamp)::character varying
						WHEN 'status' THEN max(coalesce (rs.typedescription, 'Draft') ) :: varchar
						WHEN 'PHARMACIST' THEN (select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying order by r2.insertedon desc limit 1  )
						WHEN 'PSYCHIATRIST' THEN (select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid ::character varying order by r3.insertedon desc limit 1  )
						WHEN 'Review Date' THEN ((select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY' order by r4.updatedon desc limit 1) ::timestamp)::character varying
        END
    END) ASC NULLS last,
    ( CASE v_sortorder
      WHEN 'desc' 
      THEN
        CASE v_sortcolumn 
        WHEN 'Medication' THEN ps.medicationname
		WHEN 'Client Name' THEN MAX(
		CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname))
						WHEN 'Prescription Date' THEN (ps.dateprescribed ::timestamp)::character varying
						WHEN 'Submitted By' THEN max((up.firstname || ' ' || up.lastname))
WHEN 'Submitted On' THEN ((select r5.insertedon from routing r5 where routingstatustypeid=908 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1)  ::timestamp)::character varying						WHEN 'status' THEN max(coalesce (rs.typedescription, 'Draft') ) :: varchar
						WHEN 'PHARMACIST' THEN (select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying order by r2.insertedon desc limit 1  )
						WHEN 'PSYCHIATRIST' THEN (select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid ::character varying order by r3.insertedon desc limit 1  )
WHEN 'Review Date' THEN ((select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY' order by r4.updatedon desc limit 1) ::timestamp)::character varying        END
    END) desc NULLS last,
   ( CASE coalesce(v_sortorder,'')  
   WHEN   ''
      THEN
        CASE  coalesce(v_sortcolumn,'')   when '' then
        COALESCE(max(r.updatedon), COALESCE(ps.updatedon,ps.insertedon))
        END
    END) desc NULLS last   LIMIT  pagelimit OFFSET    v_pagenumber)a ;

end if;

if(v_roletypekey='OTHCWPSYPHARM') then
select  array_agg(objectid)  into v_objectid from routing where tosecurityusersid in (v_OtherUserSID ) and routingstatustypeid=901 AND activeflag=1;
select json_agg(a) INTO  v_result from (select count(1) over(),ps.*,
max(concat (p.firstname ,' ',p.middlename ,' ' ,p.lastname) ) as clientname,
max(p.dob) as dob,
max(p.gendertypekey)  as gender,
max(p.cjamspid) as cjamspid,
max(co.countyname) as county,
STRING_AGG(DISTINCT rfv.description, ', ') as race,
         max(rf1.description) as ethnicity,
(select r5.insertedon from routing r5 where routingstatustypeid=908 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1) as submittedon,
max(up.firstname || ' ' || up.lastname) as submittedby,
max(rs.typedescription) as reviewstatus,
max(r.tosecurityusersid )as edituser,
( select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying 
AND Case when (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid in (904)  order by rc.insertedon desc limit 1) is not null 
then r2.insertedon > (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid=904  order by rc.insertedon desc limit 1) else true end
order by r2.insertedon desc limit 1  ) as pharmacist,
( select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid::character varying 
AND Case when (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid in (904)  order by rc.insertedon desc limit 1) is not null 
then r3.insertedon > (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid=904  order by rc.insertedon desc limit 1) else true end
order by r3.insertedon desc limit 1  ) as psychiatrist,
(select coalesce (s.servicecasenumber,a.adoptioncasenumber,isr.servicerequestnumber) 
from cjams.psychotropicmedications  ps1
--left join intakeservicerequest isr on isr.servicecaseid=ps1.objectid::uuid and isr.activeflag=1
left join servicecase s on s.servicecaseid=ps1.objectid::uuid and s.activeflag =1 
left join adoptioncase a  on a.adoptioncaseid=ps1.objectid::uuid and a.activeflag =1 
left join intakeservicerequest isr  on isr.intakeserviceid=ps1.objectid::uuid and isr.activeflag =1 
where ps1.objectid=ps.objectid limit 1 ) as casenumber,
(select (firstname || ' ' || lastname) from person where personid in( select personid  from  intakeservicerequestactor 
where (servicecaseid=ps.objectid::uuid or intakeserviceid=ps.objectid::uuid )  and  activeflag =1
and isheadofhousehold =true  order by insertedon desc limit 1) order by insertedon desc limit 1) as HOH,
(select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY'
AND Case when (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid=904  order by rc.insertedon desc limit 1) is not null 
then r4.insertedon > (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid in (904)  order by rc.insertedon desc limit 1) else true end
order by r4.updatedon desc limit 1) as reviewdate,
(select json_agg(docs)  from (SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title,dp.additionalobjectid, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon, 
    (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),
    dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,dp.uploadstatus, dp.finalstatus,dp.activeflag,
    (SELECT row_to_json(x) AS documentattachment FROM(                                                                               
    SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
    (select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                   
    WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
    ) x)
from documentproperties dp where dp.additionalobjectid = ps.psychotropicid ::character varying and dp.activeflag in (1,3,4,5)
)docs) as uploadedFiles
from cjams.psychotropicmedications  ps
left join routing r on r.objectid=ps.psychotropicid ::character varying and r.activeflag=1 and r.eventcode='PSY'
left join routingstatustype rs on rs.sequencenumber =r.routingstatustypeid
left join person p on p.personid =ps.personid ::uuid
-- left join personaddress pa on pa.personid =p.personid and pa.activeflag =1
--           left join referencevalues rf on rf.ref_key::character varying =pa.county and rf.activeflag=1 and rf.referencetypeid = '306'
left join county co on co.countyid = ps.countytypekey ::uuid and co.activeflag =1
--           left join racetype rt on rt.racetypekey = p.racetypekey  and rt.activeflag =1
           left join personracetypemap  prt on prt.personid=p.personid and prt.activeflag=1
           left join referencevalues rfv on rfv.ref_key::character varying =prt.racetypekey::varchar and rfv.activeflag=1 and rfv.referencetypeid = '171'
           left join referencevalues rf1 on rf1.ref_key=p.ethnicgrouptypekey and rf1.activeflag=1 and rf1.referencetypeid = '300'
left join userprofile up on up.securityusersid=ps.insertedby
where r.objectid =any(v_objectid) AND ( CASE WHEN v_filterdatetypeforrouting IS  NULL THEN (r.routingstatustypeid IN (907,906,901) ) ELSE r.routingstatustypeid = ANY(v_filterdatetypeforrouting)END ) and ps.activeflag=1
AND Case when v_medication is not null then ps.medicationname ilike '%' || v_medication  || '%'else true end
AND Case when v_clientname is not null then CONCAT(p.firstname, ' ', COALESCE(NULLIF(p.middlename, ''), ''), p.lastname) ilike '%' || v_clientname || '%' else true end
AND Case when v_dateprescribed is not null then ps.dateprescribed=v_dateprescribed::date else true end
AND Case when v_submittedby is not null then (up.firstname || ' ' || up.lastname) ilike '%' || v_submittedby || '%' else true end
AND Case when v_submittedon is not null then (select r5.insertedon from routing r5 where routingstatustypeid=900 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1)::date=v_submittedon::date else true end
AND Case when v_reviewstatus is not null then coalesce (rs.typedescription, 'Draft') ilike '%' || v_reviewstatus || '%' else true end
AND Case when v_pharmacist is not null then (select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying order by r2.insertedon desc limit 1  ) ilike '%' || v_pharmacist || '%' else true end
AND Case when v_psychiatrist is not null then (select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid ::character varying order by r3.insertedon desc limit 1  ) ilike '%' || v_psychiatrist || '%' else true end
AND Case when v_reviewdate is not null then (select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY' order by r4.updatedon desc limit 1)::date=v_reviewdate::date else true end

group by ps.psychotropicid order by 			( CASE v_sortorder
      WHEN 'asc'
      THEN
        CASE v_sortcolumn
        WHEN 'Medication' THEN ps.medicationname
		WHEN 'Client Name' THEN MAX(
		CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname))
						WHEN 'Prescription Date' THEN (ps.dateprescribed ::timestamp)::character varying
						WHEN 'Submitted By' THEN max((up.firstname || ' ' || up.lastname))
						WHEN 'Submitted On' THEN ((select r5.insertedon from routing r5 where routingstatustypeid=900 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1)  ::timestamp)::character varying
						WHEN 'status' THEN max(coalesce (rs.typedescription, 'Draft') ) :: varchar
						WHEN 'PHARMACIST' THEN (select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying order by r2.insertedon desc limit 1  )
						WHEN 'PSYCHIATRIST' THEN (select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid ::character varying order by r3.insertedon desc limit 1  )
						WHEN 'Review Date' THEN ((select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY' order by r4.updatedon desc limit 1) ::timestamp)::character varying
        END
    END) ASC NULLS last,
    ( CASE v_sortorder
      WHEN 'desc' 
      THEN
        CASE v_sortcolumn 
        WHEN 'Medication' THEN ps.medicationname
		WHEN 'Client Name' THEN MAX(
		CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname))
						WHEN 'Prescription Date' THEN (ps.dateprescribed ::timestamp)::character varying
						WHEN 'Submitted By' THEN max((up.firstname || ' ' || up.lastname))
WHEN 'Submitted On' THEN ((select r5.insertedon from routing r5 where routingstatustypeid=900 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1)  ::timestamp)::character varying						WHEN 'status' THEN max(coalesce (rs.typedescription, 'Draft') ) :: varchar
						WHEN 'PHARMACIST' THEN (select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying order by r2.insertedon desc limit 1  )
						WHEN 'PSYCHIATRIST' THEN (select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid ::character varying order by r3.insertedon desc limit 1  )
WHEN 'Review Date' THEN ((select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY' order by r4.updatedon desc limit 1) ::timestamp)::character varying        END
    END) desc NULLS last,
   ( CASE coalesce(v_sortorder,'')  
   WHEN   ''
      THEN
        CASE  coalesce(v_sortcolumn,'')   when '' then
        COALESCE(max(r.updatedon), COALESCE(ps.updatedon,ps.insertedon))
        END
    END) desc NULLS last   LIMIT  pagelimit OFFSET    v_pagenumber)a ;

end if;

if(v_roletypekey='OTHCWPSYPSYCH') then
select  array_agg(objectid)  into v_objectid from routing where tosecurityusersid in (v_OtherUserSID) and routingstatustypeid=903 and activeflag=1;

select json_agg(a) INTO  v_result from (select count(1) over(),ps.*,
max(concat (p.firstname ,' ',p.middlename ,' ' ,p.lastname) ) as clientname,
max(p.dob) as dob,
max(p.gendertypekey)  as gender,
max(p.cjamspid) as cjamspid,
max(co.countyname) as county ,
STRING_AGG(DISTINCT rfv.description, ', ') as race,
         max(rf1.description) as ethnicity,
(select r5.insertedon from routing r5 where routingstatustypeid=908 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1) as submittedon,
max(up.firstname || ' ' || up.lastname) as submittedby,
max(rs.typedescription) as reviewstatus,
max(r.tosecurityusersid )as edituser,
( select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying 
AND Case when (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid in (904)  order by rc.insertedon desc limit 1) is not null 
then r2.insertedon > (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid=904  order by rc.insertedon desc limit 1) else true end
order by r2.insertedon desc limit 1  ) as pharmacist,
( select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid::character varying 
AND Case when (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid in (904)  order by rc.insertedon desc limit 1) is not null 
then r3.insertedon > (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid=904  order by rc.insertedon desc limit 1) else true end
order by r3.insertedon desc limit 1  ) as psychiatrist,
(select coalesce (s.servicecasenumber,a.adoptioncasenumber,isr.servicerequestnumber) 
from cjams.psychotropicmedications  ps1
--left join intakeservicerequest isr on isr.servicecaseid=ps1.objectid::uuid and isr.activeflag=1
left join servicecase s on s.servicecaseid=ps1.objectid::uuid and s.activeflag =1 
left join adoptioncase a  on a.adoptioncaseid=ps1.objectid::uuid and a.activeflag =1 
left join intakeservicerequest isr  on isr.intakeserviceid=ps1.objectid::uuid and isr.activeflag =1 
where ps1.objectid=ps.objectid limit 1 ) as casenumber,
(select (firstname || ' ' || lastname) from person where personid in( select personid  from  intakeservicerequestactor 
where (servicecaseid=ps.objectid::uuid or intakeserviceid=ps.objectid::uuid )  and  activeflag =1
and isheadofhousehold =true  order by insertedon desc limit 1) order by insertedon desc limit 1) as HOH,
(select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY'
AND Case when (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid=904  order by rc.insertedon desc limit 1) is not null 
then r4.insertedon > (select rc.insertedon  from routing rc where rc.objectid=ps.psychotropicid::character varying and rc.routingstatustypeid in (904)  order by rc.insertedon desc limit 1) else true end
order by r4.updatedon desc limit 1) as reviewdate,
(select json_agg(docs)  from (SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title,dp.additionalobjectid, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon, 
    (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),
    dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,dp.uploadstatus, dp.finalstatus,dp.activeflag,
    (SELECT row_to_json(x) AS documentattachment FROM(                                                                               
    SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
    (select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                   
    WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
    ) x)
from documentproperties dp where dp.additionalobjectid = ps.psychotropicid ::character varying and dp.activeflag in (1,3,4,5)
)docs) as uploadedFiles
from cjams.psychotropicmedications  ps
left join routing r on r.objectid=ps.psychotropicid ::character varying and r.activeflag=1 and r.eventcode='PSY'
left join routingstatustype rs on rs.sequencenumber =r.routingstatustypeid
left join person p on p.personid =ps.personid ::uuid
-- left join personaddress pa on pa.personid =p.personid and pa.activeflag =1
--           left join referencevalues rf on rf.ref_key::character varying =pa.county and rf.activeflag=1 and rf.referencetypeid = '306'
left join county co on co.countyid = ps.countytypekey ::uuid and co.activeflag =1
--           left join racetype rt on rt.racetypekey = p.racetypekey  and rt.activeflag =1
           left join personracetypemap  prt on prt.personid=p.personid and prt.activeflag=1
           left join referencevalues rfv on rfv.ref_key::character varying =prt.racetypekey::varchar and rfv.activeflag=1 and rfv.referencetypeid = '171'
           left join referencevalues rf1 on rf1.ref_key=p.ethnicgrouptypekey and rf1.activeflag=1 and rf1.referencetypeid = '300'
left join userprofile up on up.securityusersid=ps.insertedby
where r.objectid =any(v_objectid) AND ( CASE WHEN v_filterdatetypeforrouting IS  NULL THEN (r.routingstatustypeid IN (907,906,903) ) ELSE r.routingstatustypeid = ANY(v_filterdatetypeforrouting)END ) and ps.activeflag=1
AND Case when v_medication is not null then ps.medicationname ilike '%' || v_medication  || '%'else true end
AND Case when v_clientname is not null then CONCAT(p.firstname, ' ',COALESCE(NULLIF(p.middlename, ''), ''), p.lastname) ilike '%' || v_clientname || '%' else true end
AND Case when v_dateprescribed is not null then ps.dateprescribed=v_dateprescribed::date else true end
AND Case when v_submittedby is not null then (up.firstname || ' ' || up.lastname) ilike '%' || v_submittedby || '%' else true end
AND Case when v_submittedon is not null then (select r5.insertedon from routing r5 where routingstatustypeid=900 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1)::date=v_submittedon::date else true end
AND Case when v_reviewstatus is not null then coalesce (rs.typedescription, 'Draft') ilike '%' || v_reviewstatus || '%' else true end
AND Case when v_pharmacist is not null then (select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying order by r2.insertedon desc limit 1  ) ilike '%' || v_pharmacist || '%' else true end
AND Case when v_psychiatrist is not null then (select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid ::character varying order by r3.insertedon desc limit 1  ) ilike '%' || v_psychiatrist || '%' else true end
AND Case when v_reviewdate is not null then (select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY' order by r4.updatedon desc limit 1)::date=v_reviewdate::date else true end

group by ps.psychotropicid order by 			( CASE v_sortorder
      WHEN 'asc'
      THEN
        CASE v_sortcolumn
        WHEN 'Medication' THEN ps.medicationname
		WHEN 'Client Name' THEN MAX(
		CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname))
						WHEN 'Prescription Date' THEN (ps.dateprescribed ::timestamp)::character varying
						WHEN 'Submitted By' THEN max((up.firstname || ' ' || up.lastname))
						WHEN 'Submitted On' THEN ((select r5.insertedon from routing r5 where routingstatustypeid=900 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1)  ::timestamp)::character varying
						WHEN 'status' THEN max(coalesce (rs.typedescription, 'Draft') ) :: varchar
						WHEN 'PHARMACIST' THEN (select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying order by r2.insertedon desc limit 1  )
						WHEN 'PSYCHIATRIST' THEN (select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid ::character varying order by r3.insertedon desc limit 1  )
						WHEN 'Review Date' THEN ((select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY' order by r4.updatedon desc limit 1) ::timestamp)::character varying
        END
    END) ASC NULLS last,
    ( CASE v_sortorder
      WHEN 'desc' 
      THEN
        CASE v_sortcolumn 
        WHEN 'Medication' THEN ps.medicationname
		WHEN 'Client Name' THEN MAX(
		CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname))
						WHEN 'Prescription Date' THEN (ps.dateprescribed ::timestamp)::character varying
						WHEN 'Submitted By' THEN max((up.firstname || ' ' || up.lastname))
WHEN 'Submitted On' THEN ((select r5.insertedon from routing r5 where routingstatustypeid=900 and r5.eventcode='PSY' and r5.objectid=ps.psychotropicid::character varying order by r5.insertedon desc limit 1)  ::timestamp)::character varying						WHEN 'status' THEN max(coalesce (rs.typedescription, 'Draft') ) :: varchar
						WHEN 'PHARMACIST' THEN (select (up2.firstname || ' ' || up2.lastname) from  routing r2
inner join userprofile up2 on up2.securityusersid=r2.tosecurityusersid
where r2.routingstatustypeid=901 and r2.eventcode='PSY' and r2.objectid=ps.psychotropicid::character varying order by r2.insertedon desc limit 1  )
						WHEN 'PSYCHIATRIST' THEN (select (up1.firstname || ' ' || up1.lastname) from  routing r3
inner join userprofile up1 on up1.securityusersid=r3.tosecurityusersid
where r3.routingstatustypeid=903 and r3.eventcode='PSY' and r3.objectid=ps.psychotropicid ::character varying order by r3.insertedon desc limit 1  )
					WHEN 'Review Date' THEN ((select r4.updatedon from routing r4 where r4.objectid=ps.psychotropicid ::character varying and r4.activeflag=0  and r4.eventcode='PSY' order by r4.updatedon desc limit 1) ::timestamp)::character varying
        END
    END) desc NULLS last,
   ( CASE coalesce(v_sortorder,'')  
   WHEN   ''
      THEN
        CASE  coalesce(v_sortcolumn,'')   when '' then
        COALESCE(max(r.updatedon), COALESCE(ps.updatedon,ps.insertedon))
        END
    END) desc NULLS last   LIMIT  pagelimit OFFSET    v_pagenumber)a ;

end if;

RETURN v_result;
end;

$function$
;