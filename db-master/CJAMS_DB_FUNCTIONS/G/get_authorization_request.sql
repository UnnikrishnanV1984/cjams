DROP FUNCTION get_authorization_request(integer,boolean);
CREATE OR REPLACE FUNCTION cjams.get_authorization_request(v_authorizationid integer, isapproved boolean DEFAULT NULL::boolean)
 RETURNS TABLE(service_log_id bigint, tax_id_no character varying, casename character varying, case_id bigint, authorization_id integer, provider_id integer, provider_nm character varying, provider_address text, provider_ph character varying, case_worker jsonb, client_id bigint, justification_tx character varying, fiscal_category_desc character varying, start_dt text, end_dt text, cost_no numeric, voucher_sw character, final_amount_no numeric, service_nm character varying, clientname text, cfecareduration character varying, supervisor jsonb, rundate text, funding jsonb, payment jsonb, director jsonb, payment_id bigint)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 06/21/2023 Manasa Kasula - Fetching isapproved flag table instead of from the parameter (CDM-32093)
-- 11/09/2021 Vineet Tirodkar - Modifications for CJAMS - Performance Issue 
-- 11/23/2021 Vineet Tirodkar - To display Payment ID for isapproved = false condition (CDM-18560)
-- 06-07-2022 - Veera To get CFE Care Duration Details
-- 10-04-2024 - Parshal Chitrakar CDM-41976 Service Log Error, added activeflag check condition for userprofilephonenumber upp
-- 10-08-2024 - Parshal Chitrakar CDM-41976 Service Log Error, added logic for getting latest phone number
-- 08/06/2025 - Parshal Chitrakar CDM-44494	Modification for the supervisor name logic while downloading
-- 10/02/2025 - Vinesh Puthan CDM-44535 Case worker information not showing while downloading when the purchase authorization is in status Return to worker
------------------------------------------------------------------------
DECLARE	
v_isapproved boolean default false;

