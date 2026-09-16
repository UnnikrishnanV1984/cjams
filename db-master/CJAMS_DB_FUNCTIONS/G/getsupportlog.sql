DROP FUNCTION IF EXISTS cjams.getsupportlog(json, character varying, character varying, character varying, integer, integer, boolean);
CREATE OR REPLACE FUNCTION cjams.getsupportlog(v_input json, v_securityusersid character varying, v_sortcolumn character varying, v_sortorder character varying, pagenumber integer, pagesize integer, v_nolimit boolean DEFAULT false)
 RETURNS TABLE(totalcount bigint, supportlogid uuid, supportno character varying, ldssregion character varying, clientid character varying, subject character varying, notes text, frommailid character varying, effectivedate timestamp without time zone, severity character varying, status character varying, caseid character varying, issuetype character varying, priority character varying, jirarequestsent text, application character varying, jirarequestno character varying, program character varying, focus character varying, jiraticketresolution character varying, cdmticketno character varying, fixtype character varying, approvedsupervisorid character varying, caseworkerdefaultsupervisorid character varying, supportlogfiles json, releasenotes json)
 LANGUAGE plpgsql
AS $function$
/* Revision History
--CIDM-9899 (Sreekanth Marrikanti) - Added changes to include new filter 'identifiedas' to fetch support tickets 
--CIDM-9918 (Vinesh Puthan)- Added "Approved By" (approvedsupervisorid) and "Default Supervisor"(caseworkerdefaultsupervisorid) for jira creation from contact support
*/
DECLARE
	v_pageoffset 		INTEGER;
	v_pagenumber 		INTEGER;
	v_application 		CHARACTER VARYING; 
	v_ldssregion 		CHARACTER VARYING; 
	v_supportno 		CHARACTER VARYING;
	v_frommailid 		CHARACTER VARYING; 
	v_caseid 			CHARACTER VARYING; 
	v_subject 			CHARACTER VARYING;  
	v_notes 			CHARACTER VARYING; 
	v_fromdate 			timestamp; 
	v_todate 			timestamp; 
	v_jirarequestsent	CHARACTER VARYING; 
    v_teamid			CHARACTER VARYING;
	v_focus				CHARACTER VARYING; 
	v_issuetype			CHARACTER VARYING; 
	v_severity			CHARACTER VARYING; 
	v_jirastatus		CHARACTER VARYING;
	v_appname			CHARACTER VARYING;	
    v_searchstring		CHARACTER VARYING;		
	v_jiraenv			character varying;
	v_fixtype           character varying;
	v_identifiedas		CHARACTER VARYING;
	
BEGIN

	v_pagenumber := pagenumber-1;
    v_pageoffset = v_pagenumber * pagesize;
	
	v_searchstring := v_input->>'searchstring';
	
	IF (v_searchstring IS NULL) THEN
		v_ldssregion 		:= v_input->>'ldssregion';	
		v_supportno 		:= v_input->>'supportno';	
		v_frommailid 		:= v_input->>'frommailid';	
		v_caseid 			:= v_input->>'caseid';	
		v_subject 			:= v_input->>'subject';		
		v_notes 			:= v_input->>'notes';		
		v_fromdate			:= (v_input->>'fromdate')::timestamp; 		
		v_todate 			:= (v_input->>'todate')::timestamp;		
		v_jirarequestsent	:= v_input->>'jirarequestsent';
		v_issuetype			:= v_input->>'issuetype';
		v_fixtype			:= v_input->>'fixtype';
		v_identifiedas		:= v_input->>'identifiedas';
		IF( (v_input->>'jirastatus') is not null and (v_input->>'jirastatus') != '') THEN
			v_jirastatus := array(select json_array_elements_text((v_input->>'jirastatus')::json));
		END IF ;
		v_severity			:= v_input->>'severity';
		v_focus				:= v_input->>'focus';
		v_teamid			:= v_input->>'teamid';	
		
		IF (v_ldssregion = 'All') THEN 
			v_ldssregion = null; 
		END IF;
	END IF;

	v_application		:= v_input->>'application';
	v_jiraenv			:= v_input->>'jiraenv';
	
