DROP FUNCTION IF EXISTS cjams.spcloseduemytasks(v_userid uuid, v_personid uuid, v_alerttype character varying, ispageopened boolean);
CREATE OR REPLACE FUNCTION cjams.spcloseduemytasks(v_userid uuid, v_personid uuid, v_alerttype character varying, ispageopened boolean DEFAULT false)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------
-- Revision(s)
-- 06/12/2025 - Naveenkumar Chemutu - (CIDM-10354) - Changed logic for task complete. updating task complete for all task fall under same month.
-- 10/10/2025 - Vinesh Puthan -(CIDM-10846) - Updating the previous months prescription tasks to closed 
------------------------------------------------------------------------ 

BEGIN
 
if (v_alerttype = 'Medication-Psychotropic') then
		
			update activitytask set activitytaskstatustypekey ='CRClosed',completeddate = now(),updatedby = v_userid, updatedon = now()
			where activitytaskid in (			  			
			select actt.activitytaskid from activitytask actt
				inner join activity act on act.activityid = actt.activityid and actt.activeflag = 1
				inner join intakeservreqchildremoval irl on irl.intakeservreqchildremovalid = act.objectid				
				where irl.personid = v_personid
				and irl.exitdate is null
				and irl.activeflag = 1				
			    and actt.description = 'MedicationPsychotropic'
				AND actt.activitytaskstatustypekey != 'CRClosed'
				and (EXTRACT(YEAR FROM actt.duedate) < EXTRACT(YEAR FROM CURRENT_DATE)
                OR (EXTRACT(YEAR FROM actt.duedate) = EXTRACT(YEAR FROM CURRENT_DATE) 
                AND EXTRACT(MONTH FROM actt.duedate) <= EXTRACT(MONTH FROM CURRENT_DATE)))
                order by duedate);
			

elseif (v_alerttype = 'Health-Disorder') then
	
			update activitytask set activitytaskstatustypekey ='CRClosed',completeddate = now(),updatedby = v_userid, updatedon = now()
			where activitytaskid in (
				select actt.activitytaskid from activity act 
				inner join activitytask actt on act.activityid = actt.activityid
				inner join intakeservreqchildremoval irl on irl.intakeservreqchildremovalid = act.objectid
				where irl.personid = v_personid
				and irl.exitdate is null
				and irl.activeflag = 1		
			  	AND actt.duedate::date <= CURRENT_DATE
			    and actt.description = 'HealthDisorder'
				AND actt.activitytaskstatustypekey != 'CRClosed');
	
	end if;
Return 1;
END;

$function$
;
