-- DROP FUNCTION IF EXISTS cjams.sp_funding_scr_child_search(json, bigint, bigint);
CREATE OR REPLACE FUNCTION cjams.sp_funding_scr_child_search(searchobj json, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint, client_id bigint, client_name character varying, client_dob timestamp without time zone, ssn character varying, local_dept character varying)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 10/04/2021 Vineet Tirodkar - Modifications to caseassignment logic (exclude toworkeridno null records ) (CDM-17266)
------------------------------------------------------------------------------------------------------------	
DECLARE  
	v_client_id bigint;
	v_pagenumber int;
	v_pageoffset int;
	v_client_name character varying;
	v_DOBDateFrom   TIMESTAMP(3);                
	v_DOBDateTo TIMESTAMP(3);
	v_ssn character varying;
	v_caseworker_name character varying;
	v_localdpt character varying;
	client_last_name character varying;
	client_first_name character varying;
BEGIN 
	v_client_id := searchobj ->> 'client_id';
	v_client_name := searchobj ->> 'client_name';
	v_DOBDateFrom 	 := searchobj ->> 'dobdaterangefrom';                       
	v_DOBDateTo   := searchobj ->> 'dobdaterangeto';
	v_pagenumber := v_liPageNumber - 1;
	v_pageoffset := v_pagenumber * v_liPageSize;
	v_ssn := searchobj ->> 'ssn'; 
	v_caseworker_name :=searchobj ->> 'caseworker_name';
	v_localdpt := searchobj ->> 'local_dept';
	 client_last_name := searchobj ->> 'client_last_name';
	 client_first_name := searchobj ->> 'client_first_name';

	return query
		SELECT  COUNT(1) OVER() totalcount, 
			P.cjamspid as client_ids, 
			CAST(INITCAP(TRIM(P.firstname)||' '||TRIM(P.lastname) ||
			CASE WHEN P.middlename IS NOT NULL AND TRIM(P.middlename) != '' THEN 
				', ' || TRIM(P.middlename) 
			ELSE 
				''
			END) as character varying) as client_names, 
			P.dob as client_dob,
			(select pid.personidentifiervalue 
				from personidentifier pid 
			where pid.personidentifiertypekey = 'SSN' 
				and pid.personid = p.personid 
				and pid.activeflag = 1 
			limit 1) :: character varying as p_ssn
			,c.countyname as local_dept
		FROM tb_fund_allocation_master fam 
			join tb_payment_detail tpd on tpd.payment_detail_id= fam.payment_detail_id 
				and tpd.delete_sw = 'N'
			join person as P on p.cjamspid = tpd.client_id 
				and p.activeflag = 1
			left JOIN servicecase sc on sc.servicecasenumber = tpd.case_id::character varying
			left JOIN adoptioncase ac on ac.adoptioncasenumber = tpd.case_id::character varying
			left JOIN caseassignment ca on ca.objectid = COALESCE(sc.servicecaseid, ac.adoptioncaseid)
				and ca.activeflag = 1     
			LEFT JOIN userprofile up on up.securityusersid = ca.toworkeridno 
				and up.activeflag = 1 
			left join teammemberassignment tma on tma.securityusersid = up.securityusersid 
				and tma.activeflag = 1 
			left join teammember tm on  tm.teammemberid = tma.teammemberid  
				and tm.activeflag = 1 
			left join team t on t.teamid = tm.teamid 
				and t.activeflag = 1
			left join county c on  t.countyid = c.countyid::character varying 
        Where (v_client_id is null or P.cjamspid = v_client_id)
			and (client_last_name is null or trim(client_last_name) = ''
				or 
				(lower(CAST((Trim(p.lastname)) as character varying)) like lower('%' || client_last_name || '%')) 
				OR  
				CASE WHEN lower(trim(client_last_name)) is NOT NULL THEN 
					(soundex(lower(trim( p.LastName))) = soundex(lower(trim(client_last_name))))  
				END  
				) 
			and (client_first_name is null  or  trim(client_first_name) = '' 
				or 
				(lower(CAST((TRIM(P.firstname))as character varying)) like lower('%' || client_first_name || '%'))
				OR	
				CASE WHEN lower(trim(client_first_name)) is NOT NULL THEN  
					(soundex(lower(trim(p.firstname))) = soundex(lower(trim(client_first_name))))  
				END  
				)  
    		AND (case WHEN (v_DOBDateFrom IS NOT null and v_DOBDateTo is not null) THEN 
					to_char(p.dob, 'YYYY-MM-DD') ::date
						BETWEEN to_char(DATE(v_DOBDateFrom ::varchar), 'YYYY-MM-DD')::date 
								AND to_char(DATE(v_DOBDateTo ::varchar), 'YYYY-MM-DD')::date
				WHEN (v_DOBDateFrom IS NOT null) THEN 
					to_char(p.dob, 'YYYY-MM-DD') ::date >= to_char(DATE(v_DOBDateFrom ::varchar), 'YYYY-MM-DD')::date 
	 			WHEN (v_DOBDateTo IS NOT null)  THEN 
					to_char(p.dob , 'YYYY-MM-DD') ::date <= to_char(DATE(v_DOBDateTo ::varchar), 'YYYY-MM-DD')::date 
				ELSE
					TRUE 
				end) 
			AND (v_ssn is null or p.ssnno  = v_ssn )
			AND (v_localdpt is null or c.countyname  ilike '%'||v_localdpt||'%' )
			AND (v_caseworker_name is null or lower(TRIM(up.fullname)) like lower('%' || v_caseworker_name || '%') )
			AND ca.toworkeridno = ( select toworkeridno  
										from caseassignment 
									where objectid = COALESCE(sc.servicecaseid, ac.adoptioncaseid) 
										and activeflag = 1
										and coalesce(toworkeridno,'') <> ''
									order by insertedon desc 
									limit 1
								  )
			AND p.activeflag =1 and fam.delete_sw='N'
	group by client_ids, 
		client_names, 
		client_dob, 
		p_ssn,
		p.firstname,
		p.lastname,
		p.middlename, 
		local_dept
	order by (case when (v_client_name is not null or trim(v_client_name) ='') then 
					levenshtein(((TRIM(P.firstname)||' '||TRIM(P.lastname) ||
			  CASE WHEN P.middlename IS NOT NULL AND TRIM(P.middlename) != '' THEN 
				', ' || TRIM(P.middlename) 
			  ELSE 
			    '' 
			  END)::character varying ),
			  (lower( trim( v_client_name) )),1,0,4 ) end ) asc nulls last
	LIMIT v_liPageSize OFFSET v_pageoffset;
END;

$function$
;
