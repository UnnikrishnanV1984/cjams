--DROP FUNCTION IF EXISTS cjams.createfcchecklist(uuid, uuid, uuid,character varying, character varying);
CREATE OR REPLACE FUNCTION cjams.createfcchecklist(v_servicecaseid uuid, v_servreqtypeid uuid, v_servreqsubtypeid uuid, securityuserid character varying, v_roletypekey character varying DEFAULT 'CW'::character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
                                                                                                          
DECLARE  
v_activity  record;
newactivityid  uuid;
duedate  timestamp;
loadnumber  character  varying;
v_manualinvestigation  character  varying;
v_protectivesupervision character varying;

BEGIN            
duedate:=now();
  SELECT  tm.loadnumber  into  loadnumber
  FROM  userprofile  u  
  INNER  JOIN      teammemberassignment  tma  
  	ON  tma.SecurityUsersId  =    u.SecurityUsersId  AND  tma.activeflag  =1
  INNER  JOIN    teammember  tm  
  	on  tm.teammemberid  =  tma.teammemberid  AND  tm.activeflag  =1
    
  WHERE  u.activeflag  =1      AND  u.SecurityUsersId  =  securityuserid;
  
 
FOR  v_activity  IN

SELECT     am.name,        am.amactivityid,
		am.ammappingid,am.description,    
		am.activitytypekey,  am.helptext
FROM  investigationmapping  as  im    
INNER  JOIN  servicerequesttypeconfig  as  sc
	on  sc.servicerequesttypeconfigid  =  im.objectid  
INNER  JOIN  ammapping  am  on  am.ammappingid  =  im.ammappingid  
	AND  am.activitytypekey  ='services'
        --and  am.teamtypekey  =v_teamtypekey
        and  coalesce(am.isinvestigstionactivity,0)  =1
INNER  JOIN  ammappingrole  amr  on  amr.ammappingid  =  am.ammappingid  
and  amr.activeflag  =1  
and  amr.roletypecode  =v_roletypekey
                      
                      
WHERE  coalesce(im.isreviewactivity  ,false)    =false
AND  sc.intakeservreqtypeid  in  (v_servreqtypeid)
--AND  sc.servicerequestsubtypeid  in  (v_servreqsubtypeid)
AND  sc.activeflag    =1  
AND  sc.intakeservicerequestplantypekey='FC'  

LOOP
	  
	  INSERT  INTO  activity
                      (  
			description,    amactivityid
                      ,ammappingid,objectid,sourcedescription
                      ,activitytypekey,helptext,sequence
                      ,updatedby,insertedby
                      ,effectivedate,expirationdate
			)
		    values
		    (
		      v_activity.name,    v_activity.amactivityid,
		      v_activity.ammappingid,  v_servicecaseid,  v_activity.description,  
		      v_activity.activitytypekey,  v_activity.helptext,  1,
		      securityuserid,securityuserid,  now(),duedate)  RETURNING  "activityid"  INTO    newactivityid;

/*ACTIVIY  TASK  taken  from  activity  mapping  based  on  mapping  id    (task  status  hardcoded)*/

	INSERT  INTO    activitytask
                      (  
		      activityid,name,description
                      ,helptext,amtaskid,assignedto
                      ,assignedon  ,activitytaskstatustypekey  
                      ,activitytasktypekey,activityprioritytypekey,duedate
                        ,sequence,required,activeflag
                      ,updatedby,insertedby,EffectiveDate
                              ,assessmenttemplateid
                    )
	/*Task  end  */	
	       
  SELECT    newactivityid  ,ta.name,  ta.description,
			  ta.description,ta.amtaskid,securityuserid,
			  now()   ,'InvOpen',
			    amt.activitytasktypekey,  amt.activityprioritytypekey,
				  (now()   )::  date    +coalesce(amt.duedateoffset,1)                   
			    ,1,true,1,
			    securityuserid,securityuserid,  now()  
                            ,amt.assessmenttemplateid
	FROM     ammappingtask  amt     
	INNER  JOIN  amtask  ta  on  ta.amtaskid  =  amt.amtaskid  
		AND  ta.activeflag  =1  
		AND  ta.activitytypekey  ='services'	  
	WHERE   amt.ammappingid  =v_activity.ammappingid AND  amt.activeflag  =1 AND  amt.required  =true ;
END  LOOP;
 
RETURN 
	  'Success';
END;

$function$
