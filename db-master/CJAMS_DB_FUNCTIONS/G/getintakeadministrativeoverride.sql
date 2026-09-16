CREATE OR REPLACE FUNCTION cjams.getintakeadministrativeoverride(intakenumber character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$                                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                          
 DECLARE
 overrides  json;
 v_intakenumber character varying;
  
                                                                                                                                                                                                                                                                         
 begin
	 v_intakenumber :=intakenumber;
	select json_agg(x) into overrides from (
	 select (select fullname from userprofile where securityusersid = ao.overridestaffid)fullname, 
	 ao.overridedate, ao.overridereasontypekey, ao."comments", ao.intakeapproveddate, ao.referralsnapshotid , 
	 isr.servicerequestnumber
	 	from administrativeoverrides ao
		 left join intakeservicerequest isr on isr.intakeserviceid =ao.intakeserviceid
		 and isr.intakenumber = ao.entityid
	 	where ao.entityid = v_intakenumber
	 	order by ao.insertedon)x;
	 return overrides;
 END;                                                                                                                                                                                                                                                                    

$function$;