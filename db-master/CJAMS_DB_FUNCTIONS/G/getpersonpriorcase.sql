DROP function if exists  cjams.getpersonpriorcase(v_personid uuid);
CREATE OR REPLACE FUNCTION cjams.getpersonpriorcase(v_personid uuid)
 RETURNS TABLE(intakeserviceid uuid, casenumber character varying, intakenumber character varying, servicetype character varying, dasubtype character varying, service text, subservice character varying, role character varying, datecreated timestamp without time zone, dateclosed timestamp without time zone, dispstatus text)
 LANGUAGE plpgsql
AS $function$

----
--CIDM-9850-stg3_case_participation: This SP was being called by getpriorbyservicecase for getting the previous servicecase. Updating the logic to fetch the CPS AR/IR case
----
DECLARE  

jsondata  json;
BEGIN

return  query

		SELECT  
		        DISTINCT  ISR.intakeserviceid,  
				--ISR.servicerequestnumber                AS  casenumber,  
				case when ISR.actiontype in ('IR','AR') then ISR.servicerequestnumber end as casenumber,
				ISR.intakenumber,  
				ISRT.description                                AS  servicetype,  
				SRST.description                                AS  dasubtype,  
				(SELECT  ins.description    from  intakeserv  ins  where  ins.intakeservtypekey  =  isrs.intakeservreqservicekey)  AS  service,
				(SELECT  inss.typedescription  from  Intakeservsubtype  inss  where    inss.intakeservsubtypekey  =  isrss.intakeservsubtypekey)AS  subservice,
			 --	AT.typedescription  			AS  role,
				(  select  replace(replace(replace(( 
					(select json_agg(a) from (
						 select AT.typedescription as a from   intakeservicerequestactor ISRA 
						  INNER  JOIN intakeservicerequest  ISRR  on ISRR.intakeserviceid  =  ISRA.intakeserviceid and ISR.servicerequestnumber= ISRR.servicerequestnumber
						  inner join ActorType  AT  ON  AT.actortype  =  ISRA.intakeservicerequestpersontypekey  
			 			  and AT.actortype  =  ISRA.intakeservicerequestpersontypekey and ISRA.personid  =  v_personid  	                    
					 )a):: json
				 )  :: character varying   ,'[','') , ']',''),'"',''))::character varying	AS  role,
				ISR.insertedon                                    AS  datecreated,  
				ISR.exitdate    			AS  dateclosed ,
				--st.Description as dispstatus
                '' :: text
			FROM      intakeservicerequestactor ISRA 
						  INNER  JOIN intakeservicerequest  ISR  on ISR.intakeserviceid  =  ISRA.intakeserviceid 
			              INNER  JOIN  intakeserreqstatustype  ISRST    ON  ISR.intakeserreqstatustypeid  =  ISRST.intakeserreqstatustypeid  
			              LEFT  JOIN  intakeservicerequestinputtype  ISRIT    ON  ISRIT.intakeservreqinputtypeid  =  ISR.intakeserreqstatustypeid  
			              LEFT  JOIN  intakeservicerequesttype  ISRT  ON  ISRT.intakeservreqtypeid  =  ISR.intakeservreqtypeid  
			              LEFT  JOIN  servicerequestsubtype  SRST  ON  SRST.servicerequestsubtypeid  =    ISR.intakeservicerequestclassid  
			              LEFT  JOIN  intakeservicerequestservice  ISRS  ON  ISRS.intakeserviceid  =  ISR.intakeserviceid
			              LEFT  JOIN  intakeservicerequestsubservice  ISRSS  ON  ISRSS.intakeservreqserviceid    =  ISRS.intakeservreqserviceid
			        --      LEFT  JOIN    ActorType  AT  ON  AT.actortype  =  ISRA.intakeservicerequestpersontypekey  
			             -- LEFT  JOIN IntakeServiceRequestDispositionCode sd  ON  sd.intakeserviceid  =  ISR.intakeserviceid
						 -- LEFT  JOIN IntakeSerReqStatusType st on st.IntakeSerReqStatusTypeid = sd.IntakeSerReqStatusTypeid  
			WHERE    ISRA.personid  =  v_personid;
		
END;

$function$
;
