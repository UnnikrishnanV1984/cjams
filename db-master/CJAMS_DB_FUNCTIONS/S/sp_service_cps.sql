CREATE OR REPLACE FUNCTION cjams.sp_service_cps(v_securityid character varying, pagenumber integer, pagesize integer, v_status character varying, v_servicecase character varying, v_cpscase character varying)
 RETURNS TABLE(totalcount bigint, caseid uuid, casenumber character varying, legalguardian json, scstartdate timestamp without time zone, scenddate timestamp without time zone, programarea json, srtype character varying, srsubtype character varying, reporteddate timestamp without time zone, getreportername character varying, duedate timestamp without time zone, status character varying, accepteddate timestamp without time zone, routedon timestamp without time zone, ismaltreatment integer, approvaldate timestamp without time zone, foldertype character varying, childfatality integer, fatalityinfo json, getreportercjamspid bigint, insertedon timestamp without time zone, updatedon timestamp without time zone, casetype character varying)
 LANGUAGE plpgsql
AS $function$

DECLARE 
query_toexecute text;
	v_pageoffset int;
	v_pagenumber int;

v_appendstring character varying;
v_searchvalsc character varying;
v_searchvalisr character varying;


begin
    v_pagenumber := pagenumber-1;
    v_pageoffset = v_pagenumber * pagesize;

   v_searchvalsc := '';
