DROP FUNCTION IF EXISTS cjams.getlisthearingdetails(v_objecttypekey character varying, v_meetingid uuid, servicecaseid uuid, meetingdate character varying);

CREATE OR REPLACE FUNCTION cjams.getlisthearingdetails(v_objecttypekey character varying, v_meetingid uuid, servicecaseid uuid, meetingdate character varying)
 RETURNS TABLE(intakeservicerequestcourthearingid uuid, hearingtype text, hearingdatetime timestamp without time zone, personid uuid)
 LANGUAGE plpgsql
AS $function$                                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                          
 DECLARE
 v_servicecaseid uuid;
 v_meetingdate timestamp;
  
                                             
 begin
 v_servicecaseid = servicecaseid;
 v_meetingdate = meetingdate;
 
RETURN QUERY  

select ih.intakeservicerequestcourthearingid ,string_agg(distinct(pt.description),',')
as hearingtype,ih.hearingdatetime,isra.personid as personid from Intakeservicerequestcourthearing ih 
inner join hearingtype pt on  ih.hearingtype ? pt.hearingtypekey  
inner join intakeservicerequestpetitionactor ispa on ih.intakeservicerequestpetitionid =ispa.intakeservicerequestpetitionid
inner join  intakeservicerequestactor isra on isra.intakeservicerequestactorid=ispa.intakeservicerequestactorid  AND isra.activeflag =1	and
--left join meetingrecordinghearingdetail mrhd on mrhd.intakeservicerequestcourthearingid = ih.intakeservicerequestcourthearingid and mrhd.activeflag =1 where 
--case when v_meetingid is  not null 
--  THEN mrhd.meetingrecordingid = v_meetingid or mrhd.intakeservicerequestcourthearingid is null  ELSE 
--  mrhd.intakeservicerequestcourthearingid is null end and
CASE LOWER(v_objecttypekey) WHEN 'servicecase' THEN ih.servicecaseid = v_servicecaseid ELSE ih.intakeserviceid = v_servicecaseid END and ih.activeflag=1 and
(ih.hearingdatetime > v_meetingdate - INTERVAL '6 months' and ih.hearingdatetime < v_meetingdate + INTERVAL '6 months') 
group by ih.intakeservicerequestcourthearingid , isra.personid ;

 END;                                                                                                                                                                                                                                                                    

$function$
;
