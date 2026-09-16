CREATE OR REPLACE FUNCTION cjams.getservicecaseremovallistfordisordercheck(v_objectid uuid)
 RETURNS json
 LANGUAGE plpgsql
AS $function$  

----------------------------------------------------------------
-- 02/05/2025 - B-208477 - Vamshikrishna.byreddy
-- 05/13/2025 - B-208462 - Naveenkumar Chemutu 
---------------------------------------------------------------
 
 DECLARE           
 l_childremoval json;     
 
 BEGIN    
	
with temp_data_set as (
select pr.cjamspid,irl.removaldate,acttask.ActivityTaskStatusTypeKey,acttask.name as task,acttask.duedate ,
pr.firstname || ' ' || pr.lastname personname, 
(SELECT gr.typedescription from gendertype gr where gr.gendertypekey  = pr.gendertypekey limit 1),      
(
	SELECT JSON_aGG(TT) FROM (     
	SELECT   
	irl.intakeservreqchildremovalid,  
	irl.intakeserviceid,   
	irl.intakeservicerequestactorid,        
	irl.removaldate,       
	irl.removaltime, 
	irl.exitdate,	
	(
		SELECT rs.typedescription 
		FROM routing r 
		INNER JOIN routingstatustype rs ON rs.sequencenumber = r.routingstatustypeid AND rs.activeflag =1
		WHERE r.objectid = irl.intakeservreqchildremovalid :: character varying AND r.activeflag =1 order by r.insertedon desc limit 1 
	) AS approvalstatus FROM Intakeservreqchildremoval irl 
	LEFT JOIN servicecase sc on sc.servicecaseid = irl.servicecaseid AND sc.activeflag = 1 
	INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = irl.intakeservicerequestactorid
	WHERE irl.activeflag =1 and irl.servicecaseid = v_objectid and isra.personid = pr.personid and irl.exitdate is null
	) TT 
) AS childremoval,
pr.personid,
(case when acttask.activitytasktypekey = 'HealthDisorder' then 'Health-Disorder'
 when acttask.activitytasktypekey = 'MedicationPsychotropic' then 'Medication-Psychotropic' end)
 as AlertType
  from Intakeservreqchildremoval irl 
	INNER JOIN servicecase scc on scc.servicecaseid = irl.servicecaseid AND scc.activeflag = 1 
	INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = irl.intakeservicerequestactorid and irl.activeflag  = 1
	inner join person pr on pr.personid = isra.personid  AND pr.activeflag = 1 
    INNER JOIN Activity act ON irl.intakeservreqchildremovalid = act.objectid AND act.activeflag = 1
    INNER JOIN Activitytask acttask ON act.activityid = acttask.activityid  
    AND acttask.activeflag = 1 AND act.activeflag = 1 
    
    WHERE 
  	irl.activeflag = 1 
    AND irl.exitdate IS NULL
    AND pr.personid in (
		select DISTINCT iscr.personid from intakeservicerequestactor  iscr
		where iscr.servicecaseid = v_objectid and iscr.activeflag = 1
		and iscr.intakeservicerequestpersontypekey in ('AV','CHILD','BIOCHILD','OTHERCHILD'))
	AND
        (
            -- past due tasks with pending/open status
            duedate::date <= CURRENT_DATE AND activitytaskstatustypekey IN ('CROpen', 'CRInProgress')
        )

),

ranked_tasks AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY  personid, activitytaskstatustypekey,alerttype
               ORDER BY 
                   CASE 
                       WHEN activitytaskstatustypekey = 'CRInProgress' THEN 1
                       WHEN activitytaskstatustypekey = 'CROpen' THEN 2
                       ELSE 3
                   END,
                   duedate
           ) AS rn
    FROM temp_data_set
)

	SELECT json_agg(e) INTO l_childremoval FROM( 
		SELECT * FROM ranked_tasks WHERE rn = 1 and duedate::date <= current_date
	)e ;

RETURN l_childremoval;
END;

$function$
;


