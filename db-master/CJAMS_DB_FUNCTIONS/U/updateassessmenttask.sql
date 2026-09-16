 DROP FUNCTION IF EXISTS cjams.updateassessmenttask(uuid);

CREATE OR REPLACE FUNCTION cjams.updateassessmenttask(v_assessmentid uuid)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
declare 
v_submissionid character varying;
v_intakeserviceid uuid;
v_activitytaskid uuid;
l_objectid uuid;
l_rec record;

Begin

SELECT avt.activitytaskid,asm.submissionid,ivg.intakeserviceid
	into v_activitytaskid,v_submissionid,v_intakeserviceid

			FROM assessment asm
			INNER JOIN investigation ivg ON ivg.intakeserviceid=asm.objectid
                           AND ivg.activeflag=1
			INNER JOIN activity av 
                           ON av.objectid=ivg.investigationid
                           AND av.activeflag=1
			INNER JOIN activitytask avt 
                           ON avt.assessmenttemplateid=asm.assessmenttemplateid
                           AND av.activityid=avt.activityid
                           AND avt.activeflag=1
			WHERE asm.assessmentid=v_assessmentid
             AND asm.activeflag=1;

	    UPDATE activitytask SET completeddate = now() ,
        	assessmentid = v_assessmentid, activitytaskstatustypekey='InvClosed' 
        WHERE 
	    	activitytaskid =v_activitytaskid;
	    
	--   update routing r set activeflag=0 where r.objectid=v_assessmentid::varchar and r.eventcode='ASST' and routingstatustypeid=15;
			
		
Return 'Success';
		
End

$function$;