if (v_servicecase is not null) then 
v_searchvalsc := ' AND SC.servicecasenumber = COALESCE('''||v_servicecase||''',SC.servicecasenumber) ';
end if;

raise notice 'v_servicecase%',v_servicecase;

   v_searchvalisr := '';
if (v_cpscase is not null) then 
v_searchvalisr :=   '  AND  ISR.servicerequestnumber = COALESCE('''||v_cpscase||''', ISR.servicerequestnumber) ';
end if;

raise notice 'v_searchvalsc%',v_searchvalsc;
raise notice 'v_searchvalisr%',v_searchvalisr;

v_appendstring = '';
if (v_status = 'inprogress')
then 
v_appendstring = ' and sc.servicecaseid not in (select scd.servicecaseid from servicecasedisposition scd where scd.servicecaseid=sc.servicecaseid  and scd.intakeserreqstatustypekey=''Closed'')';
end if;

if (v_status = 'closed')
then 
v_appendstring = ' and sc.servicecaseid  in (select scd.servicecaseid from servicecasedisposition scd where scd.servicecaseid=sc.servicecaseid  and scd.intakeserreqstatustypekey=''Closed'')';
end if;

 DROP TABLE IF EXISTS tmp_status;
 
  CREATE TEMP TABLE   tmp_status ( statustypeid uuid);
  
      IF (v_status IN ('pending','inprogress')) THEN 
         INSERT INTO tmp_status(statustypeid)
         SELECT intakeserreqstatustypeid  FROM  intakeserreqstatustype  WHERE  activeflag =1  AND LOWER(intakeserreqstatustypekey) NOT IN  ('closed', 'cancelled','completed');
    ELSIF(v_status='closed') THEN 
        INSERT INTO tmp_status(statustypeid)
        SELECT intakeserreqstatustypeid  FROM  intakeserreqstatustype  WHERE  activeflag =1  AND  LOWER(intakeserreqstatustypekey) IN  ('closed');
    ELSE
         INSERT INTO tmp_status (statustypeid)       
        SELECT intakeserreqstatustypeid  FROM  intakeserreqstatustype  WHERE   activeflag =1  AND LOWER(intakeserreqstatustypekey) NOT IN  ('cancelled');
    END IF; 



query_toexecute:='
 select count(1) over(),x.* from (select sc.servicecaseid as caseid,SC.servicecasenumber as casenumber,   (select getcasepersonname as legalguardian from getcasepersonname (''servicecase'',SC.servicecaseid::character varying)),
	SC.startdate as scstartdate,
	SC.enddate as scenddate,
		(SELECT json_agg(e) AS programarea 
	FROM
	(
		SELECT
			DISTINCT ppa.programkey,
			ppa.subprogramkey,
			(SELECT rv.description FROM referencevalues rv 
			WHERE rv.ref_key = ppa.subprogramkey AND rv.referencetypeid = 12 AND rv.activeflag =1 LIMIT 1) subprogramname,
			(SELECT ap.programname FROM agencyprogramarea ap 
			WHERE ap.programkey = ppa.programkey AND ap.activeflag =1 LIMIT 1 ) programname
		FROM personprogramarea ppa 
		WHERE ppa.objectid=SC.servicecaseid::character varying AND ppa.activeflag=1  
	) AS e),null::character varying as srtype, null::character varying as srsubtype,null::timestamp as reporteddate
	,null::character varying as getreportername,null::timestamp as duedate,null::character varying as status,
	null::timestamp as accepteddate,  null::timestamp as routedon,
	null::int as ismaltreatment, null::timestamp as approvaldate,null::character varying as foldertype,
	null::int as childfatality,null::json as fatalityinfo,null::int as getreportercjamspid,sc.insertedon,sc.updatedon,
	''servicecase''::character varying as casetype
	from servicecase sc
	INNER JOIN  (SELECT DISTINCT R.objectid FROM routing  R WHERE  R.tosecurityusersid  ='''||v_securityid||'''  AND eventcode =''SRVC''
             	AND  R.activeflag  =1 AND R.routingstatustypeid =4 )  R ON R.objectid =  SC.servicecaseid::  character  varying 
WHERE 
SC.activeflag=1   
AND SC.statustypekey = ''ASSGN''  '||v_appendstring||' '||v_searchvalsc||'
union all
select isr.intakeserviceid as caseid,ISR.servicerequestnumber as casenumber,
(select getcasepersonname as legalguardian from getcasepersonname (''servicerequest'',ISR.intakeserviceid::character varying)),
      null::timestamp as scstartdate,
        null::timestamp as scenddate,
         null::json as programarea,
         (SELECT  itsrt.description FROM  intakeservicerequesttype  as  itsrt
        WHERE  itsrt.intakeservreqtypeid=ISR.intakeservreqtypeid AND  itsrt.activeflag  =1 limit  1) as srtype, 
        (SELECT  srst.classkey  FROM  servicerequestsubtype  as  srst WHERE  srst.servicerequestsubtypeid=ISR.intakeservicerequestclassid
        AND  srst.activeflag  =1    limit  1) as srsubtype,
           ISR.reporteddate::timestamp without time zone,
              (SELECT getreportername FROM getreportername(''servicerequest'',ISR.intakeserviceid::character varying, ''reporter'')) as getreportername,
                   (SELECT 
            CASE WHEN ISR.TargetCompleteDate is null then CAST(ISR.ReportedDate as date) + CAST(src.DueDateOffset as integer)
                ELSE  ISR.TargetCompleteDate    
            END   
        FROM ServiceRequestTypeConfig as src  
        WHERE src.intakeservreqtypeid=isr.IntakeServReqTypeId AND src.servicerequestsubtypeid= isr.IntakeServiceRequestClassId and src.activeflag=1 limit 1
        ) duedate, CAST(CASE ISR.isaccepted WHEN false THEN ''Rejected'' WHEN true THEN ''Assigned'' ELSE ''Pending'' END
             AS character  varying)  AS  status,
              ISR.accepteddate, 
        ISR.routedon,
        CASE  COALESCE((
            SELECT  COUNT(1) 
                FROM  investigationallegation  ia 
                INNER  JOIN  investigation  i  ON  i.investigationid=  ia.investigationid  AND  i.activeflag=1	AND  I.intakeserviceid  =  ISR.intakeserviceid  
            WHERE  ia.activeflag=1  AND  COALESCE(ia.isproviderinvolved,0)  =1),0)
        WHEN  0  THEN  0  ELSE  1  end as ismaltreatment,    
        ISR.insertedon AS approvaldate,
        (SELECT ft.description FROM foldertype ft WHERE ft.foldertypekey = ISR.foldertypekey AND ft.activeflag = 1 LIMIT 1) AS foldertype,
        (SELECT childfatality FROM getchildfatality (ISR.intakeserviceid::character varying,''servicerequest''))  ,
        (SELECT T.fatalityinfo FROM getchildfatality (ISR.intakeserviceid::character varying,''servicerequest'') T),
		(SELECT getreportercjamspid FROM getreportercjamspid(''servicerequest'',ISR.intakeserviceid::character varying, ''reporter'')),isr.insertedon,isr.updatedon,
		''non-cps''::character varying as casetype
        from intakeservicerequest isr 
         LEFT JOIN intakedastatus as IDAS ON IDAS.intakenumber=ISR.intakenumber and IDAS.activeflag=1 
    INNER JOIN tmp_status ts ON ts.statustypeid =ISR.intakeserreqstatustypeid 
    WHERE ISR.activeflag=1  
	AND ISR.isrouted =true 
    AND ISR.Intakeserviceid:: character varying in (SELECT  objectid FROM routing R WHERE R.tosecurityusersid = '''||v_securityid||''' AND R.activeflag=1 '||v_searchvalisr||'))x
 ORDER BY x.insertedon,x.updatedon  desc
 limit '|| pagesize||' offset '||v_pageoffset; 

   raise notice 'query_toexecute%',query_toexecute;
    
    return query execute query_toexecute;

END;




$function$
