DROP FUNCTION IF EXISTS cjams.getcountyticketcounts(json);
CREATE OR REPLACE FUNCTION cjams.getcountyticketcounts(v_input json)
 RETURNS TABLE(countyticketstatuscounts json, 
				countyfocuscdmcounts json, 
				countyfocuscjamscounts json, 
				countyresolutioncounts json, 
				countyfixtypecounts json, 
				countyteamticketcounts json, 
				countyticketcreatedcounts json,
				countyincidentcounts	json,
				countyincidentopenclosecounts json,
				countyjirastatuscounts	json,
				statecountyticketcounts json, 
				teamticketstatuscounts json, 
				teamfocuscdmcounts json,
				teamfocuscjamscounts json,
				teamresolutioncounts json, 
				teamfixtypecounts json, 
				teamworkerticketcounts json,
				teamticketcreatedcounts json,
				teamincidentcounts json,
				teamincidentopenclosecounts json, 
				teamjirastatuscounts json,
				date_diff	integer)
 LANGUAGE plpgsql
AS $function$
/** REVISION HISTORY
-- CIDM-9705 (Sreekanth Marrikanti) - Changes to add a new filter for identifiedas field for fetching jira tickets
-- CIDM-9839 (Sreekanth Marrikanti) - Changed logic to use CDM ticket created date for date filter conditions
-- CIDM-11046 (Sreekanth Marrikanti) - 1/20/2026 Added query to fetch focus counts for CDM & CJAMS tickets
*/

DECLARE
	v_ldssregion 		CHARACTER VARYING; 
	v_fromdate 			timestamp; 
	v_todate 			timestamp;
	v_teamid 			uuid;
	v_application		character varying;
	v_datediff			integer;
	v_dateformat		character varying;
	v_enddate			date;
	v_startdate			date;
	v_jiraenv			character varying;
	v_charttype			character varying;
	v_range				character varying;	
	v_teamincidentopenclosecounts json;
	v_countyincidentopenclosecounts json;
	v_dow				integer;
	v_searchstartdate	date;
	v_searchenddate		date;
	v_jirarequestsent	CHARACTER VARYING; 
	v_identifiedas 		CHARACTER VARYING;

