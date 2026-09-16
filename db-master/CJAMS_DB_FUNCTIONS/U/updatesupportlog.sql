DROP FUNCTION IF EXISTS cjams.updatesupportlog();
CREATE OR REPLACE FUNCTION cjams.updatesupportlog()
	RETURNS CHARACTER VARYING
 LANGUAGE plpgsql
AS $function$
/* Revision History
--CIDM-9705 (Sreekanth Marrikanti) - Added changes to include new column 'identifiedas' to copy jira data 
--CIDM-9882 (Sreekanth Marrikanti) - Added changes to include 'application' column to copy jira data 
--CIDM-9902 (Sreekanth Marrikanti) - Added changes to include cdmcomponent column to copy jira data 
*/
DECLARE
	vrec 				RECORD;
	v_status 			CHARACTER VARYING;
	v_index				integer;
	v_sec_index 		integer;
	v_updateflag 		boolean;
	v_securityusersid	character varying;
	v_county			character varying;
	v_createdby			character varying;
	
BEGIN

	v_index := 0;
	v_sec_index := 0;
	
	RAISE NOTICE 'Begin Execution - cjams.updatesupportlog';

	FOR vrec IN 
		SELECT 	supportnumber, cjamsticketnumber, cjamsticketstatus, cjamsticketcreateddate, cjamslastupdateddate, cjamsresolutiondate, cjamscloseddate, 
				cdmticketnumber, cdmticketstatus, cdmticketcreateddate, cdmlastupdateddate,	cdmresolutiondate,cdmcloseddate,
				fixtype, focusarea, resolution, resolutioncomments, title, component, cdmcomponent, cjamscreatedby, cjamsreportedby,cjamscounty, 
				cdmcreatedby,cdmreportedby, cdmcounty, identifiedas,
				CASE WHEN cdmticketnumber like 'CDM%' THEN
					CASE WHEN cdmcomponent = 'Child Welfare' THEN 'CW'
						WHEN cdmcomponent = 'Adult Services' THEN 'AS'
						WHEN cdmcomponent = 'Provider' THEN 'PROV'
					ELSE '' END 
				ELSE 
					CASE WHEN component = 'Child Welfare' THEN 'CW'
						WHEN component = 'Adult Services' THEN 'AS'
						WHEN component = 'Provider' THEN 'PROV'
					ELSE '' END 
				END as application				
			FROM defecttracking.cjamsjiratickets cjt
			WHERE cjt.activeflag = 1
				AND date(updatedon) >= (now()::date - '1 DAY'::INTERVAL)::date
		LOOP
			v_updateflag := true;
			v_index := v_index + 1;
			v_sec_index := v_sec_index + 1;
			
			IF (vrec.cdmticketnumber IS NULL OR BTRIM(vrec.cdmticketnumber) = '') THEN 
				v_status = vrec.cjamsticketstatus;
			ELSE 
				v_status = vrec.cdmticketstatus;
			END IF;	
			
			IF (btrim(vrec.focusarea) = '') THEN
				vrec.focusarea = null;
			END IF;
			
			IF (vrec.cdmcloseddate IS NULL  
			AND (vrec.cdmticketstatus IN ('Closed', 'CLOSED (NO USER RESPONSE)', 'Cancelled','Ready For Production','Deployed in Production','Done'))) THEN 
				vrec.cdmcloseddate := vrec.cdmresolutiondate;
			END IF;
			
			IF (vrec.cjamscloseddate IS NULL 
				AND (vrec.cjamsticketstatus IN ('Closed', 'CLOSED (NO USER RESPONSE)', 'Cancelled','Ready For Production','Deployed in Production','Done'))) THEN 
				vrec.cjamscloseddate := vrec.cjamsresolutiondate;
			END IF;
			
			IF (vrec.supportnumber IS NULL OR BTRIM(vrec.supportnumber) = '') THEN
				IF NOT EXISTS (SELECT jirarequestno FROM defecttracking.supportlog WHERE jirarequestno = vrec.cjamsticketnumber) THEN
					RAISE NOTICE 'New Record: %', vrec.cjamsticketnumber;
					v_createdby := lower(vrec.cjamsreportedby);
					IF (btrim(v_createdby) = '') THEN 
						v_createdby = vrec.cjamscreatedby;						
					END IF;
					RAISE NOTICE 'Created By: %', v_createdby;
					v_updateflag := false;
					
					IF (vrec.application = 'AS') THEN
						SELECT up.securityusersid, c.countyname INTO v_securityusersid, v_county
							FROM cjams.userprofile up
								left join cjams.as_teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
								left join cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
								left join cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
								left join cjams.county c on c.countyid::character varying = t.countyid and c.activeflag = 1
							WHERE lower(up.email) = v_createdby
							LIMIT 1;
					ELSE
						SELECT up.securityusersid, c.countyname INTO v_securityusersid, v_county
							FROM cjams.userprofile up
								left join cjams.teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
								left join cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
								left join cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
								left join cjams.county c on c.countyid::character varying = t.countyid and c.activeflag = 1
							WHERE lower(up.email) = v_createdby
							LIMIT 1;
					END IF;
										
					INSERT INTO defecttracking.supportlog
						(jirarequestno, subject, notes, issuetype, 
							ismailsent, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, 
							severity, status,  jirarequestsent, priority, jiraenv, focus, jiraticketresolution,
							application, 
							frommailid, ldssregion, approveddate, 
							cjamsticketstatus, cjamsticketcreateddate, cjamslastupdateddate, cjamscloseddate, 
							cdmticketno, cdmticketstatus, cdmticketcreateddate, 
							cdmlastupdateddate, cdmcloseddate, fixtype, resolutioncomments, cjamsresolutiondate, cdmresolutiondate, identifiedas)
						values (vrec.cjamsticketnumber, vrec.title, vrec.title, '528',
							0, 1, COALESCE(v_securityusersid,'CJAMS_BATCH'), vrec.cjamsticketcreateddate::timestamp, 'CJAMS_BATCH', vrec.cjamsticketcreateddate::timestamp, vrec.cjamsticketcreateddate::timestamp,
							'Medium',v_status, 'Jira Ticket', 3, 'Production', vrec.focusarea, vrec.resolution,vrec.application,
							v_createdby, v_county, vrec.cjamsticketcreateddate, 
							vrec.cjamsticketstatus, vrec.cjamsticketcreateddate, vrec.cjamslastupdateddate, vrec.cjamscloseddate, 
							vrec.cdmticketnumber, vrec.cdmticketstatus,vrec.cdmticketcreateddate,vrec.cdmlastupdateddate, vrec.cdmcloseddate, 
							vrec.fixtype, vrec.resolutioncomments,  
							vrec.cjamsresolutiondate, vrec.cdmresolutiondate, vrec.identifiedas);
				END IF;
			END IF;
			
			IF (v_updateflag IS true) THEN
				
				UPDATE defecttracking.supportlog
					SET status = v_status,
						jirarequestno = COALESCE(jirarequestno,vrec.cjamsticketnumber),
						cjamsticketstatus = vrec.cjamsticketstatus,
						cjamsticketcreateddate = vrec.cjamsticketcreateddate,
						cjamslastupdateddate = vrec.cjamslastupdateddate,
						cjamsresolutiondate  = vrec.cjamsresolutiondate,
						cjamscloseddate = vrec.cjamscloseddate,
						approveddate = COALESCE(approveddate,vrec.cjamsticketcreateddate),
						cdmticketno = vrec.cdmticketnumber,
						cdmticketstatus = vrec.cdmticketstatus,
						cdmticketcreateddate = vrec.cdmticketcreateddate,
						cdmlastupdateddate = vrec.cdmlastupdateddate,
						cdmresolutiondate  = vrec.cdmresolutiondate,
						cdmcloseddate = vrec.cdmcloseddate,
						fixtype = vrec.fixtype,
						focus = coalesce(vrec.focusarea, focus),
						jiraticketresolution=vrec.resolution,
						resolutioncomments = vrec.resolutioncomments,
						identifiedas = vrec.identifiedas,
						application = vrec.application,
						updatedon = now(),
						updatedby = 'CJAMS_BATCH'
					WHERE jirarequestno = vrec.cjamsticketnumber
						OR (vrec.supportnumber IS NOT NULL AND supportno = vrec.supportnumber);
			END IF;
			IF (v_sec_index = 1000) THEN
				RAISE NOTICE 'Records procesed Count %', v_index;
				v_sec_index := 0;
			END IF;
			
		END LOOP;
		
		update defecttracking.supportlog set supportno = 'J'||supportno where jirarequestsent = 'Jira Ticket' AND supportno LIKE 'S%'; 
		
		update defecttracking.supportlog set jirarequestsent = 'Approved' 
			where jirarequestsent is null 
				and jirarequestno is not null 
				and btrim(jirarequestno) != '';
				
		update defecttracking.supportlog 
			set status = 'Waiting for User Response' 
			where status like 'Waiting for User Response%'
				AND status != 'Waiting for User Response';		
		
		RAISE NOTICE 'End Execution - cjams.updatesupportlog';
		
		RETURN 'Success';
	
END;

$function$
;
