CREATE OR REPLACE FUNCTION cjams.getancillaryserviceslist(v_securityuserid uuid, 
															v_userrole character varying,
															v_type character varying,
															pagenumber bigint, 
															pagesize bigint
														)
RETURNS json
LANGUAGE plpgsql

AS $function$ 
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vigneshwar Kumar
-- Date Created : 04/18/2022 
-- Stored Procedure to get the Ancillary Services Payment details
-- Revision(s)
-- CIDM-11365: Appending paymentypevalue and concatinating fiscal_category_description 
-- with its code. - Raghavendra Puli - 04/27/2026
------------------------------------------------------------------------     
DECLARE   
v_pageoffset  int;  
v_pagenumber  int;  
l_ancillaryserviceslist json;

BEGIN     
	v_pagenumber := pagenumber - 1;
	v_pageoffset := v_pagenumber * pagesize;
     
	select json_agg(e) 
		into l_ancillaryserviceslist 
	from (	select distinct COUNT(1) OVER() totalcount, 
				ans.ancillaryservicesid,
				ans.alternateid,
				ans.paymenttype,
				tpv.value_tx AS paymenttypevalue,
				ans.startdate,
				ans.insertedon,
				ans.enddate,	
				ans.noofbeds,	
				ans.costnotexceed,	
				ans."comments",	
				ans.finalamount,	
				ans.financecategorycode,	
				coalesce(tfcm.fiscal_category_desc, '') || ' (' || tfcm.fiscal_category_cd || ')' AS financecategorydescriptionwithcode,
				ans.updatedby,	
				ans.updatedon,	
				ans.insertedby,	
				ans.insertedon,
				ans.providerserviceid,
				ans.paymentid,
				ans.purchasedetails :: jsonb,
				(
					SELECT row_to_json(X) 
					FROM   (
						select TBS.Provider_ID as ProviderID 
								, TBS.provider_service_id
								, case when (PVR.Provider_nm is null or (PVR.provider_nm='')) then concat(PVR.provider_first_nm,' ', PVR.provider_last_nm) else PVR.provider_nm end AS ProviderName
								, PVR.tax_id_no AS TaxID
								, (select provider_adr from get_provider_address(TBS.provider_id::integer,trim('{3357,3356}')))
						FROM prov.TB_PROVIDER_SERVICES TBS 
						INNER JOIN prov.tb_provider PVR ON PVR.Provider_id = TBS.Provider_id and PVR.delete_sw='N' 
						WHERE provider_service_id = ans.providerserviceid
							AND PVR.provider_status_cd = '1791' AND PVR.delete_sw='N' 
							AND TBS.start_dt <= now()::date AND TBS.delete_sw='N' 
							AND ((TBS.end_dt is null) or (TBS.end_dt >= now()::date)) 
						LIMIT 1
					) AS X
				)::jsonb providerinfo,
				(select json_agg(v) as routinginfo from (
						select routingstatustypeid,
						r2.insertedon,
						r2.updatedon, 
						LEAD(r2.routingstatustypeid,1) OVER (
							ORDER BY r2.insertedon
						) nextroutingstatustypeid,
						r2.fromsecurityusersid,
						(	select up.firstname || ' ' || up.lastname 
							from userprofile up 
							where up.securityusersid::character varying  = r2.fromsecurityusersid
								and up.activeflag=1 
						) as requestorname,
						r2.updatedby as tosecurityusersid,
						(	select up.firstname || ' ' || up.lastname 
							from userprofile up 
							where up.securityusersid::character varying  = coalesce(r2.tosecurityusersid, r2.updatedby)
								and up.activeflag=1 
						) as approvername,
						rt1.description as fromrole,
						rt2.description as torole
						from routing r2 
						left join role rt1 on rt1.roletypekey=r2.fromroleid
						left join role rt2 on rt2.roletypekey=r2.toroleid
						where r2.objectid = ans.ancillaryservicesid:: character varying 
						order by r2.insertedon desc
				) as v) ::jsonb as routinginfo
			from cjams.ancillaryservices ans
			INNER JOIN prov.TB_PROVIDER_SERVICES PS ON PS.provider_service_id = ans.providerserviceid
			INNER JOIN prov.tb_provider PR ON PR.Provider_id = PS.Provider_id and PR.delete_sw='N' and pr.provider_status_cd = '1791'  and PS.delete_sw='N' 
			left join routing r on r.objectid = ans.ancillaryservicesid:: character varying 
			LEFT JOIN cjams.tb_picklist_values tpv ON tpv.picklist_type_id = 2 AND tpv.picklist_value_cd = ans.paymenttype AND tpv.delete_sw = 'N'
			LEFT JOIN cjams.tb_fiscal_category_master tfcm ON tfcm.fiscal_category_cd = ans.financecategorycode AND tfcm.delete_sw = 'N'
			where (case $2 
					when 'SP' then (r.fromsecurityusersid = $1:: character varying  or r.tosecurityusersid = $1:: character varying) 
					when 'FS' then ans.statecountycode = (
							SELECT c.statecountycode  
							FROM teammemberassignment tma
							INNER JOIN teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
							INNER JOIN teammemberroletype tmrt ON tmrt.roletypekey = tm.roletypekey AND tmrt.activeflag= 1
							INNER JOIN team t on t.teamid = tm.teamid  and t.activeflag =1
							inner join county  c on c.countyid::character varying = t.countyid ::character varying
							WHERE tma.SecurityUsersId::character varying = $1::character varying AND tma.activeflag =1 LIMIT 1
					)
					when 'FW' then ans.statecountycode = (
							SELECT c.statecountycode  
							FROM teammemberassignment tma
							INNER JOIN teammember tm ON tm.teammemberid = tma.teammemberid AND tm.activeflag =1
							INNER JOIN teammemberroletype tmrt ON tmrt.roletypekey = tm.roletypekey AND tmrt.activeflag= 1
							INNER JOIN team t on t.teamid = tm.teamid  and t.activeflag =1
							inner join county  c on c.countyid::character varying = t.countyid ::character varying
							WHERE tma.SecurityUsersId::character varying = $1::character varying AND tma.activeflag =1 LIMIT 1
					)
				 else  
				 	ans.insertedby = $1:: character varying   
				 end)
				 and case when $3 = 'pending' then 
				 		case $2 when 'FS' then 
							(r.routingstatustypeid = 112 and r.activeflag = 1)
						when 'FW' then 
							(r.routingstatustypeid = 111 and r.activeflag = 1)
						else 
							true 
						end
					else 
						true
					end	
				 and (case when $3 = 'pending' then true else (r.routingstatustypeid in (111, 112, 113) and r.activeflag = 1) end)
				 and ans.activeflag = 1
				 and PS.start_dt <= now()::date
				 and PS.delete_sw='N' 
				 and ((PS.end_dt is null) or (PS.end_dt >= now()::date))
			order by ans.insertedon desc
			limit pagesize offset v_pageoffset 
		)e ;
	 
		RETURN COALESCE(l_ancillaryserviceslist, '[]')::json;
END;

$function$
;
