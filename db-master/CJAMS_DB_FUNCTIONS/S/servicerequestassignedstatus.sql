CREATE OR REPLACE FUNCTION cjams.servicerequestassignedstatus(intakeservid uuid, securityuserid character varying, isaccepted boolean, isrejected boolean, reason character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$                                                                                                                                                                        
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 11/21/2023 Charan Sai-CIDM 8172- Removed the alias name 'a' from intakeservicerequest  in the update statement for isaccepted and accepteddate.
-------------------------------------------------------------------------------------------------------------
                                                                                                                                                                                    
 DECLARE                                                                                                                                                                              
                                                                                                                                                                                      
 v_intakeservid uuid;                                                                                                                                                                 
 v_securityuserid character varying;                                                                                                                                                  
 v_date timestamp without time zone;                                                                                                                                                  
 v_supsecurityuserid character varying;                                                                                                                                               
 v_servreqno character varying;                                                                                                                                                       
 v_username  character varying;                                                                                                                                                       
 v_notifystatus  character varying;   
 v_isaccepted boolean; 
 BEGIN                                                                                                                                                                                
                                                                                                                                                                                      
 v_intakeservid := intakeservid;                                                                                                                                                      
 v_securityuserid := securityuserid;                                                                                                                                                  
                                                                                                                                                                                      
 v_date := now() ;                                                                                                                                                  
                                                                                                                                                                                      
 IF(coalesce(isaccepted,false) =true) THEN                                                                                                                                            
                                                                                                                                                                                      
    /* Select insertedby into v_supsecurityuserid from areateammemberservicerequest                                                                                                     
     where intakeserviceid = v_intakeservid                                                                                                                                           
     and  securityusersid =v_securityuserid                                                                                                                                           
     and activeflag =1; */                                                                                                                                                           
                                                                                                                                                                                      
     Select isrt.Servicerequestnumber, coalesce(isrt.isaccepted,false) into v_servreqno, v_isaccepted                                                                                                                                     
     from intakeservicerequest isrt                                                                                                                                                       
     where intakeserviceid = v_intakeservid;                                                                                                                                          
                                                                                                                                                                                      
    -- Select coalesce(lastname,'')||','|| coalesce(firstname,'') into v_username   from userprofile where securityusersid =v_securityuserid;   
	-- Checking whether this case opened already and notified
	--select  coalesce(isr.isaccepted,false) into v_isaccepted from intakeservicerequest isr where isr.intakeserviceid = v_intakeservid;
	
	IF(v_isaccepted = false) THEN	 
                                                                                                                                                                                      
        with user_info as (
            select insertedby from areateammemberservicerequest                                                                                                     
            where intakeserviceid = v_intakeservid                                                                                                                                           
            and  securityusersid =v_securityuserid                                                                                                                                           
            and activeflag = 1       
        ), user_name as (
            Select coalesce(lastname,'')||','|| coalesce(firstname,'') as username                                                                                                    
            from userprofile where securityusersid =v_securityuserid
        ), update_intakerequest as (
            Update intakeservicerequest  set isaccepted = true, accepteddate = v_date                                                                                                      
            where intakeserviceid = v_intakeservid
        ), update_teammemberservicerequest as (
            UPDATE areateammemberservicerequest 
            SET isaccepted = true,rejectreason=null, rejecteddate=v_date 
            WHERE intakeserviceid = v_intakeservid                                                                                                                       
                and  securityusersid =v_securityuserid                                                                                                                                           
                and activeflag = 1
        )
        SELECT send_notification into v_notifystatus from                                                                                                                                 
            send_notification((select insertedby from user_info), v_securityuserid, (select insertedby from user_info),                                                                                                 
            'System', 'Normal', 'Case ('|| v_servreqno ||') accepted by ' || v_username,                                                                                                 
            'Case ('|| v_servreqno ||') accepted by ' || (select * from user_name),                                                                                                                    
            cast(v_intakeservid as character varying)); 
            
    END IF;                                                                                                                                                                                  
 ELSIF(coalesce(isrejected,false) =true) THEN                                                                                                                                         
                                                                                                                                                                                      
         Update intakeservicerequest set isaccepted = false,accepteddate = v_date where intakeserviceid = v_intakeservid;                                                             
                                                                                                                                                                                      
         UPDATE areateammemberservicerequest SET isaccepted = false ,rejectreason=reason,                                                                                             
     rejecteddate=v_date WHERE intakeserviceid = v_intakeservid                                                                                                                       
      and  securityusersid =v_securityuserid                                                                                                                                          
     and activeflag =1;                                                                                                                                                               
                                                                                                                                                                                      
 END IF;                                                                                                                                                                              
                                                                                                                                                                                      
                                                                                                                                                                                      
         return 'SUCCESS';                                                                                                                                                            
                                                                                                                                                                                      
                                                                                                                                                                                      
 END;                                                                                                                                                                                 
                                                                                                                                                                                      
 $function$
;
