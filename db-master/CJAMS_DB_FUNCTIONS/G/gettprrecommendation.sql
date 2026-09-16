CREATE OR REPLACE FUNCTION cjams.gettprrecommendation(v_servicecaseid uuid, v_permanencyplanid uuid)
 RETURNS TABLE(tprrecommendationid character varying, isrecommended boolean, remarks character varying, reasontypekey character varying, tprlist json, courtorder json)
 LANGUAGE plpgsql
AS $function$                                                                                                                                                                                                                                              
 DECLARE                                                                                                                                                                               
	v_servicerequestnumber character varying;                             
	ischildincare int;iscourtorder int;                                  
	iscourthearing int;ispetition int;                                   
	isadoption int;                                                      
	v_tprrecommendation int;                                             
	items RECORD;                                                        
	v_intakeservicerequestactorid uuid;  
	v_placementenddate character varying; 
	v_current_placement record;
	v_totaldays integer;
	v_temptotaldays integer;
	v_count integer;
	v_tpr json;

 BEGIN                                                               
 DROP TABLE IF EXISTS sp_create_temp_tprchecklist;                                                                                                                                                                               
 CREATE TEMP TABLE sp_create_temp_tprchecklist(tprrecommendationid  character varying,
	 isrecommended boolean,                                                                                                                             
	 remarks text,                                                                                                                                      
	 reasontypekey character varying,                                                                                                                   
	 checklistid uuid,                                                                                                                                  
	 checklistname character varying,                                                                                                                   
	 description character varying,                                                                                                                     
	 checklisttypekey character varying,                                                                                                                
	 isvalidated int,
	 insertedon timestamp without time zone);                                                                                                                                  
 SELECT COUNT(*) INTO v_tprrecommendation FROM tprrecommendation tp   
         WHERE tp.servicecaseid= v_servicecaseid AND  tp.permanencyplanid  = v_permanencyplanid ;                                                                                                                                                   
 RAISE NOTICE 'v_tprrecommendation>>%', v_tprrecommendation;
 RAISE NOTICE '%', v_servicecaseid;
 RAISE NOTICE '%', v_permanencyplanid;
 
	IF(v_tprrecommendation >= 1) THEN
		 RAISE  NOTICE  ' IF v_tprrecommendation >>>>>>>>>>>  %',v_tprrecommendation;
		 INSERT INTO sp_create_temp_tprchecklist(checklistid,checklistname,description,checklisttypekey,isvalidated)    
			SELECT cl.checklistid,cl.checklistname,cl.description,cl.checklisttypekey,tprc.isselected
			FROM tprrecommendation tpr                                           
			INNER JOIN tprrecommendationchecklist tprc ON tprc.tprrecommendationid =tpr.tprrecommendationid AND tprc.activeflag =1
			INNER JOIN   checklist cl  ON   tprc.checklistid=cl.checklistid and cl.activeflag =1 AND cl.checklisttypekey='TPRC'
			WHERE tpr.activeflag=1 AND tpr.servicecaseid=v_servicecaseid
			AND tpr.permanencyplanid  = v_permanencyplanid;                                                         
		RETURN QUERY                                                              
		 SELECT tpr.tprrecommendationid::  character varying ,tpr.isrecommended,tpr.remarks,tpr.reasontypekey,
		 (SELECT ((
				SELECT json_agg(t) FROM(
					SELECT 	tpr.tprrecommendationid, tpr.isrecommended, cl.checklisttypekey checklisttypekey,tprc.isselected isvalidated,
							cl.checklistid,cl.checklistname,cl.description                                                                                                                                        
					FROM 	tprrecommendationchecklist tprc 
							INNER JOIN  checklist cl  ON   tprc.checklistid=cl.checklistid and cl.activeflag =1 AND cl.checklisttypekey='TPRC'                                                                                                                
					WHERE 	tprc.tprrecommendationid = tpr.tprrecommendationid AND tprc.activeflag =1 
							AND tpr.activeflag=1 AND tpr.servicecaseid=v_servicecaseid 
							AND tpr.permanencyplanid  = v_permanencyplanid
				) AS t                                                                                                                                                            
			 )):: json tprlist),
			 
		 (SELECT ((            
				SELECT json_agg(d) FROM(
					SELECT isrp.petitionid,isrp.petitiontypekey,pt.description as petitiondesc,isrch.courtcasenumber, isrch.hearingtypekey, isrch.hearingtype ,ht.description as hearingtypedesc, isrch.hearingdatetime,isrch.hearingstatustypekey, hst.description as hearingstatustypedesc,isrco.hearingoutcometypekey,rfv.value_text  hearingoutcometypedesc, ( p.firstname || ' '||p.lastname):: character varying clientname
					FROM 	intakeservreqcourtorder isrco 
						INNER JOIN intakeservreqcourtorderdetails cod ON cod.intakeservreqcourtorderid = isrco.intakeservreqcourtorderid
						INNER JOIN intakeservicerequestcourthearing isrch ON isrch.servicecaseid = isrco.servicecaseid AND isrch.hearingstatustypekey='CONCULD' AND isrch.activeflag=1  
						INNER JOIN intakeservicerequestpetition isrp ON isrco.intakeservicerequestpetitionid=isrp.intakeservicerequestpetitionid AND isrco.activeflag=1 
						LEFT JOIN petitiontype pt ON pt.petitiontypekey =isrp.petitiontypekey AND pt.activeflag=1    
						LEFT JOIN hearingtype ht ON (ht.hearingtypekey = isrch.hearingtypekey OR isrch.hearingtype ? ht.hearingtypekey) AND ht.activeflag=1 
						LEFT JOIN hearingstatustype hst ON hst.hearingstatustypekey = isrch.hearingstatustypekey AND hst.activeflag=1
						LEFT  JOIN referencevalues rfv on rfv.ref_key = isrco.hearingoutcometypekey and rfv.activeflag =1 and rfv.referencetypeid = 32
						LEFT JOIN intakeservicerequestpetitionactor isrpa ON isrpa.intakeservicerequestpetitionid=isrp.intakeservicerequestpetitionid AND isrpa.activeflag=1
						AND isrpa.petitionactortype='CA'                                
						LEFT JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid=isrpa.intakeservicerequestactorid AND isra.activeflag=1                                                                                       
						LEFT JOIN person p ON p.personid=isra.personid AND p.activeflag=1      
					WHERE isrco.activeflag=1 AND isrco.servicecaseid = v_servicecaseid
					LIMIT 1                                                           
				) AS d        
			 )):: json courtorder)                                                
		 FROM tprrecommendation tpr         
		 WHERE tpr.activeflag=1 AND tpr.servicecaseid=v_servicecaseid AND tpr.permanencyplanid  = v_permanencyplanid         
		 GROUP BY tpr.tprrecommendationid,tpr.isrecommended,tpr.remarks,tpr.reasontypekey
		order by tpr.insertedon desc limit 1 ;                                                               
	ELSE    
		RAISE  NOTICE  ' ELSE v_tprrecommendation >>>>>>>>>>>  %',v_tprrecommendation;
		INSERT INTO sp_create_temp_tprchecklist( checklistid,checklistname,description,checklisttypekey,isvalidated,insertedon)
			SELECT  cl.checklistid,cl.checklistname,cl.description,cl.checklisttypekey,0,now()
			FROM checklist cl WHERE cl.checklisttypekey='TPRC' AND activeflag=1;                                                          
		SELECT intakeservicerequestactorid INTO v_intakeservicerequestactorid FROM permanencyplan WHERE permanencyplanid = v_permanencyplanid; 
		SELECT	count(*) into v_count                              
		FROM	permanencyplan pp 
				INNER JOIN placement pl ON pl.intakeservicerequestactorid = pp.intakeservicerequestactorid			  
		WHERE 	pp.permanencyplanid = v_permanencyplanid  ;                                                                                                                                                         
		v_totaldays:=0;

		RAISE  NOTICE  '  v_count  initial  %',v_count;  
		RAISE  NOTICE  '  v_totaldays  initial  %',v_totaldays;  

		if v_count >= 1 then 	-- check more than 1 placement
		
			FOR v_current_placement IN SELECT * FROM	permanencyplan pp 
				INNER JOIN placement pl ON pl.intakeservicerequestactorid = pp.intakeservicerequestactorid	
				inner join routing r on pl.placementid  :: character varying = r.objectid and r.routingstatustypeid in (15,16) and r.activeflag=1   and r.toroleid in ('CWCW','CWSP')
				WHERE 	pp.permanencyplanid = v_permanencyplanid and  (pl.isvoided=0 or pl.isvoided is null)
			loop
				select 
					case when v_current_placement.enddatetime  is not null 
						and date(v_current_placement.enddatetime) <  date(now())-   interval '1' day * 660  
					then 0  
					else  
						case when  v_current_placement.enddatetime is not null then  
							date(v_current_placement.enddatetime)  -  date( case when date(v_current_placement.startdatetime) <= date(now()) -   interval '1' day * 660  
										then  date(now()) -   interval '1' day * 660 
										else date(v_current_placement.startdatetime) end )
						else 
							date(now())  - date(v_current_placement.startdatetime)  
					  end 
				  end as totaldays
				  into v_temptotaldays;
				
				RAISE  NOTICE  '  v_totaldays  final if%',v_totaldays;  
				  v_totaldays:=v_temptotaldays + v_totaldays;
		 
			END LOOP;

			if (v_totaldays  >= 450 ) then 
				RAISE  NOTICE  '  v_totaldays  final if %',v_totaldays;  
				ischildincare:=1;
			else
				RAISE  NOTICE  '  v_totaldays  final else %',v_totaldays;  
				ischildincare:=0;
			end if;
			RAISE  NOTICE  '  v_totaldays  final %',v_totaldays;  
		
		else -- check for 1 placement
			SELECT	CASE WHEN date(now()) - interval '15 month' >= pl.startdatetime THEN 1 ELSE 0 END  INTO ischildincare
			FROM	permanencyplan pp 
					INNER JOIN placement pl ON pl.intakeservicerequestactorid = pp.intakeservicerequestactorid
					INNER JOIN routing rg ON rg.objectid=pl.placementid :: character varying AND rg.routingstatustypeid =16 AND rg.activeflag=1  
			WHERE 	pp.permanencyplanid = v_permanencyplanid
					AND pl.activeflag=1 AND altproviderid IS NOT NULL AND pl.enddatetime IS null and pl.placementtypekey != 'LA' order by pl.insertedon desc limit 1 ;
				SELECT	pl.enddatetime into v_placementenddate                                                                                                                 
			FROM	permanencyplan pp 
					INNER JOIN placement pl ON pl.intakeservicerequestactorid = pp.intakeservicerequestactorid
					INNER JOIN routing rg ON rg.objectid=pl.placementid :: character varying AND rg.routingstatustypeid =16 AND rg.activeflag=1  
			WHERE 	pp.permanencyplanid = v_permanencyplanid
					AND pl.activeflag=1 AND altproviderid IS NOT NULL  and pl.placementtypekey != 'LA' order by pl.insertedon desc limit 1 ;
				
			if(v_placementenddate is not null)
			then
			SELECT	CASE WHEN date(pl.startdatetime) + interval '15 month' <= date(pl.enddatetime) THEN 1 ELSE 0 END INTO ischildincare                          
			FROM	permanencyplan pp 
				INNER JOIN placement pl ON pl.intakeservicerequestactorid = pp.intakeservicerequestactorid
				INNER JOIN routing rg ON rg.objectid=pl.placementid :: character varying AND rg.routingstatustypeid =16 AND rg.activeflag=1  and rg.tosecurityusersid is not null
			WHERE 	pp.permanencyplanid = v_permanencyplanid
					AND pl.activeflag=1 AND altproviderid IS NOT NULL  and pl.placementtypekey != 'LA' order by pl.insertedon desc limit 1 ;   
			end if;
 	end if ;

	RAISE  NOTICE  ' L:160 ischildincare  >>>>>>>>>> %',ischildincare;  
    if( ischildincare  = 0) then
		RAISE  NOTICE  '  ischildincare >>>>> loop >>>>> %',ischildincare;  
		SELECT json_agg(t)into v_tpr FROM(SELECT * FROM sp_create_temp_tprchecklist order by insertedon desc) AS t ;
		RAISE  NOTICE  '  v_tpr loop v_tpr %',v_tpr;  
		select 
		CASE   
			WHEN count(1) > 0         
			THEN 1 ELSE 0 END INTO ischildincare   
		from intakeservreqcourtorder insc
			join intakeservreqcourtorderdetails inscd on insc.intakeservreqcourtorderid = inscd.intakeservreqcourtorderid
			where insc.servicecaseid = v_servicecaseid 
			and insc.intakeservicerequestactorid in (select pp.intakeservicerequestactorid from permanencyplan pp where pp.permanencyplanid = v_permanencyplanid)
			and inscd.checklistid = '031f190c-57c6-4bfb-aa94-db2ab6f72345' :: uuid and inscd.isselected = 1 and inscd.activeflag =1 ;
	end if;
	
    --Petition
     SELECT 1 INTO ispetition                          
     FROM intakeservicerequestpetition isrp
     INNER JOIN intakeservicerequestpetitionactor isrpa ON isrpa.intakeservicerequestpetitionid=isrp.intakeservicerequestpetitionid     
         AND isrpa.activeflag=1 AND isrpa.petitionactortype='PA'  
     INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = isrpa.intakeservicerequestactorid AND
        isra.personid = (
        SELECT personid FROM intakeservicerequestactor tempisra WHERE intakeservicerequestactorid = v_intakeservicerequestactorid)
     WHERE isrp.activeflag=1 AND isrp.servicecaseid=v_servicecaseid
     and petitiontypekey = 'GAPTPR'  ORDER BY 1 DESC LIMIT 1;  
	 
	 --Court Hearing
	 SELECT 1
	 --CASE COALESCE( COALESCE(LOWER(isrch.hearingtypekey), isrch.hearingtype::TEXT) ,'') WHEN '' THEN 0 ELSE 1 END
     INTO iscourthearing
	 FROM intakeservicerequestcourthearing isrch
     LEFT JOIN
         (SELECT isco.intakeservicerequestpetitionid,isco.intakeservicerequesthearingid,isrcho.hearingoutcometypekey,isrpa1.intakeservicerequestactorid
         FROM intakeservreqcourtorder isco
         INNER JOIN (SELECT * FROM intakeservreqcohearingoutcome WHERE hearingoutcometypekey ='TPRGRA' AND activeflag =1 LIMIT 1 ) isrcho ON isco.intakeservreqcourtorderid=isrcho.intakeservreqcourtorderid AND isrcho.activeflag=1                
         INNER JOIN intakeservicerequestpetitionactor isrpa1 ON isrpa1.intakeservicerequestpetitionid=isco.intakeservicerequestpetitionid
         AND isrpa1.intakeservicerequestactorid=v_intakeservicerequestactorid
         AND isrpa1.activeflag=1
         WHERE  isco.activeflag=1
         )isrco ON isrco.intakeservicerequesthearingid=isrch.intakeservicerequestcourthearingid
	 WHERE 
		LOWER(isrch.hearingstatustypekey)='conculd' AND isrch.activeflag=1 
		AND (isrch.hearingtypekey in ('TGC','TGU') OR isrch.hearingtype ? 'TGC' OR isrch.hearingtype ? 'TGU')
		AND isrch.activeflag=1 AND isrch.servicecaseid=v_servicecaseid;

	 --Court Order
	 SELECT CASE COALESCE(LOWER(isco.hearingoutcometypekey),'') WHEN '' THEN 0 ELSE 1 END
     INTO iscourtorder
	 FROM intakeservreqcourtorder isco
	 INNER JOIN (SELECT * FROM intakeservreqcohearingoutcome WHERE hearingoutcometypekey ='TPRGRA' AND activeflag =1 LIMIT 1 ) isrcho ON isco.intakeservreqcourtorderid=isrcho.intakeservreqcourtorderid AND isrcho.activeflag=1                
	 INNER JOIN intakeservicerequestpetitionactor isrpa1 ON isrpa1.intakeservicerequestpetitionid=isco.intakeservicerequestpetitionid
         AND isrpa1.intakeservicerequestactorid=v_intakeservicerequestactorid
         AND isrpa1.activeflag=1
	 INNER JOIN intakeservicerequestcourthearing isrch ON isco.intakeservicerequesthearingid=isrch.intakeservicerequestcourthearingid
	 WHERE  isco.activeflag=1;
	 
	 SELECT 1 into isadoption  FROM permanencyplan pp WHERE pp.servicecaseid=v_servicecaseid AND pp.activeflag=1 AND pp.primarypermanencytype in ('ADOPTNR','ADOPTR');                                                         
	RAISE  NOTICE  ' L:199 ischildincare >>>>>>>>>>>> %',ischildincare;                                                                   
     UPDATE sp_create_temp_tprchecklist SET isvalidated=COALESCE(ischildincare,0)     
         WHERE lower(checklistname)='childplacement';                                                          
     UPDATE sp_create_temp_tprchecklist SET isvalidated=COALESCE(iscourtorder,0)         
         WHERE LOWER(checklistname)='courtorder';                                                           
     UPDATE sp_create_temp_tprchecklist SET isvalidated=COALESCE(iscourthearing,0)     
         WHERE LOWER(checklistname)='courthearing';                                                        
     UPDATE sp_create_temp_tprchecklist SET isvalidated=COALESCE(ispetition,0)
         WHERE LOWER(checklistname)='petition';                                                             
     UPDATE sp_create_temp_tprchecklist SET isvalidated=COALESCE(isadoption,0)    
         WHERE LOWER(checklistname)='permanancyplan';  

	 SELECT json_agg(t)into v_tpr FROM(SELECT * FROM sp_create_temp_tprchecklist order by insertedon desc) AS t ;
	RAISE  NOTICE  ' L:211 >>> v_tpr loop11 v_tpr %',v_tpr;          

	RETURN      QUERY                                                
	 SELECT                                                                   
     null :: character varying,null :: boolean ,null :: character varying,null :: character varying,  
    --  tpr.tprrecommendationid::  character varying ,tpr.isrecommended,tpr.remarks,tpr.reasontypekey,
     (SELECT (( SELECT json_agg(t) FROM(SELECT * FROM sp_create_temp_tprchecklist order by insertedon desc) AS t     
         )):: json tprlist),                                                       
	 (SELECT ((                                                                                                                                                                 
			SELECT json_agg(d) FROM(                                                                                                                                                                    
			SELECT                                                
			isrp.petitionid,isrp.petitiontypekey,pt.description as petitiondesc,isrch.courtcasenumber, isrch.hearingtypekey, isrch.hearingtype, ht.description as hearingtypedesc,                        isrch.hearingdatetime,isrch.hearingstatustypekey,
			hst.description as hearingstatustypedesc,isrco.hearingoutcometypekey,rfv.value_text  hearingoutcometypedesc,                                                                                                               
			( p.firstname || ' '||p.lastname):: character varying clientname 
			FROM 	intakeservreqcourtorder isrco 
			INNER JOIN intakeservreqcourtorderdetails cod ON cod.intakeservreqcourtorderid = isrco.intakeservreqcourtorderid
			INNER JOIN intakeservicerequestcourthearing isrch ON isrch.servicecaseid = isrco.servicecaseid AND isrch.hearingstatustypekey='CONCULD' AND isrch.activeflag=1  
			INNER JOIN intakeservicerequestpetition isrp ON isrco.intakeservicerequestpetitionid=isrp.intakeservicerequestpetitionid AND isrco.activeflag=1 
			LEFT JOIN petitiontype pt ON pt.petitiontypekey =isrp.petitiontypekey AND pt.activeflag=1    
			LEFT JOIN hearingtype ht ON (ht.hearingtypekey = isrch.hearingtypekey OR isrch.hearingtype ? ht.hearingtypekey) AND ht.activeflag=1                      
			LEFT JOIN hearingstatustype hst ON hst.hearingstatustypekey = isrch.hearingstatustypekey AND hst.activeflag=1
			LEFT  JOIN referencevalues rfv on rfv.ref_key = isrco.hearingoutcometypekey and rfv.activeflag =1 and rfv.referencetypeid = 32
			LEFT JOIN intakeservicerequestpetitionactor isrpa ON isrpa.intakeservicerequestpetitionid=isrp.intakeservicerequestpetitionid AND isrpa.activeflag=1
			AND isrpa.petitionactortype='CA'
			LEFT JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid=isrpa.intakeservicerequestactorid AND isra.activeflag=1
			LEFT JOIN person p ON p.personid=isra.personid AND p.activeflag=1      
			WHERE isrco.activeflag=1 AND isrco.servicecaseid = v_servicecaseid 
			LIMIT 1) AS d                                         
         )):: json courtorder);
	DROP TABLE IF EXISTS sp_create_temp_tprchecklist;                                                                  
	END IF;                                                                  
 END;                                                                 
 $function$
;