BEGIN
	v_ldssregion 		:= v_input->>'ldssregion';	
	v_fromdate			:= (v_input->>'fromdate')::timestamp; 		
	v_todate 			:= (v_input->>'todate')::timestamp;	
	v_teamid			:= (v_input->>'teamid')::uuid;
	v_application		:= (v_input->>'application')::character varying;
	v_charttype			:= (v_input->>'chartType')::character varying;
	v_jirarequestsent	:= v_input->>'jirarequestsent';
	v_identifiedas		:= v_input->>'identifiedas';
	v_dateformat		:= 'YYYY-MM';
	v_datediff			:= 99;
	v_jiraenv			:= v_input->>'jiraenv';
	v_teamincidentopenclosecounts := null::json;
	v_countyincidentopenclosecounts := null::json;
	
	
	IF (v_ldssregion = '') THEN
		v_ldssregion = null;
	END IF;
	
	IF (v_fromdate IS NOT NULL) THEN
		v_enddate := now()::date;
		v_startdate	:= 	v_fromdate::date;
		IF (v_todate IS NOT NULL) THEN
			v_enddate := v_todate::date;
		END IF;
		SELECT v_enddate - v_startdate INTO v_datediff;
		IF (v_datediff <= 31) THEN
			v_dateformat		:= 'YYYY-MM-DD';	
		END IF;
		v_range := 'monthly';
		IF (v_datediff <= 62) THEN
			v_range := 'weekly';	
		END IF;
		IF (v_datediff <= 14) THEN
			v_range := 'daily';	
		END IF;
	END IF;
	
	DROP TABLE IF EXISTS tempticketscounts; 
	CREATE TEMP TABLE tempticketscounts(weeknumber INTEGER, startdate date, enddate date);
	
	IF (v_range = 'weekly') THEN
		RAISE NOTICE 'v_startdate %', v_startdate;
		RAISE NOTICE 'v_enddate %', v_enddate;
		v_searchstartdate := v_startdate;
		v_searchenddate := v_enddate;
		select extract(dow from v_startdate) INTO v_dow;
		IF (v_dow != 1) THEN
			SELECT CASE WHEN v_dow = 2 THEN (v_startdate - '1 DAY'::INTERVAL)::DATE
						WHEN v_dow = 3 THEN (v_startdate - '2 DAY'::INTERVAL)::DATE
						WHEN v_dow = 4 THEN (v_startdate - '3 DAY'::INTERVAL)::DATE
						WHEN v_dow = 5 THEN (v_startdate - '4 DAY'::INTERVAL)::DATE
						WHEN v_dow = 6 THEN (v_startdate - '5 DAY'::INTERVAL)::DATE
						WHEN v_dow = 0 THEN (v_startdate - '6 DAY'::INTERVAL)::DATE
						END 
						INTO v_searchstartdate;
		END IF;
		
		
		select extract(dow from v_enddate) INTO v_dow;
		IF (v_dow != 0) THEN
			SELECT CASE WHEN v_dow = 1 THEN (v_enddate + '6 DAY'::INTERVAL)::DATE
						WHEN v_dow = 2 THEN (v_enddate + '5 DAY'::INTERVAL)::DATE
						WHEN v_dow = 3 THEN (v_enddate + '4 DAY'::INTERVAL)::DATE
						WHEN v_dow = 4 THEN (v_enddate + '3 DAY'::INTERVAL)::DATE
						WHEN v_dow = 5 THEN (v_enddate + '2 DAY'::INTERVAL)::DATE
						WHEN v_dow = 6 THEN (v_enddate + '1 DAY'::INTERVAL)::DATE
						END 
						INTO v_searchenddate;
		
		END IF;
		
		INSERT INTO tempticketscounts(weeknumber, startdate, enddate)
		select a.rownumber as WeekNumber, a.startdate, a.enddate 
			FROM (WITH cte1 AS
					(SELECT t.d1::DATE
						FROM GENERATE_SERIES
							(v_searchstartdate,
							v_searchenddate,
							INTERVAL  '7 DAY') AS t(d1)
					),
					cte2 AS
					(SELECT d1, (d1 + '6 DAY'::INTERVAL)::DATE AS d2
						FROM cte1
						WHERE (d1 + '6 DAY'::INTERVAL)::DATE <= v_searchenddate
					)
					SELECT row_number() over() as rownumber, d1 as startdate, d2 as enddate FROM cte2
				) a;
	END IF;
	
	IF (v_charttype = 'team') THEN
			IF (v_range = 'weekly') THEN
				select json_agg(e)::json INTO v_teamincidentopenclosecounts
					from
						(select to_char(ttc.startdate,'MM/DD') || '-' ||to_char(ttc.enddate,'MM/DD') as ticketmonth,
								(select count(*) 
									from defecttracking.supportlog sl
									 LEFT join cjams.county c on countyname = sl.ldssregion and c.activeflag = 1
									where sl.cjamsticketcreateddate >= ttc.startdate AND  sl.cjamsticketcreateddate <= ttc.enddate
										AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END 
										AND sl.application = v_application 
										AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
										CASE WHEN v_jirarequestsent = 'Pending' THEN sl.jirarequestsent IS NULL 
										ELSE sl.jirarequestsent = v_jirarequestsent END ELSE true END
										AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
										AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
										and sl.activeflag = 1)  as opencount,
								(select count(*) 
									from defecttracking.supportlog sl
									 LEFT join cjams.county c on countyname = sl.ldssregion and c.activeflag = 1
									where 
										CASE WHEN sl.cdmticketno IS NOT NULL AND btrim(sl.cdmticketno) != '' THEN 
											(sl.cdmcloseddate >= ttc.startdate AND sl.cdmcloseddate <= ttc.enddate)
											ELSE
											(sl.cjamscloseddate >= ttc.startdate AND  sl.cjamscloseddate <= ttc.enddate)	
											END
										AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END 
										AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
										CASE WHEN v_jirarequestsent = 'Pending' THEN sl.jirarequestsent IS NULL 
										ELSE sl.jirarequestsent = v_jirarequestsent END ELSE true END
										AND sl.application = v_application 
										AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
										AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
										and sl.activeflag = 1)  as closedcount
							from tempticketscounts ttc
							order by ttc.weeknumber ASC) e;
			ELSE
				-- Ticket Open & Closed Counts for county based on each month.
				select json_agg(e)::json INTO  v_teamincidentopenclosecounts from
					(select ticketmonth,
							(select count(*) 
								from defecttracking.supportlog sl
								LEFT join cjams.userprofile u1 on u1.email = sl.frommailid 
								LEFT join cjams.teammemberassignment tma1 on tma1.securityusersid = u1.securityusersid and tma1.activeflag = 1
								LEFT join cjams.teammember tm1 on tm1.teammemberid = tma1.teammemberid and tm1.activeflag = 1
								LEFT join cjams.team t1 on t1.teamid = tm1.teamid and t1.activeflag = 1
								LEFT join cjams.county c on countyname = sl.ldssregion and c.activeflag = 1
								where CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(sl.cjamsticketcreateddate) = ticketmonth ELSE to_char_yyyymmdd(sl.cjamsticketcreateddate) = ticketmonth END
									AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END 
									AND sl.application = v_application 
									AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
									AND t1.teamid = v_teamid
									AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
									CASE WHEN v_jirarequestsent = 'Pending' THEN sl.jirarequestsent IS NULL 
									ELSE sl.jirarequestsent = v_jirarequestsent END ELSE true END
									AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
									and sl.activeflag = 1)  as opencount,
							(select count(*) 
								from defecttracking.supportlog sl
								LEFT join cjams.userprofile u1 on u1.email = sl.frommailid 
								LEFT join cjams.teammemberassignment tma1 on tma1.securityusersid = u1.securityusersid and tma1.activeflag = 1
								LEFT join cjams.teammember tm1 on tm1.teammemberid = tma1.teammemberid and tm1.activeflag = 1
								LEFT join cjams.team t1 on t1.teamid = tm1.teamid and t1.activeflag = 1
								LEFT join cjams.county c on countyname = sl.ldssregion and c.activeflag = 1
								where CASE WHEN v_dateformat = 'YYYY-MM' THEN 
											CASE WHEN sl.cdmticketno IS NOT NULL AND btrim(sl.cdmticketno) != '' THEN to_char_yyyymm(sl.cdmcloseddate) = ticketmonth  ELSE to_char_yyyymm(sl.cjamscloseddate) = ticketmonth END
										ELSE 
											CASE WHEN sl.cdmticketno IS NOT NULL AND btrim(sl.cdmticketno) != ''  THEN to_char_yyyymmdd(sl.cdmcloseddate) = ticketmonth  ELSE to_char_yyyymmdd(sl.cjamscloseddate) = ticketmonth END	
										END
									AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END
									AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
									AND t1.teamid = v_teamid
									AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
									CASE WHEN v_jirarequestsent = 'Pending' THEN sl.jirarequestsent IS NULL 
									ELSE sl.jirarequestsent = v_jirarequestsent END ELSE true END
									AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
									AND sl.application = v_application 
									and sl.activeflag = 1)  as closedcount	
 						from
							(select distinct b.ticketmonth FROM
								(select distinct CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(s.cjamsticketcreateddate) ELSE to_char_yyyymmdd(s.cjamsticketcreateddate) END as ticketmonth
										from defecttracking.supportlog s
										LEFT join cjams.userprofile u on u.email = s.frommailid 
										LEFT join cjams.teammemberassignment tma on tma.securityusersid = u.securityusersid and tma.activeflag = 1
										LEFT join cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
										LEFT join cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
										LEFT join cjams.county c on countyname = s.ldssregion and c.activeflag = 1
										where s.activeflag = 1
											AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END
											AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
											AND t.teamid = v_teamid
											AND s.application = v_application
											AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
											CASE WHEN v_jirarequestsent = 'Pending' THEN s.jirarequestsent IS NULL 
											ELSE s.jirarequestsent = v_jirarequestsent END ELSE true END
											AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
											AND CASE WHEN v_fromdate is not null THEN s.cjamsticketcreateddate::date >= v_fromdate::date ELSE true END
											AND CASE WHEN v_todate is not null THEN s.cjamsticketcreateddate::date <= v_todate::date ELSE true END
											
									UNION ALL
										
									select distinct CASE WHEN v_dateformat = 'YYYY-MM' THEN 
															CASE WHEN s.cdmticketno IS NOT NULL AND btrim(s.cdmticketno) != '' THEN to_char_yyyymm(s.cdmcloseddate) ELSE to_char_yyyymm(s.cjamscloseddate) END
														ELSE  
															CASE WHEN s.cdmticketno IS NOT NULL AND btrim(s.cdmticketno) != '' THEN to_char_yyyymmdd(s.cdmcloseddate) ELSE to_char_yyyymmdd(s.cjamscloseddate) END
														END as ticketmonth
										from defecttracking.supportlog s
											LEFT JOIN cjams.userprofile u on u.email = s.frommailid 
											LEFT JOIN cjams.teammemberassignment tma on tma.securityusersid = u.securityusersid and tma.activeflag = 1
											LEFT JOIN cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
											LEFT JOIN cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
											LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
										where s.activeflag = 1
											AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END 
											AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
											AND t.teamid = v_teamid
											AND s.application = v_application 
											AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
												CASE WHEN v_jirarequestsent = 'Pending' THEN s.jirarequestsent IS NULL ELSE s.jirarequestsent = v_jirarequestsent END 
											ELSE true END
											AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
											AND CASE WHEN v_fromdate is not null THEN 
														CASE WHEN s.cdmticketno IS NOT NULL AND btrim(s.cdmticketno) != '' THEN s.cdmcloseddate::date >= v_fromdate::date ELSE s.cjamscloseddate::date >= v_fromdate::date END
													ELSE true END
											AND CASE WHEN v_todate is not null THEN 
														CASE WHEN s.cdmticketno IS NOT NULL AND btrim(s.cdmticketno) != '' THEN s.cdmcloseddate::date <= v_todate::date ELSE s.cjamscloseddate::date <= v_todate::date END
													ELSE true END
								) b 
								WHERE b.ticketmonth IS NOT NULL
								order by b.ticketmonth
							) a
						order by a.ticketmonth) e;			
			
			END IF;
		
		ELSE
		
			IF (v_range = 'weekly') THEN
				select json_agg(e)::json INTO v_countyincidentopenclosecounts 
					from
						(select to_char(ttc.startdate,'MM/DD') || '-' ||to_char(ttc.enddate,'MM/DD') as ticketmonth,
								(select count(*) 
									from defecttracking.supportlog sl
										LEFT JOIN cjams.county c on countyname = sl.ldssregion and c.activeflag = 1
									where sl.cjamsticketcreateddate >= ttc.startdate 
										AND  sl.cjamsticketcreateddate <= ttc.enddate
										AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END 
										AND sl.application = v_application
										AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
										CASE WHEN v_jirarequestsent = 'Pending' THEN sl.jirarequestsent IS NULL 
										ELSE sl.jirarequestsent = v_jirarequestsent END ELSE true END 
										AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
										AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
										and sl.activeflag = 1)  as opencount,
								(select count(*) 
									from defecttracking.supportlog sl
										LEFT JOIN cjams.county c on countyname = sl.ldssregion and c.activeflag = 1
									where CASE WHEN sl.cdmticketno IS NOT NULL AND btrim(sl.cdmticketno) != '' THEN 
											(sl.cdmcloseddate >= ttc.startdate AND  sl.cdmcloseddate <= ttc.enddate)
											ELSE
											(sl.cjamscloseddate >= ttc.startdate AND  sl.cjamscloseddate <= ttc.enddate)	
											END
										AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END 
										AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
										CASE WHEN v_jirarequestsent = 'Pending' THEN sl.jirarequestsent IS NULL 
										ELSE sl.jirarequestsent = v_jirarequestsent END ELSE true END
										AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
										AND sl.application = v_application 
										AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
										and sl.activeflag = 1)  as closedcount
							from tempticketscounts ttc
							order by ttc.weeknumber ASC) e;
			ELSE 
				-- Ticket Open & Close Counts for county based on each month.
				select json_agg(e)::json INTO v_countyincidentopenclosecounts from
					(select ticketmonth,
							(select count(*) 
								from defecttracking.supportlog sl
									LEFT JOIN cjams.county c on countyname = sl.ldssregion and c.activeflag = 1
								where CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(sl.cjamsticketcreateddate) = ticketmonth ELSE to_char_yyyymmdd(sl.cjamsticketcreateddate) = ticketmonth END
									AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END 
									AND sl.application = v_application 
									AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
									CASE WHEN v_jirarequestsent = 'Pending' THEN sl.jirarequestsent IS NULL 
									ELSE sl.jirarequestsent = v_jirarequestsent END ELSE true END
									AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
									AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
									and sl.activeflag = 1)  as opencount,
							(select count(*) 
								from defecttracking.supportlog sl
									LEFT JOIN cjams.county c on countyname = sl.ldssregion and c.activeflag = 1
								where CASE WHEN v_dateformat = 'YYYY-MM' THEN 
												(CASE WHEN sl.cdmticketno IS NOT NULL AND btrim(sl.cdmticketno) != '' THEN to_char_yyyymm(sl.cdmcloseddate) = ticketmonth 
													ELSE to_char_yyyymm(sl.cjamscloseddate) = ticketmonth 
												END)
											ELSE 
												(CASE WHEN sl.cdmticketno IS NOT NULL AND btrim(sl.cdmticketno) != '' THEN to_char_yyyymmdd(sl.cdmcloseddate) = ticketmonth 
													ELSE to_char_yyyymmdd(sl.cjamscloseddate) = ticketmonth 
												END)
											END
									AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END 
									AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
									CASE WHEN v_jirarequestsent = 'Pending' THEN sl.jirarequestsent IS NULL 
									ELSE sl.jirarequestsent = v_jirarequestsent END ELSE true END
									AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
									AND sl.application = v_application 
									AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
									and sl.activeflag = 1)  as closedcount
							
 						from
							(select distinct b.ticketmonth FROM
								(select distinct CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(s.cjamsticketcreateddate) ELSE to_char_yyyymmdd(s.cjamsticketcreateddate) END as ticketmonth
										from defecttracking.supportlog s
											LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
										where s.activeflag = 1
											AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END 
											AND s.application = v_application 
											AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
											CASE WHEN v_jirarequestsent = 'Pending' THEN s.jirarequestsent IS NULL 
											ELSE s.jirarequestsent = v_jirarequestsent END ELSE true END
											AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
											AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
											AND CASE WHEN v_fromdate is not null THEN s.cjamsticketcreateddate::date >= v_fromdate::date ELSE true END
											AND CASE WHEN v_todate is not null THEN s.cjamsticketcreateddate::date <= v_todate::date ELSE true END
											
										UNION ALL
										
										select distinct CASE WHEN v_dateformat = 'YYYY-MM' THEN 
															CASE WHEN s.cdmticketno IS NOT NULL AND btrim(s.cdmticketno) != '' THEN to_char_yyyymm(s.cdmcloseddate) ELSE to_char_yyyymm(s.cjamscloseddate) END
														ELSE  
															CASE WHEN s.cdmticketno IS NOT NULL AND btrim(s.cdmticketno) != '' THEN to_char_yyyymmdd(s.cdmcloseddate) ELSE to_char_yyyymmdd(s.cjamscloseddate) END
														END as ticketmonth
										from defecttracking.supportlog s
											LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
										where s.activeflag = 1
											AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END 
											AND s.application = v_application 
											AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
											CASE WHEN v_jirarequestsent = 'Pending' THEN s.jirarequestsent IS NULL 
											ELSE s.jirarequestsent = v_jirarequestsent END ELSE true END
											AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
											AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
											AND CASE WHEN v_fromdate is not null THEN 
														CASE WHEN s.cdmticketno IS NOT NULL AND btrim(s.cdmticketno) != '' THEN s.cdmcloseddate::date >= v_fromdate::date ELSE s.cjamscloseddate::date >= v_fromdate::date END
													ELSE true END
											AND CASE WHEN v_todate is not null THEN 
														CASE WHEN s.cdmticketno IS NOT NULL AND btrim(s.cdmticketno) != '' THEN s.cdmcloseddate::date <= v_todate::date ELSE s.cjamscloseddate::date <= v_todate::date END
													ELSE true END
								) b 
								WHERE b.ticketmonth IS NOT NULL
								order by b.ticketmonth
							) a
						order by a.ticketmonth) e;
			
			END IF;
		END IF;
	
	IF (v_charttype = 'team') THEN
		RETURN QUERY
		SELECT 
				null::json as countyticketstatuscounts,
				null::json as countyfocuscdmcounts,
				null::json as countyfocuscjamscounts,
				null::json as countyresolutioncounts,
				null::json as countyfixtypecounts,
				null::json as countyteamticketcounts, 
				null::json as countyticketcreatedcounts,
				null::json as countyincidentcounts,
				null::json as countyincidentopenclosecounts,
				null::json as countyjirastatuscounts,
				null:: json as statecountyticketcounts,
				-- Ticket Counts for given Team for each support log ticket status
				(select json_agg(e) from
					(SELECT * FROM 
						(SELECT coalesce(s.jirarequestsent, 'Pending Approval') AS ticketstatus, count(*) as ticketcount
							from defecttracking.supportlog s
								LEFT JOIN cjams.userprofile u on u.email = s.frommailid 
								LEFT JOIN cjams.teammemberassignment tma on tma.securityusersid = u.securityusersid and tma.activeflag = 1
								LEFT JOIN cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
								LEFT JOIN cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
								LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
							where s.activeflag = 1 
								AND s.application = v_application 
								AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
								AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
								AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END
								AND t.teamid = v_teamid
								AND CASE WHEN v_fromdate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) >= v_fromdate::date ELSE true END
								AND CASE WHEN v_todate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) <= v_todate::date ELSE true END
							GROUP BY jirarequestsent) g
							ORDER BY g.ticketstatus
						)e
				) :: json as teamticketstatuscounts,
				-- CDM Ticket Counts for given Team for each focus area
				(select json_agg(e) from
					(select focus, count(*) as ticketcount FROM
						(SELECT (case when s.focus is null or btrim(s.focus) = '' then 'Not Yet Determined'
									ELSE s.focus
									end ) as focus
							from defecttracking.supportlog s
								LEFT JOIN cjams.userprofile u on u.email = s.frommailid 
								LEFT JOIN cjams.teammemberassignment tma on tma.securityusersid = u.securityusersid and tma.activeflag = 1
								LEFT JOIN cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
								LEFT JOIN cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
								LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
							where s.activeflag = 1 	
								AND s.application = v_application 
								AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
								AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
								AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END
								AND t.teamid = v_teamid
								AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
										CASE WHEN v_jirarequestsent = 'Pending' THEN s.jirarequestsent IS NULL ELSE s.jirarequestsent = v_jirarequestsent END 
									ELSE true END
								AND cdmticketcreateddate IS NOT NULL
								AND CASE WHEN v_fromdate is not null THEN cdmticketcreateddate >= v_fromdate::date ELSE true END
								AND CASE WHEN v_todate is not null THEN cdmticketcreateddate <= v_todate::date ELSE true END) a
						GROUP BY focus) e
				) :: json as teamfocuscdmcounts,
				-- CJAMS Ticket Counts for given Team for each focus area
				(select json_agg(e) from
					(select focus, count(*) as ticketcount FROM
						(SELECT (case when s.focus is null or btrim(s.focus) = '' then 'Not Yet Determined'
									ELSE s.focus
									end ) as focus
							from defecttracking.supportlog s
								LEFT JOIN cjams.userprofile u on u.email = s.frommailid 
								LEFT JOIN cjams.teammemberassignment tma on tma.securityusersid = u.securityusersid and tma.activeflag = 1
								LEFT JOIN cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
								LEFT JOIN cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
								LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
							where s.activeflag = 1 	
								AND s.application = v_application 
								AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
								AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
								AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END
								AND t.teamid = v_teamid
								AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
										CASE WHEN v_jirarequestsent = 'Pending' THEN s.jirarequestsent IS NULL ELSE s.jirarequestsent = v_jirarequestsent END 
									ELSE true END
								AND cdmticketcreateddate IS  NULL
								AND cjamsticketcreateddate IS NOT NULL
								AND CASE WHEN v_fromdate is not null THEN cjamsticketcreateddate >= v_fromdate::date ELSE true END
								AND CASE WHEN v_todate is not null THEN cjamsticketcreateddate <= v_todate::date ELSE true END) a
						GROUP BY focus) e
				) :: json as teamfocuscjamscounts,
				-- Ticket Counts for given Team for each resolution
				(select json_agg(e) from
					(select resolution, count(*) as ticketcount FROM
						(SELECT (case when s.jiraticketresolution is null or btrim(s.jiraticketresolution) = '' then 'Not Yet Determined'
									ELSE s.jiraticketresolution
									end ) as resolution
							from defecttracking.supportlog s
								LEFT JOIN cjams.userprofile u on u.email = s.frommailid 
								LEFT JOIN cjams.teammemberassignment tma on tma.securityusersid = u.securityusersid and tma.activeflag = 1
								LEFT JOIN cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
								LEFT JOIN cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
								LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
							where s.activeflag = 1 	
								AND s.application = v_application 
								AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
								AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END
								AND t.teamid = v_teamid
								AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
								CASE WHEN v_jirarequestsent = 'Pending' THEN s.jirarequestsent IS NULL 
								ELSE s.jirarequestsent = v_jirarequestsent END ELSE true END
								AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
								AND CASE WHEN v_fromdate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) >= v_fromdate::date ELSE true END
								AND CASE WHEN v_todate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) <= v_todate::date ELSE true END) a
						GROUP BY resolution) e
				) :: json as teamresolutioncounts,
				-- Ticket Counts for given Team for each fixtype
				(select json_agg(e) from
					(select fixtype, count(*) as ticketcount FROM
						(SELECT (case when s.fixtype is null or btrim(s.fixtype) = '' then 'Not Yet Determined'
									ELSE s.fixtype
									end ) as fixtype
							from defecttracking.supportlog s
								LEFT JOIN cjams.userprofile u on u.email = s.frommailid 
								LEFT JOIN cjams.teammemberassignment tma on tma.securityusersid = u.securityusersid and tma.activeflag = 1
								LEFT JOIN cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
								LEFT JOIN cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
								LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
							where s.activeflag = 1 	
								AND s.application = v_application 
								AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
									CASE WHEN v_jirarequestsent = 'Pending' THEN s.jirarequestsent IS NULL ELSE s.jirarequestsent = v_jirarequestsent END 
								ELSE true END
								AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
								AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
								AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END
								AND t.teamid = v_teamid
								AND CASE WHEN v_fromdate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) >= v_fromdate::date ELSE true END
								AND CASE WHEN v_todate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) <= v_todate::date ELSE true END) a
						GROUP BY fixtype) e
				) :: json as teamfixtypecounts,
				-- Ticket counts for give team
				(select json_agg(e) from
					(select s.frommailid, u.displayname, s.application, s.ldssregion, count(*) as totalcount,
							sum(case when s.jirarequestsent='Approved' then 1 else 0 end) approvedcount,
							sum(case when s.jirarequestsent='Rejected' then 1 else 0 end) rejectedcount,
							sum(case when s.jirarequestsent IS NULL OR s.jirarequestsent = '' then 1 else 0 end) pendingcount		
						from defecttracking.supportlog s
							LEFT JOIN cjams.userprofile u on u.email = s.frommailid 
							LEFT JOIN cjams.teammemberassignment tma on tma.securityusersid = u.securityusersid and tma.activeflag = 1
							LEFT JOIN cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
							LEFT JOIN cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
							LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
						where s.activeflag = 1 
							AND s.application = v_application 
							AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
							AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
							AND (s.jirarequestsent is null OR s.jirarequestsent IN ('Approved', 'Rejected','') )
							AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END
							AND t.teamid = v_teamid
							AND CASE WHEN v_fromdate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) >= v_fromdate::date ELSE true END
							AND CASE WHEN v_todate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) <= v_todate::date ELSE true END
						group by s.ldssregion, s.frommailid, u.displayname, s.application	
					)e
				) :: json as teamworkerticketcounts,
				
				-- Ticket Counts for given team based on CDM created or not.
				(select json_agg(e) from
					(select ticketmonth,
							(select count(*) 
								from defecttracking.supportlog sl
									LEFT JOIN cjams.userprofile u1 on u1.email = sl.frommailid 
									LEFT JOIN cjams.teammemberassignment tma1 on tma1.securityusersid = u1.securityusersid and tma1.activeflag = 1
									LEFT JOIN cjams.teammember tm1 on tm1.teammemberid = tma1.teammemberid and tm1.activeflag = 1
									LEFT JOIN cjams.team t1 on t1.teamid = tm1.teamid and t1.activeflag = 1
									LEFT JOIN cjams.county c1 on countyname = sl.ldssregion and c1.activeflag = 1
								where CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(sl.approveddate) = ticketmonth ELSE to_char_yyyymmdd(sl.approveddate) = ticketmonth END
									AND sl.application = v_application 
									AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
									AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
									AND t1.teamid = v_teamid
									and sl.jirarequestsent = 'Approved'
									AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END
									and sl.activeflag = 1)  as approvedcount,
							(select count(*) 
								from defecttracking.supportlog sl
									LEFT JOIN cjams.userprofile u1 on u1.email = sl.frommailid 
									LEFT JOIN cjams.teammemberassignment tma1 on tma1.securityusersid = u1.securityusersid and tma1.activeflag = 1
									LEFT JOIN cjams.teammember tm1 on tm1.teammemberid = tma1.teammemberid and tm1.activeflag = 1
									LEFT JOIN cjams.team t1 on t1.teamid = tm1.teamid and t1.activeflag = 1
									LEFT JOIN cjams.county c1 on countyname = sl.ldssregion and c1.activeflag = 1
								where CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(sl.cdmticketcreateddate) = ticketmonth ELSE to_char_yyyymmdd(sl.cdmticketcreateddate) = ticketmonth END
									AND sl.application = v_application 
									AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
									AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
									AND t1.teamid = v_teamid
									AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END
									and sl.jirarequestsent = 'Approved'
									AND sl.cdmticketno IS NOT NULL AND btrim(sl.cdmticketno) != ''
									and sl.activeflag = 1)  as acceptedcount		
 						from
							(select distinct b.ticketmonth FROM
								(select distinct CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(s.approveddate) ELSE to_char_yyyymmdd(s.approveddate) END as ticketmonth
									from defecttracking.supportlog s
										LEFT JOIN cjams.userprofile u on u.email = s.frommailid 
										LEFT JOIN cjams.teammemberassignment tma on tma.securityusersid = u.securityusersid and tma.activeflag = 1
										LEFT JOIN cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
										LEFT JOIN cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
										LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
									where s.activeflag = 1
										AND s.application = v_application 
										AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
										AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
										AND t.teamid = v_teamid
										AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END
										AND s.jirarequestsent = 'Approved'
										AND CASE WHEN v_fromdate is not null THEN s.approveddate::date >= v_fromdate::date ELSE true END
										AND CASE WHEN v_todate is not null THEN s.approveddate::date <= v_todate::date ELSE true END
											
								UNION ALL
										
								select distinct CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(s.cdmticketcreateddate) ELSE to_char_yyyymmdd(s.cdmticketcreateddate) END as ticketmonth
									from defecttracking.supportlog s
										LEFT JOIN cjams.userprofile u on u.email = s.frommailid 
										LEFT JOIN cjams.teammemberassignment tma on tma.securityusersid = u.securityusersid and tma.activeflag = 1
										LEFT JOIN cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
										LEFT JOIN cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
										LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
									where s.activeflag = 1
										AND s.cdmticketno IS NOT NULL AND btrim(s.cdmticketno) != ''
										AND s.application = v_application 
										AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
										AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
										AND t.teamid = v_teamid
										AND s.ldssregion = v_ldssregion
										AND s.jirarequestsent = 'Approved'
										AND CASE WHEN v_fromdate is not null THEN s.cdmticketcreateddate::date >= v_fromdate::date ELSE true END
										AND CASE WHEN v_todate is not null THEN s.cdmticketcreateddate::date <= v_todate::date ELSE true END
								) b 
								WHERE b.ticketmonth IS NOT NULL
								order by b.ticketmonth
							) a
						order by a.ticketmonth) e
				) :: json as teamticketcreatedcounts,
				
				-- Ticket Counts for county based on each month.
				(select json_agg(e) from
					(select ticketmonth,
							(select count(*) 
								from defecttracking.supportlog sl
									LEFT JOIN cjams.userprofile u1 on u1.email = sl.frommailid 
									LEFT JOIN cjams.teammemberassignment tma1 on tma1.securityusersid = u1.securityusersid and tma1.activeflag = 1
									LEFT JOIN cjams.teammember tm1 on tm1.teammemberid = tma1.teammemberid and tm1.activeflag = 1
									LEFT JOIN cjams.team t1 on t1.teamid = tm1.teamid and t1.activeflag = 1
									LEFT JOIN cjams.county c on countyname = sl.ldssregion and c.activeflag = 1
								where CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(sl.insertedon) = ticketmonth ELSE to_char_yyyymmdd(sl.insertedon) = ticketmonth END
									AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END
									AND sl.application = v_application 
									AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
									AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
									AND t1.teamid = v_teamid
									and sl.activeflag = 1)  as totalcount,
							(select count(*) 
								from defecttracking.supportlog sl
									LEFT JOIN cjams.userprofile u1 on u1.email = sl.frommailid 
									LEFT JOIN cjams.teammemberassignment tma1 on tma1.securityusersid = u1.securityusersid and tma1.activeflag = 1
									LEFT JOIN cjams.teammember tm1 on tm1.teammemberid = tma1.teammemberid and tm1.activeflag = 1
									LEFT JOIN cjams.team t1 on t1.teamid = tm1.teamid and t1.activeflag = 1
									LEFT JOIN cjams.county c on countyname = sl.ldssregion and c.activeflag = 1
								where CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(sl.approveddate) = ticketmonth ELSE to_char_yyyymmdd(sl.approveddate) = ticketmonth END
									AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END
									AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
									AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
									AND t1.teamid = v_teamid
									and sl.jirarequestsent = 'Approved'
									AND sl.application = v_application 
									and sl.activeflag = 1)  as approvedcount,
							(select count(*) 
								from defecttracking.supportlog sl
									LEFT JOIN cjams.userprofile u1 on u1.email = sl.frommailid 
									LEFT JOIN cjams.teammemberassignment tma1 on tma1.securityusersid = u1.securityusersid and tma1.activeflag = 1
									LEFT JOIN cjams.teammember tm1 on tm1.teammemberid = tma1.teammemberid and tm1.activeflag = 1
									LEFT JOIN cjams.team t1 on t1.teamid = tm1.teamid and t1.activeflag = 1
									LEFT JOIN cjams.county c on countyname = sl.ldssregion and c.activeflag = 1
								where CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(sl.rejecteddate) = ticketmonth ELSE to_char_yyyymmdd(sl.rejecteddate) = ticketmonth END
									AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END
									AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
									AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
									AND t1.teamid = v_teamid
									and sl.jirarequestsent = 'Rejected'
									AND sl.application = v_application 
									and sl.activeflag = 1)  as rejectedcount,
							(select count(*) 
								from defecttracking.supportlog sl
									LEFT JOIN cjams.userprofile u1 on u1.email = sl.frommailid 
									LEFT JOIN cjams.teammemberassignment tma1 on tma1.securityusersid = u1.securityusersid and tma1.activeflag = 1
									LEFT JOIN cjams.teammember tm1 on tm1.teammemberid = tma1.teammemberid and tm1.activeflag = 1
									LEFT JOIN cjams.team t1 on t1.teamid = tm1.teamid and t1.activeflag = 1
									LEFT JOIN cjams.county c on countyname = sl.ldssregion and c.activeflag = 1
								where CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(sl.insertedon) = ticketmonth ELSE to_char_yyyymmdd(sl.insertedon) = ticketmonth END
									AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END
									AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
									AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
									AND t1.teamid = v_teamid
									AND sl.application = v_application 
									and (sl.jirarequestsent is null or  sl.jirarequestsent = '')
									and sl.activeflag = 1)  as pendingcount		
 						from
							(select distinct CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(s.insertedon) ELSE to_char_yyyymmdd(s.insertedon) END as ticketmonth
								from defecttracking.supportlog s
									LEFT JOIN cjams.userprofile u on u.email = s.frommailid 
									LEFT JOIN cjams.teammemberassignment tma on tma.securityusersid = u.securityusersid and tma.activeflag = 1
									LEFT JOIN cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
									LEFT JOIN cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
									LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
								where s.activeflag = 1
									AND s.ldssregion = v_ldssregion
									AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
									AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
									AND t.teamid = v_teamid
									AND s.application = v_application 
									AND CASE WHEN v_fromdate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) >= v_fromdate::date ELSE true END
									AND CASE WHEN v_todate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) <= v_todate::date ELSE true END) a
						order by a.ticketmonth) e
				) :: json as teamincidentcounts,
				
				
				v_teamincidentopenclosecounts as teamincidentopenclosecounts,
				
				-- Ticket Counts for given team for each jira status
				(select json_agg(e) from
					(SELECT coalesce(s.status, 'No Status') AS status, count(*) as ticketcount
						from defecttracking.supportlog s
							LEFT JOIN cjams.userprofile u on u.email = s.frommailid 
							LEFT JOIN cjams.teammemberassignment tma on tma.securityusersid = u.securityusersid and tma.activeflag = 1
							LEFT JOIN cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
							LEFT JOIN cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
							LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
						where s.activeflag = 1 
							AND s.application = v_application 
							AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
							CASE WHEN v_jirarequestsent = 'Pending' THEN s.jirarequestsent IS NULL 
							ELSE s.jirarequestsent = v_jirarequestsent END ELSE true END
							-- AND s.jirarequestsent IN ('Approved','Jira Ticket')
							AND s.jirarequestno IS NOT NULL
							AND t.teamid = v_teamid
							AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
							AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
							AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END 
							AND CASE WHEN v_fromdate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) >= v_fromdate::date ELSE true END
							AND CASE WHEN v_todate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) <= v_todate::date ELSE true END
						GROUP BY coalesce(s.status, 'No Status')	
					)e
				) :: json as teamjirastatuscounts,
				v_datediff;
	ELSE
		RETURN QUERY
		SELECT 
				-- Ticket Counts for given county for each support log ticket status
				(select json_agg(e) from
					(SELECT * FROM 
						(SELECT coalesce(s.jirarequestsent, 'Pending Approval') AS ticketstatus, count(*) as ticketcount
							from defecttracking.supportlog s
								LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
							where s.activeflag = 1 
								AND s.application = v_application 
								AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
								AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
								AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END 
								AND CASE WHEN v_fromdate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) >= v_fromdate::date ELSE true END
								AND CASE WHEN v_todate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) <= v_todate::date ELSE true END
							GROUP BY jirarequestsent) g
							ORDER BY g.ticketstatus
						)e
				) :: json as countyticketstatuscounts,
				-- CDM Ticket Counts for given county for each focus area
				(select json_agg(e) from
					(select focus, count(*) as ticketcount FROM
						(SELECT (case when s.focus is null or btrim(s.focus) = '' then 'Not Yet Determined'
									ELSE s.focus
									end ) as focus
							from defecttracking.supportlog s
								LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
							where s.activeflag = 1 	
								AND s.application = v_application 
								AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
										CASE WHEN v_jirarequestsent = 'Pending' THEN s.jirarequestsent IS NULL ELSE s.jirarequestsent = v_jirarequestsent END 
									ELSE true END
								AND cdmticketcreateddate IS NOT NULL
								AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
								AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
								AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END 
								AND CASE WHEN v_fromdate is not null THEN cdmticketcreateddate >= v_fromdate::date ELSE true END
								AND CASE WHEN v_todate is not null THEN cdmticketcreateddate <= v_todate::date ELSE true END) a
						GROUP BY focus) e
				) :: json as countyfocuscdmcounts,
				-- CJAMS Ticket Counts for given county for each focus area
				(select json_agg(e) from
					(select focus, count(*) as ticketcount FROM
						(SELECT (case when s.focus is null or btrim(s.focus) = '' then 'Not Yet Determined'
									ELSE s.focus
									end ) as focus
							from defecttracking.supportlog s
								LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
							where s.activeflag = 1 	
								AND s.application = v_application 
								AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
										CASE WHEN v_jirarequestsent = 'Pending' THEN s.jirarequestsent IS NULL ELSE s.jirarequestsent = v_jirarequestsent END 
									ELSE true END
								AND cdmticketcreateddate IS  NULL
								AND cjamsticketcreateddate IS NOT NULL 
								AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
								AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
								AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END 
								AND CASE WHEN v_fromdate is not null THEN cjamsticketcreateddate >= v_fromdate::date ELSE true END
								AND CASE WHEN v_todate is not null THEN cjamsticketcreateddate <= v_todate::date ELSE true END) a
						GROUP BY focus) e
				) :: json as countyfocuscjamscounts,
				-- Ticket Counts for given county for each resolution
				(select json_agg(e) from
					(select resolution, count(*) as ticketcount FROM
						(SELECT (case when s.jiraticketresolution is null or btrim(s.jiraticketresolution) = '' then 'Not Yet Determined'
									ELSE s.jiraticketresolution
									end ) as resolution
							from defecttracking.supportlog s
								LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
							where s.activeflag = 1 	
								AND s.application = v_application 
								AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
								CASE WHEN v_jirarequestsent = 'Pending' THEN s.jirarequestsent IS NULL 
								ELSE s.jirarequestsent = v_jirarequestsent END ELSE true END
								AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
								AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
								AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END 
								AND CASE WHEN v_fromdate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) >= v_fromdate::date ELSE true END
								AND CASE WHEN v_todate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) <= v_todate::date ELSE true END) a
						GROUP BY resolution) e
				) :: json as countyresolutioncounts,
				-- Ticket Counts for given county for each fix type
				(select json_agg(e) from
					(select fixtype, count(*) as ticketcount FROM
						(SELECT (case when s.fixtype is null or btrim(s.fixtype) = '' then 'Not Yet Determined'
									ELSE s.fixtype
									end ) as fixtype
							from defecttracking.supportlog s
								left join cjams.county c on countyname = s.ldssregion and c.activeflag = 1
							where s.activeflag = 1 	
								AND s.application = v_application 
								AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
								CASE WHEN v_jirarequestsent = 'Pending' THEN s.jirarequestsent IS NULL ELSE s.jirarequestsent = v_jirarequestsent END 
								ELSE true END
								-- AND s.jirarequestsent = 'Approved'
								AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
								AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
								AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END 
								AND CASE WHEN v_fromdate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) >= v_fromdate::date ELSE true END
								AND CASE WHEN v_todate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) <= v_todate::date ELSE true END) a
						GROUP BY fixtype) e
				) :: json as countyfixtypecounts,
				-- Ticket Counts for given county for each team
				(select json_agg(e) from
					(select t.teamid, t.teamname, s.application, s.ldssregion, count(*) as totalcount,
							sum(case when s.jirarequestsent='Approved' then 1 else 0 end) approvedcount,
							sum(case when s.jirarequestsent='Rejected' then 1 else 0 end) rejectedcount,
							sum(case when s.jirarequestsent IS NULL OR s.jirarequestsent = '' then 1 else 0 end) pendingcount		
						from defecttracking.supportlog s
							LEFT JOIN cjams.userprofile u on u.email = s.frommailid 
							LEFT JOIN cjams.teammemberassignment tma on tma.securityusersid = u.securityusersid and tma.activeflag = 1
							LEFT JOIN cjams.teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
							LEFT JOIN cjams.team t on t.teamid = tm.teamid and t.activeflag = 1
							LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
						where s.activeflag = 1 
							AND s.application = v_application 
							AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
							AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
							AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
								CASE WHEN v_jirarequestsent = 'Pending' THEN s.jirarequestsent IS NULL ELSE s.jirarequestsent = v_jirarequestsent END 
							ELSE true END
							AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END 
							AND CASE WHEN v_fromdate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) >= v_fromdate::date ELSE true END
							AND CASE WHEN v_todate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) <= v_todate::date ELSE true END
						group by t.teamid, t.teamname, s.application, s.ldssregion	
					)e
				) :: json as countyteamticketcounts, 
				-- Ticket Counts for given county based on CDM created or not.
				(select json_agg(e) from
					(select ticketmonth,
							(select count(*) 
								from defecttracking.supportlog sl
									LEFT JOIN cjams.county c1 on countyname = sl.ldssregion and c1.activeflag = 1
								where 
									CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(sl.approveddate) = ticketmonth ELSE to_char_yyyymmdd(sl.approveddate) = ticketmonth END
									AND sl.application = v_application 
									and sl.jirarequestsent = 'Approved'
									AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
									AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
									AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END 
									and sl.activeflag = 1)  as approvedcount,
							(select count(*) 
								from defecttracking.supportlog sl
									LEFT JOIN cjams.county c1 on countyname = sl.ldssregion and c1.activeflag = 1
								where CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(sl.cdmticketcreateddate) = ticketmonth ELSE to_char_yyyymmdd(sl.cdmticketcreateddate) = ticketmonth END
									AND sl.application = v_application 
									AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
									AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
									AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END 
									and sl.jirarequestsent = 'Approved'
									AND sl.cdmticketno IS NOT NULL AND btrim(sl.cdmticketno) != '' 
									and sl.activeflag = 1)  as acceptedcount		
 						from
							(select distinct b.ticketmonth FROM
								(select distinct CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(s.approveddate) ELSE to_char_yyyymmdd(s.approveddate) END as ticketmonth
										from defecttracking.supportlog s
											LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
										where s.activeflag = 1
											AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END 
											AND s.application = v_application 
											and s.jirarequestsent = 'Approved'
											AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
											AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
											AND CASE WHEN v_fromdate is not null THEN s.approveddate::date >= v_fromdate::date ELSE true END
											AND CASE WHEN v_todate is not null THEN s.approveddate::date <= v_todate::date ELSE true END
										
									UNION ALL
										
									select distinct CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(s.cdmticketcreateddate) ELSE to_char_yyyymmdd(s.cdmticketcreateddate) END as ticketmonth
										from defecttracking.supportlog s
											LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
										where s.activeflag = 1
											AND s.cdmticketno IS NOT NULL AND btrim(s.cdmticketno) != ''
											AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END 
											AND s.application = v_application 
											and s.jirarequestsent = 'Approved'
											AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
											AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
											AND CASE WHEN v_fromdate is not null THEN s.cdmticketcreateddate::date >= v_fromdate::date ELSE true END
											AND CASE WHEN v_todate is not null THEN s.cdmticketcreateddate::date <= v_todate::date ELSE true END
								) b 
								WHERE b.ticketmonth IS NOT NULL
								order by b.ticketmonth
							) a							
						order by a.ticketmonth) e
				) :: json as countyticketcreatedcounts,
				
				-- Ticket Counts for county based on each month.
				(select json_agg(e) from
					(select ticketmonth,
							(select count(*) 
								from defecttracking.supportlog sl
									LEFT JOIN cjams.county c on countyname = sl.ldssregion and c.activeflag = 1
								where CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(sl.insertedon) = ticketmonth ELSE to_char_yyyymmdd(sl.insertedon) = ticketmonth END
									AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END 
									AND sl.application = v_application 
									AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
									AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
									and sl.activeflag = 1)  as totalcount,
							(select count(*) 
								from defecttracking.supportlog sl
									LEFT JOIN cjams.county c on countyname = sl.ldssregion and c.activeflag = 1
								where CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(sl.approveddate) = ticketmonth ELSE to_char_yyyymmdd(sl.approveddate) = ticketmonth END
									AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END 
									and sl.jirarequestsent = 'Approved'
									AND sl.application = v_application 
									AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
									AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
									and sl.activeflag = 1)  as approvedcount,
							(select count(*) 
								from defecttracking.supportlog sl
									LEFT JOIN cjams.county c on countyname = sl.ldssregion and c.activeflag = 1
								where CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(sl.rejecteddate) = ticketmonth ELSE to_char_yyyymmdd(sl.rejecteddate) = ticketmonth END
									AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END 
									and sl.jirarequestsent = 'Rejected'
									AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
									AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
									AND sl.application = v_application 
									and sl.activeflag = 1)  as rejectedcount,
							(select count(*) 
								from defecttracking.supportlog sl
									LEFT JOIN cjams.county c on countyname = sl.ldssregion and c.activeflag = 1
								where CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(sl.insertedon) = ticketmonth ELSE to_char_yyyymmdd(sl.insertedon) = ticketmonth END
									AND CASE WHEN v_ldssregion IS NOT NULL THEN sl.ldssregion = v_ldssregion ELSE true END 
									AND sl.application = v_application 
									AND CASE WHEN v_jiraenv IS NOT NULL THEN sl.jiraenv = v_jiraenv ELSE true END
									AND CASE WHEN v_identifiedas IS NOT NULL THEN sl.identifiedas = v_identifiedas ELSE true END
									and (sl.jirarequestsent is null or  sl.jirarequestsent = '')
									and sl.activeflag = 1)  as pendingcount		
 						from
							(select distinct CASE WHEN v_dateformat = 'YYYY-MM' THEN to_char_yyyymm(s.insertedon) ELSE to_char_yyyymmdd(s.insertedon) END as ticketmonth
								from defecttracking.supportlog s
									LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
								where s.activeflag = 1
									AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END 
									AND s.application = v_application 
									AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
									AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
									AND CASE WHEN v_fromdate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) >= v_fromdate::date ELSE true END
									AND CASE WHEN v_todate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) <= v_todate::date ELSE true END) a
						order by a.ticketmonth) e
				) :: json as countyincidentcounts,
				
				v_countyincidentopenclosecounts as countyincidentopenclosecounts,
				
				-- Ticket Counts for given county for each jira status
				(select json_agg(e) from
					(SELECT coalesce(s.status, 'No Status') AS status, count(*) as ticketcount
						from defecttracking.supportlog s
							left join cjams.county c on countyname = s.ldssregion and c.activeflag = 1
						where s.activeflag = 1 
							AND s.application = v_application 
							AND CASE WHEN v_jirarequestsent is not null AND v_jirarequestsent != 'All' THEN 
							CASE WHEN v_jirarequestsent = 'Pending' THEN s.jirarequestsent IS NULL 
							ELSE s.jirarequestsent = v_jirarequestsent END ELSE true END
							-- AND s.jirarequestsent IN ('Approved','Jira Ticket')
							AND s.jirarequestno IS NOT NULL
							AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
							AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
							AND CASE WHEN v_ldssregion IS NOT NULL THEN s.ldssregion = v_ldssregion ELSE true END 
							AND CASE WHEN v_fromdate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) >= v_fromdate::date ELSE true END
							AND CASE WHEN v_todate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) <= v_todate::date ELSE true END
						GROUP BY coalesce(s.status, 'No Status')	
					)e
				) :: json as countyjirastatuscounts,

				-- Ticket Counts for entire state based on suportlog ticket status for each county.
				(select json_agg(e) from
					(select s.application, s.ldssregion, count(*) as totalcount,
							sum(case when s.jirarequestsent='Approved' then 1 else 0 end) approvedcount,
							sum(case when s.jirarequestsent='Rejected' then 1 else 0 end) rejectedcount,
							sum(case when s.jirarequestsent IS NULL OR s.jirarequestsent = '' then 1 else 0 end) pendingcount
						from defecttracking.supportlog s
							LEFT JOIN cjams.county c on countyname = s.ldssregion and c.activeflag = 1
						where s.activeflag = 1 
							AND s.application = v_application 
							AND CASE WHEN v_jiraenv IS NOT NULL THEN s.jiraenv = v_jiraenv ELSE true END
							AND CASE WHEN v_identifiedas IS NOT NULL THEN s.identifiedas = v_identifiedas ELSE true END
							AND (s.jirarequestsent is null OR s.jirarequestsent IN ('Approved', 'Rejected','') )
							AND CASE WHEN v_fromdate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) >= v_fromdate::date ELSE true END
							AND CASE WHEN v_todate is not null THEN coalesce(coalesce(cdmticketcreateddate, cjamsticketcreateddate), s.effectivedate::date) <= v_todate::date ELSE true END
						group by s.ldssregion, s.application	
					)e
				) :: json as statecountyticketcounts,
		
				null :: json as teamticketstatuscounts,
				null :: json as teamfocuscdmcounts,
				null :: json as teamfocuscjamscounts,
				null :: json as teamresolutioncounts,
				null :: json as teamfixtypecounts,
				null :: json as teamworkerticketcounts,
				null :: json as teamticketcreatedcounts,
				null :: json as teamincidentcounts,
				null :: json as teamincidentopenclosecounts,
				null :: json as teamjirastatuscounts,
				v_datediff;
	
	END IF;
				
END;

$function$
;
