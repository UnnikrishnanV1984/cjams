DROP FUNCTION IF EXISTS  cjams.getintakeservicerequestsdm(uuid, character varying);
DROP FUNCTION IF EXISTS  cjams.getintakeservicerequestsdm(uuid, character varying,character varying, integer);
DROP FUNCTION IF EXISTS  cjams.getintakeservicerequestsdm(uuid, character varying,character varying, integer, integer);
DROP FUNCTION IF EXISTS  cjams.getintakeservicerequestsdm(uuid, character varying, integer, integer);

CREATE OR REPLACE FUNCTION cjams.getintakeservicerequestsdm(
    v_intakeserviceid uuid,
    v_intakenumber character varying DEFAULT ''::character varying,
    isExpungementSuperUser integer DEFAULT 0,
    isexpunged integer DEFAULT 0::integer
)
RETURNS json
LANGUAGE plpgsql
AS $function$

declare  l_sdmdetails  json;
v_isexpunged integer;
begin

v_isexpunged = 0;
IF isExpungementSuperUser= 1 THEN
	v_isexpunged = isexpunged;
END IF;

    IF v_isexpunged = 1 THEN
    RAISE NOTICE 'BLOCK: FULLY EXPUNGED';

-- FULLY EXPUNGED
   SELECT  coalesce(json_agg(  sdm),'[]'::json)  into  l_sdmdetails  from  (                                                                                                                                                                                     
                                                                                                                                                                                                                                                                 
                         SELECT                                                                                                                                                                                                                                  
                                         CASE  sdm.status    WHEN    15  THEN  'Review'                                                                                                                                                                          
                                                   WHEN    16  THEN  'Accepted'                                                                                                                                                                                  
                                                   WHEN      17  THEN  'Rejected'                                                                                                                                                                               
                                                                                                         END  AS  pathwaystatus,                                                                                                                                
                                         sdm.*,sdm.comments, immediateother "immediateList6",                                                                                                                                                                                                                  
                         (SELECT  coalesce(json_agg(e),'[]'::json)  AS  sdmmaltreatment  FROM  (                                                                                                                                                                 
                                                                                                         SELECT  irsmt.intakeservicerequestsdmid,
                                                                                                         irsmt.maltreatmenttype,
                                                                                                         irsmt.maltreatorsname as victimname  FROM  expunge.intakeservrequestsdmmaltreatment_expunge  irsmt                                                                                    
                                                                                                         WHERE  irsmt.intakeservicerequestsdmid=sdm.intakeservicerequestsdmid  and  irsmt.maltreatmenttype  =  'AV'                                                    
                                                                                                         GROUP  BY  irsmt.intakeservicerequestsdmid,irsmt.maltreatmenttype,irsmt.maltreatorsname    )e)  allegedvictim,   
                         (select jsondata::json from expunge.intakesnapshot_expunge where intakeserviceid = v_intakeserviceid and activeflag = 1 limit 1) as intakesnapshotdata ,                                                                                                                   
                         (SELECT  coalesce(json_agg(a),'[]'::json)  AS  sdmmaltreatment  FROM  (                                                                                                                                                                 
                                                                                                         SELECT  irsmt.intakeservicerequestsdmid,
                                                                                                         irsmt.maltreatmenttype,
                                                                                                         irsmt.maltreatorsname  FROM  expunge.intakeservrequestsdmmaltreatment_expunge  irsmt                                                                                    
                                                                                                         WHERE  irsmt.intakeservicerequestsdmid=sdm.intakeservicerequestsdmid  and  irsmt.maltreatmenttype  =  'AM'                                                    
                                                                                                         GROUP  BY  irsmt.intakeservicerequestsdmid,irsmt.maltreatmenttype,irsmt.maltreatorsname    )a)  allegedmaltreator,                                      
                         (SELECT  coalesce(json_agg(a),'[]'::json)  AS  sdmmaltreatment  FROM  (                                                                                                                                                                 
                                                                                                         SELECT  irsmt.intakeservicerequestsdmid,
                                                                                                         irsmt.maltreatmenttype,
                                                                                                         irsmt.maltreatorsname  FROM  expunge.intakeservrequestsdmmaltreatment_expunge  irsmt                                                                                    
                                                                                                         WHERE  irsmt.intakeservicerequestsdmid=sdm.intakeservicerequestsdmid  and  irsmt.maltreatmenttype  =  'PR'                                                    
                                                                                                         GROUP  BY  irsmt.intakeservicerequestsdmid,irsmt.maltreatmenttype,irsmt.maltreatorsname    )a)  provider,                                               
                         (SELECT  coalesce(json_agg(a),'[]'::json)  AS  sdmmaltreatment  FROM  (                                                                                                                                                                 
                                                                                                 SELECT  up.firstname,  up.lastname,up.email,upa.address,upa.zipcode,upa.city,upa.state,up.securityusersid,up.activeflag,upp.userprofiletypekey,upp.phonenumber  
         FROM  userprofile  up    LEFT  JOIN  userprofileaddress  upa  on  upa.securityusersid  =  up.securityusersid                                                                                                                                            
         and  upa.activeflag  =1                                                                                                                                                                                                                                 
         LEFT  JOIN  userprofilephonenumber  upp  on  upp.securityusersid  =  up.securityusersid                                                                                                                                                                 
         and  upp.activeflag=1                                                                                                                                                                                                                                   
           where    up.securityusersid  =  sdm.insertedby  )a)  insertedby,
            ( SELECT tpv.description_tx 
              from responsereassignhistory rrh
              join tb_picklist_values tpv on tpv.picklist_value_cd = rrh.changereasontypekey and tpv.picklist_type_id = 10037
              where rrh.activeflag = 1 and rrh.referralid in (sdm.intakeservicerequestsdmid, v_intakeserviceid) order by rrh.updatedon limit 1)changereason,
              (SELECT  coalesce(json_agg(e),'[]'::json)  FROM  (                                                                                                                                                                 
                    		SELECT  tpvsub.description_tx  
                    		FROM  responsereassignhistory rrh
                    		left join alternativeresponsetype ast on ast.reassignhistoryid = rrh.reassignhistoryid  and ast.activeflag = 1
                            left join tb_picklist_values tpvsub on tpvsub.picklist_value_cd = ast.picklistvaluetypekey and tpvsub.picklist_type_id = 10040
                              where rrh.referralid in (sdm.intakeservicerequestsdmid, v_intakeserviceid) and rrh.activeflag = 1 )e)  subchangereason,
              ( SELECT up.fullname  
              from responsereassignhistory rrh
              left join userprofile up on up.securityusersid = rrh.updatedby and up.activeflag = 1
              where rrh.activeflag = 1 and rrh.referralid in (sdm.intakeservicerequestsdmid, v_intakeserviceid) order by rrh.updatedon limit 1)approvedby                                                                                                                                                                      
                         FROM  expunge.intakeservicerequestsdm_expunge  sdm  WHERE  sdm.intakeserviceid  =v_intakeserviceid  OR  sdm.intakenumber  =  v_intakenumber                                                                                                            
                         --AND  sdm.status  !=  20                                                                                                                                                                                                               
                         ORDER    BY  sdm.insertedon  DESC  )  as  sdm;

    ELSE
    RAISE NOTICE 'BLOCK: NORMAL';
    -- NORMAL
      SELECT  coalesce(json_agg(  sdm),'[]'::json)  into  l_sdmdetails  from  (                                                                                                                                                                                     
                                                                                                                                                                                                                                                                 
                         SELECT                                                                                                                                                                                                                                  
                                         CASE  sdm.status    WHEN    15  THEN  'Review'                                                                                                                                                                          
                                                   WHEN    16  THEN  'Accepted'                                                                                                                                                                                  
                                                   WHEN      17  THEN  'Rejected'                                                                                                                                                                               
                                                                                                         END  AS  pathwaystatus,                                                                                                                                
                                         sdm.*, immediateother "immediateList6",                                                                                                                                                                                                                  
                         (SELECT  coalesce(json_agg(e),'[]'::json)  AS  sdmmaltreatment  FROM  (                                                                                                                                                                 
                                                                                                         SELECT  irsmt.intakeservicerequestsdmid,irsmt.maltreatmenttype,                                                                                         
                                                                                                         irsmt.maltreatorsname as victimname  FROM  intakeservrequestsdmmaltreatment  irsmt                                                                                    
                                                                                                         WHERE  irsmt.intakeservicerequestsdmid=sdm.intakeservicerequestsdmid  and  maltreatmenttype  =  'AV'                                                    
                                                                                                         GROUP  BY  irsmt.intakeservicerequestsdmid,irsmt.maltreatmenttype,irsmt.maltreatorsname    )e)  allegedvictim,   
                         (select jsondata from intakesnapshot where intakeserviceid = v_intakeserviceid and activeflag = 1 limit 1) as intakesnapshotdata ,                                                                                                                   
                         (SELECT  coalesce(json_agg(a),'[]'::json)  AS  sdmmaltreatment  FROM  (                                                                                                                                                                 
                                                                                                         SELECT  irsmt.intakeservicerequestsdmid,irsmt.maltreatmenttype,                                                                                         
                                                                                                         irsmt.maltreatorsname  FROM  intakeservrequestsdmmaltreatment  irsmt                                                                                    
                                                                                                         WHERE  irsmt.intakeservicerequestsdmid=sdm.intakeservicerequestsdmid  and  maltreatmenttype  =  'AM'                                                    
                                                                                                         GROUP  BY  irsmt.intakeservicerequestsdmid,irsmt.maltreatmenttype,irsmt.maltreatorsname    )a)  allegedmaltreator,                                      
                         (SELECT  coalesce(json_agg(a),'[]'::json)  AS  sdmmaltreatment  FROM  (                                                                                                                                                                 
                                                                                                         SELECT  irsmt.intakeservicerequestsdmid,irsmt.maltreatmenttype,                                                                                         
                                                                                                         irsmt.maltreatorsname  FROM  intakeservrequestsdmmaltreatment  irsmt                                                                                    
                                                                                                         WHERE  irsmt.intakeservicerequestsdmid=sdm.intakeservicerequestsdmid  and  maltreatmenttype  =  'PR'                                                    
                                                                                                         GROUP  BY  irsmt.intakeservicerequestsdmid,irsmt.maltreatmenttype,irsmt.maltreatorsname    )a)  provider,                                               
                         (SELECT  coalesce(json_agg(a),'[]'::json)  AS  sdmmaltreatment  FROM  (                                                                                                                                                                 
                                                                                                 SELECT  up.firstname,  up.lastname,up.email,upa.address,upa.zipcode,upa.city,upa.state,up.securityusersid,up.activeflag,upp.userprofiletypekey,upp.phonenumber  
         FROM  userprofile  up    LEFT  JOIN  userprofileaddress  upa  on  upa.securityusersid  =  up.securityusersid                                                                                                                                            
         and  upa.activeflag  =1                                                                                                                                                                                                                                 
         LEFT  JOIN  userprofilephonenumber  upp  on  upp.securityusersid  =  up.securityusersid                                                                                                                                                                 
         and  upp.activeflag=1                                                                                                                                                                                                                                   
           where    up.securityusersid  =  sdm.insertedby  )a)  insertedby,
            ( SELECT tpv.description_tx 
              from responsereassignhistory rrh
              join tb_picklist_values tpv on tpv.picklist_value_cd = rrh.changereasontypekey and tpv.picklist_type_id = 10037
              where rrh.activeflag = 1 and rrh.referralid in (sdm.intakeservicerequestsdmid, v_intakeserviceid) order by rrh.updatedon limit 1)changereason,
              (SELECT  coalesce(json_agg(e),'[]'::json)  FROM  (                                                                                                                                                                 
                    		SELECT  tpvsub.description_tx  
                    		FROM  responsereassignhistory rrh
                    		left join alternativeresponsetype ast on ast.reassignhistoryid = rrh.reassignhistoryid  and ast.activeflag = 1
                            left join tb_picklist_values tpvsub on tpvsub.picklist_value_cd = ast.picklistvaluetypekey and tpvsub.picklist_type_id = 10040
                              where rrh.referralid in (sdm.intakeservicerequestsdmid, v_intakeserviceid) and rrh.activeflag = 1 )e)  subchangereason,
              ( SELECT up.fullname  
              from responsereassignhistory rrh
              left join userprofile up on up.securityusersid = rrh.updatedby and up.activeflag = 1
              where rrh.activeflag = 1 and rrh.referralid in (sdm.intakeservicerequestsdmid, v_intakeserviceid) order by rrh.updatedon limit 1)approvedby                                                                                                                                                                      
                         FROM  intakeservicerequestsdm  sdm  WHERE  sdm.intakeserviceid  =v_intakeserviceid  OR  sdm.intakenumber  =  v_intakenumber                                                                                                            
                         --AND  sdm.status  !=  20                                                                                                                                                                                                               
                         ORDER    BY  sdm.insertedon  DESC  )  as  sdm;                                                                                                                                                                                          

   END IF;

 return  l_sdmdetails;

end;

$function$
