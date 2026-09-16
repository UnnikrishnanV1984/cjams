DROP function if exists getprovidercontractrate( bigint,bigint,bigint);
Create or replace function getprovidercontractrate(v_providerid bigint,v_lipagesize bigint, v_lipagenumber bigint)
returns table (totalcount bigint,program_id int, 
programstartdate timestamp without time zone,
programenddate timestamp without time zone,
license_no character varying,license_level character varying,license_type character varying,
site_id integer, annual_rate numeric,monthly_rate numeric,per_diem_rate numeric,
start_dt timestamp without time zone,end_dt timestamp without time zone,
program_nm character varying)
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 02/06/2023 Vineet Tirodkar - To fix Provider Contract Rates Info Display Issue (CDM-28439) 
-------------------------------------------------------------------------------------------------------------
DECLARE 
	v_pagenumber int;
	v_pageoffset int;

BEGIN 
	IF COALESCE(v_liPageSize, 0) < 1 THEN                     
		v_liPageSize := 10;
	END IF;
	IF COALESCE(v_liPageNumber, 0) < 1 THEN
		v_liPageNumber := 1;	
	end if;

	v_pagenumber := v_liPageNumber - 1;
	v_pageoffset := v_pagenumber * v_liPageSize;

	return query 
	select count(1) over() as totalcount,   
		tcp.program_id, 
		tcp.start_dt as programstartdate,
		tcp.end_dt as programenddate,
		NULL::character varying as license_no, 
		-- tcp.license_no, 
		NULL::character varying as license_level,
		-- tpl.license_level, 
		NULL::character varying as license_type, 
		-- tpl.license_type, 
		NULL::integer as site_id,
		-- tpl.site_id,
		-- tprm.annual_rate,
		-- tprm.monthly_rate,
		-- tprm.per_diem_rate,
		-- tprm.start_dt,
		-- tprm.end_dt,
		ppr.annual_rate_no as annual_rate,
		ppr.monthly_rate_no as monthly_rate,
		ppr.per_diem_rate_no as per_diem_rate,
		ppr.start_dt::timestamp without time zone as start_dt,
		ppr.end_dt::timestamp without time zone as end_dt,
		tcp.program_nm 
	from tb_provider_contracts tpc 
		inner JOIN tb_contract_program tcp ON tpc.contract_id = tcp.contract_id
			and tcp.delete_sw = 'N'
		-- inner join prov.tb_prov_program_sites pps on pps.program_id = tcp.program_id
		--	and pps.delete_sw = 'N'
		inner join prov.tb_prov_program_rates ppr on ppr.program_id = tcp.program_id
			and ppr.delete_sw = 'N'	
		-- inner JOIN tb_provider_licensing tpl on tpl.license_no = tcp.license_no
		-- left join tb_provider_rates_master tprm on tprm.provider_id=tpc.provider_id
		where ( tpc.provider_id = v_providerid 
				or 
				tpc.provider_id =
					(	select distinct pr.affiliate_provider_id
						from prov.tb_prov_program_sites pps,
							prov.tb_provider pr
						where pps.site_id = pr.provider_id
							and pps.site_id = v_providerid
							and pps.delete_sw = 'N'
							and pr.delete_sw = 'N'
					)	
				or
				tpc.provider_id =
					(select distinct pr.affiliate_provider_id 
						from prov.tb_prov_program_facility ppf,
							prov.tb_provider pr
						where ppf.provider_id = pr.provider_id
						and ppf.provider_id = v_providerid
						and ppf.delete_sw = 'N'	
						and pr.delete_sw = 'N'
					)	
				)   	
			and tpc.delete_sw = 'N'
		order by tcp.program_id,
			ppr.start_dt desc
		LIMIT v_liPageSize OFFSET v_pageoffset; 
end;
$function$;
