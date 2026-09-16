DROP FUNCTION IF EXISTS getservicecaseremovallist(v_objectid uuid, isgroup integer, pagenumber bigint, pagesize bigint);

CREATE OR REPLACE FUNCTION cjams.getservicecaseremovallist(v_objectid uuid, isgroup integer, pagenumber bigint, pagesize bigint)
 RETURNS json
 LANGUAGE plpgsql
AS $function$  

----------------------------------------------------------------
-- 08-03-22 - Veera Nadimpalli
-- CIDM-4165 - Veera Nadimpalli
--01/06/2025 Smitha Somasekharan -Modifications for luggage question update userstory- (CIDM-10008-b-210234)
---------------------------------------------------------------
 
 DECLARE    
 v_pageoffset  int;       
 v_pagenumber  int;       
 l_childremoval json;     
 
 BEGIN      
 v_pagenumber  :=  pagenumber-1;     
 v_pageoffset  =  v_pagenumber  *  pagesize;    
 
 
IF(isgroup=1) THEN    
 
SELECT json_agg(e) INTO l_childremoval FROM(       
SELECT
pr.cjamspid,  
pr.firstname, 
pr.lastname,  
pr.middlename,
pr.userphoto,
pr.suffix,
pr.prefx,
pr.firstname || ' ' || pr.lastname personname, 
pr.dob :: date,
pr.dateofdeath :: date,
pr.isbioadoptedflag,  
CASE  WHEN EXTRACT(YEAR FROM age(now(), pr.dob)) <= 0 THEN 
CASE WHEN EXTRACT(MONTH FROM age(now(), pr.dob)) <= 0 THEN CONCAT (EXTRACT(DAY FROM age(now(), pr.dob)) :: CHARACTER VARYING, ' ', 'Day(s)')
ELSE CONCAT (EXTRACT(MONTH FROM age(now(), pr.dob)) :: CHARACTER VARYING, ' ', 'Month(s)')  
END
ELSE CONCAT (EXTRACT(YEAR FROM age(now(), pr.dob)) :: CHARACTER VARYING,' ', 'Yrs')
END AS age,
(SELECT gr.typedescription from gendertype gr where gr.gendertypekey  = pr.gendertypekey limit 1),      
(
	SELECT JSON_aGG(TT) FROM (     
	SELECT   
	irl.intakeservreqchildremovalid,  
	irl.intakeserviceid,   
	irl.intakeservicerequestactorid,  
	irl.rmvdfrmisractorid, 
	irl.agencytypekey,
	irl.fathername,
	irl.mothername,
	irl.rmvdfrmpersonname, 
	irl.removalreasontypeid,
	irl.removaladd1,       
	irl.removaladd2 ,      
	irl.removalzip,
	irl.removalstatecd,    
	irl.removalcity,       
	irl.removaldate,       
	irl.removaltime,       
	irl.familystructuretypekey,       
	irl.primarycaregiverid,
	irl.vpabegindate,      
	irl.vpaparentssigneddate, 
	irl.agencysigneddate,  
	irl.isbothparentssigned,  
	irl.reasonableeffortsmade,
	irl.childfactorsentry, 
	irl.removaltypekey, 
	irl.environmentatremovalkey, 
	irl.removalid, 
	irl.primarycaregiveractorid,      
	irl.seccaregiveractorid,  
	irl.seccaregiveradd,   
	irl.primarycaregiveradd,  
	irl.isverifiedreporteradd,
	irl.isverifiedcaregiver1add,      
	irl.isverifiedcaregiver2add,      
	irl.relativeactorid,   
	irl.isdisability,      
	irl.servicecaseid,
	irl.removalcircumstances,
	irl.childremovalluggage,
	irl.luggageprovided,
	irl.luggagecomments,
	irl.placementdisposableortrashbag,
	irl.luggageupdatedby,
	irl.luggageupdatedon,
	case when isra.servicecaseid is null then
		(select 'CPS-' || coalesce(ins.actiontype, '') || ' ' || ins.servicerequestnumber 
				from intakeservicerequest ins 
			where ins.intakeserviceid = isra.intakeserviceid 
		 )	
		 else (sc.servicecasenumber) 
	end,	
	irl.vpaenddate,
	irl.vpayouthsigneddate,
	irl.vpaparentssigneddate, 
	irl.parent2signeddate, 
	irl.vpaguardiansigneddate, 
	irl.parent1id,
	irl.parent2id,
	irl.guardianid,
	irl.comments,  
	irl.specifiedrelativedatechildlastlivedwith, 
	irl.specifiedrelativename,
	irl.showcontactpage,
	irl.parent2comments,   
	irl.returndate,
	irl.returntime AS exittime,
	irl.childphysicalremovaladdress,
	irl.ischildphysicalremovaladdressverified,
	irl.isuploadedmanually,
	irl.isshelterauthcompleted,
	irl.ischildaddressasprimaryaddress,
	irl.exitdate,
	irl.removalexitreason,
	irl.transferagency,
	irl.otherpublicagency,
	irl.locationofadoption,
	irl.volrelinquishment,
	(select routingstatustypeid from routing r where objectid = irl.intakeservreqchildremovalid::character varying and activeflag = 1 offset 1 limit 1) previousstatus, 
	(
		SELECT rv.description 
		FROM referencevalues rv
		WHERE rv.referencetypeid =53 AND rv.ref_key = irl.removaltypekey AND rv.activeflag=1 
	) AS removaltypekeydescription,						
	irl.primarycaregiveractorid,	
	(
		SELECT rs.typedescription 
		FROM routing r 
		INNER JOIN routingstatustype rs ON rs.sequencenumber = r.routingstatustypeid AND rs.activeflag =1
		WHERE r.objectid = irl.intakeservreqchildremovalid :: character varying AND r.activeflag =1 order by r.insertedon desc limit 1 
	) AS approvalstatus,										
	(
		SELECT json_agg(er) from (SELECT irr.removalreasontypekey, rt.description
		FROM Intakeservreqchildremovalreason irr     
		INNER JOIN removalreasontype rt  ON irr.removalreasontypekey = rt.removalreasontypekey AND rt.activeflag =1    
		WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'CHFE' and irr.activeflag = 1 
		AND irr.activeflag =1)er
	) :: json As removalreason,     
	(
		SELECT json_agg(er) from (SELECT irr.removalreasontypekey, rt.description, irr.otherdescription
		FROM Intakeservreqchildremovalreason irr
		INNER JOIN referencevalues  rt  ON irr.removalreasontypekey = rt.ref_key AND rt.activeflag =1 and rt.referencetypeid = 69    
		WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'REPCR' and irr.activeflag = 1
		AND irr.activeflag =1)er
	) :: json As reasonableefforts,    
	(
		SELECT json_agg(er) from (SELECT irr.removalreasontypekey, rt.description
		FROM Intakeservreqchildremovalreason irr     
		INNER JOIN removalreasontype rt  ON irr.removalreasontypekey = rt.removalreasontypekey AND rt.activeflag =1    
		WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'CGFE' and irr.activeflag = 1 
		AND irr.activeflag =1)er
	) :: json As caregiverreason,   

	(
		SELECT json_agg(er) from (SELECT irr.removalreasontypekey, rt.description
		FROM Intakeservreqchildremovalreason irr     
		INNER JOIN referencevalues rt  ON irr.removalreasontypekey = rt.ref_key AND rt.activeflag =1 and rt.referencetypeid = 70  
		WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'RNME' and irr.activeflag = 1
		AND irr.activeflag =1)er
	) :: json As notmakingefforts,  
	(
		SELECT json_agg(er) from (SELECT irr.removalreasontypekey, rt.description
		FROM Intakeservreqchildremovalreason irr     
		INNER JOIN referencevalues rt  ON irr.removalreasontypekey = rt.ref_key AND rt.activeflag =1 and rt.referencetypeid = 68  
		WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'ECR' and irr.activeflag = 1  
		AND irr.activeflag =1)er
	) :: json As exitreason, 
	(
		SELECT json_agg(er) from (SELECT *
		FROM intakeservreqchildremoval_history ih 
		WHERE ih.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and "rowtype" = 'REVISION' and ih.activeflag = 1
		order by updatedon desc limit 1) er
	) :: json As revisionrecord
	FROM Intakeservreqchildremoval irl 
	LEFT JOIN servicecase sc on sc.servicecaseid = irl.servicecaseid AND sc.activeflag = 1 
	INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = irl.intakeservicerequestactorid
	WHERE irl.activeflag =1 and irl.servicecaseid =v_objectid and isra.personid = pr.personid 
	) TT 
) AS childremoval,
(
  select exists (
    select 1
    from bintifamilyfindings b
    where b.cjamspid = pr.cjamspid::bigint
  )
) as hasbintisearch,
pr.personid
FROM Intakeservreqchildremoval irl
LEFT JOIN servicecase sc on sc.servicecaseid = irl.servicecaseid  
INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = irl.intakeservicerequestactorid
INNER JOIN person pr on pr.personid = isra.personid and pr.activeflag = 1
WHERE irl.activeflag = 1 
AND pr.personid in (
		select DISTINCT iscr.personid from intakeservicerequestactor  iscr
		where iscr.servicecaseid = v_objectid and iscr.activeflag = 1
		and iscr.intakeservicerequestpersontypekey in ('AV','CHILD','BIOCHILD','OTHERCHILD')
)
GROUP BY pr.personid, pr.cjamspid, pr.firstname || ' ' || pr.lastname,pr.dob, pr.dateofdeath,pr.gendertypekey,pr.firstname,pr.lastname,pr.userphoto,pr.middlename,pr.suffix,pr.prefx
)e ;
RETURN l_childremoval;