/*	IF (pagenumber = 1) THEN
		SELECT count(*) INTO v_tickets
			FROM
			(SELECT distinct s.supportno
				FROM defecttracking.supportlog s
				WHERE s.insertedby = v_securityusersid
					AND s.application = v_application
					AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
					AND s.activeflag = 1) e;
	
		SELECT count(*) INTO v_pendingapproval
			FROM
			(SELECT distinct s.supportno
				FROM defecttracking.supportlog s
				WHERE s.insertedby = v_securityusersid
					AND s.application = v_application
					AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
					AND s.jirarequestsent is null
					AND s.activeflag = 1) e;
				
		SELECT count(*) INTO v_approved
			FROM
			(SELECT distinct s.supportno
				FROM defecttracking.supportlog s
				WHERE s.insertedby = v_securityusersid
					AND s.application = v_application
					AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
					AND s.jirarequestsent = 'Approved'
					AND s.activeflag = 1) e;
				
		SELECT count(*) INTO v_rejected
			FROM
			(SELECT distinct s.supportno
				FROM defecttracking.supportlog s
				WHERE s.insertedby = v_securityusersid
					AND s.application = v_application
					AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
					AND s.jirarequestsent = 'Rejected'
					AND s.activeflag = 1) e;

		SELECT distinct count(*) INTO v_teamtickets
			FROM
			(SELECT distinct s.supportno
				FROM cjams.userprofile up
					JOIN teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
					JOIN teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
					JOIN team t on t.teamid = tm.teamid and t.activeflag = 1
					JOIN cjams.county c on c.countyid::character varying = t.countyid and c.activeflag = 1
					JOIN teammember tm1 on tm1.teamid = t.teamid and tm1.activeflag = 1
					JOIN teammemberassignment tma1 on tma1.teammemberid = tm1.teammemberid and tma1.activeflag = 1
					JOIN defecttracking.supportlog s on s.insertedby = tma1.securityusersid and s.activeflag = 1
				WHERE up.securityusersid = v_securityusersid
					AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
					and s.ldssregion = c.countyname
					AND s.application = v_application) e;
				
		SELECT distinct count(*) INTO v_countytickets
			FROM
			(SELECT distinct s.supportno
				FROM cjams.userprofile up
					JOIN teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
					JOIN teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
					JOIN team t on t.teamid = tm.teamid and t.activeflag = 1
					JOIN county c ON t.countyid = c.countyid::character varying and c.activeflag = 1
					JOIN defecttracking.supportlog s on s.ldssregion = c.countyname and s.activeflag = 1
				WHERE up.securityusersid = v_securityusersid
					AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
					AND s.application = v_application) e;
		
		SELECT distinct count(*) INTO v_countypendingapproval
			FROM
			(SELECT distinct s.supportno
				FROM cjams.userprofile up
					JOIN teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
					JOIN teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
					JOIN team t on t.teamid = tm.teamid and t.activeflag = 1
					JOIN county c ON t.countyid = c.countyid::character varying and c.activeflag = 1
					JOIN defecttracking.supportlog s on s.ldssregion = c.countyname and s.activeflag = 1
				WHERE up.securityusersid = v_securityusersid
					AND s.application = v_application
					AND s.jirarequestsent is null
					AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
					AND s.activeflag = 1) e;	

		SELECT distinct count(*) INTO v_countyapproved
			FROM
			(SELECT distinct s.supportno
				FROM cjams.userprofile up
					JOIN teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
					JOIN teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
					JOIN team t on t.teamid = tm.teamid and t.activeflag = 1
					JOIN county c ON t.countyid = c.countyid::character varying and c.activeflag = 1
					JOIN defecttracking.supportlog s on s.ldssregion = c.countyname and s.activeflag = 1
				WHERE up.securityusersid = v_securityusersid
					AND s.application = v_application
					AND s.jirarequestsent = 'Approved'
					AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
					AND s.activeflag = 1) e;
				
		SELECT distinct count(*) INTO v_countyrejected
			FROM
			(SELECT distinct s.supportno
				FROM cjams.userprofile up
					JOIN teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
					JOIN teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
					JOIN team t on t.teamid = tm.teamid and t.activeflag = 1
					JOIN county c ON t.countyid = c.countyid::character varying and c.activeflag = 1
					JOIN defecttracking.supportlog s on s.ldssregion = c.countyname and s.activeflag = 1
				WHERE up.securityusersid = v_securityusersid
					AND s.application = v_application
					AND s.jirarequestsent = 'Rejected'
					AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
					AND s.activeflag = 1) e;
					
		SELECT distinct count(*) INTO v_waitingonuser
			FROM
			(SELECT distinct s.supportno
				FROM defecttracking.supportlog s
				WHERE s.status = 'Waiting for User Response'
						AND s.application = v_application
						AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
						AND s.activeflag = 1) e;			
		
		SELECT distinct count(*) INTO v_waitingonssa
			FROM
			(SELECT distinct s.supportno
				FROM defecttracking.supportlog s
				WHERE s.status like 'Waiting for SSA/Product Owner%'
						AND s.application = v_application
						AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
						AND s.activeflag = 1) e;		
	END IF;
	
	SELECT row_to_json(a) INTO v_counts
		FROM (SELECT v_tickets as tickets,
					v_pendingapproval as pendingapproval,
					v_approved as approved,
					v_rejected as rejected,
					v_teamtickets as teamtickets,
					v_countytickets as countytickets,
					v_countypendingapproval as countypendingapproval,
					v_countyapproved as countyapproved,
					v_countyrejected as countyrejected,
					v_waitingonuser as waitingonuser,
					v_waitingonssa as waitingonssa) a; */
					
	
	DROP TABLE IF EXISTS tempsupportlog; 
	CREATE TEMP TABLE tempsupportlog(supportno character varying);
	IF (v_searchstring IS NOT NULL) THEN
	
		IF (v_searchstring = 'tickets') THEN
			INSERT INTO tempsupportlog(supportno)
				SELECT distinct s.supportno	
					FROM defecttracking.supportlog s
					WHERE s.insertedby = v_securityusersid
						AND s.application = v_application
						AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
						AND s.activeflag = 1;
		END IF;
		
		IF (v_searchstring = 'pendingapproval') THEN
			INSERT INTO tempsupportlog(supportno)
				SELECT distinct s.supportno	
					FROM defecttracking.supportlog s
					WHERE s.insertedby = v_securityusersid
						AND s.application = v_application
						AND s.jirarequestsent is null
						AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
						AND s.activeflag = 1;
		END IF;
		
		IF (v_searchstring = 'approved') THEN
			INSERT INTO tempsupportlog(supportno)
				SELECT distinct s.supportno	
					FROM defecttracking.supportlog s
					WHERE s.insertedby = v_securityusersid
						AND s.application = v_application
						AND s.jirarequestsent = 'Approved'
						AND s.activeflag = 1;
		END IF;
		
		IF (v_searchstring = 'rejected') THEN
			INSERT INTO tempsupportlog(supportno)
				SELECT distinct s.supportno	
					FROM defecttracking.supportlog s
					WHERE s.insertedby = v_securityusersid
						AND s.application = v_application
						AND s.jirarequestsent = 'Rejected'
						AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
						AND s.activeflag = 1;
		END IF;
	
		IF (v_searchstring = 'teamtickets') THEN
			INSERT INTO tempsupportlog(supportno)
				SELECT distinct s.supportno
					FROM cjams.userprofile up
						JOIN teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
						JOIN teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
						JOIN team t on t.teamid = tm.teamid and t.activeflag = 1
						JOIN cjams.county c on c.countyid::character varying = t.countyid and c.activeflag = 1
						JOIN teammember tm1 on tm1.teamid = t.teamid and tm1.activeflag = 1
						JOIN teammemberassignment tma1 on tma1.teammemberid = tm1.teammemberid and tma1.activeflag = 1
						JOIN defecttracking.supportlog s on s.insertedby = tma1.securityusersid and s.activeflag = 1
					WHERE up.securityusersid = v_securityusersid
						AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
						AND s.ldssregion = c.countyname
						AND s.application = v_application;
		END IF;
		
	
		IF (v_searchstring = 'countytickets') THEN
			INSERT INTO tempsupportlog(supportno)
				SELECT distinct s.supportno
					FROM cjams.userprofile up
						JOIN teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
						JOIN teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
						JOIN team t on t.teamid = tm.teamid and t.activeflag = 1
						JOIN county c ON t.countyid = c.countyid::character varying and c.activeflag = 1
						JOIN defecttracking.supportlog s on s.ldssregion = c.countyname and s.activeflag = 1
					WHERE up.securityusersid = v_securityusersid
						AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
						AND s.application = v_application;
		END IF;
		
		IF (v_searchstring = 'countypendingapproval') THEN
			INSERT INTO tempsupportlog(supportno)
				SELECT distinct s.supportno
					FROM cjams.userprofile up
						JOIN teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
						JOIN teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
						JOIN team t on t.teamid = tm.teamid and t.activeflag = 1
						JOIN county c ON t.countyid = c.countyid::character varying and c.activeflag = 1
						JOIN defecttracking.supportlog s on s.ldssregion = c.countyname and s.activeflag = 1
					WHERE up.securityusersid = v_securityusersid
						AND s.application = v_application
						AND s.jirarequestsent is null
						AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
						AND s.activeflag = 1;
		END IF;
		
		IF (v_searchstring = 'countyapproved') THEN
			INSERT INTO tempsupportlog(supportno)
				SELECT distinct s.supportno
					FROM cjams.userprofile up
						JOIN teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
						JOIN teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
						JOIN team t on t.teamid = tm.teamid and t.activeflag = 1
						JOIN county c ON t.countyid = c.countyid::character varying and c.activeflag = 1
						JOIN defecttracking.supportlog s on s.ldssregion = c.countyname and s.activeflag = 1
					WHERE up.securityusersid = v_securityusersid
						AND s.application = v_application
						AND s.jirarequestsent = 'Approved'
						AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
						AND s.activeflag = 1;
		END IF;
		
		IF (v_searchstring = 'countyrejected') THEN
			INSERT INTO tempsupportlog(supportno)
				SELECT distinct s.supportno 
					FROM cjams.userprofile up
						JOIN teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
						JOIN teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
						JOIN team t on t.teamid = tm.teamid and t.activeflag = 1
						JOIN county c ON t.countyid = c.countyid::character varying and c.activeflag = 1
						JOIN defecttracking.supportlog s on s.ldssregion = c.countyname and s.activeflag = 1
					WHERE up.securityusersid = v_securityusersid
						AND s.application = v_application
						AND s.jirarequestsent = 'Rejected'
						AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
						AND s.activeflag = 1;
		END IF;
		
		IF (v_searchstring = 'waitingOnUser') THEN
			INSERT INTO tempsupportlog(supportno)
				SELECT distinct s.supportno	
					FROM defecttracking.supportlog s
					WHERE s.status ilike '%Waiting for User Response%'
						AND s.application = v_application
						AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
						AND s.activeflag = 1;
		END IF;
		
		IF (v_searchstring = 'waitingOnSSA') THEN
			INSERT INTO tempsupportlog(supportno)
				SELECT distinct s.supportno	
					FROM defecttracking.supportlog s
					WHERE s.status like 'Waiting for SSA/Product Owner%'
						AND s.application = v_application
						AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
						AND s.activeflag = 1;
		END IF;

	END IF;
	
	RETURN QUERY
		SELECT COUNT(*) over(), x.*,
				(select json_agg(e) from
						(SELECT sf.supportlogfilesid, sf.supportlogid
							from defecttracking.supportlogfiles  sf
							where sf.supportlogid = x.supportlogid and sf.activeflag=1 
						)e
				) :: json as supportlogfiles,
			--	v_counts as ticketcounts,
				(select json_agg(e) from
					(SELECT rn.* 
							from defecttracking.releasenotes  rn
							where rn.supportid IS NOT NULL 
								and rn.supportid = x.supportno 
								and rn.activeflag=1 
								and rn.publish is true
							ORDER BY rn.insertedon desc
							LIMIT 1
						)e
				) :: json as releasenotes
		FROM
			(SELECT DISTINCT
				s.supportlogid, 
				(CASE WHEN s.supportno like 'S%' THEN s.supportno ELSE '' END)::character varying as supportno, 
				s.ldssregion, 
				s.clientid, 
				s.subject, 
				s.notes, 
				s.frommailid, 
				s.effectivedate, 
				s.severity, 
				s.status, 
				s.caseid, 
				s.issuetype,
				(CASE WHEN s.priority = '1' OR s.priority = '10100' THEN 'Emergency'
					WHEN s.priority = '2' THEN 'High'
					WHEN s.priority = '3' THEN 'Medium'
					WHEN s.priority = '4' THEN 'Low'
					ELSE '' END)::character varying as priority, 
				s.jirarequestsent, 
				CASE 	WHEN lower(s.application) = 'cw' THEN 'Child Welfare'
						WHEN lower(s.application) = 'prov' THEN 'Provider'
						WHEN lower(s.application) = 'as' THEN 'Adult Services'
					ELSE s.application END as application, 
				s.jirarequestno, 
				s.program, 
				s.focus,
				s.jiraticketresolution,
				s.cdmticketno,
				s.fixtype,
				approved.fullname as approvedsupervisorid,
				supervisor.fullname as caseworkerdefaultsupervisorid
			FROM defecttracking.supportlog s
				LEFT JOIN cjams.userprofile up on up.securityusersid = s.insertedby --and up.activeflag = 1
				LEFT JOIN cjams.teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1
				LEFT JOIN cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
				LEFT JOIN cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
				LEFT JOIN tempsupportlog ts on ts.supportno = s.supportno
				LEFT JOIN userprofile supervisor ON supervisor.securityusersid = s.caseworkerdefaultsupervisorid::character varying AND supervisor.activeflag = 1
				LEFT JOIN userprofile approved ON approved.securityusersid = s.approvedsupervisorid::character varying AND approved.activeflag = 1
			WHERE s.activeflag = 1 
				AND s.application = v_application
				AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
				AND CASE WHEN v_ldssregion is not null THEN lower(s.ldssregion) like '%' || lower(v_ldssregion) || '%'  ELSE true END
				AND CASE WHEN v_supportno is not null THEN 
					(lower(s.supportno) like '%' || lower(v_supportno) || '%'  
						OR
					 lower(s.jirarequestno) like '%' || lower(v_supportno) || '%'
						OR
					 lower(s.cdmticketno) like '%' || lower(v_supportno) || '%')
					ELSE true END
				AND CASE WHEN v_severity is not null AND v_severity != '' THEN lower(s.severity) = lower(v_severity) ELSE true END
				AND CASE WHEN v_issuetype is not null AND v_issuetype != '' THEN lower(s.issuetype) = lower(v_issuetype) ELSE true END
				AND CASE WHEN v_jirastatus IS NOT NULL THEN s.status=any(v_jirastatus::TEXT[]) ELSE TRUE END
				AND CASE WHEN v_focus is not null AND v_focus != '' THEN lower(s.focus) = lower(v_focus) ELSE true END
				AND CASE WHEN v_frommailid is not null AND v_frommailid != '' THEN lower(s.frommailid) = lower(v_frommailid) ELSE true END
				AND CASE WHEN v_caseid is not null THEN lower(s.caseid) = lower(v_caseid) ELSE true END
				AND CASE WHEN v_subject is not null THEN lower(s.subject) like '%' || lower(v_subject) || '%' ELSE true END
				AND CASE WHEN v_notes is not null THEN lower(s.notes) like '%' || lower(v_notes) || '%'  ELSE true END
				AND CASE WHEN v_fromdate is not null THEN coalesce(s.cdmticketcreateddate::date, s.effectivedate::date) >= v_fromdate::date ELSE true END
				AND CASE WHEN v_todate is not null THEN coalesce(s.cdmticketcreateddate::date, s.effectivedate::date) <= v_todate::date ELSE true END
				AND CASE WHEN v_teamid IS NOT NULL AND v_teamid != '' THEN t.teamid = v_teamid::uuid ELSE true END
				AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
					CASE WHEN v_jirarequestsent = 'Pending' THEN s.jirarequestsent IS NULL 
					ELSE s.jirarequestsent = v_jirarequestsent END
					ELSE true END
				AND CASE WHEN v_searchstring IS NOT NULL THEN ts.supportno IS NOT NULL ELSE true END
				AND CASE WHEN v_identifiedas IS NOT NULL AND v_identifiedas != '' THEN lower(s.identifiedas) = lower(v_identifiedas) ELSE true END
				AND CASE WHEN v_fixtype IS NOT NULL AND v_fixtype != '' THEN lower(s.fixtype) = lower(v_fixtype) ELSE true END) x
			ORDER BY 
						(
						CASE v_sortorder
							WHEN 'asc'
							THEN
								CASE v_sortcolumn
									WHEN 'supportno' THEN x.supportno:: character varying
									WHEN 'ldssregion' THEN  x.ldssregion::character varying
									WHEN 'clientid' THEN x.clientid:: character varying
									WHEN 'subject' THEN x.subject:: character varying
									WHEN 'notes' THEN x.notes:: character varying
									WHEN 'frommailid' THEN x.frommailid:: character varying
									WHEN 'effectivedate' THEN x.effectivedate::character varying
									WHEN 'severity' THEN x.severity:: character varying
									WHEN 'caseid' THEN x.caseid:: character varying
									WHEN 'issuetype' THEN x.issuetype:: character varying
									WHEN 'jirarequestsent' THEN COALESCE(x.jirarequestsent, ''):: character varying
									WHEN 'application' THEN x.application:: character varying
									WHEN 'program' THEN x.program:: character varying
									WHEN 'focus' THEN x.focus:: character varying
									WHEN 'status' THEN x.status:: character varying
									WHEN 'jirarequestno' THEN x.jirarequestno:: character varying
									WHEN 'cdmticketno' THEN x.cdmticketno:: character varying
									ELSE  x.supportno::character varying
								END
						END) ASC NULLS last,
						(CASE v_sortorder
							WHEN 'desc'
							THEN
								CASE v_sortcolumn
									WHEN 'supportno' THEN x.supportno:: character varying
									WHEN 'ldssregion' THEN  x.ldssregion::character varying
									WHEN 'clientid' THEN x.clientid:: character varying
									WHEN 'subject' THEN x.subject:: character varying
									WHEN 'notes' THEN x.notes:: character varying
									WHEN 'frommailid' THEN x.frommailid:: character varying
									WHEN 'effectivedate' THEN x.effectivedate::character varying
									WHEN 'severity' THEN x.severity:: character varying
									WHEN 'caseid' THEN x.caseid:: character varying
									WHEN 'issuetype' THEN x.issuetype:: character varying
									WHEN 'jirarequestsent' THEN COALESCE(x.jirarequestsent, ''):: character varying
									WHEN 'application' THEN x.application:: character varying
									WHEN 'program' THEN x.program:: character varying
									WHEN 'focus' THEN x.focus:: character varying
									WHEN 'status' THEN x.status:: character varying
									WHEN 'jirarequestno' THEN x.jirarequestno:: character varying
									WHEN 'cdmticketno' THEN x.cdmticketno:: character varying
									ELSE  x.supportno::character varying
								END
						END) DESC NULLS last 
			LIMIT   CASE WHEN v_nolimit = false  THEN pagesize END offset 
				CASE WHEN v_nolimit = false  THEN v_pageoffset END;
	
END;

$function$
;
