CREATE OR REPLACE FUNCTION cjams.getreferrallist(searchobj json, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS json
 LANGUAGE plpgsql
AS $function$

DECLARE  

	v_taxid numeric;
    v_providernm character varying;
    v_providerdecision character varying;
    v_referralid character varying;
    v_providerid int;
	v_pagenumber int;
	v_pageoffset int;
v_data json;
	
BEGIN 
v_taxid := searchobj ->> 'tax_id';
v_providernm := searchobj ->> 'provider_referral_nm';
v_providerdecision := searchobj ->> 'referral_decision';
v_referralid := searchobj ->> 'referral_id';
v_providerid := searchobj ->> 'provider_id';
v_pagenumber := v_liPageNumber - 1;
v_pageoffset := v_pagenumber * v_liPageSize;

		
select array_to_json(array_agg(row_to_json(t)))
from (
SELECT count(1) over() as totalcount,*,
    (
      select array_to_json(array_agg(row_to_json(d)))
      from (
        select pt.program_type, pt.program_type_id from tb_prov_ref_program_type pt
        where pt.referral_id = pr.provider_referral_id 
      ) d
    ) as provider_program_type
  from tb_provider_referral pr 
  where  (v_taxid is null or pr.corporation_entity_taxid=v_taxid) 
  and (v_referralid is null or pr.provider_referral_id=v_referralid) 
  and  (COALESCE(lower(pr.provider_referral_nm) ,'') LIKE COALESCE(lower(v_providernm) ,'')||'%')
    and  (COALESCE(lower(pr.referral_decision) ,'') LIKE COALESCE(lower(v_providerdecision) ,'')||'%')
       and (v_providerid is null or pr.provider_id=v_providerid)
        LIMIT v_liPageSize OFFSET v_pageoffset
) t into v_data;

return v_data;
END;

$function$
