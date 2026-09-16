DROP FUNCTION IF EXISTS cjams.mycasesearch(userid character varying, page integer, pagelimit integer, casesearchval character varying, sortorder character varying, sortcolumn character varying, v_worker character varying, actiontype character varying, v_foldertypekey character varying, v_status character varying);
CREATE OR REPLACE FUNCTION cjams.mycasesearch(userid character varying, page integer, pagelimit integer, casesearchval character varying, sortorder character varying, sortcolumn character varying, v_worker character varying, actiontype character varying, v_foldertypekey character varying, v_status character varying)
 RETURNS TABLE(totalcount bigint, intakeserviceid character varying, legalguardian json, servicerequestnumber character varying, srtype text, datereceived timestamp without time zone, workername character varying, updateon timestamp without time zone, adoptionplanningid uuid, startdate timestamp without time zone, restrictedstatus text, outcomes json, providerdetails json, istagged integer)
 LANGUAGE plpgsql
AS $function$                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
------------------------------------------------------------------------------------------------------------                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
------------------------------------------------------------------------------------------------------------
-- Function Note: This proc has the expunge proc. If changing to mycasesearch, similar updates are also required for mycasesearch_expunge
-- Expungement Proc : cjams.mycasesearch_expunge
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 06/14/2023 Vineet Tirodkar - Modifications to fix Intake missing issue (CDM-31953)
-- 06/21/2023 Manasa Kasula - Fix to fetch the case on search when only quick add persons are available on the cps case(CIDM-7357)
-- 08/08/2023 Palani/Chandra -- Query tuning(CIDM-7904)
-- 12/11/2024 Naresh - Finding migrated intakes (CIDM-9845)
-- 12/04/2024 Manasa Kasula - Fix for after deactivating the user, the user name is appeared in the search cases and case audit trail screens(CIDM-9852)
------------------------------------------------------------------------------------------------------------  

DECLARE  v_pageoffset  int;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
 v_pagenumber  int;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
 l_actiontype  character  varying; 
