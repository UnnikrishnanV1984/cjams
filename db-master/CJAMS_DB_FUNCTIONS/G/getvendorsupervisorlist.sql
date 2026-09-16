drop function if exists getvendorsupervisorlist(character varying,bigint,bigint);
drop function if exists getvendorsupervisorlist(character varying,bigint,bigint,character varying);
drop function if exists getvendorsupervisorlist(character varying,bigint,bigint,character varying,character varying,json);
CREATE OR REPLACE FUNCTION cjams.getvendorsupervisorlist(v_vendorid character varying, v_lipagenumber bigint, v_lipagesize bigint,v_securityuserid character varying,v_filter character varying,v_sort json)
 RETURNS TABLE(totalcount bigint, vendorid character varying, vendorapplicantid uuid, org_nm character varying, referraldate character varying, status character varying,providerid character varying, address text, 
 approvaldate date,insertedon timestamp without time zone)
 LANGUAGE plpgsql
AS $function$
	
DECLARE
    	v_pagenumber int;
	    v_pageoffset int;
	     v_status text[];
	   v_active character varying;
	   v_direction character varying;
	  searchstring character varying(1000);
	 querytxt text;
	   v_orderby character varying;
	
BEGIN
        v_pagenumber := v_liPageNumber - 1;
        v_pageoffset := v_pagenumber * v_liPageSize;
         v_status := v_filter;
       v_active := v_sort ->> 'active';
      v_direction := v_sort ->> 'direction';
     v_securityuserid := concat ('''',v_securityuserid,'''');
  
     searchstring := concat('and va.status = ANY (','''',v_status,'''',')') ;
    v_orderby := concat('order by ',v_active,' ',v_direction);
   if(v_active is not null) then
    searchstring := concat(searchstring,' ',v_orderby);
  end if;
 

querytxt :=	

'select count(1) over() as totalcount, x.* from (select va.vendorid,va.vendorapplicantid,va.org_nm,va.create_ts as referraldate,va.status,va.providerid,
 (select concat_ws('' '',tva.adr_1,tva.adr_2,tva.adr_city_nm,tva.adr_state_cd,tva.adr_zip_no) 
from tb_vendor_addresses tva where tva.vendorapplicantid=va.vendorapplicantid and tva.adr_end_dt is null limit 1)  as address,va.approvaldate,
r.insertedon
from tb_vendor_applicant va
inner join routing r on r.objectid= va.vendorid and r.activeflag=1 and r.tosecurityusersid='||v_securityuserid||'
where va.delete_sw=''N''' ||searchstring||') as x limit '||v_liPageSize||' offset '||v_pageoffset||'';
--order by x.insertedon desc
--and va.vendorapplicantid=v_vendorid
--LIMIT v_liPageSize OFFSET v_pageoffset;

 raise notice 'querytxt%',querytxt;
return query execute querytxt;

END;

$function$;
