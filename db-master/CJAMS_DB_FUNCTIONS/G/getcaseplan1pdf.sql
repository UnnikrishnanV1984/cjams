DROP FUNCTION IF EXISTS cjams.getcaseplan1pdf(uuid, uuid);

CREATE OR REPLACE FUNCTION cjams.getcaseplan1pdf(
	v_caseid uuid,
	v_caseplan1id uuid)
    RETURNS json
   LANGUAGE plpgsql
AS $function$

DECLARE resultdata json;
BEGIN
	
	SELECT json_agg(a) INTO resultdata FROM (
			SELECT  cp1.personid,
					concat(p.firstname,' ',p.lastname) childname,
					p.prefx, p.firstname,p.middlename,p.lastname, p.suffix,
					p.cjamspid,
					coalesce((select pii.personidentifiervalue from personidentifier pii where pii.personidentifiertypekey = 'IRN' and pii.personid = p.personid and pii.activeflag = 1 limit 1), p.cisclientid) as cisclientid,
					(SELECT value_text FROM referencevalues WHERE referencetypeid = 301 AND ref_key = p.gendertypekey limit 1) gender,
					(SELECT value_text FROM referencevalues WHERE referencetypeid = 159 AND ref_key = p.religiontypekey limit 1) religion,
					(SELECT value_text FROM referencevalues WHERE referencetypeid = 171 AND ref_key = 
								(select racetypekey from personracetypemap pr 
								where pr.personid = p.personid and pr.activeflag = 1 limit 1)) racetype,
					p.ssnno,
					p.dob::date,
					(select cast(p.firstname ||' '||COALESCE(p.middlename, '')|| ' '|| p.lastname as character varying) from person p where p.personid = (select a.person1id from actorrelationship a where a.person2id = cp1.personid 
					and a.relationshiptypekey = 'BGFTHR' limit 1)) as fathername,
					(select cast(p.firstname ||' '||COALESCE(p.middlename, '')|| ' '|| p.lastname as character varying) from person p where p.personid = (select a.person1id from actorrelationship a where a.person2id = cp1.personid 
					and a.relationshiptypekey = 'BGMTHR' limit 1)) as mothername,
					cp1.placement,
					cp1.familyhistory,
					cp1.childdesc,
					icr.removaldate,
					icr.removaladd1 addressatremoval,
					cui.hospitalname,cui.cityname,cui.statetypekey,
					(select updatedon from assessment a where a.assessmentid = cp1.safetyassessmentid) safetydate,
					(select updatedon from assessment a where a.assessmentid = cp1.riskassessmentid) riskdate,
					(SELECT json_agg(t) reasonableeffortsremoval FROM 
						(SELECT ref_key, value_text
						FROM referencevalues 
						WHERE referencetypeid = 69
						AND ref_key in 
							(select removalreasontypekey
							from intakeservreqchildremovalreason icrr
							where icrr.intakeservreqchildremovalid = icr.intakeservreqchildremovalid) ) t)
			FROM 	caseplan1 cp1
			INNER JOIN  person p 
				on p.personid = cp1.personid 
				and p.activeflag = 1
			INNER JOIN intakeservreqchildremoval icr
				on icr.servicecaseid = cp1.caseid
				and icr.personid = p.personid
				and icr.activeflag = 1
			LEFT JOIN clientunder5yearsinfo cui 
				on cui.personid = p.personid
				and cui.activeflag=1
			WHERE cp1.caseplan1id = v_caseplan1id
				and cp1.activeflag=1
		)a;
RETURN resultdata;
					
end;
$function$;

 