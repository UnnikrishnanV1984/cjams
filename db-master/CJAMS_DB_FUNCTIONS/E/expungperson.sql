-- DROP FUNCTION IF EXISTS cjams.expungperson(character varying);
DROP FUNCTION IF EXISTS cjams.expungperson(character varying[]);

CREATE OR REPLACE FUNCTION cjams.expungperson( v_personid character varying[])
 RETURNS void
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 02/16/2024 Vineet Tirodkar - Modifications for Expungement Job Performance Fixes (CIDM-8423)
------------------------------------------------------------------------
BEGIN
	--## EXPUNG PERSON RECORD IF NOT LINKED TO ANY SERVICE CASE
	UPDATE personracetypemap SET
	 activeflag  = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	WHERE   personid IN (SELECT UNNEST (ARRAY[v_personid])::uuid);

	UPDATE personidentifier SET
	 activeflag  = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	WHERE   personid IN (SELECT UNNEST (ARRAY[v_personid])::uuid);

	UPDATE personmaritalstatus SET
	 activeflag  = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	WHERE   personid IN (SELECT UNNEST (ARRAY[v_personid])::uuid);

	UPDATE personspouseaddress SET
	 activeflag  = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	WHERE   personid IN (SELECT UNNEST (ARRAY[v_personid])::uuid);

	UPDATE personphysicalattribute SET
	 activeflag  = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	WHERE   personid IN (SELECT UNNEST (ARRAY[v_personid])::uuid);

	UPDATE personrole SET
	 activeflag  = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	WHERE   personid IN (SELECT UNNEST (ARRAY[v_personid])::uuid);

	UPDATE "alias" SET
	 activeflag  = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	WHERE   personid IN (SELECT UNNEST (ARRAY[v_personid])::uuid);
	-- /*DOUBT*/
	-- UPDATE personauditlog SET
	--  activeflag  = 0
	-- , updatedby = 'EXPUNG'
	-- , updatedon = now()
	-- WHERE   personid::TEXT IN (SELECT UNNEST (ARRAY[v_personid]));

	UPDATE personemployerdetail SET
	 activeflag  = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	WHERE   personid IN (SELECT UNNEST (ARRAY[v_personid])::uuid);

	UPDATE personemployment SET
	 activeflag  = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	WHERE   personid IN (SELECT UNNEST (ARRAY[v_personid])::uuid);

	UPDATE personaddress SET
	 activeflag  = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	WHERE   personid IN (SELECT UNNEST (ARRAY[v_personid])::uuid);

	UPDATE personphonenumber SET
	 activeflag  = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	WHERE   personid IN (SELECT UNNEST (ARRAY[v_personid])::uuid);

	UPDATE personemail SET
	 activeflag  = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	WHERE   personid IN (SELECT UNNEST (ARRAY[v_personid])::uuid);

	UPDATE emergencycontactperson SET
	 activeflag  = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	WHERE   personid IN (SELECT UNNEST (ARRAY[v_personid])::uuid);

	UPDATE personsupport SET
	 activeflag  = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	WHERE   personid IN (SELECT UNNEST (ARRAY[v_personid])::uuid);

	UPDATE personrepresentativepayee SET
	 activeflag  = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	WHERE   personid IN (SELECT UNNEST (ARRAY[v_personid])::uuid);

	UPDATE personrelation SET
	 activeflag  = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	WHERE   personid IN (SELECT UNNEST (ARRAY[v_personid])::uuid);


	UPDATE tb_cjams_client_participation tb SET
	 action_flag  = 'D'
	, update_ts = now()
	, participation_sw = 'E'
	FROM person p
	WHERE tb.cjams_person_id = p.cjamspid -- OR tb.cis_client_id = p.cisclientid
		AND p.personid IN (SELECT UNNEST (ARRAY[v_personid])::uuid);

	UPDATE tb_cjams_client_participation tb SET
	 action_flag  = 'D'
	, update_ts = now()
	, participation_sw = 'E'
	FROM person p
	WHERE tb.cis_client_id = p.cisclientid -- OR tb.cjams_person_id = p.cjamspid
		AND p.personid IN (SELECT UNNEST (ARRAY[v_personid])::uuid)
		and tb.action_flag <> 'D';

END;

$function$
;