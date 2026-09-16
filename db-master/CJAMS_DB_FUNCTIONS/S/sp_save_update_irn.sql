DROP FUNCTION IF EXISTS sp_save_update_irn(uuid,varchar,varchar);
DROP FUNCTION IF EXISTS sp_save_update_irn(varchar,varchar,varchar);
CREATE OR REPLACE FUNCTION cjams.sp_save_update_irn(vs_mdmid character varying, vs_insertedby character varying, vs_cisclientid character varying)
 RETURNS character varying[]
 LANGUAGE plpgsql
AS $function$     

-------------------------------------------------------------------------------------------------------
-- 9/19/2023 - Manasa Kasula - CIDM-7949 - Cisclientid update when mdm call is done
-- 5/8/2024 - Manasa Kasula - CIDM-8819 - Cisclientid update when more than person is linked with mdm id
-------------------------------------------------------------------------------------------------------

 DECLARE                                                                                                                                                                                         
        i        record;  
        response character varying[];       
        v_count int;                                                      
 BEGIN    

select count(1) into v_count from personidentifier pi 
inner join person p on p.personid = pi.personid and p.activeflag = 1
where pi.personidentifiervalue = vs_mdmid and pi.personidentifiertypekey = 'MDM_ID' and pi.activeflag = 1;

if(v_count is null or v_count = 0) then 
       response := array_append(response,'Shared MDM ID is not matching with any of the client in the CJAMS'::varchar); 
Else
       FOR i in (select p.personid as personid, p.cisclientid as cisclientid, p.cjamspid as cjamspid from personidentifier pi 
              inner join person p on p.personid = pi.personid and p.activeflag = 1
              where pi.personidentifiervalue = vs_mdmid and pi.personidentifiertypekey = 'MDM_ID' and pi.activeflag = 1)
       LOOP

              IF(vs_cisclientid is not null and (i.cisclientid is null or trim(i.cisclientid) = '')) THEN 

                     response := array_append(response,concat('cjamspid:', i.cjamspid,',personid:',i.personid,'message:Added successfully')::varchar);
                     
                     UPDATE person 
                     SET cisclientid = vs_cisclientid, updatedby = 'irn_user', updatedon = now()
                     WHERE personid = i.personid::uuid;

                     UPDATE personidentifier SET activeflag = 0, updatedby = 'irn_user', updatedon = now() WHERE personid = i.personid::uuid AND personidentifiertypekey='IRN' and activeflag = 1; 

                     INSERT INTO personidentifier(personid,personidentifiertypekey,personidentifiervalue,insertedby,updatedby,insertedon,updatedon) values (i.personid::uuid,'IRN',vs_cisclientid,'irn_user','irn_user',now(),now());                                    

              ELSIF (vs_cisclientid is not null and i.cisclientid != vs_cisclientid) THEN     

                     response := array_append(response,concat('cjamspid:', i.cjamspid,',personid:',i.personid,'message:Updated successfully')::varchar);          
                     
                     UPDATE personidentifier SET activeflag = 0, updatedby = 'irn_user', updatedon = now() WHERE personid = i.personid::uuid AND personidentifiertypekey='IRN' and activeflag = 1;    
                     INSERT INTO personidentifier(personid,personidentifiertypekey,personidentifiervalue,insertedby,updatedby,insertedon,updatedon) values (i.personid::uuid,'IRN',vs_cisclientid,'irn_user','irn_user',now(),now());  
              ELSE
                     response := array_append(response,concat('cjamspid:', i.cjamspid,',personid:',i.personid,'message:Updated successfully')::varchar);          
              END IF;    

       END Loop;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
End IF;
RETURN response;                                                                                                                                                                                
                                                                                                                                                                                                 
END;                                                                                                                                                                                             
$function$
;
