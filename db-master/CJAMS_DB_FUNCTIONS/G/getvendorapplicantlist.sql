drop function if exists getvendorapplicantlist(character varying,bigint,bigint);
drop function if exists getvendorapplicantlist(character varying,character varying,bigint,bigint);
drop function if exists getvendorapplicantlist(character varying,character varying,json,bigint,bigint);
-- FUNCTION: cjams.getvendorapplicantlist(character varying, character varying, json, bigint, bigint)

CREATE OR REPLACE FUNCTION cjams.getvendorapplicantlist(
	v_vendorid character varying,
	v_filter character varying,
	v_sort json,
	v_lipagenumber bigint,
	v_lipagesize bigint)
    RETURNS TABLE(totalcount bigint, vendorid character varying, vendorapplicantid uuid, org_nm character varying, referraldate character varying, status character varying,submittedfor character varying, address text, approvaldate date, jurisdiction character varying, narrative text, providerid character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
AS $BODY$
	
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
  
     searchstring := concat('and va.status = ANY (','''',v_status,'''',')') ;
    v_orderby := concat('order by ',v_active,' ',v_direction);


querytxt :=
'select count(1) over() as totalcount,va.vendorid,va.vendorapplicantid,va.org_nm,va.create_ts as referraldate,va.status,
(SELECT up.displayname FROM routing r 
INNER JOIN userprofile up ON up.securityusersid = r.tosecurityusersid AND up.activeflag = 1
WHERE r.activeflag =1 AND r.objectid = va.vendorid LIMIT 1),
 (select concat_ws('' '',tva.adr_1,tva.adr_2,tva.adr_city_nm,tva.adr_state_cd,tva.adr_zip_no)
from tb_vendor_addresses tva where tva.vendorapplicantid=va.vendorapplicantid and tva.adr_end_dt is null limit 1)  as address,va.approvaldate,va.jurisdiction,va.narrative,va.providerid
from tb_vendor_applicant va
where va.delete_sw=''N''' ||searchstring|| '' ||v_orderby||' LIMIT '||v_liPageSize ||' OFFSET '||v_pageoffset||'';
--order by case when v_active is not null then v_active  end 
--and va.vendorapplicantid=v_vendorid
--LIMIT v_liPageSize OFFSET v_pageoffset;
 raise notice 'querytxt%',querytxt;
return query execute querytxt;

END;

$BODY$;

ALTER FUNCTION cjams.getvendorapplicantlist(character varying, character varying, json, bigint, bigint)
    OWNER TO welfareadmin;

