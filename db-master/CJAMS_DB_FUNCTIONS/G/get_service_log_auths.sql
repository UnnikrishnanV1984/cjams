drop function if exists cjams.get_service_log_auths(casenumber text,v_role_id character varying,clientid bigint,v_service_log_id bigint);
CREATE OR REPLACE FUNCTION cjams.get_service_log_auths(casenumber text,	v_role_id character varying,clientid bigint,v_service_log_id bigint)
    RETURNS TABLE(totalcount bigint, service_log_id bigint, provider_service_id bigint, provider_id integer, provider_nm text, service_name character varying, service_id integer, service_type character varying, tax_id numeric, zip numeric, frequency_cd character varying, frequency character varying, duration_cd character varying, duration character varying, agency_program_area_id character varying, agency_sub_program_area_id character varying, agency_program_nm character varying, service_end_reason_cd character varying, service_end_reason character varying, no_service_reason_cd character varying, no_service_reason character varying, actual_start_date text, actual_end_date text, estimated_start_date text, estimated_end_date text, start_time character varying, end_time character varying, referred_date text, courtorder character, notes character varying, endReason character varying, endReasonNotes character varying, outcome character varying, status text, serviceplanactionid uuid, serviceplanid uuid, serviceplanname character varying, serviceplanactionname character varying, current_dt date, ongoingtransflag boolean, authflag boolean, clientdob text, clientname varchar, clientgender varchar, purchaseauths json) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
AS $BODY$

declare 

