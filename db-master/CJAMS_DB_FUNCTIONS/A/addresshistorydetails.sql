-- Drop function if exists addresshistorydetails(bigint);
CREATE OR REPLACE FUNCTION cjams.addresshistorydetails(v_providerid bigint)
 RETURNS TABLE(address_type text,startdate date,enddate date,address text,fullname character varying,update_ts date)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 05/20/2022 Vineet Tirodkar - To make address format consistency on Provider Information & Address History screens (CDM-21991)
------------------------------------------------------------------------------------------------------------	
DECLARE	

BEGIN  
RETURN QUERY 
	select ( select trim(value_tx) 
			from tb_picklist_values
		where trim(picklist_value_cd) = trim(tpa.adr_type_cd)  
			and picklist_type_id = '10' 
		limit 1) as address_type,
		tpa.adr_start_dt,
		tpa.adr_end_dt,
		( 
			coalesce(tpa.adr_street_tx,'') || ' ' ||
			(	select coalesce(value_tx,'') 
					from tb_picklist_values 
				where trim(picklist_value_cd) in (trim(tpa.adr_pre_dir_cd)) 
					and picklist_type_id = '69') || ' ' ||
			coalesce(tpa.adr_street_nm,'') || ' ' ||
			(	select coalesce(value_tx,'') 
					from tb_picklist_values 
				where trim(picklist_value_cd) in ( trim(tpa.adr_street_suffix_cd) ) 
					and picklist_type_id = '212'
			) || ' ' ||
			(	select coalesce(value_tx,'') 
					from tb_picklist_values 
				where trim(picklist_value_cd) in (trim(tpa.adr_post_dir_cd)) 
					and picklist_type_id = '69'
			) || ' ' ||
			(	select value_tx 
					from tb_picklist_values 
				where trim(picklist_value_cd) in (trim(tpa.adr_unit_type_cd) )
				and picklist_type_id = '250'
			) || ' ' ||
			coalesce(tpa.adr_unit_no_tx,'') || chr(10) ||
			coalesce(tpa.adr_city_nm,'') 
			|| (case when tpa.adr_city_nm is not null then 
					', '
				end) || ' ' ||
			coalesce((	select value_tx 
							from tb_picklist_values 
						where trim(picklist_value_cd) in (trim(tpa.adr_state_cd) ) 
							and picklist_type_id = '211'),'') || ' ' ||
			(case when tpa.adr_zip4_no is not null then
				coalesce(lpad(tpa.adr_zip5_no::character varying, 5, '0') ,'')
				|| '-' ||  coalesce(lpad(tpa.adr_zip4_no::character varying, 4, '0'), '')
			else
				coalesce(lpad(tpa.adr_zip5_no::character varying, 5, '0') ,'')		
			end) || chr(10) ||
			(case when tpa.adr_county_cd  is not null and btrim(tpa.adr_county_cd) <> '3825' then
				'(County: ' 
				|| (select coalesce(cnty.countyname,'') 
						from county cnty 
					where cnty.statecountycode = tpa.adr_county_cd 
						and activeflag = 1
				) || ')'
			 when btrim(tpa.adr_county_cd) = '3825'	then
				'(Out of State)'	
			 end)
		) as address
		,up.fullname,
		tpa.update_ts::date
	from tb_provider_addresses tpa 
		inner join tb_provider tbp on tbp.provider_id = tpa.parent_key_id::int
		left join muser m on m.securityusersid = tpa.update_user_id 
			or m.username = tpa.update_user_id
		left join userprofile up on up.securityusersid = m.securityusersid
	where TBP.provider_id = v_providerid 
		and tpa.adr_type_cd in ('3356','3357') 
		--and tpa.adr_end_dt is not null 
		and tpa.delete_sw = 'N' 
	order by tpa.adr_end_dt desc;
 END;

$function$;
