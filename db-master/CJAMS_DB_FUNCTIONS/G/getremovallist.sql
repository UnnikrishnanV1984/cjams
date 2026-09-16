DROP FUNCTION IF EXISTS getremovallist(uuid, pagenumber bigint, pagesize bigint);
DROP FUNCTION IF EXISTS getremovallist(uuid, pagenumber bigint, pagesize bigint, integer);
DROP FUNCTION IF EXISTS getremovallist(uuid, pagenumber bigint, pagesize bigint, character varying, integer);
DROP FUNCTION IF EXISTS getremovallist(uuid, pagenumber bigint, pagesize bigint, character varying, integer, integer);
DROP FUNCTION IF EXISTS getremovallist(uuid, pagenumber bigint, pagesize bigint, integer, integer);
CREATE OR REPLACE FUNCTION cjams.getremovallist(v_intakeserviceid uuid, pagenumber bigint, pagesize bigint,  
isExpungementSuperUser integer DEFAULT 0,isexpunged integer DEFAULT 0::integer)
 RETURNS json
 LANGUAGE plpgsql
AS $function$   
     
 DECLARE   
   v_pageoffset  int;  
   v_pagenumber  int;  
   l_childremoval json;
   v_isexpunged int;
 BEGIN     
    v_pagenumber  :=  pagenumber-1;
    v_pageoffset  =  v_pagenumber  *  pagesize;

	v_isexpunged = 0;
	IF isExpungementSuperUser= 1 THEN
		v_isexpunged = isexpunged;
	END IF;

    IF v_isexpunged = 1 THEN
    RAISE NOTICE 'BLOCK: FULLY EXPUNGED';

    --------------------------------------------------------------------
    -- FULLY EXPUNGED (encrypted tables only)
    --------------------------------------------------------------------

    SELECT json_agg(e) INTO l_childremoval FROM(     
    SELECT irl.intakeservreqchildremovalid,  
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
         irl.removaldate ::timestamp without time zone,  
         irl.removaltime, 
         irl.exitdate, 
         irl.familystructuretypekey,   
         irl.primarycaregiverid, 
         irl.vpabegindate, 
         irl.vpaparentssigneddate,     
         irl.parent1id,
         irl.parent2id,
         irl.guardianid,
         irl.agencysigneddate,   
         irl.isbothparentssigned,
         irl.reasonableeffortsmade,    
         irl.childfactorsentry,  
         irl.removaltypekey,  
         irl.environmentatremovalkey,   
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
         irl.vpaenddate,   
         irl.vpayouthsigneddate, 
         irl.parent2signeddate,  
         irl.vpaguardiansigneddate,  
         irl.comments,     
         irl.specifiedrelativedatechildlastlivedwith,    
         irl.specifiedrelativename,    
         irl.parent2comments,    
         irl.returndate,   
         irl.returntime,
         irl.childphysicalremovaladdress,
         irl.ischildphysicalremovaladdressverified,
         irl.isuploadedmanually,
         irl.isshelterauthcompleted,     
         irl.ischildaddressasprimaryaddress,
         irl.volrelinquishment,
         irl.removalid,
         irl.showcontactpage,
         p.personid, 
         case when isra.servicecaseid is null then
            (select 'CPS-' || coalesce(ins.actiontype, '') || ' ' || ins.servicerequestnumber
                    from expunge.intakeservicerequest_expunge ins 
                where ins.intakeserviceid = isra.intakeserviceid 
             )	
             else (sc.servicecasenumber) 
         end,
         (
             SELECT  rv.description 
             FROM referencevalues rv 
             WHERE rv.ref_key = irl.removaltypekey AND rv.activeflag=1 order by irl.insertedon desc limit 1
         ) AS removaltypekeydescription,
         (
             SELECT rs.typedescription FROM routing r 
             INNER JOIN routingstatustype rs ON rs.sequencenumber = r.routingstatustypeid and rs.activeflag =1
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
            SELECT json_agg(er) from (SELECT   
            irr.removalreasontypekey,  
            rt.description 
            FROM Intakeservreqchildremovalreason irr  
            INNER JOIN removalreasontype rt  ON irr.removalreasontypekey = rt.removalreasontypekey AND rt.activeflag =1 
            WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'CGFE' and irr.activeflag = 1  
            AND irr.activeflag =1)er
         ) :: json As caregiverreason, 
         (
            SELECT json_agg(er) from (SELECT   
            irr.removalreasontypekey,  
            rt.description 
            FROM Intakeservreqchildremovalreason irr  
            INNER JOIN referencevalues rt  ON irr.removalreasontypekey = rt.ref_key AND rt.activeflag =1 and rt.referencetypeid = 70
            WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'RNME' and irr.activeflag = 1 
            AND irr.activeflag =1)er
         ) :: json As notmakingefforts,
         (
            SELECT json_agg(er) from (SELECT   
            irr.removalreasontypekey,  
            rt.description 
            FROM Intakeservreqchildremovalreason irr  
            INNER JOIN referencevalues rt  ON irr.removalreasontypekey = rt.ref_key AND rt.activeflag =1 and rt.referencetypeid = 68
            WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'ECR' and irr.activeflag = 1   
            AND irr.activeflag =1)er
         ) :: json As exitreason 
         
        FROM Intakeservreqchildremoval irl   
        INNER JOIN expunge.intakeservicerequestactor_expunge isra ON isra.intakeservicerequestactorid =irl.intakeservicerequestactorid  AND isra.activeflag =1
        left join servicecase sc on sc.servicecaseid = 	isra.servicecaseid
        join person p on p.personid = isra.personid
        WHERE p.personid in (
            select distinct p.personid from expunge.intakeservicerequestactor_expunge ina
            join person p on p.personid = ina.personid
            where ina.intakeserviceid  = v_intakeserviceid 
            and ina.intakeservicerequestpersontypekey in  ('CHILD','OTHERCHILD','AV' )
        )
       and irl.activeflag =1
       LIMIT  pagesize  OFFSET  v_pageoffset 
     )e ;

    ELSIF v_isexpunged = 2 THEN
    RAISE NOTICE 'BLOCK: PARTIALLY EXPUNGED';

    --------------------------------------------------------------------
    -- PARTIALLY EXPUNGED (UNION normal + encr)
    --------------------------------------------------------------------

    SELECT json_agg(e) INTO l_childremoval FROM(     
    SELECT irl.intakeservreqchildremovalid,  
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
         irl.removaldate ::timestamp without time zone,  
         irl.removaltime, 
         irl.exitdate, 
         irl.familystructuretypekey,   
         irl.primarycaregiverid, 
         irl.vpabegindate, 
         irl.vpaparentssigneddate,     
         irl.parent1id,
         irl.parent2id,
         irl.guardianid,
         irl.agencysigneddate,   
         irl.isbothparentssigned,
         irl.reasonableeffortsmade,    
         irl.childfactorsentry,  
         irl.removaltypekey,  
         irl.environmentatremovalkey,   
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
         irl.vpaenddate,   
         irl.vpayouthsigneddate, 
         irl.parent2signeddate,  
         irl.vpaguardiansigneddate,  
         irl.comments,     
         irl.specifiedrelativedatechildlastlivedwith,    
         irl.specifiedrelativename,    
         irl.parent2comments,    
         irl.returndate,   
         irl.returntime,
         irl.childphysicalremovaladdress,
         irl.ischildphysicalremovaladdressverified,
         irl.isuploadedmanually,
         irl.isshelterauthcompleted,     
         irl.ischildaddressasprimaryaddress,
         irl.volrelinquishment,
         irl.removalid,
         irl.showcontactpage,
         p.personid, 
         case when isra.servicecaseid is null then
            (select 'CPS-' || coalesce(ins.actiontype, '') || ' ' || ins.servicerequestnumber
                    from (
                            SELECT intakeserviceid, actiontype, servicerequestnumber
                            FROM intakeservicerequest
                            WHERE activeflag = 1
                            UNION ALL
                            SELECT intakeserviceid, actiontype, servicerequestnumber
                            FROM expunge.intakeservicerequest_expunge
                            WHERE activeflag = 1
                         ) ins 
                where ins.intakeserviceid = isra.intakeserviceid 
             )	
             else (sc.servicecasenumber) 
         end,
         (
             SELECT  rv.description 
             FROM referencevalues rv 
             WHERE rv.ref_key = irl.removaltypekey AND rv.activeflag=1 order by irl.insertedon desc limit 1
         ) AS removaltypekeydescription,
         (
             SELECT rs.typedescription FROM routing r 
             INNER JOIN routingstatustype rs ON rs.sequencenumber = r.routingstatustypeid and rs.activeflag =1
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
            SELECT json_agg(er) from (SELECT   
            irr.removalreasontypekey,  
            rt.description 
            FROM Intakeservreqchildremovalreason irr  
            INNER JOIN removalreasontype rt  ON irr.removalreasontypekey = rt.removalreasontypekey AND rt.activeflag =1 
            WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'CGFE' and irr.activeflag = 1  
            AND irr.activeflag =1)er
         ) :: json As caregiverreason, 
         (
            SELECT json_agg(er) from (SELECT   
            irr.removalreasontypekey,  
            rt.description 
            FROM Intakeservreqchildremovalreason irr  
            INNER JOIN referencevalues rt  ON irr.removalreasontypekey = rt.ref_key AND rt.activeflag =1 and rt.referencetypeid = 70
            WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'RNME' and irr.activeflag = 1 
            AND irr.activeflag =1)er
         ) :: json As notmakingefforts,
         (
            SELECT json_agg(er) from (SELECT   
            irr.removalreasontypekey,  
            rt.description 
            FROM Intakeservreqchildremovalreason irr  
            INNER JOIN referencevalues rt  ON irr.removalreasontypekey = rt.ref_key AND rt.activeflag =1 and rt.referencetypeid = 68
            WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'ECR' and irr.activeflag = 1   
            AND irr.activeflag =1)er
         ) :: json As exitreason 
         
        FROM Intakeservreqchildremoval irl   
        INNER JOIN (
                        SELECT intakeservicerequestactorid, intakeserviceid, servicecaseid, personid
                        FROM intakeservicerequestactor
                        WHERE activeflag = 1
                        UNION ALL
                        SELECT intakeservicerequestactorid, intakeserviceid, servicecaseid,
                               personid
                        FROM expunge.intakeservicerequestactor_expunge
                        WHERE activeflag = 1
                    ) isra ON isra.intakeservicerequestactorid =irl.intakeservicerequestactorid
        left join servicecase sc on sc.servicecaseid = 	isra.servicecaseid
        join person p on p.personid = isra.personid
        WHERE p.personid in (
            select distinct p.personid from (
                    SELECT intakeservicerequestactorid, intakeserviceid, intakeservicerequestpersontypekey, personid
                    FROM intakeservicerequestactor
                    WHERE activeflag = 1
                    UNION ALL
                    SELECT intakeservicerequestactorid, intakeserviceid, intakeservicerequestpersontypekey,
                           personid
                    FROM expunge.intakeservicerequestactor_expunge
                    WHERE activeflag = 1
            ) ina
            join person p on p.personid = ina.personid 
            where ina.intakeserviceid  = v_intakeserviceid 
            and ina.intakeservicerequestpersontypekey in  ('CHILD','OTHERCHILD','AV' )
        )
       and irl.activeflag =1
       LIMIT  pagesize  OFFSET  v_pageoffset 
     )e ;

    ELSE
    RAISE NOTICE 'BLOCK: NORMAL';