BEGIN  
	select case when count(1) > 0 then true else false end into v_isapproved from tb_service_purchase_authorization tss
	where tss.authorization_id = v_authorizationid and coalesce(btrim(tss.payment_approval_status_cd),'') = '3047';
	if (v_isapproved = true)
	then 
		RETURN query 
		select tss.service_log_id,
			-- lpad(tss.tax_id_no::character varying ,9,'0')::character varying,
			(case when btrim(prov_tax_type_cd) = '2518' then
				 left(lpad(tss.tax_id_no::character varying ,9,'0')::character varying,3) || '-' || 
				 substr(lpad(tss.tax_id_no::character varying ,9,'0')::character varying,4, 2) || '-' || 
				 substr(lpad(tss.tax_id_no::character varying ,9,'0')::character varying,6, length(lpad(tss.tax_id_no::character varying ,9,'0')::character varying))
			 else
				 left(lpad(tss.tax_id_no::character varying ,9,'0')::character varying,2) || '-' || 
				 SUBSTR(lpad(tss.tax_id_no::character varying ,9,'0')::character varying,3, length(lpad(tss.tax_id_no::character varying ,9,'0')::character varying))
			 end )::character varying,
			tss.case_nm,
			tss.case_id,
			(tss.authorization_id)::int,
			(tss.provider_id)::int,
			tss.provider_name,
			tss.provider_address::text,
			tss.provider_phone,
			(select row_to_json(x) from
				(select tss.worker_name as fullname,
					tss.ldss_address as address,
					(select c.countyname
						from county c
					 where c.statecountycode = tss.ldss_cd	
					 ) as localdepartment,
					tss.worker_staff_id as workerid,
					tss.requestor_name as requestorname,
					tss.requestor_phone as requestorphone 			
				) as x)::jsonb as case_worker,
			tss.client_id,
			tss.justification_tx::character varying,
			case when tss.fiscal_category_desc is not null then 
				(tss.fiscal_category_desc || ' (' || tss.fiscal_category_cd || ')')  :: character varying
			else 
				tss.fiscal_category_desc
			end as fiscalcode
			,to_char(tss.start_dt,'MM-DD-YYYY')::text 
			,to_char(tss.end_dt,'MM-DD-YYYY')::text 
			,tss.cost_no,tss.voucher_sw
			,tss.final_amount_no
			,tss.provider_service_desc
			,tss.client_name::text
			, (select tpv.description_tx from tb_service_purchase_authorization tspa left join tb_picklist_values tpv on tpv.picklist_type_id = '11001' and tspa.cfecareduration  = tpv.picklist_value_cd  where tspa.authorization_id = v_authorizationid::int limit 1) 
			,(select row_to_json(x) from
				(select  case when tss.fiscal_category_cd = '7108' then
				    (select up1.fullname from routing r1 
					  join userprofile up1 on up1.securityusersid=r1.fromsecurityusersid 
					  join tb_service_purchase_authorization tspaaa on tspaaa.authorization_id :: character varying = r1.objectid and routingstatustypeid = 40
				      where r1.objectid = v_authorizationid::character varying
					 ) else  tss.supervisor_name end as fullname,
					to_char(tss.sprvsr_approval_dt,'MM-DD-YYYY')::text as insertedon 
				) as x) ::jsonb,
			coalesce((select to_char(route.insertedon ,'MM-DD-YYYY')::text  
						from routing route 
					 where route.objectid::character varying = tss.authorization_id::character varying 
						and routingstatustypeid=39 limit 1),''
			)::text	as rundate
			,(select row_to_json(x) from
				(select  tss.funding_name as fullname,
					to_char(tss.funding_approval_dt ,'MM-DD-YYYY')::text as insertedon 
				) as x)::jsonb
			,(select row_to_json(x) from
				(select  tss.payment_name as fullname,
					to_char(tss.payment_approval_dt ,'MM-DD-YYYY')::text as insertedon 
			 ) as x) ::jsonb
			 ,(select row_to_json(x) from
				(select  tss.director_name as fullname,
					to_char(tss.ads_approval_dt ,'MM-DD-YYYY')::text as insertedon  
			  ) as x)::jsonb,
			 payhead.payment_id::bigint
		from tb_slpa_snapshot tss  
			left join tb_payment_header payhead on payhead.authorization_id = tss.authorization_id 
				and payhead.delete_sw='N'
		where tss.authorization_id=v_authorizationid;
	else
	 	RETURN QUERY 
		select  tsl.service_log_id,
			(case when btrim(prov_tax_type_cd) = '2518' then
				 left(lpad(prov.tax_id_no::character varying ,9,'0')::character varying,3) || '-' || 
				 substr(lpad(prov.tax_id_no::character varying ,9,'0')::character varying,4, 2) || '-' || 
				 substr(lpad(prov.tax_id_no::character varying ,9,'0')::character varying,6, length(lpad(prov.tax_id_no::character varying ,9,'0')::character varying))
			 else
				 left(lpad(prov.tax_id_no::character varying ,9,'0')::character varying,2) || '-' || 
				 SUBSTR(lpad(prov.tax_id_no::character varying ,9,'0')::character varying,3, length(lpad(prov.tax_id_no::character varying ,9,'0')::character varying))
			 end )::character varying,
			(SELECT INITCAP(TRIM(P.firstname)||' '||TRIM(P.lastname) ||
				CASE WHEN P.middlename IS NOT NULL AND TRIM(P.middlename) != '' THEN ', ' || TRIM(P.middlename) ELSE '' END)
			FROM person as P 
			WHERE personid = (
				SELECT PersonId  
					FROM IntakeServiceRequestActor  
				where isheadofhousehold = true 
					and servicecaseid = 
						(select servicecaseid from servicecase 
							where servicecasenumber = tsl.case_id::varchar 
						)
					and activeflag = 1	
				LIMIT 1)
			):: character varying as case_nm,
			tsl.case_id,
			payauth.authorization_id,
			prov.provider_id,
			(CASE WHEN (prov.provider_nm is null OR prov.provider_nm='') THEN 
				CONCAT(prov.provider_first_nm,' ',prov.provider_last_nm) 
			 ELSE 
				prov.provider_nm 
			END) as provider_nm,
			(select provider_adr as paymentaddress from get_provider_address(prov.provider_id,trim('{3357,3356}') )):: text as provider_address,
			coalesce(prov.adr_cell_phone_tx,prov.adr_home_phone_tx,prov.adr_work_phone_tx) :: character varying,
			(select row_to_json(x) from
				(select distinct up.fullname,
					up.cjamspid as workerid,
					upp.phonenumber,
					upa.county as localdepartment,
					(concat_ws(' ',upa.address,upa.city) :: character varying
					|| ' ' ||
					concat_ws(' ',upa.state,upa.zipcode) :: character varying) as address,
					upa.city,
					upa.state,
					upa.country,
					ups.fullname as requestorname,
					upps.phonenumber as requestorphone,
					upps.updatedon  -- Included updatedon to fetch the latest worker phone record
				from routing rr 
					inner join userprofile up on up.securityusersid=rr.fromsecurityusersid
					inner join userprofile ups on ups.securityusersid = rr.fromsecurityusersid
					left join userprofilephonenumber upps on ups.securityusersid = upps.securityusersid and upps.activeflag =1 
					left join userprofilephonenumber upp on up.securityusersid = upp.securityusersid and upp.activeflag=1
					left join userprofileaddress upa on up.securityusersid = upa.securityusersid
				where rr.objectid = payauth.authorization_id::character varying 
					and rr.routingstatustypeid in ('39','850') 
					ORDER BY upps.updatedon DESC 
					LIMIT 1
			)as x)::jsonb as case_worker,
			tsl.client_id ,
			payauth.justification_tx::character varying,
			(tfcm.fiscal_category_desc || ' (' || tfcm.fiscal_category_cd || ')')::character varying as fiscalcode,
			to_char(payauth.start_dt,'MM-DD-YYYY')::text as start_dt,
			to_char(payauth.end_dt,'MM-DD-YYYY')::text as end_dt,
			payauth.cost_no,
			payauth.voucher_sw,
			payauth.final_amount_no,
			(select ts.service_nm 
				from tb_services ts 
			where ts.service_id = tps.service_id
			) as service_nm,
			
			concat(client.firstname,' ',client.lastname) as clientname,
		   (select tpv.description_tx from tb_service_purchase_authorization tspa left join tb_picklist_values tpv on tpv.picklist_type_id = '11001' and tspa.cfecareduration  = tpv.picklist_value_cd  where tspa.authorization_id = v_authorizationid::int limit 1),
			(select row_to_json(x) from
				(select case when payauth.fiscal_category_cd = '7108' then
				 (select up1.fullname from routing r1 
					  join userprofile up1 on up1.securityusersid=r1.fromsecurityusersid 
					  join tb_service_purchase_authorization tspaaa on tspaaa.authorization_id :: character varying = r1.objectid and routingstatustypeid = 40
				      where r1.objectid = v_authorizationid::character varying
					 ) else 
						(
			            SELECT 
			              CASE 
			                WHEN rr.routingstatustypeid = 39 THEN 
			                  CASE 
			                    WHEN (
			                      SELECT COUNT(*) 
			                      FROM routing rr2
			                      JOIN userprofile up2 ON up2.securityusersid = rr2.fromsecurityusersid
			                      JOIN tb_service_purchase_authorization tspaaa2 
			                        ON tspaaa2.authorization_id::varchar = rr2.objectid
			                      WHERE rr2.objectid = payauth.authorization_id::varchar
			                        AND rr2.eventcode IN ('PCAUTH', 'PCAUTHR')
			                        AND rr2.routingstatustypeid IN (40, 42)
			                    ) > 0 THEN
			                      (
			                        SELECT up2.fullname
			                        FROM routing rr2
			                        JOIN userprofile up2 ON up2.securityusersid = rr2.fromsecurityusersid
			                        JOIN tb_service_purchase_authorization tspaaa2 
			                          ON tspaaa2.authorization_id::varchar = rr2.objectid
			                        WHERE rr2.objectid = payauth.authorization_id::varchar
			                          AND rr2.eventcode IN ('PCAUTH', 'PCAUTHR')
			                          AND rr2.routingstatustypeid IN (40, 42)
			                        LIMIT 1
			                      )
			                    ELSE up.fullname
			                  END
			                ELSE up.fullname
			              END
						)
						END AS fullname,
					coalesce(to_char(payauth.sprvsr_approval_dt,'MM-DD-YYYY'),
					case when rr.routingstatustypeid = 62 and payauth.sprvsr_approval_status_cd is null  then 
						'Supervisor Denied' 
					else 
						'Pending' 
					end
					)::text as insertedon
				from routing rr 
					inner join userprofile up on up.securityusersid=rr.tosecurityusersid
				where rr.objectid= payauth.authorization_id::character varying  
					and rr.eventcode  in ('PCAUTH','PCAUTHR') order by rr.insertedon
					--and rr.toroleid='CWSP'
					--and rr.routingstatustypeid in (39,40,42, 62) order by rr.insertedon
			limit 1 )as x)::jsonb as supervisor,
			
			coalesce(
				(select to_char(route.insertedon ,'MM-DD-YYYY')::text   
					from routing route 
				 where route.objectid::character varying = payauth.authorization_id::character varying 
					and routingstatustypeid=39 limit 1),'')::text
				,(select row_to_json(x) from
					(select up.fullname,
						coalesce(to_char(payauth.funding_approval_dt,'MM-DD-YYYY'),
						case when rr.routingstatustypeid = 62 and rr.activeflag = 1 
							and (( payauth.sprvsr_approval_status_cd = '3047' 
							and case when payauth.cost_no < 1000 then 
								true 
						else 
								payauth.ads_approval_status_cd ='3047' 
						end 
						and payauth.funding_approval_status_cd is null) or payauth.funding_approval_status_cd = '3281') then
							'Funding Denied' 
				when rr.routingstatustypeid =62  
					and rr.activeflag = 1 
					and case when payauth.cost_no < 1000 then 
							true 
						else 
							payauth.ads_approval_status_cd is null 
						end 
					and payauth.funding_approval_status_cd is null  then 
						''
					else 
						'Pending' 
					end
				)::text as insertedon 
			from routing rr 
				inner join userprofile up on up.securityusersid=rr.tosecurityusersid  and rr.eventcode  in ('PCAUTH','PCAUTHR') 
			where rr.objectid = payauth.authorization_id::character varying 
				and  rr.routingstatustypeid in (40,44,62)  
			limit 1)as x)::jsonb as funding,
			
			(select row_to_json(x) from
				(select up.fullname,
					coalesce(to_char(payauth.payment_approval_dt,'MM-DD-YYYY'),
					case when rr.routingstatustypeid = 62 and ((payauth.funding_approval_status_cd='3047' 
						and case when payauth.cost_no < 1000 then 
							true 
					else 
						payauth.ads_approval_status_cd ='3047' 
					end 
					and payauth.payment_approval_status_cd is null) or payauth.funding_approval_status_cd = '3281') and rr.activeflag = 1 then 
						'Payment Denied' 
					when payauth.funding_approval_status_cd is null then
						'' 
					else 
						'Pending' 
					end)::text as insertedon
				from routing rr 
					inner join userprofile up on up.securityusersid=rr.tosecurityusersid  and rr.eventcode  in ('PCAUTH','PCAUTHR') 
				where rr.objectid = payauth.authorization_id::character varying 
				and  rr.routingstatustypeid in (41,43,62)  
			limit 1)as x)::jsonb as payment,
			
			(select row_to_json(x) from
				(select up.fullname,
					coalesce(to_char(payauth.ads_approval_dt,'MM-DD-YYYY'),
					case when rr.routingstatustypeid = 62 and rr.activeflag = 1 and payauth.sprvsr_approval_status_cd = '3047' 
						and case when payauth.cost_no >= 1000 then payauth.ads_approval_status_cd is null end then 
						'Director Denied' 
					when payauth.sprvsr_approval_status_cd is null then 
						''
					else 
						case when payauth.cost_no >= 1000 then 'Pending' else '' end end
				)::text as insertedon 
				from routing rr 
					inner join userprofile up on up.securityusersid=rr.tosecurityusersid  and rr.eventcode  in ('PCAUTH','PCAUTHR') 
				where rr.objectid = payauth.authorization_id::character varying 
					and payauth.cost_no >= 1000 
					and rr.toroleid = 'CWSP'
					and rr.routingstatustypeid in (40,42,44,62)  
			limit 1)as x)::jsonb as director,
			payhead.payment_id::bigint
		from tb_service_purchase_authorization payauth 
			join tb_service_log tsl on tsl.service_log_id = payauth.service_log_id 
			left JOIN person as client ON tsl.client_id = client.cjamspid and client.activeflag=1
			join tb_provider_services tps on tps.provider_service_id = tsl.provider_service_id 
			left JOIN tb_provider as prov ON tps.provider_id = prov.provider_id and prov.delete_sw='N'
			left join tb_provider_addresses provadd on prov.provider_id = provadd.parent_key_id::integer 
				and provadd.delete_sw='N'
			left join tb_fiscal_category_master tfcm on tfcm.fiscal_category_cd = payauth.fiscal_category_cd
			left join tb_payment_header payhead on payhead.authorization_id = payauth.authorization_id 
				and payhead.delete_sw = 'N'
		where payauth.authorization_id = v_authorizationid 
		limit 1;
	end if;
END;

$function$
;
