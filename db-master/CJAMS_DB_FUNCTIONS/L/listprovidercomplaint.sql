drop function if exists listprovidercomplaint(userid character varying, p_status character varying, pagenumber integer, pagelimit integer, compliantno character varying, sortcolumn character varying, sortorder character varying);

CREATE OR REPLACE FUNCTION cjams.listprovidercomplaint(userid character varying, p_status character varying, pagenumber integer, pagelimit integer, compliantno character varying, sortcolumn character varying, sortorder character varying)
 RETURNS TABLE(totalcount bigint, provider_complaintid uuid, narrative text, complaint_number character varying,complaint_status character varying, provider_id integer, draft text, insertedon timestamp without time zone, inserted_by character varying, formatted_provider_nm character varying, updated_on timestamp without time zone, displayname character varying, status character varying, statusdesc text)
 LANGUAGE plpgsql
AS $function$

DECLARE 
v_pageoffset int;
v_pagenumber int;
v_pagelimit int;
v_limit int;
 totalcount integer;
 v_status character varying;
  v_userid character varying;

 BEGIN
 v_limit=10;
    v_pagenumber := pageNumber-1;
    v_pageoffset = v_pagenumber * v_limit;  
v_userid=null;
   
IF (p_status ='pending')  THEN
  	v_status=null;   


ELSIF  (p_status='refferalsubmit')  then
    v_userid='refferalsubmit'; 
  	v_status='27';
   
   
   ELSIF  (p_status='refferal_approved')  then
   v_userid=null; 
  	v_status='28';
  
     ELSIF  (p_status='refferel_rejected')  then
   v_userid=null; 
  	v_status='29';
  
    ELSIF  (p_status='complaint_submited')  then
    v_userid='complaint_submited'; 
  	v_status='31';
  
   ELSIF  (p_status='closed')  then
   v_userid=null; 
  	v_status='32';
  
    end if;

 RETURN QUERY 
	

select count(1)  over(),  TPC.provider_complaintid,  TPC.narrative,  
TPC.complaint_number,TPC.complaint_status,  TPC.provider_id,
 CASE  TPC.is_draft   WHEN  1 THEN  'Completed'  ELSE 'Draft'  end as draft, 
-- CASE     WHEN RTs.routingstatustypekey is null THEN  'Draft'  ELSE RTs.routingstatustypekey  end as draft, 
TPC.inserted_on, TPC.inserted_by,TB.formatted_provider_nm,TPC.updated_on,UP.displayname,
CASE     WHEN RTs.routingstatustypekey is null THEN  'Draft'  ELSE RTs.routingstatustypekey  end as status,
CASE     WHEN RTs.typedescription is null THEN  'Pending'  ELSE RTs.typedescription  end as statusdesc
	FROM  tb_provider_complaint TPC 
		left join tb_provider TB on TB.provider_id=TPC.provider_id
		left join userprofile UP on UP.securityusersid=TPC.inserted_by
		LEFT  JOIN  routing  r  ON  r.objectid  = TPC.complaint_number  AND  (r.activeflag  =1 )  and  r.eventcode in ('PRCM')
		LEFT  JOIN  routingstatustype  RTs  ON  RTs.sequencenumber  =  r.routingstatustypeid  and  rts.activeflag  =1  
		LEFT  JOIN  teammemberroletype  rt  on  rt.roletypekey  =  r.toroleid  AND  rt.activeflag  =1

where TPC.activeflag=1 
and  CASE WHEN v_status is  NULL THEN (TPC.is_draft = 0 or TPC.complaint_status='27' or TPC.complaint_status='29')
ELSE (TPC.complaint_status = v_status::character varying) 
end
 
--and case
--WHEN v_userid is  null THEN (TPC.inserted_by=userid)
--ELSE (r.tosecurityusersid = userid) end
and TPC.complaint_number like  compliantno||'%'

group by TPC.provider_complaintid,TPC.narrative,TPC.provider_id,
TPC.is_draft,TPC.inserted_on,TPC.inserted_by,
TB.formatted_provider_nm,TPC.updated_on,UP.displayname,RTs.routingstatustypekey,RTs.typedescription
order by  
	( CASE sortorder when 'asc' then 
		CASE sortcolumn 
		when 'datereceived' then 
          cast( TPC.inserted_on as character varying)          
		else cast( TPC.inserted_on as character varying) end end) asc,
	( CASE sortorder when 'desc' then 
		CASE sortcolumn 
		when 'datereceived' then 
          cast( TPC.inserted_on as character varying)          
		else cast( TPC.inserted_on as character varying) end end) desc
	
	LIMIT v_limit OFFSET v_pageoffset ;  
          RAISE  NOTICE  'v_userid%',v_userid;              
end

$function$
