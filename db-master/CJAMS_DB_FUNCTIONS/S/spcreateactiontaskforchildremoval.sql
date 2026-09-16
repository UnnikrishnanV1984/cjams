DROP FUNCTION IF EXISTS cjams.spcreateactiontaskforchildremoval(au_personid uuid, au_removalid uuid, ad_removal_dt date, ad_exit_dt date,  user_id uuid );
CREATE OR REPLACE FUNCTION cjams.spcreateactiontaskforchildremoval(au_personid uuid, au_removalid uuid, ad_removal_dt date, ad_exit_dt date,  user_id uuid)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Naveenkumar Chemutu
-- Date Created : 05/13/2025 
-- To create system generated task in mydashboard (Child entered out of home placement)

-- Argument   : 1) IN au_personid - Client ID
--				2) IN au_removalid - Removal ID
--				3) IN ad_removal_dt - Removal Date
--				4) in ad_exit_dt  - Removal exit Date 	
--				5) IN  user_id - User Id 

------------------------------------------------------------------------

------------------------------------------------------------------------
-- Revision(s)
-- 05/27/2025 - Naveenkumar Chemutu - (CIDM-10354) - Modiying task status from open to inprogress for past due date.
-- 06/26/2025 - Naveenkumar Chemutu - (CIDM-10354) - Added audit columns for child removal end.
------------------------------------------------------------------------ 

DECLARE
    v_activityid uuid;
    v_userid character varying;
	v_task1_due_date DATE := ad_removal_dt;
    v_task_due_date_MS DATE;
	v_task_due_date_HD DATE;
    v_business_days INT := 0;
    v_actiontype TEXT;
    i INT;
   	vs_healthdisorder_task_txt varchar(500);
   	vs_medicationpsychotropic_task_txt varchar(500);
   	vs_client_nm varchar(150);
    v_task_limit INT;
    v_status TEXT;
    v_completed_date DATE;
    v_recent_medication_entry_date DATE;
    v_found_recent_medication_entry BOOLEAN := FALSE;
   	v_old_child_removal BOOLEAN := FALSE;
    v_task2_date DATE;
    v_check_date DATE;
    v_year INTEGER := EXTRACT(YEAR FROM v_task1_due_date);
    v_holidays DATE[];  
    v_next_year INTEGER := v_year + 1;  -- Calculate the next year
	v_servicecasenumber character varying;

begin
	
	 
	-- Dynamically generate U.S. federal holidays
    v_holidays := ARRAY[
        MAKE_DATE(v_year, 1, 1),                                   -- New Year's Day
        getnthweekday(v_year, 1, 1, 3),                              -- MLK Day (3rd Monday Jan)
        getnthweekday(v_year, 2, 1, 3),                              -- Presidents' Day (3rd Monday Feb)
        getlastweekday(v_year, 5, 1),                                -- Memorial Day (Last Monday May)
        MAKE_DATE(v_year, 6, 19),                                  -- Juneteenth
        MAKE_DATE(v_year, 7, 4),                                   -- Independence Day
        getnthweekday(v_year, 9, 1, 1),                              -- Labor Day (1st Monday Sep)
        getnthweekday(v_year, 10, 1, 2),                             -- Columbus Day (2nd Monday Oct)
        MAKE_DATE(v_year, 11, 11),                                 -- Veterans Day
        getnthweekday(v_year, 11, 4, 4),                             -- Thanksgiving (4th Thursday Nov)
        MAKE_DATE(v_year, 12, 25),                                  -- Christmas
        MAKE_DATE(v_next_year, 1, 1)                               -- New Year's Day (Next Year)
    ];

  RAISE NOTICE 'v_holidays%',v_holidays;

