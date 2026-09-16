
drop function if exists get_providerchilddetails(bigint,bigint,bigint);
CREATE OR REPLACE FUNCTION cjams.get_providerchilddetails(v_providerid bigint, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint,personid uuid,firstname character varying,lastname character varying,dob timestamp without time zone, 
 gendertypekey character varying,gendertypedesc character varying,cjamspid bigint,nationalitytypekey character varying)
 LANGUAGE plpgsql
AS $function$

DECLARE  
     v_pagenumber int;
	v_pageoffset int;

	
BEGIN 
     v_pagenumber := v_liPageNumber - 1;
	 v_pageoffset := v_pagenumber * v_liPageSize;

	return query
		
	select count(1) over() as totalcount,x.* from (select distinct  p.personid,p.firstname,p.lastname,p.dob,p.gendertypekey,gt.typedescription as gendertypedesc,p.cjamspid,p.nationalitytypekey from placement pl
inner join person p on p.personid=pl.personid and p.activeflag=1
left join gendertype gt on gt.gendertypekey = p.gendertypekey
where pl.altproviderid=v_providerid and pl.enddatetime is null and pl.activeflag=1) as x
 LIMIT v_liPageSize OFFSET v_pageoffset; 
END;

$function$
