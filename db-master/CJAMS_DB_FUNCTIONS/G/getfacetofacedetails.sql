Drop FUNCTION IF EXISTS cjams.getfacetofacedetails(uuid);
Drop FUNCTION IF EXISTS cjams.getfacetofacedetails(uuid, character varying);
Drop FUNCTION IF EXISTS cjams.getfacetofacedetails(uuid, character varying, integer, character varying);
Drop FUNCTION IF EXISTS cjams.getfacetofacedetails(uuid, character varying, integer, character varying, integer);
Drop FUNCTION IF EXISTS cjams.getfacetofacedetails(uuid, character varying, integer, integer);
CREATE OR REPLACE FUNCTION cjams.getfacetofacedetails(v_intakeserviceid uuid, v_intakenumber character varying, isExpungementSuperUser integer DEFAULT 0, isexpunged integer DEFAULT 0::integer)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 10/03/2022 - Vineet Tirodkar - To add new the Response Timer Checklist Item (CIDM-5447/B-144171)
-- 05/18/2023 - Vineet Tirodkar - To verify all applicable clients are having approved Safe-Cs (CIDM-7055/B-156868))
-- 09/18/2023 - Chandra/Palani - Query tuning (CIDM-7941)
-- 10/02/2023 - Manasa Kasula - Reverting query tuning changes (CIDM-7972)
-- 1/21/2025 - Umasankar Raavi - Modified assessment changes as per CPS Child Fatality User Story (CIDM-10009)
-- 2/6/2025 - Anil Dharni - Modified MFIRA changes based on dateofdeath and assessmentinitiated time (CIDM-10009)
-- 02/11/2025 - Umasankar Raavi --Fetching the list of satisfied and not satisfied children for SAFE-C and MIFRA as per the CPS Child Fatality User Story (CIDM-10009).
-- 04/24/2025 - Vinesh Puthan -- Unable to submit case for closure as MFIRA checkbox is not checked(CDM-44349) 
-- 07/07/2025 - Naveenkumar Chemutu - User story Form1080 changes (CIDM-10473)
-- 06/16/2025 - Vinesh Puthan -- Case closure checklist should look for either safe-c or safe-c ohp for case closure (CDM-44354)
-- 01/30/2026 - Manasa Kasula - CIDM-10890: Expungement story changes
-- 03/13/2026 - Vinesh Puthan -CDM-44547 :  Fix for selecting MFIRA when Child with DOD and approved assessment with DOD after the assessment date.
-------------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE l_taskdetails json;
DECLARE l_count integer;
DECLARE l_isvalid integer;
DECLARE v_entitytypeid character varying(50);
DECLARE v_responsetimer_status character varying;
DECLARE v_show_responsetimer character varying;
DECLARE v_responsetimer_reason character varying;
DECLARE v_responsetimer_check character varying;
DECLARE vs_safec_sw character varying;
DECLARE is_face_to_face character varying;
DECLARE v_alleged_victim_contact_sw character varying ;
DECLARE v_icc_contact_sw character varying;
DECLARE v_other_children_contact_sw character varying;
DECLARE v_isexpunged integer;

DECLARE l_av_cnt bigint;
 l_am_cnt bigint ;
  l_victim_list text[];
   l_mal_list text[];
   l_allrelation json ;
l_allrel_cnt int;
DECLARE safecmissingchild text[];
DECLARE miframissingchild text[];
DECLARE form1080achild text[];
DECLARE form1080bchild text[];
DECLARE form1080cchild text[];
DECLARE v_form1080A_status character varying;
DECLARE v_form1080B_status character varying;
DECLARE v_form1080C_status character varying;
BEGIN

v_entitytypeid = v_intakeserviceid;

v_isexpunged = 0;
IF (isExpungementSuperUser  = 1) THEN
	v_isexpunged = isexpunged;
END IF;

SELECT  COUNT(1) am_cnt
		, 	array_AGG(personid::text)
		
INTO 	 l_am_cnt, l_mal_list
FROM  	intakeservicerequestactor isra 
WHERE  	isra.activeflag=1  AND v_entitytypeid::uuid  IN (servicecaseid, intakeserviceid)
		AND  intakeservicerequestpersontypekey in ('AM');

SELECT 	COUNT(1) av_cnt
		,	array_AGG(personid::text)	
		
INTO 	l_av_cnt, l_victim_list 
FROM  	intakeservicerequestactor isra 
WHERE  	isra.activeflag=1  AND v_entitytypeid::uuid  IN (servicecaseid, intakeserviceid)
		AND  intakeservicerequestpersontypekey in ('AV');
	
SELECT allrelationshipdetails INTO  l_allrelation 
FROM allrelationshipdetails(v_entitytypeid,l_victim_list, l_mal_list);


SELECT json_array_length(l_allrelation) INTO l_allrel_cnt;

select alleged_victim_contact_sw, icc_contact_sw, other_children_contact_sw, responsetimer_status 
into v_alleged_victim_contact_sw, v_icc_contact_sw, v_other_children_contact_sw , v_responsetimer_status
from cjams.getresponsetimerdetails(v_intakeserviceid::uuid, ''::character varying);

if(v_alleged_victim_contact_sw in ('Y', 'L') and v_icc_contact_sw in ('Y', 'L') and v_other_children_contact_sw in ('Y', 'L')) then 
	is_face_to_face = 'Y';
else
	is_face_to_face = 'N';
end if;

SELECT count(1) INTO l_count 
from intakeservicerequestactor isr
where isr.intakeservicerequestpersontypekey  IN ('AV','ICC') and isr.activeflag = 1
and isr.personid in ( 
SELECT isra.personid
FROM contactparticipant ct
		INNER JOIN progressnote pt ON ct.progressnoteid=pt.progressnoteid AND  ct.activeflag=1 AND pt.activeflag=1
		INNER JOIN progressnotetype pty ON pty.progressnotetypeid=pt.progressnotetypeid AND pty.activeflag=1
		INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid=ct.intakeservicerequestactorid --AND isra.activeflag=1  
WHERE pty.progressnotetypekey in ('Initialfacetoface', 'Face To Face') 
		AND pt.attemptindicator IS NOT NULL AND pt.entitytypeid in (v_entitytypeid,
				(SELECT DISTINCT intakeserviceid:: character varying FROM intakeservicerequest WHERE servicecaseid =v_entitytypeid::UUID AND activeflag =1 LIMIT 1),
									(SELECT DISTINCT intakenumber:: character varying FROM intakeservicerequestactor WHERE (servicecaseid =v_entitytypeid::UUID OR intakeserviceid =v_entitytypeid::UUID ) AND activeflag =1 LIMIT 1),
									(SELECT DISTINCT servicecaseid:: character varying FROM intakeservicerequestactor WHERE (servicecaseid =v_entitytypeid::UUID OR intakeserviceid =v_entitytypeid::UUID ) AND activeflag =1 LIMIT 1)
									));
									

