--DROP function if exists cjams.getpaymentnotice(character varying, character varying);
--DROP function if exists cjams.getpaymentnotice(character varying, character varying, character varying);
CREATE OR REPLACE FUNCTION cjams.getpaymentnotice(v_providerid character varying, v_receivable_detail_id character varying, v_collection_status_cd character varying, v_securityusersid character varying)
 RETURNS TABLE(provider_id integer, providername character varying, provideraddress text, receivables json, paymentdetails json, balancenotice jsonb, paymentdate text, totalbal numeric, amount numeric, startdate text, receivablebalanceno numeric, percentageno numeric, reciptdate text, useraddress jsonb)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 06/02/2023 - Vineet Tirodkar - To display default the provider’s default location address (CDM-31742)
--02/13/2025-Naresh Moola -Issue with A/R Notice not able to  generated.
------------------------------------------------------------------------------------------------------------
DECLARE                    
_offset    integer;

BEGIN    
 
return query
SELECT 
	tbp.provider_id, 
	(CASE WHEN (tbp.provider_nm is null OR tbp.provider_nm='') 
	THEN CONCAT(tbp.provider_first_nm,' ',tbp.provider_last_nm) 
	ELSE tbp.provider_nm END)
	as providername,
	concat_ws(' ',
		coalesce(provadd.adr_street_tx,''),
		(case when provadd.adr_pre_dir_cd is not null then
			coalesce((	select coalesce(value_tx,'') 
					from tb_picklist_values 
				where trim(picklist_value_cd) in (trim(provadd.adr_pre_dir_cd)) 
					and picklist_type_id = '69'),'')
		else
			''
		end),
		coalesce(provadd.adr_street_nm,''),
		(case when provadd.adr_street_suffix_cd is not null then
			coalesce((	select coalesce(value_tx,'') 
					from tb_picklist_values 
				where trim(picklist_value_cd) in ( trim(provadd.adr_street_suffix_cd) ) 
					and picklist_type_id = '212'
					),'')
		else
			''			
		end),
		(case when provadd.adr_post_dir_cd is not null then
			coalesce((	select coalesce(value_tx,'') 
					from tb_picklist_values 
				where trim(picklist_value_cd) in (trim(provadd.adr_post_dir_cd)) 
					and picklist_type_id = '69'
			),'')
		else
			''
		end),
		(case when provadd.adr_unit_type_cd is not null then
			coalesce((	select value_tx 
					from tb_picklist_values 
				where trim(picklist_value_cd) in (trim(provadd.adr_unit_type_cd) )
				and picklist_type_id = '250'
			),'')
		else
			''
		end)	,
		coalesce(provadd.adr_unit_no_tx,'') 
		|| '<br>' ||
		(case when provadd.adr_city_nm is not null then 
			coalesce(provadd.adr_city_nm,'') || ',' 
		else
			''
		end),
		coalesce((	select value_tx 
						from tb_picklist_values 
					where trim(picklist_value_cd) in (trim(provadd.adr_state_cd) ) 
						and picklist_type_id = '211'),''),
		(case when provadd.adr_zip4_no is not null then
			coalesce(lpad(provadd.adr_zip5_no::character varying, 5, '0') ,'')
			|| '-' ||  coalesce(lpad(provadd.adr_zip4_no::character varying, 4, '0'), '')
		else
			coalesce(lpad(provadd.adr_zip5_no::character varying, 5, '0') ,'')		
		end)
		|| '<br>' ||		
		coalesce((case when provadd.adr_county_cd  is not null and btrim(provadd.adr_county_cd) <> '3825' then
		'(County: ' 
		|| coalesce((select coalesce(cnty.countyname,'') 
				from county cnty 
			where cnty.statecountycode = provadd.adr_county_cd 
				and activeflag = 1
		),'') || ')'
	 when btrim(provadd.adr_county_cd) = '3825'	then
		'(Out of State)'	
	 else 
		''
	 end),'')	
	) as provideraddress,
	(  SELECT  json_agg(x)   FROM (
			select    p.firstname ||' ' ||p.lastname as childname, 
					  p.dob ,
	  				  'Placement/Living Arrangement' as service,
	 				  trd.start_dt,
	 				  trd.end_dt,
	 				  receivable_balance_no as amount,
	 				  p.cjamspid,
  	 				 (select (select value_tx from tb_picklist_values where 
							TRIM(PICKLIST_VALUE_CD)=pa.county
							AND PICKLIST_TYPE_ID='328')  from person pp ,personaddress pa 
  	 				 where pp.personid=pa.personid and pp.cjamspid = p.cjamspid 
  					 and pp.activeflag=1 and pa.activeflag=1   
  					 order by pa.insertedon desc limit 1) as county
  	 ) x  ) as receivables,
	 (  SELECT  json_agg(x)   FROM (
		 	     select p.firstname ||' ' ||p.lastname as childname, p.cjamspid, p.dob, 'Placement/Living Arrangement' as service,
		         trd.start_dt, trd.end_dt, tph.payment_id ,tph.payment_dt, tph.gross_amount_no, trd.amount_no, trd.receivable_balance_no, 
		         rf.value_tx As county, trd.receivable_detail_id, to_char(trd.create_ts, 'Mon YYYY')::text As receiptdate
		         from tb_payment_detail tpd, tb_receivable_detail trd, tb_payment_header tph, tb_picklist_values rf,	person p ,tb_receivable_collection_status rcs
				 where tpd.payment_detail_id = trd.payment_detail_id 
  				 and trd.receivable_detail_id=rcs.receivable_detail_id and rcs.delete_sw='N' and trim(rcs.collection_status_cd) = v_collection_status_cd
				 and TRIM(rf.PICKLIST_VALUE_CD)= trd.county_cd and rf.PICKLIST_TYPE_ID='328'
				 and  p.cjamspid=tpd.client_id and p.activeflag=1
				 and case when v_receivable_detail_id is not null then trd.receivable_detail_id ::character varying  LIKE v_receivable_detail_id ||'%' else true end
				 and tph.payment_id = tpd.payment_id and tph.provider_id = v_Providerid::int
				 order by tph.payment_id desc
			 ) x ) as paymentdetails ,
	 (select json_agg(x) from
	      ( 
	       select trl.collected_amount_no, trl.create_ts, a.localdept from
            (select distinct trd.receivable_detail_id, (select description_tx from tb_picklist_values where trim(picklist_value_cd)=trd.county_cd and picklist_type_id='104') as localdept
	     	from tb_payment_header tph
		    inner join tb_payment_detail tpd on tpd.payment_id= tph.payment_id
		    inner join tb_receivable_detail trd on trd.payment_detail_id = tpd.payment_detail_id 
			and trd.receivable_balance_no <> 0 and trd.receivable_balance_no is not null
			and trd.county_cd in (select statecountycode from county where golivedate <= CURRENT_DATE)
	    	where tph.provider_id=v_Providerid::int 
		    and trd.county_cd in (select statecountycode from county where golivedate <= CURRENT_DATE) 
		    and  trd.delete_sw='N'  
		    and trd.receivable_detail_id :: character varying 
			not in 
			(select objectid from routing r
				join tb_receivable_detail trde on trde.receivable_detail_id :: character varying = r.objectid
				join tb_receivable_header trhr on trhr.receivable_id=trde.receivable_id
				where r.eventcode = 'MANREC' and trhr.provider_id = v_Providerid::bigint
				and r.routingstatustypeid  in (73,75) and r.activeflag = 1 
				and trde.county_cd in (select statecountycode from county where golivedate <= CURRENT_DATE)
			))a left join tb_RECEIVABLE_LIQUIDATION trl on a.receivable_detail_id = trl.receivable_detail_id 
			 and  trl.delete_sw = 'N' 
			 order by trl.create_ts desc limit 1
    )  as x)::jsonb as balancenotice,
	to_char(trd.receivable_ts::date, 'MM/DD/YYYY')::text as paymentdate,	 
	(select sum(trdd.receivable_balance_no) from tb_receivable_detail trdd
		join tb_receivable_header ttrh on ttrh.receivable_id=trdd.receivable_id
		join tb_provider tp1 on tp1.provider_id =ttrh.provider_id where
		trdd.receivable_detail_id :: character varying 
		not in 
	(select objectid from routing r
		join tb_receivable_detail trde on trde.receivable_detail_id :: character varying = r.objectid
		join tb_receivable_header trhr on trhr.receivable_id=trde.receivable_id
		where r.eventcode = 'MANREC' and trhr.provider_id = v_providerid::bigint
		and r.routingstatustypeid in (73,75) and r.activeflag = 1 )
		and 
		tp1.provider_id= v_providerid::bigint and ttrh.delete_sw='N') as totalbal,
		ROUND(AVG(tpp.amount_no)::numeric,2) as amount,
		to_char(tpp.start_dt, 'MM/DD/YYYY')::text as startdate,
		ROUND(AVG(trd.receivable_balance_no)::numeric,2) as receivablebalanceno,
		tpp.percentage_no as percentageno,
	(select to_char(trl.create_ts, 'Mon YYYY')::text from tb_receivable_liquidation trl 
		where trl.receivable_detail_id ::character varying  LIKE v_receivable_detail_id ||'%'
		and trl.delete_sw ='N'
		order by trl.create_user_id limit 1) as reciptDate,
		(select json_agg(a) from (
			-- select up.address, up.zipcode, up.city, up.state
			-- from userprofileaddress up 
			-- where up.securityusersid = v_securityusersid
			-- and up.activeflag = 1
			select up.address, up.zipcode, up.city, up.state,
				( select phonenumber 
				    from userprofilephonenumber un
				   where un.securityusersid = up.securityusersid 
				    and un.activeflag = 1
				   order by updatedon desc
				   limit 1
				) as phonenumber
			from userprofileaddress up 
			where up.securityusersid = v_securityusersid
			and up.activeflag = 1
		) as a)::jsonb as useraddress
  	 from tb_provider tbp 
		 left join tb_provider_addresses provadd on provadd.parent_key_id = tbp.provider_id::character varying 
				and provadd.delete_sw = 'N' 
				and provadd.adr_default_sw = 'Y'
				and provadd.adr_type_cd  = '3357' -- Provider Location
		 left join tb_receivable_header trh on trh.provider_id = tbp.provider_id  and trh.delete_sw='N'
		 left join tb_receivable_detail trd on trd.receivable_id = trh.receivable_id  and trd.delete_sw='N'
		 left join tb_payment_detail tpd on tpd.payment_detail_id = trd.payment_detail_id and tpd.delete_sw='N'
		 left join tb_payment_header tph on tph.payment_id = tpd.payment_id and tph.delete_sw = 'N' 
		 left join tb_payment_plan tpp on trh.receivable_id = tpp.receivable_id and tpp.delete_sw ='N' and (tpp.end_dt is null or tpp.end_dt >= now())
		 left join person p on p.cjamspid=tpd.client_id and p.activeflag=1
	where tbp.provider_id ::character varying =  v_providerid::character varying 
		and tbp.delete_sw = 'N'
		and case when v_receivable_detail_id is not null then trd.receivable_detail_id ::character varying LIKE v_receivable_detail_id ||'%' else true end
	group by tbp.provider_id, provadd.adr_street_tx, provadd.adr_street_nm, provadd.adr_unit_no_tx,
		provadd.adr_pre_dir_cd, provadd.adr_street_suffix_cd, provadd.adr_post_dir_cd, provadd.adr_unit_type_cd, 
		provadd.adr_zip4_no, provadd.adr_county_cd, provadd.adr_city_nm, provadd.adr_state_cd, provadd.adr_zip5_no, 
		p.firstname, p.lastname, p.dob, trd.start_dt, trd.end_dt, trd.receivable_balance_no, p.cjamspid, trd.receivable_ts, 
		tpp.start_dt, tpp.percentage_no
	order by trd.receivable_ts;
 
  END;

$function$
;