-- executes when child removal is approved
  if ad_exit_dt is null then 
  
  -- If child removal is edited then it will inactivate existing task.
   IF EXISTS (SELECT 1 FROM cjams.activity WHERE objectid = au_removalid::uuid) then
   	update activitytask set activeflag = 0 where activityid = (select activityid from activity where objectid = au_removalid::uuid and activeflag = 1 limit 1);
   	update activity set activeflag = 0 where objectid = au_removalid::uuid;
   end if;

	-- Getting client_nm from person table
	select pr.firstname || ' ' || pr.lastname as client_nm
	into vs_client_nm		
	from intakeservreqchildremoval rm, person pr 
	where rm.personid = pr.personid 		
		and rm.intakeservreqchildremovalid::uuid = au_removalid::uuid
		and rm.activeflag = 1;

	-- Updating task text for both alerts
	vs_healthdisorder_task_txt := 'Condition/Disorder need update for ' || vs_client_nm;
   	vs_medicationpsychotropic_task_txt := 'Medication sub-tab update is required for Client '	|| vs_client_nm;
  
	-- Getting case worker userid from Intakeservreqchildremoval
	select insertedby into v_userid from  
	Intakeservreqchildremoval where intakeservreqchildremovalid::uuid = au_removalid::uuid and activeflag = 1;
    
	-- Insert into activity table and get the activityid  
	INSERT INTO cjams.activity
	(activityid, description, activitystatustypekey, amactivityid, ammappingid, objectid, sourcedescription, activitytypekey, helptext, "sequence", activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id, "timestamp", voidedby, voidedon, voidreasonid, groupsequence, iseditable)
	VALUES(gen_random_uuid()::uuid, 'Child Welfare - Service Case', NULL, NULL, NULL, au_removalid::uuid, 'Child Welfare - Service Case', 'ChildRemoval', 'Child Welfare - Service Case', 1, 1, v_userid, now(), v_userid, now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL)
	RETURNING activityid INTO v_activityid;

  -- Calculate the 5th business day from ad_removal_dt
   
    WHILE v_business_days < 5 LOOP
        v_task1_due_date := v_task1_due_date + INTERVAL '1 day';
        v_check_date := v_task1_due_date::DATE;

        IF EXTRACT(DOW FROM v_check_date) NOT IN (0, 6) AND
           v_check_date NOT IN (SELECT unnest(v_holidays)) THEN
            v_business_days := v_business_days + 1;
        END IF;
    END LOOP;
   
   RAISE NOTICE 'v_business_days%',v_business_days;
     
       -- New child removal created with older date and first task is older than current date then setting first task date as current date.
	if v_task1_due_date < current_date then
		v_task1_due_date := current_date;	
		v_old_child_removal := TRUE;
	end if;

	-- setting initial duedate for HealthDisorder and MedicationPsychotropic
	v_task_due_date_MS := v_task1_due_date;
	v_task_due_date_HD := v_task1_due_date;


	select servicecasenumber from servicecase where servicecaseid in (select servicecaseid from intakeservreqchildremoval 
	where intakeservreqchildremovalid = au_removalid limit 1) INTO v_servicecasenumber;

	  -- Find the most recent date from medication entry and audit table within the last 30 days
  	SELECT COALESCE(
               (select MAX(insertedon)  from cjams.personmedicpshychotropic where personid = au_personid and insertedon >= NOW() - interval '30 days'),
               (select MAX(insertedon)  from auditlog where objecttype = 'Medication-Psychotropic' and objectid = v_servicecasenumber and referenceid = au_personid and insertedby = v_userid and insertedon >= NOW() - interval '30 days')
           )
    INTO v_recent_medication_entry_date;
    IF v_recent_medication_entry_date IS NOT NULL THEN
        v_found_recent_medication_entry := TRUE;
    END IF;

    -- Loop through tasks for HealthDisorder, MedicationPsychotropic
    FOR v_actiontype IN SELECT unnest(ARRAY['HealthDisorder', 'MedicationPsychotropic']) loop
    
     -- Determining number of tasks for each action
        v_task_limit := CASE v_actiontype
            WHEN 'HealthDisorder' THEN 2
            WHEN 'MedicationPsychotropic' THEN 4
        END;
     
          FOR i IN 0..(v_task_limit - 1) LOOP   
	          -- defining task date for 2nd task onwords for MedicationPsychotropic
	          if i != 0 and v_actiontype = 'MedicationPsychotropic' then     
					if v_old_child_removal then
						--setting task dates based on child removal date cycle for child removals with past dates.
						v_task_due_date_MS = (ad_removal_dt::date + (INTERVAL '30 day' * (FLOOR((CURRENT_DATE - ad_removal_dt::date) / 30) + i))); -- Task  2, 3, 4
						else 
						v_task_due_date_MS = ad_removal_dt + (i * INTERVAL '30 days');  -- Task  2, 3, 4
					end if;
			  end if;
			 
			 -- defining task date for 2nd task onwords for HealthDisorder
			 if i != 0 and v_actiontype = 'HealthDisorder' then    
					v_task_due_date_HD = v_task_due_date_HD + (i * INTERVAL '90 days');  -- Task 1, 2
			end if;					
           
          
          -- updating task status and completion date if medication entry found in last 30 days
	            IF v_found_recent_medication_entry and v_actiontype = 'MedicationPsychotropic' then
	            -- Check if recent medication entry exists AND falls within the same month as the current task date
	            	IF EXTRACT(YEAR FROM v_recent_medication_entry_date) = EXTRACT(YEAR FROM v_task_due_date_MS) AND
	               	EXTRACT(MONTH FROM v_recent_medication_entry_date) = EXTRACT(MONTH FROM v_task_due_date_MS) THEN
		                v_status := 'CRClosed';
		                v_completed_date := v_recent_medication_entry_date;
		            ELSE
		                v_status := 'CROpen';
		                v_completed_date := NULL;
		            END IF;
		        else
		        		v_status := 'CROpen';
						v_completed_date := NULL;
		        END IF;

			-- updating task status and completion date for HealthDisorder
				If v_actiontype = 'HealthDisorder' then				
					v_status := case when v_task_due_date_HD < current_date then 'CRInProgress' else 'CROpen' end;
					v_completed_date := NULL;
				end if;	
          
           -- Inserting records into activitytask table
           INSERT INTO cjams.activitytask
			(activitytaskid, activityid, "name", description, helptext, amtaskid, assignedto, assignedon, activitytaskstatustypekey, activitytaskdispositiontypekey, activitytasktypekey, activityprioritytypekey, duedate, startdatetime, enddatetime, "location", outofoffice, reasonnotmet, "sequence", required, completeddate, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id, "timestamp", voidedby, voidedon, voidreasonid, targetcompleteddate, assessmenttemplateid, assessmentid, taskcommunicationtypekey, taskdispositiontypekey, iscontinual, reminderdate, iseditable, notes, etl_userid, etl_load_date, supervisorstatus, status)
			VALUES(
				gen_random_uuid()::uuid, 
				v_activityid::uuid, 
				CASE v_actiontype
                    WHEN 'HealthDisorder' THEN vs_healthdisorder_task_txt
                    WHEN 'MedicationPsychotropic' THEN vs_medicationpsychotropic_task_txt
                end,
                CASE v_actiontype
                    WHEN 'HealthDisorder' THEN 'HealthDisorder'
                    WHEN 'MedicationPsychotropic' THEN 'MedicationPsychotropic'
                end,				
				'Child Welfare - Service Case', 
				NULL, 
				v_userid,
				now(), 
				v_status,				
				NULL,
				CASE v_actiontype
                    WHEN 'HealthDisorder' THEN 'HealthDisorder'
                    WHEN 'MedicationPsychotropic' THEN 'MedicationPsychotropic'
                end,	
				NULL, 
				CASE v_actiontype
                    WHEN 'HealthDisorder' THEN v_task_due_date_HD
                    WHEN 'MedicationPsychotropic' then v_task_due_date_MS                    	
                end,
				NULL, NULL, NULL, NULL, NULL,
				case v_old_child_removal 
					when true then 
						case i when 0 then 
							0 
						else 
							1 
						end 
					else 1 end,				
				--i,
				true, 
				v_completed_date,	
				1, v_userid, now(), v_userid, now(), now(), NULL, 
				NULL, NULL, NULL, NULL, NULL, NULL,NULL,NULL, NULL, NULL, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
        END LOOP;
     END LOOP;
    
  
   else
   
        --	Updating existing open and pending task to inactive on child removal end.
        update activitytask set activeflag = 0, updatedon=now(), updatedby=user_id::uuid where activityid = (select activityid from activity where objectid = au_removalid and activeflag = 1 limit 1)
        and activitytaskstatustypekey != 'CRClosed';
    
   end if;
	
	Return 1;
END;

$function$
;
