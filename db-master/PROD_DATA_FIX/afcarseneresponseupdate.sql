DROP FUNCTION IF EXISTS cjams.afcarseneresponseupdate(json); 
CREATE OR REPLACE FUNCTION cjams.afcarseneresponseupdate(reqobj json, fromuserid character varying)                                                                                           
  RETURNS text
  LANGUAGE plpgsql                                                                                                                                                         
AS $function$                                                                                                                                                             
                                                                                                                                                                           
 declare 
v_res json;
v_afcarseneresponseid int;
v_num int;
v_updatedby varchar;
v_ivaflag varchar;
v_xixflag varchar;
v_record json;
v_securityuserid varchar;

 BEGIN   

  v_record = reqobj;
  v_securityuserid = fromuserid;

FOR v_record IN SELECT * FROM json_array_elements(reqobj)
	LOOP
  
    
    RAISE NOTICE 'v_afcarseneresponseid%',v_afcarseneresponseid;
		v_afcarseneresponseid := v_record ->> 'afcarseneresponseid';
		v_ivaflag := v_record ->> 'ivaflag';
		v_xixflag := v_record ->> 'xixflag'; 

    SELECT count(*) into v_num FROM afcarseneresponse WHERE afcarseneresponseid = v_afcarseneresponseid;

	IF (v_num) >= 1
		THEN
    RAISE NOTICE 'v_res%',v_num;
		
		UPDATE afcarseneresponse
		SET  ivaflag= v_ivaflag, xixflag= v_xixflag, updatedon=now(), updatedby=v_securityuserid
		where afcarseneresponseid= v_afcarseneresponseid;
						
		END IF;

  END LOOP;  
	  
    --  for v_res in select * from json_array_elements(v_resources)

    -- v_personassetid := v_record ->> 'personassetid';
		-- v_purchasedate := v_record ->> 'purchasedate';
		-- v_disposaldate := v_record ->> 'disposaldate'; 
		
    --  loop
          
    --       RAISE NOTICE 'v_res%',v_res;
        
    --     UPDATE personasset
		-- SET  assettypekey= v_assettypekey, marketvaluetypekey=v_marketvaluetypekey, amountowed=v_amountowed, facevalue=v_facevalue, beneficiaryname=v_beneficiaryname, 
		-- verificationtypekey=v_verificationtypekey, locationname=v_locationname, cityname=v_cityname, countytypekey= v_countytypekey, statetypekey=v_statetypekey, zip5no=v_zip5no, purchasedate=v_purchasedate, disposaldate=v_disposaldate, accountno=v_accountno, updatedon=now(), updatedby=v_securityuserid,disregardflag=v_disregardflag, notes=v_notes, personid=v_personid
		-- where personassetid= v_personassetid; 


    --   END LOOP;  

return 'Success';                                                                                                                   
                                                                                                                                                                        
end;                                                                                                                                                                    
                                                                                                                                                                           
$function$;                                                                                                                                                                
