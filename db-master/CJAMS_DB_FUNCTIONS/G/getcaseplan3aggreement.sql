DROP FUNCTION IF EXISTS cjams.getcaseplan3aggreement(v_caseid uuid, v_agreementid uuid);
CREATE OR REPLACE FUNCTION cjams.getcaseplan3aggreement(v_caseid uuid, v_agreementid uuid)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
DECLARE l_aggreement json;
begin
	
	SELECT json_agg(servagg) INTO l_aggreement 
	FROM (
			SELECT  cpa.personid
					, concat(p.firstname,' ',p.lastname) childname
					, p.prefx, p.firstname,p.middlename,p.lastname, p.suffix
					, p.cjamspid
					, coalesce((select pii.personidentifiervalue from personidentifier pii where pii.personidentifiertypekey = 'IRN' and pii.personid = p.personid and pii.activeflag = 1 limit 1), p.cisclientid) as cisclientid
					, (SELECT value_text FROM referencevalues WHERE referencetypeid = 301 AND ref_key = p.gendertypekey limit 1) gender
					, (SELECT value_text FROM referencevalues WHERE referencetypeid = 159 AND ref_key = p.religiontypekey limit 1) religion
					, (SELECT value_text FROM referencevalues WHERE referencetypeid = 171 AND ref_key = 
								(select racetypekey from personracetypemap pr 
								where pr.personid = p.personid and pr.activeflag = 1 limit 1)) racetype
					, p.ssnno
					, to_char(p.dob::timestamp,'MM/dd/yyyy') dob
					, '' fathername
					, '' mothername
					, to_char(begindate::timestamp,'MM/dd/yyyy') begindate
					, to_char(enddate::timestamp,'MM/dd/yyyy') enddate
					, initialplacement
					, continueplacement
					, concurpermplanflag
					, to_char(concurpermplandate::timestamp,'MM/dd/yyyy') concurpermplandate
					, staffheldflag
					, staffhelddate
					, ( SELECT 	json_agg(t) FROM 
							((	SELECT 	
								establisheddate,
								case pp.primarypermanencytype<>'' when true then 1 else 0 end primaryflag,
								0 as secondaryflag,
								(select description from permanencyplantype where permanencyplantypekey = pp.primarypermanencytype limit 1) concplan,
								(select value_tx from tb_picklist_values where picklist_type_id = 147 and picklist_value_cd = pp.primarylegalstatustypekey) permlegalstatus,
								(select description from permanencyplansubtype where permanencyplansubtypekey = pp.primaryarrangetype limit 1) livingarr,
								projecteddate
								FROM 	permanencyplan pp
								WHERE 	pp.servicecaseid = cpa.caseid
								and 	pp.intakeservicerequestactorid = 
											(select isra.intakeservicerequestactorid 
											from intakeservicerequestactor isra
											where isra.personid = p.personid
											and isra.servicecaseid = cpa.caseid
											and isra.isprimary = true
											limit 1)
								and	    case when cpa.enddate is not null then	pp.establisheddate::date <= cpa.enddate::date else pp.establisheddate::date <= cpa.case3plandate::date end
								and		pp.activeflag = 1 
								and     pp.old_id is not null order by pp.establisheddate desc limit 1)
							union
								(SELECT 	
								establisheddate,
								0 as primaryflag,
								case pp.concurrentpermanencytype <>'' when true then 1 else 0 end secondaryflag,
								(select description from permanencyplantype where permanencyplantypekey = pp.concurrentpermanencytype limit 1) concplan,
								(select value_tx from tb_picklist_values where picklist_type_id = 147 and picklist_value_cd = pp.primarylegalstatustypekey) permlegalstatus,
								(select description from permanencyplansubtype where permanencyplansubtypekey = pp.concurrentarrangetype limit 1) livingarr,
								projecteddate
								FROM 	permanencyplan pp
								WHERE 	pp.servicecaseid =  cpa.caseid
								and 	pp.intakeservicerequestactorid = 
											(select isra.intakeservicerequestactorid 
											from intakeservicerequestactor isra
											where isra.personid = p.personid
											and isra.servicecaseid = cpa.caseid
											and isra.isprimary = true
											limit 1)
								and		case when cpa.enddate is not null then	pp.establisheddate::date <= cpa.enddate::date else pp.establisheddate::date <= cpa.case3plandate::date end
								and		pp.activeflag = 1 
								and     pp.old_id is not null order by pp.establisheddate desc limit 1)
								order by establisheddate desc) 
							t) permanencyplan
					, COALESCE( (SELECT 	json_agg(parenttask) 
						FROM (  SELECT 	ct.tasktx 
										, to_char(ct.identifieddate::timestamp,'MM/dd/yyyy') identifieddate
										, to_char(ct.expectedcompletedate::timestamp,'MM/dd/yyyy') expectedcompletedate
								FROM 	caseplan3servagreement c
										INNER JOIN caseplan3tasks ct ON ct.caseplan3id = c.caseplan3servagreementid --AND  ct.activeflag = 1
								WHERE 	ct.responsibilitytypekey IN ('6077','6079')
										AND c.caseid = cpa.caseid AND c.caseplan3servagreementid = v_agreementid
							) parenttask),'[]')::json cp3parenttask
					, COALESCE((SELECT 	json_agg(agencytask) 
						FROM (  SELECT 	ct.tasktx 
										, to_char(ct.identifieddate::timestamp,'MM/dd/yyyy') identifieddate
										, to_char(ct.expectedcompletedate::timestamp,'MM/dd/yyyy') expectedcompletedate
								FROM 	caseplan3servagreement c
										INNER JOIN caseplan3tasks ct ON ct.caseplan3id = c.caseplan3servagreementid-- AND  ct.activeflag = 1
								WHERE 	ct.responsibilitytypekey IN ('6078')
										AND c.caseid = cpa.caseid AND c.caseplan3servagreementid = v_agreementid
							) agencytask),'[]')::json  c3agencytask
					, (SELECT displayname FROM userprofile WHERE securityusersid = 
							(select securityusersid from muser where username = cpa.insertedby limit 1)) completedby
			FROM 	caseplan3servagreement  cpa
					INNER JOIN person p ON p.personid = cpa.personid and p.activeflag = 1
			WHERE 	cpa.caseplan3servagreementid = v_agreementid

		)servagg;
return l_aggreement;
					
end;
$function$;