DROP function if exists get_purchase_auth_fiscal(json,bigint,bigint) ;
CREATE OR REPLACE FUNCTION cjams.get_purchase_auth_fiscal(searchobj json, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(fiscalcode character varying, fiscal_description character varying, costnot_exceed numeric, justification_text character varying, voucher_requested character, authorization_id integer, attachments json, service_log_id integer, fiscal_category_cd text, cost_no numeric, cfecareduration character varying, fundingstatus text, paymentstatus text, startdt date, enddt date, dateofpreapproval date, final_amount_no numeric, client_account_id integer, client_account_no character varying, status integer, supervisorid character varying, reason_tx text, routingstatus text, ongoingtransflag boolean)
 LANGUAGE plpgsql
AS $function$


--------------------------------------------------------------------------------------------------
--- CIDM-4643- To get the CFE Duration

---CIDM-7183--06/08/2023-Service-log--Umasankar Raavi - Getting few more values from document tables 
--CIDM-7362--06/27/2023-Servicelog-Umasankar Raavi --fetching objecttypekey,additionalobjectid info from document tables 
--CIDM-8168--04/12/2024-Manasa Kasula -- changes to fetch the purchase authorization based on auth id filter if it has value
-----------------------------------------------------------------------------------------------------

DECLARE  

	v_service_log_id bigint;
	v_pagenumber int;
	v_pageoffset int;
	v_role_id character varying;
	v_auth_id character varying;
BEGIN
v_service_log_id := searchobj ->> 'service_log_id';
v_role_id := searchobj ->> 'roleid';
v_auth_id := searchobj ->> 'authorization_id';

v_pagenumber := v_liPageNumber - 1;
v_pageoffset := v_pagenumber * v_liPageSize;
RETURN QUERY
SELECT  Trim(SPA.fiscal_category_cd::character varying) ::character varying AS "fiscalcode"
	   , TPV.fiscal_category_desc AS "fiscal_description"
       ,CASE WHEN SPA.final_amount_no IS NOT NULL 
	         THEN SPA.final_amount_no 
			 END AS "costnot_exceed"
       ,SPA.justification_tx::character varying AS "justification_text"
       ,SPA.Voucher_sw       AS "voucher_requested"
	   ,SPA.authorization_id AS "authorization_id"
	   ,( SELECT                                                                                                                                                                                                                                                                                                                                        
                json_agg(doc)                                                                                                                                                                                                                                                                                                          
     			FROM                                                                                                                                                                                                                                                                                                                                          
 				(                                                                                                                                                                                                                                                                                                                                             
 				SELECT  dp.filename, dp.documentpropertiesid,  dp.title,  dp.mime,  dp.numberofbytes, dp.s3bucketpathname,  dp.originalfilename , dp.actualdocumentdate, dp.updatedon, dp.objecttypekey, dp.additionalobjectid, dp.other,
				 (select fullname as updatedby from userprofile u where u.securityusersid = dp.updatedby ),
				 (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),
				  (select attachmentclassificationtypekey from documentattachment where documentpropertiesid = dp.documentpropertiesid),
				 (select attachmentclassificationsubtypekey from documentattachment where documentpropertiesid = dp.documentpropertiesid),
				 dp.uploadstatus, dp.finalstatus, dp.ecmsdocumentid, dp.insertedon                                                                                                                                                                                                                                                                                                                       
       			from documentproperties dp where dp.additionalobjecttype like 'purchaseAuthReceipt' and dp.additionalobjectid =  SPA.authorization_id::character varying and dp.activeflag in (1,3,4,5)                                                                                                                                                                                                                                          
                                         ) doc  ) :: json AS "attachments"
	   ,SPA.service_log_id   AS "service_log_id",
	   TRIM(SPA.fiscal_category_cd),SPA.cost_no,
	   SPA.cfecareduration,
	   case when SPA.funding_approval_status_cd='3047' then 'Approved' else '' end as fundingStatus,
	   case when SPA.payment_approval_status_cd='3047' then 'Approved' else '' end as paymentStatus,
	   SPA.start_dt,SPA.end_dt,SPA.dateofpreapproval 	 ,SPA.final_amount_no  , case when (trim(SPA.fiscal_category_cd) in ('7502','7503')) then SPA.client_account_id else null end, tca.account_no_tx,
	   (select r.routingstatustypeid
	  from routing r where  r.activeflag=1 and r.eventcode in ('PCAUTH','PCAUTHR') and objectid = SPA.authorization_id :: character varying limit 1)
	  ,(select r.tosecurityusersid
	  from routing r where  r.activeflag=1 and r.eventcode in ('PCAUTH','PCAUTHR') and objectid = SPA.authorization_id :: character varying limit 1)
	  ,SPA.reason_tx,
	  (select 
	  		CASE  
	  		when r.routingstatustypeid =850 
	   				THEN 'Returned' 
	   		WHEN r.toroleid=v_role_id and  r.routingstatustypeid =42  
	   				THEN r.remarks 
	  		WHEN r.toroleid=v_role_id AND r.routingstatustypeid !=62 
	   				THEN 'Pending' 
	   				ELSE --CASE WHEN tsli.end_dt IS NULL 
	   				--		THEN NULL 
	   						--ELSE 
	   						r.remarks 
	   				--END 
	   		END as remarks
	  from routing r 
	  join tb_service_purchase_authorization tspa on tspa.authorization_id :: character varying = r.objectid and tspa.delete_sw='N'
	  join tb_service_log tsli on tsli.service_log_id=tspa.service_log_id and tsli.delete_sw='N'
	  where tspa.authorization_id= SPA.authorization_id and r.activeflag=1 and r.eventcode in ('PCAUTH','PCAUTHR') limit 1
	  ),(	  select       
  (case when exists (  select r.remarks from tb_service_purchase_authorization tspa
	  inner join routing r on r.objectid=tspa.authorization_id::character varying and r.eventcode='PCAUTH' and r.remarks not in ('Approved','Denied')
	  where tspa.service_log_id=v_service_log_id)
    then true 
    else false 
  end)) as ongoingtransflag
FROM tb_service_purchase_authorization AS SPA  
LEFT JOIN tb_fiscal_category_master AS TPV ON Trim(TPV.fiscal_category_cd ::character varying) ::character varying  
= Trim(SPA.fiscal_category_cd::character varying) ::character varying
left join tb_client_account tca on tca.client_account_id=SPA.client_account_id and tca.delete_sw='N' --and tca.account_type_cd='591'

--WHERE TPV.picklist_type_id = 217
WHERE SPA.service_log_id = v_service_log_id and SPA.delete_sw='N'
and (case when v_auth_id is not null and btrim(v_auth_id) <> '' then SPA.authorization_id = v_auth_id::bigint else true end) 
order by spa.authorization_id desc;

END


$function$;