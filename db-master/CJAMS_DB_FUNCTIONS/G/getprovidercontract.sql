DROP function if exists getprovidercontract(searchobj json);

CREATE OR REPLACE FUNCTION cjams.getprovidercontract(searchobj json)
 RETURNS TABLE(totalcount bigint, provider_id integer, mail_code_tx character varying, tax_id_no numeric, provider_nm character varying, provider_first_nm character varying, provider_last_nm character varying, address character varying,county_name character varying, rate_details json)
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 02/06/2023 Vineet Tirodkar - To fix Provider Contract Rates Info Display Issue (CDM-28439) 
-------------------------------------------------------------------------------------------------------------
DECLARE 
	v_Providerid INT;
	v_ProviderName VARCHAR(50);
	v_taxid INT;
	v_Firstname varchar(50); 
	v_Lastname varchar(50);
	v_Mailcode varchar(50);

	v_pageSize int;
	v_pageNumber int;
	v_pageNum int;
	v_pageOffset int;

BEGIN 
	v_pageNumber := searchobj ->> 'pagenumber' ;
	v_pageNum := v_pageNumber - 1;
	v_pageSize := searchobj ->> 'pagesize' ;
	v_pageOffset = v_pageNum * v_pageSize;

	v_Providerid := searchobj ->> 'providerid';
	v_ProviderName := searchobj ->> 'providername';  
	v_taxid := searchobj ->> 'taxid'; 
	v_Firstname := searchobj ->> 'fname'; 
	v_Lastname := searchobj ->> 'lname'; 
	v_Mailcode := searchobj ->> 'mailcode';

	return query 
	select count(1) over(),
		prov.provider_id,
		prov.mail_code_tx,
		prov.tax_id_no,
		(case when prov.provider_nm is null then concat_ws(' ',prov.provider_first_nm,prov.provider_middle_nm,prov.provider_last_nm) else prov.provider_nm end ) as provider_nm,
		prov.provider_first_nm,
		prov.provider_last_nm,
		(select  concat_ws(' ',
		coalesce(tpa.adr_street_tx,''),
		(select coalesce(value_tx,'') from tb_picklist_values where trim(picklist_value_cd)= ANY(select trim(tpa.adr_pre_dir_cd)  from 
		tb_provider_addresses tpa where  tpa.parent_key_id = prov.provider_id::character varying and tpa.delete_sw ='N' limit 1) and picklist_type_id='69')
		,coalesce(tpa.adr_street_nm,'')
		,(select coalesce(value_tx,'') from tb_picklist_values where trim(picklist_value_cd)= ANY(select trim(tpa.adr_street_suffix_cd)  from 
		tb_provider_addresses tpa where  tpa.parent_key_id = prov.provider_id::character varying and tpa.delete_sw ='N' limit 1) and picklist_type_id='212')
		,(select value_tx from tb_picklist_values where trim(picklist_value_cd)= ANY(select trim(tpa.adr_unit_type_cd)  from 
		tb_provider_addresses tpa where  tpa.parent_key_id = prov.provider_id::character varying and tpa.delete_sw ='N' limit 1) and picklist_type_id='250')
		,coalesce(tpa.adr_unit_no_tx,''),
		coalesce(tpa.adr_city_nm,'')
		) || ', ' ||   concat_ws(' ',coalesce(tpa.adr_state_cd,''),coalesce(tpa.adr_zip5_no :: character varying,'')) 
		):: character varying as address,ct.countyname,
		(select json_agg(x) 
			from (select   tcp.program_id, tcp.start_dt as programstartdate,tcp.end_dt as programenddate,
				tcp.license_no, tpl.license_level, tpl.license_type, tpl.site_id,tprm.annual_rate,
				tprm.monthly_rate,tprm.per_diem_rate,tprm.start_dt,tprm.end_dt,tcp.program_nm,ct.countyname 
			from tb_provider_contracts tpc 
				inner JOIN tb_contract_program tcp ON tpc.contract_id = tcp.contract_id
				inner JOIN tb_provider_licensing tpl on tpl.license_no = tcp.license_no
				left join tb_provider_rates_master tprm on tprm.provider_id=tpc.provider_id
				left join county ct on ct.countyid::varchar = prov.county_cd_tx
			where tpc.provider_id = prov.provider_id) as x) as rate_details
	from tb_provider prov
		inner join tb_provider_addresses tpa on prov.provider_id = parent_key_id::integer 
			and tpa.delete_sw = 'N'
			and tpa.adr_default_sw = 'Y'
			and tpa.adr_type_cd = '3357' -- Provider Location
		left join county ct on ct.countyid::varchar= prov.county_cd_tx
	where (v_providerid is null or  prov.provider_id = v_Providerid)  
		and (case when (trim(v_ProviderName) !=''  or v_ProviderName is not null)  then (COALESCE(lower(prov.provider_nm) ,'') LIKE '%'||COALESCE(lower(v_ProviderName) ,'')||'%') else true end 
			or case when (trim(v_ProviderName) !=''  or v_ProviderName is not null)  then soundex(lower(trim(prov.provider_nm))) = soundex(lower(trim(v_ProviderName))) else true end)
		and (case when (trim(v_Firstname) !='' or v_Firstname is not null)then  (COALESCE(lower(prov.provider_first_nm) ,'') LIKE '%'||COALESCE(lower(v_Firstname) ,'')||'%') else true end
			or case when (trim(v_Firstname) !='' or v_Firstname is not null)then soundex(lower(trim(prov.provider_first_nm))) = soundex(lower(trim(v_Firstname))) else true end)
		and (case when (trim(v_Lastname) !='' or v_Lastname is not null ) then  (COALESCE(lower(prov.provider_last_nm) ,'') LIKE '%'||COALESCE(lower(v_Lastname) ,'')||'%') else true end 
			or case when (trim(v_Lastname) !='' or v_Lastname is not null ) then  soundex(lower(trim(prov.provider_last_nm))) = soundex(lower(trim(v_Lastname))) else true  end)
		and (v_taxid is null or prov.tax_id_no = v_taxid  )
		and (v_Mailcode is null or prov.mail_code_tx = v_Mailcode)
	limit v_pageSize offset v_pageOffset;

end;
$function$
;