ELSE	
     
SELECT json_agg(e) INTO l_childremoval FROM( 

	SELECT   
	irl.intakeservreqchildremovalid,
	irl.intakeserviceid,
	irl.intakeservicerequestactorid,
	irl.rmvdfrmisractorid,
	irl.agencytypekey,
	irl.fathername,
	irl.mothername,	
	irl.rmvdfrmpersonname,
	irl.removalreasontypeid,
	irl.removaladd1,	
	irl.removaladd2,
	irl.removalzip,
	irl.removalstatecd,
	irl.removalcity,
	irl.removaldate,
	irl.removaltime,
	irl.familystructuretypekey,
	irl.primarycaregiverid,
	irl.vpabegindate,
	irl.vpaparentssigneddate,
	irl.agencysigneddate,
	irl.isbothparentssigned,
	irl.reasonableeffortsmade,
	irl.childfactorsentry,
	irl.removaltypekey,
	irl.environmentatremovalkey, 
	irl.removalid,
	irl.primarycaregiveractorid,
	irl.seccaregiveractorid,
	irl.seccaregiveradd,
	irl.primarycaregiveradd,
	irl.isverifiedreporteradd,
	irl.isverifiedcaregiver1add,
	irl.isverifiedcaregiver2add,
	irl.relativeactorid,
	irl.isdisability,
	irl.servicecaseid, 
	irl.removalcircumstances,
	irl.childremovalluggage,
	irl.luggageprovided,
	irl.luggagecomments,
	irl.placementdisposableortrashbag,
	irl.luggageupdatedby,
	irl.luggageupdatedon,
	case when irl.servicecaseid is null then
		(select 'CPS-' || coalesce(ins.actiontype, '') || ' ' || ins.servicerequestnumber 
				from intakeservicerequest ins 
			where ins.intakeserviceid = isra.intakeserviceid 
		 )	
		 else (sc.servicecasenumber) 
	end,
	irl.vpaenddate,
	irl.vpayouthsigneddate,
	irl.vpaparentssigneddate,
	irl.parent2signeddate,
	irl.vpaguardiansigneddate,
	irl.parent1id,
	irl.parent2id,
	irl.guardianid,
	irl.comments,
	irl.specifiedrelativedatechildlastlivedwith,
	irl.specifiedrelativename,
	irl.showcontactpage,
	irl.parent2comments,
	irl.returndate,
	irl.returntime AS exittime,
	irl.childphysicalremovaladdress,
	irl.ischildphysicalremovaladdressverified,
	irl.isuploadedmanually,
	irl.isshelterauthcompleted,
	irl.ischildaddressasprimaryaddress,
	irl.exitdate,
	irl.removalexitreason,
	irl.transferagency,
	irl.otherpublicagency,
	irl.locationofadoption,
	irl.volrelinquishment,
	irl.justification,
	p.personid,
	p.isbioadoptedflag,
	(
		SELECT rv.description 
		FROM referencevalues rv
		WHERE rv.referencetypeid=53 AND rv.ref_key = irl.removaltypekey AND rv.activeflag=1 
	) AS removaltypekeydescription,						
	irl.primarycaregiveractorid,	
	(
		SELECT rs.typedescription 
		FROM routing r 
		INNER JOIN routingstatustype rs ON rs.sequencenumber = r.routingstatustypeid AND rs.activeflag =1
		WHERE r.objectid = irl.intakeservreqchildremovalid :: character varying AND r.activeflag =1 order by r.insertedon desc limit 1
	) AS approvalstatus,										
	(
		SELECT json_agg(er) from (SELECT irr.removalreasontypekey, rt.description
		FROM Intakeservreqchildremovalreason irr     
		INNER JOIN removalreasontype rt  ON irr.removalreasontypekey = rt.removalreasontypekey AND rt.activeflag =1    
		WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'CHFE' and irr.activeflag = 1 
		AND irr.activeflag =1)er
	) :: json As removalreason,     
	(
		SELECT json_agg(er) from (SELECT irr.removalreasontypekey, rt.description, irr.otherdescription
		FROM Intakeservreqchildremovalreason irr
		INNER JOIN referencevalues  rt  ON irr.removalreasontypekey = rt.ref_key AND rt.activeflag =1 and rt.referencetypeid = 69    
		WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'REPCR' and irr.activeflag = 1
		AND irr.activeflag =1)er
	) :: json As reasonableefforts,    
	(
		SELECT json_agg(er) from (SELECT irr.removalreasontypekey, rt.description
		FROM Intakeservreqchildremovalreason irr     
		INNER JOIN removalreasontype rt  ON irr.removalreasontypekey = rt.removalreasontypekey AND rt.activeflag =1    
		WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'CGFE' and irr.activeflag = 1 
		AND irr.activeflag =1)er
	) :: json As caregiverreason,   
	(
		SELECT json_agg(er) from (SELECT irr.removalreasontypekey, rt.description
		FROM Intakeservreqchildremovalreason irr     
		INNER JOIN referencevalues rt  ON irr.removalreasontypekey = rt.ref_key AND rt.activeflag =1 and rt.referencetypeid = 70  
		WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'RNME' and irr.activeflag = 1
		AND irr.activeflag =1)er
	) :: json As notmakingefforts,  
	(
		SELECT json_agg(er) from (SELECT irr.removalreasontypekey, rt.description
		FROM Intakeservreqchildremovalreason irr     
		INNER JOIN referencevalues rt  ON irr.removalreasontypekey = rt.ref_key AND rt.activeflag =1 and rt.referencetypeid = 68  
		WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'ECR' and irr.activeflag = 1  
		AND irr.activeflag =1)er
	) :: json As exitreason , 
	(
		SELECT json_agg(er) from (SELECT *
		FROM intakeservreqchildremoval_history ih 
		WHERE ih.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and "rowtype" = 'REVISION' and ih.activeflag = 1
		order by updatedon desc limit 1) er
	) :: json As revisionrecord,
	(
		select exists (
			select 1
			from bintifamilyfindings b
			where b.cjamspid = p.cjamspid::bigint
		)
	) as hasbintisearch
	FROM Intakeservreqchildremoval irl
	LEFT JOIN servicecase sc on sc.servicecaseid = irl.servicecaseid  
	INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = irl.intakeservicerequestactorid
	INNER JOIN actor a on a.actorid = isra.actorid and a.activeflag = 1
	INNER JOIN person p on p.personid = a.personid and p.activeflag = 1
	WHERE irl.activeflag = 1 
	AND p.personid in (
		select DISTINCT iscr.personid from intakeservicerequestactor  iscr
		where iscr.servicecaseid = v_objectid and iscr.activeflag = 1
		and iscr.intakeservicerequestpersontypekey in ('AV','CHILD','BIOCHILD','OTHERCHILD')
	)

)e ;
RETURN l_childremoval;

END IF;

END;

$function$;