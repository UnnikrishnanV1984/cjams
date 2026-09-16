-- CDM-3556 -- FM105R Payee Name - Prov CELEBREE
/*
-- Issue Description: 
   FM105R report reflects incorrect payee name. 
 
-- Category/ Module: CJAMS - D365 Interface ( Finanace Management )
-- Root cause: CJAMS – D365 (AFS) Interface SP is capturing wrong Provider Name 
					   when tb_provider table is having data in provider_nm column as well as in provider_first_nm 
					   & provider_last_nm columns.
-- Pull request# Tanmay will check-in this code
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: 12/17/2020
*/

-- Update tb_afs_interfaces
-- Before
select payment_id, payee_nm, payee_alpha_sort_nm, payee_nbr 
		, ( select provider_nm from tb_provider where provider_id = payee_nbr )
		, ( select provider_first_nm  || ' ' || provider_last_nm from tb_provider where provider_id = payee_nbr )
	from tb_afs_interfaces 
where payment_id 
	in (	
		select ph.payment_id
		from tb_payment_header ph,
			tb_payment_status ps,
			tb_provider pr
		where ph.payment_id = ps.payment_id
			and ph.provider_id = pr.provider_id
			and ph.payment_type_cd not in ('6','5689','7', '5989')
			and ph.payment_id >= 2896828 -- First CJAMS Payment ID
			and ph.delete_sw = 'N'
			and ps.delete_sw = 'N'
			and pr.delete_sw = 'N'
			and pr.provider_nm is not null
			and btrim(pr.provider_nm) <> ''
			and pr.provider_first_nm is not null
			and btrim(pr.provider_first_nm) <> ''
			and btrim(pr.provider_nm) <> btrim(pr.provider_first_nm) || ' ' || btrim(pr.provider_last_nm) 
		order by ph.provider_id
		) ;

-- Update
update tb_afs_interfaces
	set payee_nm = ( select substring(provider_nm,1,40) from tb_provider where provider_id = payee_nbr ),
		payee_alpha_sort_nm = ( select substring(provider_nm,1,40) from tb_provider where provider_id = payee_nbr ),
		update_user_id = 'CDM-3556',
		update_ts = now()
where payment_id 
	in (	
		select ph.payment_id
		from tb_payment_header ph,
			tb_payment_status ps,
			tb_provider pr
		where ph.payment_id = ps.payment_id
			and ph.provider_id = pr.provider_id
			and ph.payment_type_cd not in ('6','5689','7', '5989')
			and ph.payment_id >= 2896828 -- First CJAMS Payment ID
			and ph.delete_sw = 'N'
			and ps.delete_sw = 'N'
			and pr.delete_sw = 'N'
			and pr.provider_nm is not null
			and btrim(pr.provider_nm) <> ''
			and pr.provider_first_nm is not null
			and btrim(pr.provider_first_nm) <> ''
			and btrim(pr.provider_nm) <> btrim(pr.provider_first_nm) || ' ' || btrim(pr.provider_last_nm) 
		order by ph.provider_id
		) ;

	
-- Update tb_afs_interfaces_iss
-- Before
select payment_id, payee_nm, payee_alpha_sort_nm, payee_nbr 
		, ( select provider_nm from tb_provider where provider_id = payee_nbr )
		, ( select provider_first_nm  || ' ' || provider_last_nm from tb_provider where provider_id = payee_nbr )
	from tb_afs_interfaces_iss 
where payment_id 
	in (	
		select ph.payment_id
		from tb_payment_header ph,
			tb_payment_status ps,
			tb_provider pr
		where ph.payment_id = ps.payment_id
			and ph.provider_id = pr.provider_id
			and ph.payment_type_cd not in ('6','5689','7', '5989')
			and ph.payment_id >= 2896828 -- First CJAMS Payment ID
			and ph.delete_sw = 'N'
			and ps.delete_sw = 'N'
			and pr.delete_sw = 'N'
			and pr.provider_nm is not null
			and btrim(pr.provider_nm) <> ''
			and pr.provider_first_nm is not null
			and btrim(pr.provider_first_nm) <> ''
			and btrim(pr.provider_nm) <> btrim(pr.provider_first_nm) || ' ' || btrim(pr.provider_last_nm) 
		order by ph.provider_id
		) ;

-- Update
update tb_afs_interfaces_iss
	set payee_nm = ( select substring(provider_nm,1,40) from tb_provider where provider_id = payee_nbr ),
		payee_alpha_sort_nm = ( select substring(provider_nm,1,40) from tb_provider where provider_id = payee_nbr ),
		update_user_id = 'CDM-3556',
		update_ts = now()
where payment_id 
	in (	
		select ph.payment_id
		from tb_payment_header ph,
			tb_payment_status ps,
			tb_provider pr
		where ph.payment_id = ps.payment_id
			and ph.provider_id = pr.provider_id
			and ph.payment_type_cd not in ('6','5689','7', '5989')
			and ph.payment_id >= 2896828 -- First CJAMS Payment ID
			and ph.delete_sw = 'N'
			and ps.delete_sw = 'N'
			and pr.delete_sw = 'N'
			and pr.provider_nm is not null
			and btrim(pr.provider_nm) <> ''
			and pr.provider_first_nm is not null
			and btrim(pr.provider_first_nm) <> ''
			and btrim(pr.provider_nm) <> btrim(pr.provider_first_nm) || ' ' || btrim(pr.provider_last_nm) 
		order by ph.provider_id
		) ;
	
	
	