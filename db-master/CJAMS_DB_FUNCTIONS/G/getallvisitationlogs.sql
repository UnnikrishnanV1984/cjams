-- FUNCTION: cjams.getallvisitationlogs(character varying, bigint, bigint)
DROP FUNCTION IF EXISTS cjams.getallvisitationlogs(character varying);
DROP FUNCTION IF EXISTS cjams.getallvisitationlogs(character varying, bigint, bigint);
DROP FUNCTION IF EXISTS cjams.getallvisitationlogs(character varying, bigint, bigint, character varying,character varying);
DROP FUNCTION IF EXISTS cjams.getallvisitationlogs(character varying, bigint, bigint, character varying,character varying, character varying, integer);
DROP FUNCTION IF EXISTS cjams.getallvisitationlogs(character varying, bigint, bigint, character varying,character varying, character varying, integer, integer);
DROP FUNCTION IF EXISTS cjams.getallvisitationlogs(character varying, bigint, bigint, character varying,character varying, integer, integer);

CREATE OR REPLACE FUNCTION cjams.getallvisitationlogs(
    v_caseid character varying,
    v_lipagenumber bigint,
    v_lipagesize bigint,
    v_sortdir character varying,
    v_sortcolumn character varying,
    isExpungementSuperUser integer DEFAULT 0,
	isexpunged integer DEFAULT 0::integer
)
RETURNS json
LANGUAGE plpgsql
AS $function$
--------------------------------------------------------------------------------------------------
--Revision(s)
-- 11/17/2025 -Umasanakar raavi - CIDM-10890 - CJAMS Manual & Automation Expungement Enhancement - for Sexual Abuse CPS Intakes and Cases
-----------------------------------------------------------------------------------------------------------------

DECLARE v_visitationlogs json;
v_pagenumber int;
	v_pageoffset int;
	v_uuidornot character varying(50);
	v_intake character varying;
    v_isexpunged integer;
begin
    v_pagenumber := v_liPageNumber - 1;
v_pageoffset := v_pagenumber * v_liPageSize;

SELECT * into v_uuidornot from uuid_or_null(v_caseid);
v_isexpunged = 0;
IF isExpungementSuperUser= 1  THEN
	v_isexpunged = isexpunged;
END IF;

RAISE NOTICE 'isExpungementSuperUser=%, v_isexpunged=%', isExpungementSuperUser, v_isexpunged;

        IF v_isexpunged = 1 THEN
        RAISE NOTICE 'BLOCK: FULLY EXPUNGED';
            select distinct intakenumber into v_intake 
            from expunge.intakeservicerequest_expunge 
            where (intakeserviceid = v_caseid::uuid or servicecaseid = v_caseid::uuid) and activeflag = 1 
            LIMIT 1; 
        ELSIF v_isexpunged = 2 THEN
        RAISE NOTICE 'BLOCK: PARTIALLY EXPUNGED';
            select distinct intakenumber into v_intake 
            from (
                select intakenumber, intakeserviceid, servicecaseid, activeflag 
                from intakeservicerequest
                union all
                select intakenumber,
                       intakeserviceid, servicecaseid, activeflag
                from expunge.intakeservicerequest_expunge
            ) isr
            where (intakeserviceid = v_caseid::uuid or servicecaseid = v_caseid::uuid) and activeflag = 1 
            LIMIT 1; 
        ELSE
        RAISE NOTICE 'BLOCK: NORMAL';
            select distinct intakenumber 
            into v_intake 
            from intakeservicerequest 
            where (intakeserviceid = v_caseid::uuid 
                or servicecaseid = v_caseid::uuid)
            and activeflag = 1
            LIMIT 1;
        END IF;
    SELECT json_agg(vlogs) INTO v_visitationlogs 
    FROM (
		SELECT  COUNT(1) OVER() totalcount, 
		(SELECT concat_ws(' ', firstname, lastname) FROM person p WHERE p.personid = vl.personid ) AS clientname,
		(SELECT array_agg(vlc.personid) FROM visitationlogclient vlc WHERE vlc.visitationlogid = vl.visitationlogid) AS visitationlogclient,
		(SELECT array_agg(  (SELECT concat_ws(' ', firstname, lastname) FROM person p WHERE p.personid = vlc.personid) ) FROM visitationlogclient vlc WHERE vlc.visitationlogid = vl.visitationlogid and vlc.personid is not null) 
		AS participantnames,
		(SELECT array_agg(vlcc.collateralid) FROM visitationlogclient vlcc WHERE vlcc.visitationlogid = vl.visitationlogid) AS collaterallist,

        * 
		FROM visitationlog vl WHERE (CASE WHEN v_uuidornot IS NULL THEN caseid = v_caseid ELSE caseid in (v_caseid, v_intake) END) AND activeflag = 1 
		ORDER BY ( 
		CASE v_sortdir
			WHEN 'asc'
			THEN
				CASE v_sortcolumn
					WHEN 'clientname' THEN cast( (select concat_ws(' ', firstname, lastname) FROM person p WHERE p.personid = vl.personid)   as character varying)
					WHEN 'visitdate' THEN  cast(vl.visitdate  as character varying)
					WHEN 'courtorderedflag' THEN  cast( (case vl.courtorderedflag when 1 then 1 else 0 end)  as character varying)
					WHEN 'visitstatustypekey' THEN  cast(vl.visitstatustypekey  as character varying)
					WHEN 'supervisedflag' THEN  cast( (case vl.supervisedflag when 1 then 1 else 0 end)  as character varying)
					WHEN 'visitcomments' THEN  cast( vl.visitcomments   as character varying)
					WHEN 'visitlocation' THEN  cast( vl.visitlocation   as character varying)
			ELSE
                  cast(vl.visitdate  as character varying)
            END
		END) ASC NULLS LAST,
			(CASE v_sortdir
			WHEN 'desc'
			THEN
				CASE v_sortcolumn
					WHEN 'clientname' THEN cast( (select concat_ws(' ', firstname, lastname) FROM person p WHERE p.personid = vl.personid)   as character varying)
					WHEN 'visitdate' THEN  cast(vl.visitdate  as character varying)
					WHEN 'courtorderedflag' THEN  cast( (case vl.courtorderedflag when 1 then 1 else 0 end)  as character varying)
					WHEN 'visitstatustypekey' THEN  cast(vl.visitstatustypekey  as character varying)
					WHEN 'supervisedflag' THEN  cast( (case vl.supervisedflag when 1 then 1 else 0 end)  as character varying)
					WHEN 'visitcomments' THEN  cast(  vl.visitcomments as character varying)
					WHEN 'visitlocation' THEN  cast(  vl.visitlocation   as character varying)
			ELSE
                  cast(vl.visitdate  as character varying)
            END
		END) DESC NULLS LAST
		 LIMIT v_liPageSize OFFSET v_pageoffset 
	) AS vlogs;
        
RETURN v_visitationlogs;  

END;

$function$
;