SELECT json_agg(e) INTO l_childremoval FROM(     
SELECT irl.intakeservreqchildremovalid,  
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
     irl.removaldate ::timestamp without time zone,  
     irl.removaltime, 
     irl.exitdate, 
     irl.familystructuretypekey,   
     irl.primarycaregiverid, 
     irl.vpabegindate, 
     irl.vpaparentssigneddate,     
     irl.parent1id,
     irl.parent2id,
     irl.guardianid,
     irl.agencysigneddate,   
     irl.isbothparentssigned,
     irl.reasonableeffortsmade,    
     irl.childfactorsentry,  
     irl.removaltypekey,  
	 irl.environmentatremovalkey,   
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
     irl.vpaenddate,   
     irl.vpayouthsigneddate, 
     irl.parent2signeddate,  
     irl.vpaguardiansigneddate,  
     irl.comments,     
     irl.specifiedrelativedatechildlastlivedwith,    
     irl.specifiedrelativename,    
     irl.parent2comments,    
     irl.returndate,   
     irl.returntime,
     irl.childphysicalremovaladdress,
	 irl.ischildphysicalremovaladdressverified,
	 irl.isuploadedmanually,
     irl.isshelterauthcompleted,     
     irl.ischildaddressasprimaryaddress,
     irl.volrelinquishment,
     irl.removalid,
	 irl.showcontactpage,
     p.personid, 
	 case when isra.servicecaseid is null then
		(select 'CPS-' || coalesce(ins.actiontype, '') || ' ' || ins.servicerequestnumber 
				from intakeservicerequest ins 
			where ins.intakeserviceid = isra.intakeserviceid 
		 )	
		 else (sc.servicecasenumber) 
	 end,
	 (
		 SELECT  rv.description 
		 FROM referencevalues rv 
		 WHERE rv.ref_key = irl.removaltypekey AND rv.activeflag=1 order by irl.insertedon desc limit 1
	 ) AS removaltypekeydescription,
     (
		 SELECT rs.typedescription FROM routing r 
		 INNER JOIN routingstatustype rs ON rs.sequencenumber = r.routingstatustypeid and rs.activeflag =1
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
		SELECT json_agg(er) from (SELECT   
		irr.removalreasontypekey,  
		rt.description 
		FROM Intakeservreqchildremovalreason irr  
		INNER JOIN removalreasontype rt  ON irr.removalreasontypekey = rt.removalreasontypekey AND rt.activeflag =1 
		WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'CGFE' and irr.activeflag = 1  
		AND irr.activeflag =1)er
	 ) :: json As caregiverreason, 
     (
		SELECT json_agg(er) from (SELECT   
		irr.removalreasontypekey,  
		rt.description 
		FROM Intakeservreqchildremovalreason irr  
		INNER JOIN referencevalues rt  ON irr.removalreasontypekey = rt.ref_key AND rt.activeflag =1 and rt.referencetypeid = 70
		WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'RNME' and irr.activeflag = 1 
		AND irr.activeflag =1)er
	 ) :: json As notmakingefforts,
     (
		SELECT json_agg(er) from (SELECT   
		irr.removalreasontypekey,  
		rt.description 
		FROM Intakeservreqchildremovalreason irr  
		INNER JOIN referencevalues rt  ON irr.removalreasontypekey = rt.ref_key AND rt.activeflag =1 and rt.referencetypeid = 68
		WHERE irr.intakeservreqchildremovalid = irl.intakeservreqchildremovalid and irr.inputtypekey = 'ECR' and irr.activeflag = 1   
		AND irr.activeflag =1)er
	 ) :: json As exitreason 
	 
	FROM Intakeservreqchildremoval irl   
	INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid =irl.intakeservicerequestactorid  AND isra.activeflag =1
	left JOIN intakeservicerequest inr on inr.intakeserviceid = isra.intakeserviceid
	left join servicecase sc on sc.servicecaseid = 	isra.servicecaseid
	--join actor a on a.actorid = isra.actorid and a.activeflag=1
	join person p on p.personid = isra.personid
	WHERE p.personid in (
		select distinct p.personid from intakeservicerequestactor ina
		--join actor a on a.actorid = ina.actorid and a.activeflag=1
		join person p on p.personid = ina.personid 
		where ina.intakeserviceid  = v_intakeserviceid 
		and ina.intakeservicerequestpersontypekey in  ('CHILD','OTHERCHILD','AV' )
	)
   and irl.activeflag =1
   LIMIT  pagesize  OFFSET  v_pageoffset 
 )e ;

    END IF;

    RETURN l_childremoval;
 END;
     
 $function$;