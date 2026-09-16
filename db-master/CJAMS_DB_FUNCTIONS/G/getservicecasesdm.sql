DROP  FUNCTION IF EXISTS cjams.getservicecasesdm(v_servicecaseid uuid);
CREATE OR REPLACE FUNCTION cjams.getservicecasesdm(v_servicecaseid uuid)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s):
--07/16/2025 Naresh Moola - Change pathway reason shows N/A on case connect service case - CIDM-10591
------------------------------------------------------------------------
declare  l_sdmdetails  json;
begin
  
  SELECT  coalesce(json_agg(  sdm),'[]'::json)  into  l_sdmdetails  from  (
	SELECT                
			 CASE  sdm.status    WHEN    15  THEN  'Review'
				  WHEN    16  THEN  'Accepted'
				  WHEN      17  THEN  'Rejected'  
											END  AS  pathwaystatus    
			, SC.servicecasenumber 
			, SC.servicecaseid
			, ISR.servicerequestnumber
			, ISR.intakenumber
			, ISR.intakeserviceid
			, sdm.* 
			, (SELECT  coalesce(json_agg(e),'[]'::json)  AS  sdmmaltreatment  FROM  (
											SELECT  irsmt.intakeservicerequestsdmid,irsmt.maltreatmenttype,
											irsmt.maltreatorsname as victimname  FROM  intakeservrequestsdmmaltreatment  irsmt
											WHERE  irsmt.intakeservicerequestsdmid=sdm.intakeservicerequestsdmid  and  maltreatmenttype  =  'AV'
											GROUP  BY  irsmt.intakeservicerequestsdmid,irsmt.maltreatmenttype,irsmt.maltreatorsname    )e)  allegedvictim
			, (SELECT  coalesce(json_agg(a),'[]'::json)  AS  sdmmaltreatment  FROM  (
											SELECT  irsmt.intakeservicerequestsdmid,irsmt.maltreatmenttype,
											irsmt.maltreatorsname  FROM  intakeservrequestsdmmaltreatment  irsmt
											WHERE  irsmt.intakeservicerequestsdmid=sdm.intakeservicerequestsdmid  and  maltreatmenttype  =  'AM'
											GROUP  BY  irsmt.intakeservicerequestsdmid,irsmt.maltreatmenttype,irsmt.maltreatorsname    )a)  allegedmaltreator
			, (SELECT  coalesce(json_agg(a),'[]'::json)  AS  sdmmaltreatment  FROM  (
											SELECT  irsmt.intakeservicerequestsdmid,irsmt.maltreatmenttype,
											irsmt.maltreatorsname  FROM  intakeservrequestsdmmaltreatment  irsmt
											WHERE  irsmt.intakeservicerequestsdmid=sdm.intakeservicerequestsdmid  and  maltreatmenttype  =  'PR'
											GROUP  BY  irsmt.intakeservicerequestsdmid,irsmt.maltreatmenttype,irsmt.maltreatorsname    )a)  provider
			,(SELECT  coalesce(json_agg(a),'[]'::json)  AS  sdmmaltreatment  FROM  (
										SELECT  up.firstname,  up.lastname,up.email,upa.address,upa.zipcode,upa.city,upa.state,up.securityusersid,up.activeflag,upp.userprofiletypekey,upp.phonenumber  
										FROM  	userprofile  up    
												LEFT  JOIN  userprofileaddress  upa  ON  upa.securityusersid  =  up.securityusersid  AND upa.activeflag  =1  
												LEFT  JOIN  userprofilephonenumber  upp  ON  upp.securityusersid  =  up.securityusersid  AND  upp.activeflag=1
										WHERE    up.securityusersid  =  sdm.insertedby  )a)  insertedby
			,(select tpv.description_tx from responsereassignhistory rrh
				join tb_picklist_values tpv on tpv.picklist_value_cd = rrh.changereasontypekey and tpv.picklist_type_id = 10037
				where rrh.activeflag = 1 and rrh.referralid = sdm.intakeservicerequestsdmid order by rrh.updatedon limit 1) changereason
			,(select coalesce(json_agg(e),'[]'::json) from (
				select tpvsub.description_tx from responsereassignhistory rrh
				left join alternativeresponsetype ast on ast.reassignhistoryid = rrh.reassignhistoryid and ast.activeflag = 1
				left join tb_picklist_values tpvsub on tpvsub.picklist_value_cd = ast.picklistvaluetypekey and tpvsub.picklist_type_id = 10040
				where rrh.activeflag = 1 and rrh.referralid = sdm.intakeservicerequestsdmid ) e) subchangereason

	FROM  	servicecase sc 
			INNER JOIN intakeservicerequest ISR on ISR.servicecaseid = sc.servicecaseid 
			INNER JOIN  intakeservicerequestsdm  sdm  on sdm.intakeserviceid = ISR.intakeserviceid AND sdm.activeflag =1
	WHERE   sc.servicecaseid = v_servicecaseid AND sc.activeflag = 1
	ORDER    BY  sdm.insertedon  DESC  
)  as  sdm;

return  l_sdmdetails;  
              
end;

$function$
;