SELECT CASE WHEN Count(1)=1 AND p.dateofdeath IS NOT NULL THEN 0 ELSE 1 END into l_isvalid  
FROM intakeservicerequestactor isra  
INNER JOIN actor A ON a.actorid=isra.actorid and a.activeflag=1
INNER JOIN person p ON isra.personid=p.personid AND p.activeflag=1  
WHERE isra.intakeserviceid=v_intakeserviceid AND intakeservicerequestpersontypekey IN('RC', 'CHILD', 'Child') AND isra.activeflag=1 GROUP BY p.dateofdeath;

RAISE  NOTICE  '%l_isvalid',  l_isvalid;

-- Required Reporting: Late or Incomplete Initial Contact

If v_responsetimer_status is null then
	v_responsetimer_status := 'Null';
end if;

if v_responsetimer_status <> 'Stopped' then
	-- Show the new checklist Item
	v_show_responsetimer := 'YES';
  
	
	select (case when count(*) > 0 then 'YES' else 'NO' end) 
		into v_responsetimer_reason
	from cpsresponsetimeractions cra
	where cra.intakeserviceid = v_intakeserviceid
		and cra.isskipped = false
		-- and cpsresponsetimerreason1 is not null
		and cra.activeflag = 1 
		and ( select count(*)
					from routing ro
				where ro.eventcode = 'CPSRTSV'
					and ro.objectid = cra.cpsresponsetimeractionsid::character varying
					and ro.routingstatustypeid = '16'
					and ro.activeflag = 1
			) > 0;

	if v_responsetimer_reason = 'YES' then
		-- the new checklist Item should chekced
		v_responsetimer_check := 'YES';
	else
		-- the new checklist Item should blank
		v_responsetimer_check := 'NO';
	end if;
else
	-- Hide the new checklist Item
	v_show_responsetimer := 'NO';
	v_responsetimer_check := 'NO';
end if;

-- update status for Form 1080 A
 select case when status = 'Approved' then 'Yes' else 'No' end into v_form1080A_status 
 from form1080a fa 
 where fa.objectid in (v_entitytypeid,v_intakenumber) and fa.status ='Approved' and fa.activeflag  = 1 limit 1;


-- update status for Form 1080 B
 select case when status = 'Approved' then 'Yes' else 'No' end as status into v_form1080B_status 
 from form1080b fb 
 where fb.objectid in (v_entitytypeid,v_intakenumber) and fb.status ='Approved' and fb.activeflag  = 1 limit 1;

 -- update status for Form 1080 C
 select case when status = 'Approved' then 'Yes' else 'No' end into v_form1080C_status 
 from form1080c fc 
 where fc.objectid in (v_entitytypeid,v_intakenumber) and fc.status ='Approved' and fc.activeflag  = 1 limit 1;

-- Construct list of childs for Form1080A
    WITH form1080aChildArray AS (
        SELECT 
            fa.personid ,
            p.firstname,
            p.lastname,
            Status,
            fa.updatedon,
            ROW_NUMBER() OVER (PARTITION BY fa.Personid ORDER BY fa.updatedon  ASC) AS rn_first,
            ROW_NUMBER() OVER (PARTITION BY fa.Personid ORDER BY fa.updatedon DESC) AS rn_last
        FROM form1080a fa join person p on  p.personid::uuid = fa.personid::uuid
        where fa.objectid in (v_entitytypeid, v_intakenumber)
    )

    SELECT 
    ARRAY_AGG(CONCAT(first.firstname, ' ', first.lastname, ' (', first.status, ')')) 
    INTO form1080achild
    FROM form1080aChildArray first JOIN form1080aChildArray last
    ON first.Personid = last.Personid
    WHERE first.rn_first = 1 AND last.rn_last = 1;

-- Construct list of childs for Form1080B
 WITH form1080bChildArray AS (
        SELECT 
            fa.personid ,
            p.firstname,
            p.lastname,
            Status,
            fa.updatedon,
            ROW_NUMBER() OVER (PARTITION BY fa.Personid ORDER BY fa.updatedon  ASC) AS rn_first,
            ROW_NUMBER() OVER (PARTITION BY fa.Personid ORDER BY fa.updatedon DESC) AS rn_last
        FROM form1080b fa join person p on  p.personid::uuid = fa.personid::uuid
         where fa.objectid in (v_entitytypeid, v_intakenumber)
    )

    SELECT 
    ARRAY_AGG(CONCAT(first.firstname, ' ', first.lastname, ' (', first.status, ')')) 
    INTO form1080bchild
    FROM form1080bChildArray first JOIN form1080bChildArray last
    ON first.Personid = last.Personid
    WHERE first.rn_first = 1 AND last.rn_last = 1;

-- Construct list of childs for Form1080C
WITH form1080cChildArray AS (
        SELECT 
            fa.personid,
            p.firstname,
            p.lastname,
            Status,
            fa.updatedon,
            ROW_NUMBER() OVER (PARTITION BY fa.Personid ORDER BY fa.updatedon  ASC) AS rn_first,
            ROW_NUMBER() OVER (PARTITION BY fa.Personid ORDER BY fa.updatedon DESC) AS rn_last
        FROM form1080c fa join person p on  p.personid::uuid = fa.personid::uuid
         where fa.objectid  in (v_entitytypeid,v_intakenumber)
    )

    SELECT 
    ARRAY_AGG(CONCAT(first.firstname, ' ', first.lastname, ' (', first.status, ')')) 
    INTO form1080cchild
    FROM form1080cChildArray first JOIN form1080cChildArray last
    ON first.Personid = last.Personid
    WHERE first.rn_first = 1 AND last.rn_last = 1;

