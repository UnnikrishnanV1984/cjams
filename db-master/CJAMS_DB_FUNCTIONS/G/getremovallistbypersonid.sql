DROP FUNCTION IF EXISTS cjams.getremovallistbypersonid(v_personid uuid);
DROP FUNCTION IF EXISTS cjams.getremovallistbypersonid(v_personid uuid,  v_cjamspid  character varying);
CREATE OR REPLACE FUNCTION cjams.getremovallistbypersonid(v_personid uuid,  v_cjamspid  character varying DEFAULT NULL)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
	
DECLARE 

-------------------------------------
-- CDM-23453 Duplicate Removal Issue fix - Veera 07-01-2022
-- CDM-4165 - Veera Nadimpalli - To Append CPS in service case number
-- CIDM-9872---Umasankar Raavi -- Added removalcircumstances value
-- CIDM-11061 - Veera - Person Search issue fix - 02/03/2026
------------------------------------
	

jsondata  json;
BEGIN

    IF v_personid IS NULL AND v_cjamspid IS NOT NULL THEN
        SELECT p.personid
          INTO v_personid
        FROM cjams.person p
        WHERE p.cjamspid =  v_cjamspid::bigint
        LIMIT 1;
    END IF;

    IF v_personid IS NULL THEN
        RETURN '[]'::json;
    END IF;

SELECT JSON_AGG(TT) INTO jsonData FROM 			
(
	SELECT 
		(
			SELECT 
			rs.typedescription 
			FROM routing r 
			INNER JOIN routingstatustype rs ON rs.sequencenumber = r.routingstatustypeid AND rs.activeflag =1
			WHERE r.objectid = irl.intakeservreqchildremovalid :: character varying AND r.activeflag =1 order by r.insertedon desc limit 1
		) AS approvalstatus, 
		case when irl.servicecaseid is null then  irl.intakeserviceid else irl.servicecaseid end, 
		case when irl.servicecaseid is null then
			(select 'CPS-' || coalesce(ins.actiontype, '') || ' ' ||  ins.servicerequestnumber 
					from intakeservicerequest ins 
				where ins.intakeserviceid = irl.intakeserviceid 
			 )	
			 else (SELECT servicecasenumber from servicecase sc where sc.servicecaseid = isra.servicecaseid) 
		  end,
		(
			SELECT  
			rv.description 
			FROM referencevalues rv
			WHERE rv.referencetypeid =53 AND rv.ref_key = irl.removaltypekey AND rv.activeflag=1 
		) AS removaltypekeydescription, 
		irl.removaldate,
		irl.removalexitreason,
		(SELECT json_agg(er) FROM (
			SELECT                                                                                                                                       
			irr.removalreasontypekey,                                                                                                              
			rt.description                                                                                                                         
			FROM Intakeservreqchildremovalreason irr                                                                                                        
			INNER JOIN removalreasontype rt  ON irr.removalreasontypekey = rt.removalreasontypekey AND rt.activeflag =1                                     
			WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'CHFE' and irr.activeflag = 1                    
			AND irr.activeflag =1
		) er) :: json As removalreason,
		(
			select exists (
				select 1
				from bintifamilyfindings b
				where b.cjamspid = coalesce(
				case when v_cjamspid ~ '^[0-9]+$' then v_cjamspid::bigint end,
				(select cjamspid::bigint from person where personid = v_personid limit 1)
				)
			)
		) as hasbintisearch,
		irl.removalcircumstances,
		irl.exitdate,
		irl.removalid
	FROM  Intakeservreqchildremoval irl 
	JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid =irl.intakeservicerequestactorid 
	WHERE irl.personid = v_personid and irl.activeflag = 1 
) TT;
	 
RETURN	jsonData;
END;
$function$
;