begin

 RETURN QUERY 	
 	SELECT count(1) over() as totalcount,CASE WHEN TSL.service_log_id IS NOT NULL 
            THEN TSL.service_log_id 		  
			END AS "service_log_id"
      ,CASE WHEN TPS.provider_service_id IS NOT NULL 
	        THEN TPS.provider_service_id 
			END AS "provider_service_id"
      ,CASE WHEN TPR.provider_id IS NOT NULL 
	        THEN TPR.provider_id        		  
			END AS "provider_id"
	  ,CASE WHEN TPR.provider_nm IS NOT NULL and tpr.provider_nm !=''
	        THEN TPR.provider_nm else concat_ws(' ',tpr.provider_first_nm,tpr.provider_middle_nm,tpr.provider_last_nm)      		  
			END AS "provider_nm"
	  ,CASE WHEN TSR.structure_service_cd in ('S','P') AND TSR.paid_non_paid_cd::INTEGER IN ('3334','3335') 
	        THEN TSR.Service_nm 
			END AS "service_name"
      ,CASE WHEN TSR.structure_service_cd in ('S','P') AND TSR.paid_non_paid_cd::INTEGER IN ('3334','3335') 
	        THEN TSR.Service_id 
			END AS "Service_id",
			TSR.paid_non_paid_cd :: character varying
	  ,CASE WHEN TPR.provider_id  IS NOT NULL 
	        THEN TPR.tax_id_no                  
			END AS "tax_id"
      ,(select TPA.adr_zip5_no  from  tb_provider_addresses  AS TPA where  TPA.parent_key_id :: INTEGER  = TPR.provider_id and TPA.delete_sw='N' limit 1)
	  ,CASE WHEN TPV.picklist_value_cd IS NOT NULL AND TPV.picklist_value_cd = TSL.frequency_cd
	        THEN TPV.picklist_value_cd
			END AS "frequency_cd"
	  ,CASE WHEN TPV.picklist_value_cd IS NOT NULL AND TPV.picklist_value_cd = TSL.frequency_cd
	        THEN TPV.value_tx
			END AS "frequency"	  
	  ,CASE WHEN TPO.picklist_value_cd IS NOT NULL AND TPO.picklist_value_cd = TSL.duration_cd 
	        THEN TPO.picklist_value_cd
			END AS "duration_cd"	    
	  ,CASE WHEN TPO.picklist_value_cd IS NOT NULL AND TPO.picklist_value_cd = TSL.duration_cd 
	        THEN TPO.value_tx
			END AS "duration"	  	    
	  ,CASE WHEN APA.programkey IS NOT NULL 
	        THEN APA.programkey
			END AS "agency_program_area_id"
	  ,TSL.agency_sub_program_area_id
	  ,CASE WHEN APA.programname IS NOT NULL  
	        THEN APA.programname
			END AS "agency_program_nm"
	  ,CASE WHEN PVI.picklist_value_cd IS NOT NULL 
	        THEN PVI.picklist_value_cd 
			END AS "service_end_reason_cd"
	  ,CASE WHEN PVI.picklist_value_cd IS NOT NULL 
	        THEN PVI.value_tx 
			END AS "service_end_reason"	  
	  ,CASE WHEN TPI.picklist_value_cd IS NOT NULL 
	        THEN TPI.picklist_value_cd 
			END AS "no_service_reason_cd"	  
	  ,CASE WHEN TPI.picklist_value_cd IS NOT NULL 
	        THEN TPI.value_tx 
			END AS "no_service_reason"
	  ,to_char(TSL.start_dt,'MM-DD-YYYY')::text AS "actual_start_date"
	  ,to_char(TSL.end_dt,'MM-DD-YYYY')::text AS "actual_end_date"
	  ,to_char(TSL.estimated_start_dt,'MM-DD-YYYY')::text AS "estimated_start_date"
	  ,to_char(TSL.estimated_end_dt,'MM-DD-YYYY')::text AS "estimated_end_date"
	  ,TSL.start_tm AS "start_time"
	  ,TSL.end_tm AS "end_time"
	  ,to_char(TSL.referred_dt,'MM-DD-YYYY')::text AS "referred_date" 
	  ,TSL.court_ordered_sw AS "courtorder"
	  ,TSL.description_tx AS "notes"
	  ,TSL.end_service_subcategory_reason as "endReason"
	  ,TSL.end_reason_desc_tx as "endReasonNotes"
	  ,TSL.outcome_tx AS "outcome",
	  (select 
	  		CASE  WHEN r.toroleid=v_role_id AND r.routingstatustypeid !=62 
	   				THEN 'Pending' 
	   				ELSE CASE WHEN TSL.end_dt IS NULL 
	   						THEN r.remarks 
	   						ELSE r.remarks 
	   				END 
	   		END as remarks
	  from routing r 
	  join tb_service_purchase_authorization tspa on tspa.authorization_id :: character varying = r.objectid and tspa.delete_sw='N'
	  join tb_service_log tsli on tsli.service_log_id=tspa.service_log_id and tsli.delete_sw='N'
	  where tsli.service_log_id=TSL.service_log_id and r.activeflag=1 and r.eventcode in ('PCAUTH','PCAUTHR') limit 1
	  ),
	  TSL.serviceplanactionid,TSL.serviceplanid,spl.serviceplanname,spla.serviceplanactionname,now() :: date,
	  (select       
  	  (case when exists (  select r.remarks from tb_service_purchase_authorization tspa
	  inner join routing r on r.objectid=tspa.authorization_id::character varying and r.eventcode='PCAUTH' and  remarks not in ('Denied','Approved') and remarks is not null and remarks != '' and r.activeflag=1
	  where tspa.service_log_id=TSL.service_log_id)
	  then true 
	  when exists (  select r.remarks from tb_service_purchase_authorization tspa
	  inner join routing r on r.objectid=tspa.authorization_id::character varying and r.eventcode='PCAUTH' and r.remarks  in ('Approved') and r.activeflag=1
	  inner join tb_service_log tsll on tsll.service_log_id=tspa.service_log_id and tsll.end_dt is not null
	  where tspa.service_log_id=TSL.service_log_id)
	  then true 
	  else false 
	  end) ) as ongoingtransflag,(case when exists (select * from tb_service_purchase_authorization tspa
	  where tspa.service_log_id=TSL.service_log_id) then true else false end) as authflag,
	  to_char(p.dob,'MM-DD-YYYY')::text as clientdob,
	  concat(p.firstname, ' ', p.lastname)::varchar as clientname,
	  p.gendertypekey as clientgender,
	  (SELECT json_agg(auth) FROM (
		select 
		(select row_to_json(d) from ( SELECT * FROM cjams.get_authorization_request(SPA.authorization_id)) d ) as purchaseauthreq,
		*
		FROM tb_service_purchase_authorization AS SPA  
		WHERE SPA.service_log_id = TSL.service_log_id and SPA.delete_sw='N' order by spa.authorization_id desc 
		) auth
	  ):: json AS "Purchaseauths"
 FROM tb_service_log 	AS TSL 
 LEFT JOIN tb_provider_services   	AS TPS ON TPS.provider_service_id = TSL.provider_service_id AND TSL.provider_service_id IS NOT NULL
 LEFT JOIN tb_provider             AS TPR ON TPR.provider_id = TPS.provider_id          
 LEFT JOIN tb_services             AS TSR ON TSR.service_id = TPS.service_id 
 LEFT JOIN tb_picklist_values      AS TPV ON TPV.picklist_value_cd = TSL.frequency_cd
 LEFT JOIN tb_picklist_values      AS TPO ON TPO.picklist_value_cd = TSL.duration_cd and TPO.picklist_type_id = '1397'
 LEFT JOIN agencyprogramarea  AS APA ON  APA.programkey = TSL.agency_program_area_id  OR APA.old_id = TSL.agency_program_area_id 
 LEFT JOIN tb_picklist_values      AS PVI ON trim(PVI.picklist_value_cd)::character varying = trim(TSL.end_service_reason_cd)::character varying
 LEFT JOIN tb_picklist_values      AS TPI ON trim(TPI.picklist_value_cd)::character varying = trim(TSL.no_service_reason_cd)::character varying
 left join serviceplan spl on spl.serviceplanid = TSL.serviceplanid and spl.activeflag=1
 left join serviceplanaction spla  on spla.serviceplanactionid =TSL.serviceplanactionid and spla.activeflag=1
 left join person p  on p.cjamspid =TSL.client_id and p.activeflag=1
  WHERE TSL.provider_service_id IS NOT NULL  and TSL.service_log_id = v_service_log_id
  AND TSL.case_id = caseNumber ::bigint 
  AND TSL.client_id = clientid ::bigint 
  AND TSL.delete_sw='N'
order by cast(TSR.Service_nm as character varying) ASC;
 end;
 
$BODY$;