IF v_isexpunged = 1 THEN

    -- Safe-C
    WITH safec_check AS (
        SELECT DISTINCT insr.personid,
            CONCAT(p.firstname, ' ', p.lastname) AS fullname, 
            p.dateofdeath,       

            -- Count SAFE-C assessments for the child
            (
                SELECT COUNT(*)
                FROM assessment asmt
                JOIN assessmentactor asma 
                  ON asma.assessmentid = asmt.assessmentid 
                  AND asma.activeflag = 1
                JOIN expunge.intakeservicerequestactor_expunge insr1 
                  ON asma.intakeservicerequestactorid = insr1.intakeservicerequestactorid
                WHERE asmt.objectid = v_intakeserviceid
                  AND asmt.assessmenttemplateid in('0f01e16c-73db-42d8-ad84-04eeb5e26418','f6e4c466-72ae-4453-9997-a2a12fcf8035') -- SAFE-C template ID
                  AND LOWER(asmt.assessmentstatustypekey) = 'accepted'
                  AND insr1.personid::uuid = insr.personid
            ) AS safec_count,

            (
                -- Fetch the MINIMUM SAFE-C completion date across all children
                SELECT MIN(DATE((asmt.submissiondata->>'safetyassessmentcompletiondate')::TIMESTAMP))
                FROM assessment asmt
                JOIN assessmentactor asma 
                  ON asma.assessmentid = asmt.assessmentid 
                  AND asma.activeflag = 1
                JOIN intakeservicerequestactor insr1 
                  ON asma.intakeservicerequestactorid = insr1.intakeservicerequestactorid
                WHERE asmt.objectid = v_intakeserviceid
                  AND asmt.assessmenttemplateid in ('0f01e16c-73db-42d8-ad84-04eeb5e26418','f6e4c466-72ae-4453-9997-a2a12fcf8035')
                  AND LOWER(asmt.assessmentstatustypekey) = 'accepted'
            ) AS min_safec_date
        FROM (
              select isra2.activeflag, isra2.intakeservicerequestactorid, isra2.personid, isra2.intakeserviceid, isra2.intakeservicerequestpersontypekey from intakeservicerequestactor isra2 
              where isra2.intakeserviceid = v_intakeserviceid AND isra2.activeflag = 1 and (isra2.intakeservicerequestpersontypekey = 'AV' OR isra2.intakeservicerequestpersontypekey = 'CHILD')
              union 
              select isra1.activeflag, isra1.intakeservicerequestactorid, isra1.personid, isra1.intakeserviceid, isra1.intakeservicerequestpersontypekey from expunge.intakeservicerequestactor_expunge isra1 
              where isra1.intakeserviceid = v_intakeserviceid AND isra1.activeflag = 1 and (isra1.intakeservicerequestpersontypekey = 'AV' OR isra1.intakeservicerequestpersontypekey = 'CHILD')
            ) insr
        JOIN personrole prl 
          ON insr.intakeserviceid = prl.intakeserviceid 
          AND insr.personid = prl.personid
        JOIN person p 
          ON insr.personid = p.personid 
        WHERE insr.intakeserviceid = v_intakeserviceid
          AND insr.activeflag = 1
          AND prl.activeflag = 1
          AND (
              insr.intakeservicerequestpersontypekey = 'AV'
              OR (
                  insr.intakeservicerequestpersontypekey = 'CHILD'
                  AND prl.ishouseholdmember = '1'
              )
          )
    )
    -- Main query to get the satisfaction status for all children
    SELECT 
        -- Assign SAFE-C compliance flag
        CASE 
            WHEN (SELECT COUNT(*) FROM safec_check 
                WHERE safec_count = 0 
                    AND (dateofdeath IS NULL OR (min_safec_date IS NOT NULL AND dateofdeath > min_safec_date))
                ) > 0 
            THEN 'N' -- Missing SAFE-C for one or more children
            ELSE 'Y' -- All active children have SAFE-C, or deceased ones died before minimum SAFE-C completion
        END AS vs_safec_sw,

        -- Construct the list of all children with their satisfaction status
        (SELECT ARRAY_AGG(
                CONCAT(
                    safec_check.fullname, 
                    ' (', 
                    CASE 
                        WHEN safec_check.safec_count = 0 
                            AND (safec_check.dateofdeath IS NULL OR (safec_check.min_safec_date IS NOT NULL AND safec_check.dateofdeath > safec_check.min_safec_date))
                        THEN 'Not Satisfied'  -- Missing SAFE-C assessment
                        ELSE 'Satisfied'  -- Have SAFE-C assessment
                    END, 
                    ')'
                )
            )
        FROM safec_check
        ) AS safecmissingchild
    INTO vs_safec_sw, safecmissingchild;

        
  --Mifra missingchild 
  With relevant_children AS (
      -- Find children who already have a MIFRA assessment
      SELECT DISTINCT 
          insr.personid, 
          p.firstname,
          p.lastname,
          p.dateofdeath, 
          EXTRACT(YEAR FROM age(p.dateofdeath, p.dob)) AS age_at_death,
          (asmt.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::DATE AS dateassessmentinitiated
      FROM  (
              select isra2.activeflag,isra2.intakeservicerequestactorid, isra2.personid, isra2.intakeserviceid, isra2.intakeservicerequestpersontypekey from intakeservicerequestactor isra2 
              where isra2.intakeserviceid = v_intakeserviceid AND isra2.activeflag = 1 and (isra2.intakeservicerequestpersontypekey = 'AV' OR isra2.intakeservicerequestpersontypekey = 'CHILD')
              union 
              select isra1.activeflag,isra1.intakeservicerequestactorid, isra1.personid, isra1.intakeserviceid, isra1.intakeservicerequestpersontypekey from expunge.intakeservicerequestactor_expunge isra1 
              where isra1.intakeserviceid = v_intakeserviceid AND isra1.activeflag = 1 and (isra1.intakeservicerequestpersontypekey = 'AV' OR isra1.intakeservicerequestpersontypekey = 'CHILD')
            ) insr
      JOIN personrole prl 
          ON insr.intakeserviceid = prl.intakeserviceid 
          AND insr.personid = prl.personid
          AND prl.activeflag = 1
      JOIN person p 
          ON insr.personid = p.personid 
          AND p.activeflag = 1
      JOIN assessmentactor asact 
          ON insr.intakeservicerequestactorid = asact.intakeservicerequestactorid 
          AND asact.activeflag = 1
      JOIN assessment asmt 
          ON asact.assessmentid = asmt.assessmentid 
          AND asmt.activeflag = 1
      WHERE insr.intakeserviceid = v_intakeserviceid
        AND insr.activeflag = 1
        AND (
            insr.intakeservicerequestpersontypekey IN ('AV')
            OR (
                insr.intakeservicerequestpersontypekey = 'CHILD'
                AND prl.ishouseholdmember = '1'
            )
        )   
        AND asmt.assessmenttemplateid = 'ba9b5838-e8ab-434b-9871-3611e86c314d'
        AND LOWER(asmt.assessmentstatustypekey) = 'accepted'
  ),
  
    aggregated_children AS (
        -- Group children to find min assessment dates and oldest date of death
        SELECT 
            rc.personid,
            MIN(rc.dateofdeath) AS oldest_dateofdeath,
            MIN(rc.dateassessmentinitiated) AS dateassessmentinitiated,
            (ARRAY_AGG(rc.age_at_death ORDER BY rc.dateofdeath))[1] AS age_at_death
        FROM relevant_children rc
        GROUP BY rc.personid
    ),

  completed_assessments AS (
      -- Find all children linked to the intake service who should have MIFRA
      SELECT DISTINCT p.personid, p.firstname, p.lastname
      FROM (
              select isra2.intakeservicerequestactorid, isra2.personid, isra2.intakeserviceid, isra2.intakeservicerequestpersontypekey from intakeservicerequestactor isra2 
              where isra2.intakeserviceid = v_intakeserviceid AND isra2.activeflag = 1 and (isra2.intakeservicerequestpersontypekey = 'AV' OR isra2.intakeservicerequestpersontypekey = 'CHILD')
              union 
              select isra1.intakeservicerequestactorid, isra1.personid, isra1.intakeserviceid, isra1.intakeservicerequestpersontypekey from expunge.intakeservicerequestactor_expunge isra1 
              where isra1.intakeserviceid = v_intakeserviceid AND isra1.activeflag = 1 and (isra1.intakeservicerequestpersontypekey = 'AV' OR isra1.intakeservicerequestpersontypekey = 'CHILD')
            ) iar
      JOIN personrole prl 
          ON iar.intakeserviceid = prl.intakeserviceid 
          AND iar.personid = prl.personid
          AND prl.activeflag =1
      JOIN person p 
          ON p.personid = iar.personid 
          AND p.activeflag = 1 
      WHERE iar.intakeserviceid = v_intakeserviceid 
        AND (
            iar.intakeservicerequestpersontypekey IN ('AV')
            OR (
                iar.intakeservicerequestpersontypekey = 'CHILD'
                AND prl.ishouseholdmember = '1'
            )
        )

  ),

  children_without_mifra AS (
    -- Find children who DO NOT have a MIFRA assessment
    SELECT ca.personid, ca.firstname, ca.lastname
    FROM completed_assessments ca
    LEFT JOIN relevant_children rc 
        ON ca.personid = rc.personid
    WHERE rc.personid IS NULL  -- Ensures child has no MIFRA assessment
    ),

    children_to_check AS (
        -- Get missing MIFRA children's details
        SELECT 
            cw.personid AS fl_personid,
            ac.personid AS ca_personid,
            ac.dateassessmentinitiated,
            p.dateofdeath,
            ac.oldest_dateofdeath
        FROM children_without_mifra cw
        FULL OUTER JOIN aggregated_children ac 
            ON cw.personid = ac.personid
        LEFT JOIN person p 
            ON p.personid = COALESCE(cw.personid, ac.personid)
        WHERE cw.personid IS NULL OR ac.personid IS NULL
    ),

    final_filter AS (
        -- Apply the final filtering logic to check if they should be reported as missing MIFRA
        SELECT DISTINCT ctc.fl_personid AS personid, 
            ca.firstname, 
            ca.lastname,
            CASE 
                -- If child has no MIFRA assessment and is alive, mark as "Not Satisfied"
                WHEN ctc.fl_personid IS NOT NULL 
                        AND (ctc.dateofdeath IS NULL OR ctc.dateofdeath > (SELECT MIN(dateassessmentinitiated) FROM aggregated_children))
                THEN 'Not Satisfied'
                ELSE 'Satisfied'
            END AS status
        FROM completed_assessments ca
        LEFT JOIN children_to_check ctc 
            ON ca.personid = ctc.fl_personid
    )

    -- Extract unique names with their satisfaction status into an array
    SELECT ARRAY_AGG(CONCAT(ff.firstname, ' ', ff.lastname, ' (', ff.status, ')')) 
    INTO miframissingchild
    FROM final_filter ff;

ELSE 
    -- Safe-C
    WITH safec_check AS (
        SELECT DISTINCT insr.personid,
            CONCAT(p.firstname, ' ', p.lastname) AS fullname, 
            p.dateofdeath,            
            -- Count SAFE-C assessments for the child
            (
                SELECT COUNT(*)
                FROM assessment asmt
                JOIN assessmentactor asma 
                  ON asma.assessmentid = asmt.assessmentid 
                  AND asma.activeflag = 1
                JOIN intakeservicerequestactor insr1 
                  ON asma.intakeservicerequestactorid = insr1.intakeservicerequestactorid
                WHERE asmt.objectid = v_intakeserviceid
                  AND asmt.assessmenttemplateid in('0f01e16c-73db-42d8-ad84-04eeb5e26418','f6e4c466-72ae-4453-9997-a2a12fcf8035') -- SAFE-C template ID
                  AND LOWER(asmt.assessmentstatustypekey) = 'accepted'
                  AND insr1.personid = insr.personid
            ) AS safec_count,
            (
                -- Fetch the MINIMUM SAFE-C completion date across all children
                SELECT MIN(DATE((asmt.submissiondata->>'safetyassessmentcompletiondate')::TIMESTAMP))
                FROM assessment asmt
                JOIN assessmentactor asma 
                  ON asma.assessmentid = asmt.assessmentid 
                  AND asma.activeflag = 1
                JOIN intakeservicerequestactor insr1 
                  ON asma.intakeservicerequestactorid = insr1.intakeservicerequestactorid
                WHERE asmt.objectid = v_intakeserviceid
                  AND asmt.assessmenttemplateid in ('0f01e16c-73db-42d8-ad84-04eeb5e26418','f6e4c466-72ae-4453-9997-a2a12fcf8035')
                  AND LOWER(asmt.assessmentstatustypekey) = 'accepted'
            ) AS min_safec_date
        FROM intakeservicerequestactor insr
        JOIN personrole prl 
          ON insr.intakeserviceid = prl.intakeserviceid 
          AND insr.personid = prl.personid
        JOIN person p 
          ON insr.personid = p.personid 
        WHERE insr.intakeserviceid = v_intakeserviceid
          AND insr.activeflag = 1
          AND prl.activeflag = 1
          AND (
              insr.intakeservicerequestpersontypekey = 'AV'
              OR (
                  insr.intakeservicerequestpersontypekey = 'CHILD'
                  AND prl.ishouseholdmember = '1'
              )
          )
    )

    -- Main query to get the satisfaction status for all children
    SELECT 
        -- Assign SAFE-C compliance flag
        CASE 
            WHEN (SELECT COUNT(*) FROM safec_check 
                WHERE safec_count = 0 
                    AND (dateofdeath IS NULL OR (min_safec_date IS NOT NULL AND dateofdeath > min_safec_date))
                ) > 0 
            THEN 'N' -- Missing SAFE-C for one or more children
            ELSE 'Y' -- All active children have SAFE-C, or deceased ones died before minimum SAFE-C completion
        END AS vs_safec_sw,

        -- Construct the list of all children with their satisfaction status
        (SELECT ARRAY_AGG(
                CONCAT(
                    safec_check.fullname, 
                    ' (', 
                    CASE 
                        WHEN safec_check.safec_count = 0 
                            AND (safec_check.dateofdeath IS NULL OR (safec_check.min_safec_date IS NOT NULL AND safec_check.dateofdeath > safec_check.min_safec_date))
                        THEN 'Not Satisfied'  -- Missing SAFE-C assessment
                        ELSE 'Satisfied'  -- Have SAFE-C assessment
                    END, 
                    ')'
                )
            )
        FROM safec_check
        ) AS safecmissingchild
    INTO vs_safec_sw, safecmissingchild;
      
  --Mifra missingchild 
  WITH relevant_children AS (
      -- Find children who already have a MIFRA assessment
      SELECT DISTINCT 
          insr.personid, 
          p.firstname,
          p.lastname,
          p.dateofdeath, 
          EXTRACT(YEAR FROM age(p.dateofdeath, p.dob)) AS age_at_death,
          (asmt.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::DATE AS dateassessmentinitiated
      FROM intakeservicerequestactor insr
      JOIN personrole prl 
          ON insr.intakeserviceid = prl.intakeserviceid 
          AND insr.personid = prl.personid
          AND prl.activeflag = 1
      JOIN person p 
          ON insr.personid = p.personid 
          AND p.activeflag = 1
      JOIN assessmentactor asact 
          ON insr.intakeservicerequestactorid = asact.intakeservicerequestactorid 
          AND asact.activeflag = 1
      JOIN assessment asmt 
          ON asact.assessmentid = asmt.assessmentid 
          AND asmt.activeflag = 1
      WHERE insr.intakeserviceid = v_intakeserviceid
        AND insr.activeflag = 1
        AND (
            insr.intakeservicerequestpersontypekey IN ('AV')
            OR (
                insr.intakeservicerequestpersontypekey = 'CHILD'
                AND prl.ishouseholdmember = '1'
            )
        )   
        AND asmt.assessmenttemplateid = 'ba9b5838-e8ab-434b-9871-3611e86c314d'
        AND LOWER(asmt.assessmentstatustypekey) = 'accepted'
  ),
  
    aggregated_children AS (
        -- Group children to find min assessment dates and oldest date of death
        SELECT 
            rc.personid,
            MIN(rc.dateofdeath) AS oldest_dateofdeath,
            MIN(rc.dateassessmentinitiated) AS dateassessmentinitiated,
            (ARRAY_AGG(rc.age_at_death ORDER BY rc.dateofdeath))[1] AS age_at_death
        FROM relevant_children rc
        GROUP BY rc.personid
    ),

  completed_assessments AS (
      -- Find all children linked to the intake service who should have MIFRA
      SELECT DISTINCT p.personid, p.firstname, p.lastname
      FROM Intakeservicerequestactor iar
      JOIN personrole prl 
          ON iar.intakeserviceid = prl.intakeserviceid 
          AND iar.personid = prl.personid
          AND prl.activeflag =1
      JOIN actor ac 
          ON iar.actorid = ac.actorid  
          AND ac.activeflag = 1 
          AND iar.activeflag = 1
      JOIN person p 
          ON p.personid = ac.personid 
          AND p.activeflag = 1 
      WHERE iar.intakeserviceid = v_intakeserviceid 
        AND (
            iar.intakeservicerequestpersontypekey IN ('AV')
            OR (
                iar.intakeservicerequestpersontypekey = 'CHILD'
                AND prl.ishouseholdmember = '1'
            )
        )

  ),

  children_without_mifra AS (
    -- Find children who DO NOT have a MIFRA assessment
    SELECT ca.personid, ca.firstname, ca.lastname
    FROM completed_assessments ca
    LEFT JOIN relevant_children rc 
        ON ca.personid = rc.personid
    WHERE rc.personid IS NULL  -- Ensures child has no MIFRA assessment
    ),

    children_to_check AS (
        -- Get missing MIFRA children's details
        SELECT 
            cw.personid AS fl_personid,
            ac.personid AS ca_personid,
            ac.dateassessmentinitiated,
            p.dateofdeath,
            ac.oldest_dateofdeath
        FROM children_without_mifra cw
        FULL OUTER JOIN aggregated_children ac 
            ON cw.personid = ac.personid
        LEFT JOIN person p 
            ON p.personid = COALESCE(cw.personid, ac.personid)
        WHERE cw.personid IS NULL OR ac.personid IS NULL
    ),

    final_filter AS (
        -- Apply the final filtering logic to check if they should be reported as missing MIFRA
        SELECT DISTINCT ctc.fl_personid AS personid, 
            ca.firstname, 
            ca.lastname,
            CASE 
                -- If child has no MIFRA assessment and is alive, mark as "Not Satisfied"
                WHEN ctc.fl_personid IS NOT NULL 
                        AND (ctc.dateofdeath IS NULL OR ctc.dateofdeath > (SELECT MIN(dateassessmentinitiated) FROM aggregated_children))
                THEN 'Not Satisfied'
                ELSE 'Satisfied'
            END AS status
        FROM completed_assessments ca
        LEFT JOIN children_to_check ctc 
            ON ca.personid = ctc.fl_personid
    )

    -- Extract unique names with their satisfaction status into an array
    SELECT ARRAY_AGG(CONCAT(ff.firstname, ' ', ff.lastname, ' (', ff.status, ')')) 
    INTO miframissingchild
    FROM final_filter ff;

END IF;




if vs_safec_sw = 'N' then             
	SELECT json_agg(ltask) INTO l_taskdetails FROM 
	(
		SELECT 
			'initalfacetoface' AS taskname,
			CASE  WHEN coalesce(is_face_to_face,'N') = 'Y' THEN UPPER('yes') ELSE UPPER('no') END AS status,
			l_isvalid AS isvalid,
			'YES' AS shownoshow,
      COALESCE(array_to_json(safecmissingchild), '[]'::json) AS safecmissingchild,
      COALESCE(array_to_json(miframissingchild), '[]'::json) AS miframissingchild,
      COALESCE(array_to_json(form1080achild), '[]'::json) AS form1080achild,
      COALESCE(array_to_json(form1080bchild), '[]'::json) AS form1080bchild,
      COALESCE(array_to_json(form1080cchild), '[]'::json) AS form1080cchild
		
		UNION ALL		
			SELECT 
			'Personrole' AS taskname,
			CASE WHEN coalesce(l_allrel_cnt,0) >= COALESCE(l_am_cnt,0) *  COALESCE(l_av_cnt,0)  THEN UPPER('yes') ELSE UPPER('no') END AS status,
			l_isvalid AS isvalid,
			'YES' AS shownoshow,
      COALESCE(array_to_json(safecmissingchild), '[]'::json) AS safecmissingchild,
      COALESCE(array_to_json(miframissingchild), '[]'::json) AS miframissingchild,
      COALESCE(array_to_json(form1080achild), '[]'::json) AS form1080achild,
      COALESCE(array_to_json(form1080bchild), '[]'::json) AS form1080bchild,
      COALESCE(array_to_json(form1080cchild), '[]'::json) AS form1080cchild
		
		UNION ALL

SELECT 
    ast.titleheadertext AS taskname,
    'Accepted' AS status,
    l_isvalid AS isvalid,
    'YES' AS shownoshow,
    COALESCE(array_to_json(safecmissingchild), '[]'::json) AS safecmissingchild,
    COALESCE(array_to_json(miframissingchild), '[]'::json) AS miframissingchild,
    COALESCE(array_to_json(form1080achild), '[]'::json) AS form1080achild,
    COALESCE(array_to_json(form1080bchild), '[]'::json) AS form1080bchild,
    COALESCE(array_to_json(form1080cchild), '[]'::json) AS form1080cchild 
FROM assessmenttemplate ast
WHERE ast."name" IN ('marylandFamilyInitialRiskAssessment', 'cansF', 'safeCOhp')
  AND (
    -- Logic for marylandFamilyInitialRiskAssessment with strict 30-day logic
    (
      ast."name" = 'marylandFamilyInitialRiskAssessment'
      AND NOT EXISTS (
          WITH relevant_children AS (
              SELECT DISTINCT insr.personid, p.dateofdeath, 
                     EXTRACT(YEAR FROM age(p.dateofdeath, p.dob)) AS age_at_death,
                    (asmt.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::date AS dateassessmentinitiated
              FROM intakeservicerequestactor insr
              JOIN person p ON insr.personid = p.personid AND p.activeflag = 1
              JOIN personrole prl ON insr.intakeserviceid = prl.intakeserviceid AND insr.personid = prl.personid AND prl.activeflag=1
              JOIN assessmentactor asact 
                ON insr.intakeservicerequestactorid = asact.intakeservicerequestactorid 
              AND asact.activeflag = 1
              JOIN assessment asmt 
                ON asact.assessmentid = asmt.assessmentid 
              AND asmt.activeflag = 1
              WHERE insr.intakeserviceid = v_intakeserviceid
                AND insr.activeflag = 1
                AND (
      	  			insr.intakeservicerequestpersontypekey IN ('AV')
      	 		    OR (
          	  			insr.intakeservicerequestpersontypekey = 'CHILD'
          	  			AND prl.ishouseholdmember = '1'
          			   )
      				)
                AND asmt.assessmenttemplateid = 'ba9b5838-e8ab-434b-9871-3611e86c314d'
                 AND LOWER(asmt.assessmentstatustypekey) = 'accepted'
                
          ),
          reported_date_check AS (
              SELECT reporteddate
              FROM intakeservicerequest
              WHERE intakeserviceid = v_intakeserviceid
          ),
          aggregated_children AS (
              SELECT 
                  personid,
                  MIN(dateofdeath) AS oldest_dateofdeath,
                  MIN(dateassessmentinitiated) AS dateassessmentinitiated,
                  (ARRAY_AGG(age_at_death ORDER BY dateofdeath))[1] AS age_at_death
              FROM relevant_children
              GROUP BY personid
          ),
          completed_assessments AS (
              SELECT DISTINCT p.personid FROM Intakeservicerequestactor AS iar
              JOIN personrole prl ON iar.intakeserviceid = prl.intakeserviceid AND iar.personid = prl.personid AND prl.activeflag = 1
              JOIN actor AS ac ON iar.actorid = ac.actorid  AND ac.activeflag = 1 AND iar.activeflag = 1
              JOIN person AS p ON p.personid = ac.personid AND p.activeflag = 1
              WHERE iar.intakeserviceid = v_intakeserviceid
                AND (
                    iar.intakeservicerequestpersontypekey = 'AV'
                    OR (
                        iar.intakeservicerequestpersontypekey = 'CHILD'
                        AND prl.ishouseholdmember = '1'
                    )
                )
          ),
          final_list as (
	          SELECT *
	          FROM completed_assessments ctc
	          WHERE ctc.personid not IN (SELECT distinct personid FROM relevant_children)
          ),
          children_to_check AS (
			    SELECT 
			        fl.personid AS fl_personid,
			        ca.personid AS ca_personid,
			        ca.dateassessmentinitiated,
			        p.dateofdeath,
			        ca.oldest_dateofdeath
			    FROM final_list fl
			    FULL OUTER JOIN aggregated_children ca ON fl.personid = ca.personid
			    LEFT JOIN person p ON p.personid = COALESCE(fl.personid, ca.personid)
			    LEFT JOIN reported_date_check rdc ON TRUE
			    WHERE fl.personid IS NULL OR ca.personid IS NULL
			),
			final_filter AS (
			    SELECT ctc.fl_personid
			    FROM children_to_check ctc
			    CROSS JOIN (SELECT MIN(dateassessmentinitiated) AS min_dateassessmentinitiated FROM aggregated_children) AS min_dates
                WHERE ctc.fl_personid IS NOT NULL
                AND (
                    dateofdeath IS NULL
                    OR (dateofdeath IS NOT NULL AND dateofdeath > min_dates.min_dateassessmentinitiated)
                )
			)
			SELECT 1 FROM final_filter
      )
    )
    OR
    -- Updated logic for SafeCOhp 
(
    ast."name" = 'safeCOhp'
    AND (
        NOT EXISTS (
            WITH relevant_children AS (
                SELECT DISTINCT insr.personid
                FROM intakeservicerequestactor insr
                WHERE insr.intakeserviceid = v_intakeserviceid
                  AND insr.activeflag = 1
                  AND insr.intakeservicerequestpersontypekey IN ('AV', 'CHILD')
            )
            SELECT 1 
            FROM relevant_children
        )
    )
)

    OR
    -- Logic for cansF remains unchanged
    (
      ast."name" = 'cansF'
      AND (
        NOT EXISTS (
            WITH relevant_children AS (
                SELECT DISTINCT insr.personid, p.dateofdeath, 
                       EXTRACT(YEAR FROM age(p.dateofdeath, p.dob)) AS age_at_death
                FROM intakeservicerequestactor insr
                JOIN person p ON insr.personid = p.personid AND p.activeflag = 1
                WHERE insr.intakeserviceid = v_intakeserviceid
                  AND insr.activeflag = 1
                  AND insr.intakeservicerequestpersontypekey IN ('AV', 'CHILD')
            ),
            alive_or_eligible_children AS (
                SELECT personid
                FROM relevant_children
                WHERE dateofdeath IS NULL -- Alive children
                   OR (dateofdeath IS NOT NULL AND age_at_death >= 18) -- Deceased and over 18
            )
            SELECT 1
            FROM alive_or_eligible_children -- No alive or eligible deceased children
        )
      )
    )
  )


		UNION ALL
		
		SELECT
			'lateinitialcontact' AS taskname ,
			v_responsetimer_check AS status,	
			(case when v_responsetimer_check = 'YES' then 1 else 0 end) as isvalid,
			v_show_responsetimer AS shownoshow,
       COALESCE(array_to_json(safecmissingchild), '[]'::json) AS safecmissingchild,
       COALESCE(array_to_json(miframissingchild), '[]'::json) AS miframissingchild,
       COALESCE(array_to_json(form1080achild), '[]'::json) AS form1080achild,
       COALESCE(array_to_json(form1080bchild), '[]'::json) AS form1080bchild,
       COALESCE(array_to_json(form1080cchild), '[]'::json) AS form1080cchild 

UNION ALL
          
      SELECT
			'form1080a' AS taskname ,
			v_form1080A_status as status,
			l_isvalid As isvalid,
			'YES' As shownoshow,
      COALESCE(array_to_json(safecmissingchild), '[]'::json) AS safecmissingchild,
      COALESCE(array_to_json(miframissingchild), '[]'::json) AS miframissingchild,
      COALESCE(array_to_json(form1080achild), '[]'::json) AS form1080achild,
      COALESCE(array_to_json(form1080bchild), '[]'::json) AS form1080bchild,
      COALESCE(array_to_json(form1080cchild), '[]'::json) AS form1080cchild
		

         UNION all
      
      SELECT
			'form1080b' AS taskname ,
			v_form1080B_status as status,
			l_isvalid As isvalid,
			'YES' As shownoshow,
      COALESCE(array_to_json(safecmissingchild), '[]'::json) AS safecmissingchild,
      COALESCE(array_to_json(miframissingchild), '[]'::json) AS miframissingchild,
      COALESCE(array_to_json(form1080achild), '[]'::json) AS form1080achild,
      COALESCE(array_to_json(form1080bchild), '[]'::json) AS form1080bchild,
      COALESCE(array_to_json(form1080cchild), '[]'::json) AS form1080cchild

       UNION all
      
      SELECT
			'form1080c' AS taskname ,
			v_form1080C_status as status,
			l_isvalid As isvalid,
			'YES' As shownoshow,
      COALESCE(array_to_json(safecmissingchild), '[]'::json) AS safecmissingchild,
      COALESCE(array_to_json(miframissingchild), '[]'::json) AS miframissingchild,
      COALESCE(array_to_json(form1080achild), '[]'::json) AS form1080achild,
      COALESCE(array_to_json(form1080bchild), '[]'::json) AS form1080bchild,
      COALESCE(array_to_json(form1080cchild), '[]'::json) AS form1080cchild
		
	)  ltask;
else
	SELECT json_agg(ltask) INTO l_taskdetails FROM 
	(
		SELECT 
			'initalfacetoface' AS taskname,
			CASE  WHEN coalesce(is_face_to_face,'N') = 'Y' THEN UPPER('yes') ELSE UPPER('no') END AS status,
			l_isvalid AS isvalid,
			'YES' AS shownoshow,
      COALESCE(array_to_json(safecmissingchild), '[]'::json) AS safecmissingchild,
      COALESCE(array_to_json(miframissingchild), '[]'::json) AS miframissingchild,
      COALESCE(array_to_json(form1080achild), '[]'::json) AS form1080achild,
      COALESCE(array_to_json(form1080bchild), '[]'::json) AS form1080bchild,
      COALESCE(array_to_json(form1080cchild), '[]'::json) AS form1080cchild 
		
		UNION ALL		
			SELECT 
			'Personrole' AS taskname,
			CASE WHEN coalesce(l_allrel_cnt,0) >= COALESCE(l_am_cnt,0) *  COALESCE(l_av_cnt,0)  THEN UPPER('yes') ELSE UPPER('no') END AS status,
			l_isvalid AS isvalid,
			'YES' AS shownoshow,
      COALESCE(array_to_json(safecmissingchild), '[]'::json) AS safecmissingchild,
      COALESCE(array_to_json(miframissingchild), '[]'::json) AS miframissingchild,
      COALESCE(array_to_json(form1080achild), '[]'::json) AS form1080achild,
      COALESCE(array_to_json(form1080bchild), '[]'::json) AS form1080bchild,
      COALESCE(array_to_json(form1080cchild), '[]'::json) AS form1080cchild
		
		UNION ALL

SELECT 
    ast.titleheadertext AS taskname,
    'Accepted' AS status,
    l_isvalid AS isvalid,
    'YES' AS shownoshow,
    COALESCE(array_to_json(safecmissingchild), '[]'::json) AS safecmissingchild,
    COALESCE(array_to_json(miframissingchild), '[]'::json) AS miframissingchild,
    COALESCE(array_to_json(form1080achild), '[]'::json) AS form1080achild,
    COALESCE(array_to_json(form1080bchild), '[]'::json) AS form1080bchild,
    COALESCE(array_to_json(form1080cchild), '[]'::json) AS form1080cchild 
FROM assessmenttemplate ast
WHERE ast."name" IN ('marylandFamilyInitialRiskAssessment', 'cansF', 'safeCOhp')
  AND (
    -- Logic for marylandFamilyInitialRiskAssessment with strict 30-day logic
    (
      ast."name" = 'marylandFamilyInitialRiskAssessment'
      AND NOT EXISTS (
          WITH relevant_children AS (
              SELECT DISTINCT insr.personid, p.dateofdeath, 
                     EXTRACT(YEAR FROM age(p.dateofdeath, p.dob)) AS age_at_death,
                    (asmt.submissiondata->'familyHOUSEHOLD'->>'assessmentInitDate')::date AS dateassessmentinitiated
              FROM intakeservicerequestactor insr
              JOIN personrole prl ON insr.intakeserviceid = prl.intakeserviceid AND insr.personid = prl.personid AND prl.activeflag=1
              JOIN person p ON insr.personid = p.personid AND p.activeflag = 1
              JOIN assessmentactor asact 
                ON insr.intakeservicerequestactorid = asact.intakeservicerequestactorid 
              AND asact.activeflag = 1
              JOIN assessment asmt 
                ON asact.assessmentid = asmt.assessmentid 
              AND asmt.activeflag = 1
              WHERE insr.intakeserviceid = v_intakeserviceid
                AND insr.activeflag = 1
                AND (
      	  			insr.intakeservicerequestpersontypekey IN ('AV')
      	  			OR (
          	  			insr.intakeservicerequestpersontypekey = 'CHILD'
          	  			AND prl.ishouseholdmember = '1'
          			   )
  					)

                AND asmt.assessmenttemplateid = 'ba9b5838-e8ab-434b-9871-3611e86c314d'
                 AND LOWER(asmt.assessmentstatustypekey) = 'accepted'
          ),
          reported_date_check AS (
              SELECT reporteddate
              FROM intakeservicerequest
              WHERE intakeserviceid = v_intakeserviceid
          ),
          aggregated_children AS (
              SELECT 
                  personid,
                  MIN(dateofdeath) AS oldest_dateofdeath,
                  MIN(dateassessmentinitiated) AS dateassessmentinitiated,
                  (ARRAY_AGG(age_at_death ORDER BY dateofdeath))[1] AS age_at_death
              FROM relevant_children
              GROUP BY personid
          ),
          completed_assessments AS (
              SELECT DISTINCT p.personid FROM Intakeservicerequestactor AS iar
              JOIN personrole prl ON iar.intakeserviceid = prl.intakeserviceid AND iar.personid = prl.personid AND prl.activeflag = 1
              JOIN actor AS ac ON iar.actorid = ac.actorid  AND ac.activeflag = 1 AND iar.activeflag = 1
              JOIN person AS p ON p.personid = ac.personid AND p.activeflag = 1 WHERE iar.intakeserviceid = v_intakeserviceid
                AND (
                    iar.intakeservicerequestpersontypekey = 'AV'
                    OR (
                        iar.intakeservicerequestpersontypekey = 'CHILD'
                        AND prl.ishouseholdmember = '1'
                    )
                )
          ),
          final_list as (
	          SELECT *
	          FROM completed_assessments ctc
	          WHERE ctc.personid not IN (SELECT distinct personid FROM relevant_children)
          ),
          children_to_check AS (
			    SELECT 
			        fl.personid AS fl_personid,
			        ca.personid AS ca_personid,
			        ca.dateassessmentinitiated,
			        p.dateofdeath,
			        ca.oldest_dateofdeath
			    FROM final_list fl
			    FULL OUTER JOIN aggregated_children ca ON fl.personid = ca.personid
			    LEFT JOIN person p ON p.personid = COALESCE(fl.personid, ca.personid)
			    LEFT JOIN reported_date_check rdc ON TRUE
			    WHERE fl.personid IS NULL OR ca.personid IS NULL
			),
			final_filter AS (
			    SELECT ctc.fl_personid
			    FROM children_to_check ctc
			    CROSS JOIN (SELECT MIN(dateassessmentinitiated) AS min_dateassessmentinitiated FROM aggregated_children) AS min_dates
                WHERE ctc.fl_personid IS NOT NULL
                    AND (
                        dateofdeath IS NULL
                        OR (dateofdeath IS NOT NULL AND dateofdeath > min_dates.min_dateassessmentinitiated)
                    )
                )
			SELECT 1 FROM final_filter
      )
    )
    OR
    -- Updated logic for SafeCOhp 
(
    ast."name" = 'safeCOhp'
    AND (
        NOT EXISTS (
            WITH relevant_children AS (
                SELECT DISTINCT insr.personid
                FROM intakeservicerequestactor insr
                WHERE insr.intakeserviceid = v_intakeserviceid
                  AND insr.activeflag = 1
                  AND insr.intakeservicerequestpersontypekey IN ('AV', 'CHILD')
            )
            SELECT 1 
            FROM relevant_children
        )
    )
)
    OR
    -- Logic for cansF remains unchanged
    (
      ast."name" = 'cansF'
      AND (
        NOT EXISTS (
            WITH relevant_children AS (
                SELECT DISTINCT insr.personid, p.dateofdeath, 
                       EXTRACT(YEAR FROM age(p.dateofdeath, p.dob)) AS age_at_death
                FROM intakeservicerequestactor insr
                JOIN person p ON insr.personid = p.personid AND p.activeflag = 1
                WHERE insr.intakeserviceid = v_intakeserviceid
                  AND insr.activeflag = 1
                  AND insr.intakeservicerequestpersontypekey IN ('AV', 'CHILD')
            ),
            alive_or_eligible_children AS (
                SELECT personid
                FROM relevant_children
                WHERE dateofdeath IS NULL -- Alive children
                   OR (dateofdeath IS NOT NULL AND age_at_death >= 18) -- Deceased and over 18
            )
            SELECT 1
            FROM alive_or_eligible_children -- No alive or eligible deceased children
        )
      )
    )
  )


		union all 
			select 'SAFE-C'as taskname,
				'Accepted' as status,
				l_isvalid As isvalid,
				'YES' As shownoshow,
        COALESCE(array_to_json(safecmissingchild), '[]'::json) AS safecmissingchild,
        COALESCE(array_to_json(miframissingchild), '[]'::json) AS miframissingchild,
        COALESCE(array_to_json(form1080achild), '[]'::json) AS form1080achild,
        COALESCE(array_to_json(form1080bchild), '[]'::json) AS form1080bchild,
        COALESCE(array_to_json(form1080cchild), '[]'::json) AS form1080cchild 
			
		UNION ALL
		
		SELECT
			'lateinitialcontact' AS taskname ,
			v_responsetimer_check AS status,	
			(case when v_responsetimer_check = 'YES' then 1 else 0 end) as isvalid,
			v_show_responsetimer AS shownoshow,
      COALESCE(array_to_json(safecmissingchild), '[]'::json) AS safecmissingchild,
      COALESCE(array_to_json(miframissingchild), '[]'::json) AS miframissingchild,
      COALESCE(array_to_json(form1080achild), '[]'::json) AS form1080achild,
      COALESCE(array_to_json(form1080bchild), '[]'::json) AS form1080bchild,
      COALESCE(array_to_json(form1080cchild), '[]'::json) AS form1080cchild 

      UNION all
      
      SELECT
			'form1080a' AS taskname ,
			v_form1080A_status as status,
			l_isvalid As isvalid,
			'YES' As shownoshow,
      COALESCE(array_to_json(safecmissingchild), '[]'::json) AS safecmissingchild,
      COALESCE(array_to_json(miframissingchild), '[]'::json) AS miframissingchild,
      COALESCE(array_to_json(form1080achild), '[]'::json) AS form1080achild,
      COALESCE(array_to_json(form1080bchild), '[]'::json) AS form1080bchild,
      COALESCE(array_to_json(form1080cchild), '[]'::json) AS form1080cchild
		

         UNION all
      
      SELECT
			'form1080b' AS taskname ,
			v_form1080B_status as status,
			l_isvalid As isvalid,
			'YES' As shownoshow,
      COALESCE(array_to_json(safecmissingchild), '[]'::json) AS safecmissingchild,
      COALESCE(array_to_json(miframissingchild), '[]'::json) AS miframissingchild,
      COALESCE(array_to_json(form1080achild), '[]'::json) AS form1080achild,
      COALESCE(array_to_json(form1080bchild), '[]'::json) AS form1080bchild,
      COALESCE(array_to_json(form1080cchild), '[]'::json) AS form1080cchild

       UNION all
      
      SELECT
			'form1080c' AS taskname ,
			v_form1080C_status as status,
			l_isvalid As isvalid,
			'YES' As shownoshow,
      COALESCE(array_to_json(safecmissingchild), '[]'::json) AS safecmissingchild,
      COALESCE(array_to_json(miframissingchild), '[]'::json) AS miframissingchild,
      COALESCE(array_to_json(form1080achild), '[]'::json) AS form1080achild,
      COALESCE(array_to_json(form1080bchild), '[]'::json) AS form1080bchild,
      COALESCE(array_to_json(form1080cchild), '[]'::json) AS form1080cchild
	)  ltask;
end if;

RETURN  l_taskdetails;                
END;

$function$
;