BEGIN                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
     v_pagenumber  :=  (page-1)*10;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
     l_actiontype:=actiontype;     
     RETURN  QUERY
     select count(1) over(),x.*
			, COALESCE((SELECT 1 FROM userreference WHERE securityusersid = userid AND objectid=x.intakeserviceid),0)
	from 
    (( select  
     ins.intakeserviceid ::character varying,
     (select (getcasepersonname) as legalguardian from getcasepersonname ('servicerequest',ins.intakeserviceid::character varying)),
     ins.servicerequestnumber,
     case when ins.actiontype = 'IR' then 'CPS IR' when ins.actiontype = 'AR' then 'CPS AR' end as casetype,
	CAST(ins.ReportedDate as timestamp) as datereceived,
     (select string_agg(distinct up.fullname, '- ')::character varying from caseassignment ca
      inner join userprofile up on up.securityusersid =  ca.toworkeridno and up.activeflag = 1
      where ca.objectid::text=ins.intakeserviceid :: text and ca.objecttypekey = 'servicerequest' and (ca.enddate is null or ca.enddate > now())
     ) as fullname,
     ins.updatedon
     ,null :: uuid 
     ,null ::timestamp without time zone,
     (SELECT * FROM getRestrictedCaseStatus(ins.intakeserviceid::text,userid)) AS restrictStatus,
     ( select json_agg(a) from ( select  alle."name" from investigation inv  
          join Investigationmaltreatment im on im.investigationid= inv.investigationid and im.activeflag =1
          JOIN Investigationallegation ia ON  ia.maltreatmentid = im.maltreatmentid								
          INNER JOIN allegation  alle on  alle.allegationid = ia.allegationid AND alle.activeflag = 1
          where  inv.intakeserviceid = ins.intakeserviceid  
          group by alle."name"
          order by (case sortorder when 'asc' then alle."name" end) asc nulls last ,
                         (case sortorder when 'desc' then  alle."name" end)desc nulls last ) as a) as outcomes,
     null :: json     
     from intakeservicerequest ins
     where  ins.activeflag=1 and ins.teamtypekey ='CW' and ins.actiontype is not null
   	 and ins.isdraft = 0 --and ins.teamtypekey = 'CW'
     and (l_actiontype is null or l_actiontype = '' or ins.actiontype =  l_actiontype)
     and (casesearchval is null or casesearchval = '' or LOWER(ins.servicerequestnumber)  LIKE   '%' ||   LOWER(casesearchval)  ||  '%'
      or  ins.servicerequestnumber=(select casenumber from cjamscisref where cisrefid::character varying = casesearchval::character varying  limit 1 )
     )
     and ( v_worker is null or v_worker = '' or 
     (ins.intakeserviceid in (select (case when length(objectid)=36 then objectid else null end)::uuid from routing r where  (r.tosecurityusersid) =   (v_worker)))  ) group by ins.intakeserviceid                                                                                                                                   
     )
     
union all

    ( select  
     ins.servicecaseid ::character varying,
     (select (getcasepersonname) as legalguardian from getcasepersonname ('servicecase',ins.servicecaseid::character varying)),
     ins.servicecasenumber,
     'Service' as casetype,
     ins.startdate as datereceived,
     (select string_agg(distinct up.fullname, '- ')::character varying from caseassignment ca
     inner join userprofile up on up.securityusersid = ca.toworkeridno and up.activeflag = 1
     where ca.objectid=ins.servicecaseid and ca.objecttypekey = 'servicecase' and (ca.enddate is null or ca.enddate > now())
     ) as fullname,
     ins.updatedon
     ,null :: uuid ,null ::timestamp without time zone,
     (SELECT * FROM getRestrictedCaseStatus(ins.servicecaseid::text,userid)) AS restrictStatus,
     null :: json,
     null :: json
     from servicecase ins 
     where  ins.activeflag=1 
          and (l_actiontype is null or l_actiontype = '' or l_actiontype = 'SC')
     and (casesearchval is null or casesearchval = '' or (ins.servicecasenumber)  LIKE   '%' ||   (casesearchval)  ||  '%'
     or  ins.servicecasenumber=(select casenumber from cjamscisref where cisrefid:: character varying = casesearchval:: character varying   limit 1 )
     )
     and ( v_worker is null or v_worker = '' or  (ins.servicecaseid in (select (case when length(objectid)=36 then objectid else null end)::uuid
     from routing r where  (r.tosecurityusersid) =   (v_worker)))  )                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
     )
    
union all

      (select 
      adc.adoptioncaseid ::character varying,
     (select (getcasepersonname) as legalguardian from getcasepersonname ('adoptioncase',adc.adoptioncaseid::character varying)),
	  adc.adoptioncasenumber,
     'Adoption' as casetype,
     adc.startdate as datereceived,
     ( SELECT CAST(UP2.firstname || ' ' || UP2.lastname AS character varying)
				FROM  userprofile UP2  
				inner join caseassignment ca on ca.toworkeridno = up2.securityusersid AND ca.activeflag = 1 
				WHERE UP2.activeflag =1 
				and ca.objectid = adc.adoptioncaseid
				and ca.objecttypekey = 'adoptioncase' and ca.enddate is null order by ca.insertedon desc LIMIT 1) as fullname,
     
     adc.updatedon
     ,adc.adoptionplanningid,adc.startdate,
     (SELECT * FROM getRestrictedCaseStatus( adc.adoptioncaseid::text,userid)) AS restrictStatus,
     null :: json,
     (select json_agg(a) from (
				select *  from adoptioncaseagreement ag   
				where ag.adoptioncaseid = adc.adoptioncaseid 
                    and ag.activeflag=1		 
	) a ) as providerdetails

     from adoptioncase adc
     where  adc.activeflag=1 
               and (l_actiontype is null or l_actiontype = '' or l_actiontype = 'AD')
     and (casesearchval is null or casesearchval = '' or (adc.adoptioncasenumber)  LIKE   '%' ||   (casesearchval)  ||  '%'
      or  adc.adoptioncasenumber=(select casenumber from cjamscisref where cisrefid:: character varying = casesearchval:: character varying  limit 1 )
     )
     and ( v_worker is null or v_worker = '' or  (adc.adoptioncaseid in (select (case when length(objectid)=36 then objectid else null end)::uuid
     from routing r where  (r.tosecurityusersid) =   (v_worker)))  )                                          
       )
    
union all

     ( select 
     
      ids.intakenumber,
     (select (getcasepersonname) as legalguardian from getcasepersonname ('intake',ids.intakenumber::character varying)),
	  ids.intakenumber,
     'Referral' as casetype,
     case when ids.submitteddate is not null then ids.submitteddate 
     	  else 
	     (select isr.reporteddate from intakeservicerequest isr where isr.intakenumber = ids.intakenumber 
	     order by isr.insertedon desc limit 1 )end 
	     as datereceived,
     (select upr.fullname 
		from userprofile upr 
	 where upr.securityusersid = up.intakeuser
	 order by upr.updatedon desc
	 limit 1) as fullname,
     ids.updatedon,
     null :: uuid ,null ::timestamp without time zone,
     (SELECT * FROM getRestrictedCaseStatus(ids.intakenumber::text,userid)) AS restrictStatus,
     null :: json,
     null :: json

     from intakedastatus ids
	  join intakedastaging up on  up.intakenumber = ids.intakenumber and up.activeflag = 1
     where ids.activeflag=1 and ids.teamtypekey = 'CW' and up.teamtypekey ='CW'
               and (l_actiontype is null or l_actiontype = '' or l_actiontype = 'REF')
     and 
     (casesearchval is null or casesearchval = '' or LOWER(ids.intakenumber)  LIKE   '%' ||   LOWER(casesearchval)  ||  '%'
       or  ids.intakenumber=(select casenumber from cjamscisref where cisrefid:: character varying = casesearchval:: character varying  limit 1 )
     
     )
     and ( v_worker is null or v_worker = '' or (up.intakeuser) = (v_worker)  ) 
     )

union all --CIDM-9845 - Migrated intakes

(select 
ids.intakenumber,
(select (getcasepersonname) as legalguardian from getcasepersonname ('intake',ids.intakenumber::character varying)),
ids.intakenumber,
'Referral' as casetype,
case when ids.submitteddate is not null then ids.submitteddate 
else (select isr.reporteddate from intakeservicerequest isr where isr.intakenumber = ids.intakenumber 
order by isr.insertedon desc limit 1 )end 
as datereceived,
'Migrated User' as fullname,
ids.updatedon,
null :: uuid, null ::timestamp without time zone,
(select * from getRestrictedCaseStatus(ids.intakenumber::text,userid)) AS restrictStatus,
null :: json,
null :: json
from intakedastatus ids
where ids.activeflag = 1 and ids.teamtypekey = 'CW' and ids.updatedby = 'migrationuser' and (l_actiontype is null or l_actiontype = '' or l_actiontype = 'REF')
and (casesearchval is null or casesearchval = '' or LOWER(ids.intakenumber) LIKE '%' || LOWER(casesearchval) || '%' or
ids.intakenumber = ( select casenumber from cjamscisref where cisrefid::character varying = casesearchval::character varying  limit 1 ))
and ( v_worker is null or v_worker = '')
and not exists (select 1 from intakedastaging sta where sta.intakenumber = ids.intakenumber))
) x   WHERE x.restrictStatus in ('INCL','INCLRES','EXCLUDE')
    ORDER  BY  (case sortorder 
    					when 'asc' 
    					then 	
    							case sortcolumn 	
    								when 'srtype' then cast(x.casetype as character varying )
    								when 'servicerequestnumber' then cast(x.servicerequestnumber as character varying )
    								when 'legalguardian' then cast(x.legalguardian as character varying)
    								when 'datereceived'	then cast (x.datereceived as character varying )
    								when 'workername' then cast(x.fullname as character varying )
    								when 'outcomes' then cast(x.outcomes as character varying )
									END
             	END) ASC NULLS LAST,
   				(case sortorder 
    					when 'desc' 
    					then 	
    							case sortcolumn 	
    								when 'srtype' then cast(x.casetype as character varying )
    								when 'servicerequestnumber' then cast(x.servicerequestnumber as character varying )
    								when 'legalguardian' then cast(x.legalguardian as character varying)
    								when 'datereceived'	then cast (x.datereceived as character varying )
    								when 'workername' then cast(x.fullname as character varying )
    								when 'outcomes' then cast(x.outcomes as character varying )
									END
             	END) DESC NULLS LAST
       
    LIMIT  pagelimit OFFSET    v_pagenumber ;

END;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
$function$
;