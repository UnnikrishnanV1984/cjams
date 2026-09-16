DROP FUNCTION IF EXISTS cjams.spcreateactiontaskfromdailyjobforexistingchildremoval();
CREATE OR REPLACE FUNCTION cjams.spcreateactiontaskfromdailyjobforexistingchildremoval()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Naveenkumar Chemutu
-- Date Created : 05/13/2025 
-- To create system generated task in mydashboard for existing child removal using daily job (Child entered out of home placement)

------------------------------------------------------------------------
-- Revision(s)
-- 05/27/2025 - Naveenkumar Chemutu - (CIDM-10354) - Creating task for existing child removal for Medication Psychotropic and Health Disorder.
-- 10/23/2025 - Vinesh Puthan - (CIDM-10868) - Daily task for child removal job shouldn't consider federal holidays for 30 days job.
------------------------------------------------------------------------ 
declare


v_next_task_due_date DATE;
rec RECORD;
recHD RECORD;
v_year INTEGER;
v_holidays DATE[];  
v_next_year INTEGER := v_year + 1;  -- Calculate the next year


begin


-- Inserting records into activitytask table for Medication Psychotropic
	 FOR rec IN
       	select act.activityid,acttask.name, max(acttask.duedate) as last_task_date, 
		MAX(acttask."sequence" ) AS last_sequence_no,acttask.assignedto from Intakeservreqchildremoval irl	
		left join activity act on act.objectid = irl.intakeservreqchildremovalid and act.activeflag = 1
		left join activitytask acttask on acttask.activityid  = act.activityid and acttask.activeflag = 1
		where irl.exitdate is null 
		and irl.activeflag =1
		and irl.removaldate is not null
		and act.description ='Child Welfare - Service Case' 
		and act.activitytypekey = 'ChildRemoval'
		and acttask.activitytasktypekey = 'MedicationPsychotropic'
		group by act.activityid,acttask.name,acttask.assignedto
		HAVING MAX(acttask.duedate) < CURRENT_DATE + INTERVAL '90 days'
    LOOP
            v_next_task_due_date := rec.last_task_date + INTERVAL '30 days';
			v_year  := EXTRACT(YEAR FROM v_next_task_due_date);
			v_next_year := v_year + 1;  

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


            -- Loop forward to find the next business day
            LOOP
                EXIT WHEN EXTRACT(DOW FROM v_next_task_due_date) NOT IN (0, 6);  -- Not Sunday or Saturday
                    --   AND v_next_task_due_date NOT IN (SELECT unnest(v_holidays));  -- Not a holiday
                -- Move to next day
                v_next_task_due_date := v_next_task_due_date + INTERVAL '1 day';
            END LOOP;

			-- Inserting records into activitytask table for Medication Psychotropic
			INSERT INTO cjams.activitytask
			(activitytaskid, activityid, "name", description, helptext, amtaskid, assignedto, assignedon, 
			activitytaskstatustypekey, activitytaskdispositiontypekey, activitytasktypekey, activityprioritytypekey, 
			duedate, startdatetime, enddatetime, "location", outofoffice, reasonnotmet, "sequence", required, completeddate, 
			activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id, 
			"timestamp", voidedby, voidedon, voidreasonid, targetcompleteddate, assessmenttemplateid, assessmentid, 
			taskcommunicationtypekey, taskdispositiontypekey, iscontinual, reminderdate, iseditable, notes, etl_userid, 
			etl_load_date, supervisorstatus, status)
			values(
			gen_random_uuid()::uuid, 	
			rec.activityid,
			rec.name, 
			'MedicationPsychotropic',
			'Child Welfare - Service Case', 
			NULL, 
			rec.assignedto,
			now(), 
			'CROpen',
			NULL,
			'MedicationPsychotropic',
			NULL,
			v_next_task_due_date, -- next_task_date,
			NULL, NULL, NULL, NULL, NULL,
			rec.last_sequence_no + 1,
			true, 
			NULL,	
			1, 'Inserted By Daily Batch', now(), 'Inserted By Daily Batch', now(), now(), NULL, 
			NULL, NULL, NULL, NULL, NULL, NULL,NULL,NULL, NULL, NULL, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
			
			raise notice 'Activityid medication%',rec.activityid;
    END LOOP;


--------------------------------------------------------------------------------------


-- Inserting records into activitytask table for Health Disorder
	 FOR recHD IN
       	select act.activityid,acttask.name, max(acttask.duedate) as last_task_date, 
		MAX(acttask."sequence" ) AS last_sequence_no,acttask.assignedto from Intakeservreqchildremoval irl	
		left join activity act on act.objectid = irl.intakeservreqchildremovalid and act.activeflag = 1
		left join activitytask acttask on acttask.activityid  = act.activityid and acttask.activeflag = 1
		where irl.exitdate is null 
		and irl.activeflag =1
		and irl.removaldate is not null
		and act.description ='Child Welfare - Service Case' 
		and act.activitytypekey = 'ChildRemoval'
		and acttask.activitytasktypekey = 'HealthDisorder'
		group by act.activityid,acttask.name,acttask.assignedto
		HAVING MAX(acttask.duedate) < CURRENT_DATE + INTERVAL '90 days'
    LOOP

            v_next_task_due_date := recHD.last_task_date + INTERVAL '90 days';
			v_year  := EXTRACT(YEAR FROM v_next_task_due_date);
			v_next_year := v_year + 1;  

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

            -- Loop forward to find the next business day
            LOOP
                EXIT WHEN EXTRACT(DOW FROM v_next_task_due_date) NOT IN (0, 6);  -- Not Sunday or Saturday
                    --   AND v_next_task_due_date NOT IN (SELECT unnest(v_holidays));  -- Not a holiday
                -- Move to next day
                v_next_task_due_date := v_next_task_due_date + INTERVAL '1 day';
            END LOOP;

			-- Inserting records into activitytask table for Health Disorder
			INSERT INTO cjams.activitytask
			(activitytaskid, activityid, "name", description, helptext, amtaskid, assignedto, assignedon, 
			activitytaskstatustypekey, activitytaskdispositiontypekey, activitytasktypekey, activityprioritytypekey, 
			duedate, startdatetime, enddatetime, "location", outofoffice, reasonnotmet, "sequence", required, completeddate, 
			activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id, 
			"timestamp", voidedby, voidedon, voidreasonid, targetcompleteddate, assessmenttemplateid, assessmentid, 
			taskcommunicationtypekey, taskdispositiontypekey, iscontinual, reminderdate, iseditable, notes, etl_userid, 
			etl_load_date, supervisorstatus, status)
			values(
			gen_random_uuid()::uuid, 	
			recHD.activityid,
			recHD.name, 
			'HealthDisorder',
			'Child Welfare - Service Case', 
			NULL, 
			recHD.assignedto,
			now(), 
			'CROpen',
			NULL,
			'HealthDisorder',
			NULL,
			v_next_task_due_date, -- next_task_date,
			NULL, NULL, NULL, NULL, NULL,
			recHD.last_sequence_no + 1,
			true, 
			NULL,	
			1, 'Inserted By Daily Batch', now(), 'Inserted By Daily Batch', now(), now(), NULL, 
			NULL, NULL, NULL, NULL, NULL, NULL,NULL,NULL, NULL, NULL, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
			
			raise notice 'Health Disorder%',recHD.activityid;
    END LOOP;

END;
$function$;
