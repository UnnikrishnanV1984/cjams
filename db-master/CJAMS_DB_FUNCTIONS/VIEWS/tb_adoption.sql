-------------------------------------------------------------------------------------
-- Revision(s)
-- 07/19/2022 Vineet Tirodkar - Modifications to add Private Adoptive Child (PVTADPCHILD) role (CDM-23544)
-- 08/05/2022 Vineet Tirodkar - Modifications to remove "Distinct" causing performance issue (CIDM-5304)
-------------------------------------------------------------------------------------
DROP VIEW IF EXISTS cjams.tb_adoption;

CREATE OR REPLACE VIEW cjams.tb_adoption
AS SELECT a.alternateid AS adoption_id,
    NULL::text AS ma_only_payment_cd,
    a.adoptioncasenumber::bigint AS case_id,
    a.adoptioncaseid AS adoption_case_id,
    a.startdate AS subsidy_start_dt,
    a.enddate AS subsidy_end_dt,
    p.cjamspid AS client_id,
    'N'::character varying AS delete_sw,
    a.insertedby AS create_user_id,
    a.insertedon AS create_ts,
    a.updatedby AS update_user_id,
    a.updatedon AS update_ts
FROM adoptioncase a
	JOIN adoptioncaseactor aca ON aca.adoptioncaseid = a.adoptioncaseid 
		AND aca.actortypekey in ('CHILD', 'PVTADPCHILD')
		AND aca.activeflag = 1
	JOIN person p ON p.personid = aca.personid 
		AND p.activeflag = 1
WHERE a.activeflag = 1;
