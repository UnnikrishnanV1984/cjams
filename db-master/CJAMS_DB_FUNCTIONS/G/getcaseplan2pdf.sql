DROP FUNCTION IF EXISTS cjams.getcaseplan2pdf(uuid, uuid);

CREATE OR REPLACE FUNCTION cjams.getcaseplan2pdf(v_caseid uuid, v_caseplan2id uuid)
 RETURNS json
 LANGUAGE plpgsql
AS $function$

DECLARE resultdata json;
BEGIN
SELECT json_agg(cp2) INTO 	resultdata	  FROM (
		SELECT (SELECT  json_agg(r) childsection FROM   
								(SELECT  p.personid,
										concat(p.firstname,' ',p.lastname) childname,
										p.cjamspid,
										coalesce((select pii.personidentifiervalue from personidentifier pii where pii.personidentifiertypekey = 'IRN' and pii.personid = p.personid and pii.activeflag = 1 limit 1), p.cisclientid) as cisclientid,
										(SELECT typedescription FROM racetype WHERE racetypekey = p.racetypekey limit 1) racetype,
										(SELECT typedescription FROM gendertype WHERE gendertypekey = p.gendertypekey limit 1) gender,
										(SELECT typedescription FROM religiontype WHERE religiontypekey = p.religiontypekey limit 1) religion,
										p.ssnno,
										 to_char(p.dob ,'MM/dd/yyyy') dob,
										(select servicecasenumber from servicecase where servicecaseid = cp2.caseid limit 1)
										from person p
										where  p.personid = cp2.personid and p.activeflag = 1)r
								)
						, (SELECT json_agg(t) cp23bservices FROM (
								SELECT	 CASE healthpassportflag WHEN 1 THEN TRUE ELSE FALSE END ishealthpassport
										, CASE daycareflag WHEN 1 THEN true ELSE false END isdaycare
										, CASE transportflag WHEN 1 THEN true ELSE false END istransport
										, CASE financesupportflag WHEN 1 THEN true ELSE false END isfinancesupport
										, CASE specialtrainingflag WHEN 1 THEN true ELSE false END isspecialtraining
										, CASE reimbexpenseflag WHEN 1 THEN true ELSE false END isreimbursement
										, CASE emotionalguideflag WHEN 1 THEN true ELSE false END isemotionalguide
										, CASE respitecareflag WHEN 1 THEN true ELSE false END isrespitecare
										, CASE otherflag WHEN 1 THEN true ELSE false END isother
										, COALESCE(othertx,'') othertxt
										, CASE childneedsdate WHEN NULL THEN false ELSE true END ischildneed
										, CASE visitationdiscussdate WHEN NULL THEN  false ELSE true END isvisitation
								FROM 	caseplan2providerservices cps WHERE cps.caseplan2id = v_caseplan2id
								--cp2.caseplan2id
										AND cps.activeflag = 1 )t
		
							)
						,(SELECT json_agg(t) cp2placement FROM 
							(SELECT  CASE p.placementtypekey WHEN 'PRPL' THEN 'Provider' ELSE 'Living Arrangement' END  placementtype
									,  to_char(p.startdatetime,'MM/dd/yyyy')   startdate
									,  to_char(p.enddatetime,'MM/dd/yyyy') enddate
									, (SELECT value_text FROM livingarrangement la INNER JOIN referencevalues lat ON lat.ref_key = la.livingarrangementtypekey AND lat.activeflag = 1 AND lat.referencetypeid = 76
									   WHERE la.placementid = p.placementid  AND la.activeflag = 1 LIMIT 1 ) livingarrangementtype
									,  CASE p.placementtypekey WHEN 'PRPL' THEN 
																	(SELECT   COALESCE(tpa.adr_street_nm,'') || COALESCE(', ' || tpa.adr_city_nm,'') || COALESCE(', ' || tpa.adr_state_cd,'') --|| COALESCE(' - ' || tpa.adr_zip5_no,'') 
																	 FROM tb_provider_addresses tpa WHERE tpa.parent_key_id::CHARACTER VARYING = p.altproviderid::CHARACTER VARYING 
																	 AND tpa.delete_sw ='N' LIMIT 1)
															   ELSE (SELECT COALESCE(streetname,'') || COALESCE(', ' || cityname,'')||COALESCE(', ' || statetypekey,'') --||COALESCE(' - ' || zip5no,'') 
																	FROM livingarrangement l WHERE l.placementid = p.placementid LIMIT 1)
										END placementaddress
									,  to_char(cr.removaldate  ,'MM/dd/yyyy')  removaldate
									, (SELECT   string_agg(rt.description,', ')
										FROM 	intakeservreqchildremovalreason crc  
												INNER JOIN removalreasontype rt ON rt.removalreasontypekey = crc.removalreasontypekey AND rt.activeflag = 1
										WHERE crc.activeflag = 1   AND crc.intakeservreqchildremovalid = cr.intakeservreqchildremovalid
									 )removalreason
							FROM 	caseplansummary cs
									--INNER JOIN caseplan2 cp2 ON cp2.caseplan2id = cs.caseplan2id  AND cp2.activeflag = 1 
									INNER JOIN intakeservreqchildremoval cr ON cr.removalid = cs.removalid  AND cr.activeflag = 1 AND cr.servicecaseid = cp2.caseid 
									INNER JOIN placement p ON  p.intakeservreqchildremovalid =cr.intakeservreqchildremovalid  AND p.activeflag = 1 AND p.servicecaseid = cp2.caseid 
											   AND p.personid = cp2.personid
							WHERE cs.activeflag = 1 AND cs.caseplan2id = v_caseplan2id)t
						 )
						,(SELECT json_agg(t) cp2assessment FROM 
							(SELECT 	ast.titleheadertext  assessmentname 
										,  to_char(a.updatedon,'MM/dd/yyyy') assessmentdate
									, '' outcome
							FROM 	assessment as a
									INNER JOIN assessmenttemplate ast ON ast.assessmenttemplateid = a.assessmenttemplateid AND ast.activeflag = 1
							WHERE a.servicecaseid =cp2.caseid AND a.personid = cp2.personid AND cp2.activeflag  = 1 )t
						 )
						 ,(SELECT json_agg(t) cp2cwsrvpl FROM 
							(SELECT 	CASE treatmentflag WHEN 1 THEN 'Yes' ELSE 'No' END cwsrvpl4_1
										,  to_char(treatmentdate,'MM/dd/yyyy') cwsrvpl4_2
										,  to_char(lasttreatmentdate ,'MM/dd/yyyy')cwsrvpl4_3
										, ordermandates cwsrvpl7
										, orderfollowup cwsrvpl8
										, servicestrengths cwsrvpl10
										, servicestrengths cwsrvpl10_1
										, placementfinalize cwsrvpl11
										, appropriatecare cwsrvpl14
										, needaddress cwsrvpl15
										, efforts cwsrvpl16
										, lifebook cwsrvpl17
										, to_char(lastprogressrptdate ,'MM/dd/yyyy') cwsrvpl5
										, placementdiscusstx cwsrvpl6
										, caregiveradjustmenttx cwsrvpl3
										, CASE hmrelcloseproxflag WHEN 1 THEN true ELSE false END cwsrvpl2_1
										, hmrelcloseproxtx cwsrvpl2_1 
										, parentrelationshiptx  cwsrvpl18
										, visitplanaccomtx cwsrvpl19
										, parentinteractiontx cwsrvpl20
										, parentoutcometx cwsrvpl21
										, serviceneedtx cwsrvpl22
										, '' cwsrvpl23
										, flexiblefundspurposetx cwsrvpl24_1
										, flexiblefundsamountno cwsrvpl24_2
										, parentsinvolvementtx 	
								FROM	caseplan2 cp
										LEFT JOIN caseplan2parentservices cp2ps ON cp2ps.caseplan2id = cp.caseplan2id  AND cp2ps.activeflag = 1  
										LEFT JOIN caseplan2placementservices cpps ON cpps.old_id = cp.old_id AND cpps.activeflag = 1  
										LEFT JOIN caseplan2childservice CP2C ON CP2C.old_id = cp.old_id AND CP2C.activeflag = 1  
								WHERE 	cp.caseplan2id =v_caseplan2id
										AND cp.activeflag = 1  
						 
									) t
						  ) 
						 ,(SELECT json_agg(t) childedu FROM 
							(SELECT 	closeproximity
										, cjams.f_plvalue(ieptypekey,415) schooltype
										, educationalsetting currentedusetting   
										, schoolenroll   schoolname
										, COALESCE(specialprogram,'') specialprogram
										, COALESCE(reportcard,'') reportcard
										,  to_char(iepdate,'MM/dd/yyyy') iepdate
										,  cjams.f_plvalue(ieptypekey,1541) ieptype
										, CASE agelevelflag WHEN 1 THEN 'Yes' ELSE 'No' END agelevelflag
										, CASE behaviorprobflag WHEN 1 THEN true ELSE false END behaviorprobflag
										, CASE peerprobflag WHEN 1 THEN true ELSE false END peerprobflag
										, COALESCE (strengthneed,'') strengthneed 
										, COALESCE (schooladjust,'') schooladjust 
										, COALESCE (extracurricular,'') extracurricular 
										, COALESCE (ep.comments,'') prgcomments 
								FROM	caseplan2edutrnprogram ep
										LEFT JOIN caseplan2education ps ON ps.old_id = ep.old_id  AND ps.activeflag = 1
								WHERE 	ep.caseplan2id = cp2.caseplan2id AND ep.activeflag = 1 ) t
						  )
	FROM 	caseplan2 cp2
	WHERE cp2.caseplan2id  = v_caseplan2id

					)cp2;
RETURN resultdata;
					
end;
$function$
;
