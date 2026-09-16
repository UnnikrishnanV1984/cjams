DROP FUNCTION if exists cjams.getcontactnotespdf(v_entitytype character varying, v_entitytypeid character varying, searchjson json);

CREATE OR REPLACE FUNCTION cjams.getcontactnotespdf(v_entitytype character varying, v_entitytypeid character varying, searchjson json)
 RETURNS TABLE(casenumber character varying, casetype character varying, contactnotes json)
 LANGUAGE plpgsql
AS $function$
----------------------------------------------------------------------------------------
--Revisions
--6/17/2026 - Vinesh - CDM-44840 - Unable to download contacts when applying filter conditions
----------------------------------------------------------------------------------------

DECLARE 
v_RecordingStatusType  character varying(50);
v_DateFrom TIMESTAMP;
v_DateTo TIMESTAMP;
v_Draft BOOLEAN;                        
v_ContactFrom TIMESTAMP;                        
v_ContactTo TIMESTAMP;   
v_progressnotereasontypekey  character varying; 
v_caseworkername character varying;
v_note character varying;
v_progresstype character varying;
v_progresssubtype character varying;
v_actor jsonb; -- FIXED: Changed variable type from text to jsonb to prevent serialization crashes
v_progressnoteInsertedby character varying;
v_progressnoteid character varying;
v_uuidornot character varying(50);
v_sortby character varying;
v_sortdir character varying;
BEGIN
                                              
v_progressnoteid      := searchjson ->>'progressnoteid';
v_Draft               := (searchjson ->>'draft')::boolean; -- FIXED: Added explicit casting to boolean                                   
v_DateFrom            := searchjson ->>'datefrom';                                                                                              
v_DateTo              := searchjson ->>'dateto';                       
v_ContactFrom         := searchjson ->>'contactdatefrom';                                                                                               
v_ContactTo           := searchjson ->>'contactdateto';                                                                                     
v_RecordingStatusType := searchjson ->>'type';  
v_progressnotereasontypekey := searchjson ->>'progressnotereasontypekey';
v_caseworkername := searchjson ->>'workerName';
v_note := searchjson ->>'note';
v_progresstype := searchjson ->> 'recordingtype';
v_progresssubtype := searchjson ->> 'recordingsubtype';
v_actor := searchjson -> 'intakeservicerequestactorids'; -- FIXED: Extracted cleanly into native jsonb
v_progressnoteInsertedby := searchjson ->> 'insertedby';
v_sortby := searchjson ->> 'sortBy';
v_sortdir := searchjson ->> 'sortDir';

raise notice 'v_actor %',v_actor;
raise notice 'v_sortby %',v_sortby;
SELECT * into v_uuidornot from uuid_or_null(v_entitytypeid);
/*Get adoption case */
IF EXISTS (SELECT * FROM adoptioncase WHERE adoptioncaseid :: character varying =v_entitytypeid) THEN
RETURN QUERY 
	SELECT * FROM getadoptioncasecontactnotespdf(v_entitytype, v_entitytypeid, searchjson);
ELSE

RETURN query SELECT     v_entitytypeid AS casenumber, 
             v_entitytype   AS casetype, 
             json_agg(row_to_json( 
             ( 
                    SELECT r 
                    FROM   ( 
                                  SELECT pn.contactdate, 
                                         pn.insertedon, 
                                         pn.starttime, 
                                         pn.endtime, 
                                         pn.initiationindicator, 
                                         pn.attemptindicator, 
                                         pn.contactstatus,
                                         pn.traveltime, 
                                         pn.otherpersonname,
                                         pn.focusperson, 
                                         pn.progressnotereasontypekey,
                                         pn.description,
                                        -- (SELECT pns.description FROM progressnotesubtype pns  where pns.progressnotesubtypeid = pn.progressnotesubtypeid) as description,
                                        -- (select description from ProgressNoteType where ProgressNoteTypeId= pn.ProgressNoteTypeId) as recordingtype,
                                              pn.entitytype,
                                          case  pn.entitytype
											 when 'intakeservicerequest' then 'CPS'
											 when 'servicecase' then 'Service Case'
											 when 'adoption' then 'Adoption Case'
											 when 'intake' then 'Intake'
										 end as entitytypesource,
                                          CASE 
                                                WHEN ( 
                                                              pnt.progressnoteclassificationtypekey = 'System') THEN 'System'
                                                ELSE COALESCE(up.displayname, '') 
                                         END AS enteredby, 
                                         CASE 
                                                WHEN ( 
                                                              pnt.progressnoteclassificationtypekey = 'System') THEN '' 
                                                ELSE COALESCE(te.teamname, '') 
                                         END    AS teamname, 
                                         'user' AS USER, 
                                         --COALESCE((SELECT pnrt.typedescription FROM progressnotereasontype pnrt WHERE pnrt.progressnotereasontypekey=pn.progressnotereasontypekey AND pnrt.activeflag=1), '') AS contactpurpose,
                                         ( 
                                                SELECT Array_agg(pnrt.typedescription) 
                                                FROM   progressnotereasontype pnrt 
                                                WHERE  pnrt.progressnotereasontypekey= ANY(String_to_array(pn.progressnotereasontypekey, ','))
                                                AND    pnrt.activeflag=1)   AS contactpurpose, 
                                         pnt.description::character VARYING AS contacttype, 
                                         COALESCE( 
                                                    ( 
                                                    SELECT pns.description 
                                                    FROM   progressnotesubtype AS pns 
                                                    WHERE  pns.progressnotesubtypeid=pn.progressnotesubtypeid), '') AS contactlocation,
                                         ( 
                                                SELECT json_agg(actor) 
                                                FROM   ( 
                                                                 SELECT    cp.contactparticipantid, 
                                                                           cp.participanttypekey, 
                                                                           cp.intakeservicerequestactorid, 
                                                                           cp.address1, 
                                                                           cp.address2, 
                                                                           cp.city, 
                                                                           cp.state, 
                                                                           cp.zipcode, 
                                                                           cp.email, 
                                                                           cp.phonenumber, 
                                                                           isra.personid, 
                                                                           CASE 
                                                                                     WHEN p.prefx IS NULL THEN col.prefixtypekey
                                                                                     ELSE COALESCE(p.prefx, '') 
                                                                           END AS prefx, 
                                                                           CASE 
                                                                                     WHEN p.firstname IS NULL THEN col.firstname
                                                                                     ELSE COALESCE(p.firstname, '') 
                                                                           END AS firstname, 
                                                                           CASE 
                                                                                     WHEN p.middlename IS NULL THEN col.middlename
                                                                                     ELSE COALESCE(p.middlename, '') 
                                                                           END AS middlename, 
                                                                           CASE 
                                                                                     WHEN p.lastname IS NULL THEN col.lastname
                                                                                     ELSE COALESCE(p.lastname, '') 
                                                                           END AS lastname, 
                                                                           CASE 
                                                                                     WHEN p.suffix IS NULL THEN col.suffixtypekey
                                                                                     ELSE COALESCE(p.suffix, '') 
                                                                           END AS suffix, 
                                                                           isra.actorid, 
                                                                           at.actortype, 
                                                                           at.typedescription 
                                                                 FROM      contactparticipant cp 
                                                                 LEFT JOIN intakeservicerequestactor isra 
                                                                 ON        isra.intakeservicerequestactorid=cp.intakeservicerequestactorid
                                                                 AND       isra.activeflag=1 
                                                                 LEFT JOIN person p 
                                                                 ON        p.personid = isra.personid 
                                                                 AND       p.activeflag=1 
                                                                 LEFT JOIN collateral col 
                                                                 ON        col.collateralid = cp.participantid
                                                                 AND       col.activeflag=1 
                                                                 LEFT JOIN collateralroleconfig crg
                                                                 ON        col.collateralid = crg.collateralid
                                                                 AND       crg.activeflag = 1
                                                                 LEFT JOIN 
                                                                           ( 
                                                                                           SELECT DISTINCT actortype, 
                                                                                                           typedescription 
                                                                                           FROM            actortype) at 
                                                                 ON        at.actortype = isra.intakeservicerequestpersontypekey
                                                                             OR at.actortype = crg.actortypekey	
                                                                 WHERE     cp.progressnoteid = pn.progressnoteid 
                                                                 AND       cp.activeflag = 1)actor ) :: jsonb AS personcontact,
                                         CASE 
                                                WHEN ( 
                                                              pnt.progressnoteclassificationtypekey = 'System') THEN 0::boolean
                                                ELSE COALESCE(pn.savemode,0::boolean) 
                                         END AS draft, 
                                         ( 
                                                SELECT json_agg(detailnote) 
                                                FROM   ( 
                                                                SELECT   upf.displayname, 
                                                                         pnd.insertedon, 
                                                                         pnd.description, 
																		 pnd.isaddendum,
                                                                         pntin.progressnotetypekey 
                                                                FROM     progressnotedetail pnd 
                                                                left JOIN     userprofile upf 
                                                                ON       pnd.insertedby=upf.securityusersid 
                                                                left JOIN     progressnotetype pntin 
                                                                ON       pntin.progressnotetypeid = pn.progressnotetypeid 
                                                                AND      pntin.activeflag=1 
                                                                WHERE    pnd.progressnoteid = pn.progressnoteid 
                                                                AND      pnd.activeflag=1 
                                                                ORDER BY pnd.insertedon DESC) detailnote ) :: jsonb AS contactnotes) r) )
                                                                order by	
		       	      (CASE v_sortdir
                  	WHEN 'desc'
					THEN
						CASE v_sortby
                            WHEN 'contactdate' then  cast(contactdate as character varying)
                            WHEN 'progressnotereasontypekey' then cast(progressnotereasontypekey as character varying)                            
                            WHEN 'author' then up.displayname
                            --WHEN 'contactpurpose' then  contactpurpose
                            WHEN 'progressnotepurposetypekey' then  cast(pn.description as character varying)
                           -- WHEN 'personcontacted' then  contactnotes->personcontact->>'firstname'
                            WHEN 'recordingsubtype' then   ( 
                                                    SELECT pns.description 
                                                    FROM   progressnotesubtype AS pns 
                                                    WHERE  pns.progressnotesubtypeid=pn.progressnotesubtypeid)
                            WHEN 'recordingtype' then  cast(pnt.description as character varying)

                         
             		 ELSE
                  		 cast(contactdate as character varying)
             		END
                   END) desc,
                   (CASE v_sortdir
                  	WHEN 'asc'
					THEN
						CASE v_sortby
                            WHEN 'contactdate' then  cast(contactdate as character varying)
                            WHEN 'progressnotereasontypekey' then cast(progressnotereasontypekey as character varying)
                            WHEN 'author' then up.displayname
                            --   WHEN 'contactpurpose' then  contactpurpose
                            WHEN 'progressnotepurposetypekey' then  cast(pn.description as character varying)
                        --    WHEN 'personcontacted' then  contactnotes->personcontact->>'firstname'
                            WHEN 'recordingsubtype' then   ( 
                                                    SELECT pns.description 
                                                    FROM   progressnotesubtype AS pns 
                                                    WHERE  pns.progressnotesubtypeid=pn.progressnotesubtypeid)
                            WHEN 'recordingtype' then  cast(pnt.description as character varying)

             		 ELSE
                  		 cast(contactdate as character varying)
             		END
                   END) asc,
                   (case WHEN v_sortby is null                  
                  	
					then
					
					cast(contactdate as character varying)
						
                   END) desc
                                                                )
  FROM       progressnote pn 
  LEFT JOIN progressnotetype AS pnt 
  ON         pnt.progressnotetypeid = pn.progressnotetypeid 
  AND        pnt.activeflag=1 
  LEFT JOIN userprofile up 
  ON         pn.insertedby=up.securityusersid 
  -- AND        up.activeflag=1 
  LEFT JOIN  teammemberassignment tma 
  ON         tma.securityusersid=up.securityusersid 
  AND        tma.activeflag=1 
  LEFT JOIN  teammember tm 
  ON         tm.teammemberid=tma.teammemberid 
  AND        tm.activeflag=1 
  LEFT JOIN  team te 
  ON         te.teamid=tm.teamid 
  AND        te.activeflag=1 
  WHERE      pn.activeflag=1 

              -- AND pn.entitytypeid IN ( v_entitytypeid :: character VARYING, 
              --                    ( 
              --                                    SELECT  intakeserviceid:: character VARYING 
              --                                    FROM            intakeservicerequest 
              --                                    WHERE           servicecaseid :: character varying =v_entitytypeid
              --                                    AND             activeflag =1 limit 1), 
              --                    (SELECT DISTINCT servicecaseid:: character varying FROM intakeservicerequestactor 
		--                      WHERE (servicecaseid =v_entitytypeid::uuid OR intakeserviceid =v_entitytypeid::uuid ) and servicecaseid is not null LIMIT 1),                               
              --                    ( 
              --                                    SELECT  intakenumber:: character VARYING 
              --                                    FROM            intakeservicerequestactor 
              --                                    WHERE           ( 
              --                                                                    servicecaseid :: character varying= v_entitytypeid
              --                                                    OR              intakeserviceid :: character varying= v_entitytypeid ) 
              --                                    AND             activeflag =1 limit 1)
              --                                    -- cotact notes from connected CPS case can show up in service case, but cannot happen vice versa
              --                                    )
	AND (PN.EntityTypeId 
		in ( v_entitytypeid :: character varying) 
		OR 
		(CASE WHEN v_uuidornot IS NULL 
                      THEN null 
                      ELSE 
                      PN.EntityTypeId in 
                      (
                            (SELECT intakeserviceid:: character varying FROM intakeservicerequest isr
                                   WHERE servicecaseid =v_entitytypeid::uuid AND activeflag =1 and intakeserviceid is not null order by isr.updatedon desc LIMIT 1),                                      
                            (SELECT DISTINCT intakenumber:: character varying FROM intakeservicerequest
                                   WHERE (servicecaseid =v_entitytypeid::uuid OR intakeserviceid =v_entitytypeid::uuid ) and intakenumber is not null LIMIT 1)
                                                                       
                      ) 
		END )
       )               
       AND (v_DateFrom IS NULL OR (CAST( PN.insertedon AS DATE) between CAST(v_DateFrom AS DATE) AND CAST(v_DateTo AS DATE)))                                                        
       AND (v_ContactFrom IS NULL OR (CAST( PN.ContactDate AS DATE) between CAST(v_ContactFrom AS DATE) AND CAST(v_ContactTo AS DATE)))	                                                            
       AND (v_Draft IS NULL OR PN.SaveMode = v_Draft )  
       AND (v_caseworkername  IS NULL OR lower(UP.DisplayName) LIKE '%'|| lower(v_caseworkername) || '%' ) 
       AND (v_note  IS NULL OR lower(PN.description) LIKE '%'|| lower(v_note) || '%' ) 
       
       -- FIXED: Fully functional array overlap checker (handles multiple CSV data entries correctly)
       AND (v_progressnotereasontypekey IS NULL OR string_to_array(PN.Progressnotereasontypekey, ',') && string_to_array(v_progressnotereasontypekey, ',') )
       
       AND (lower(v_RecordingStatusType) IS NULL OR lower(COALESCE(PNT.ProgressNoteClassificationTypeKey,'User')) = lower(v_RecordingStatusType))
       AND (v_progresssubtype IS NULL OR PN.progressnotesubtypeid:: character varying = v_progresssubtype )
       AND (v_progresstype IS NULL OR PNT.progressnotetypeid:: character varying = v_progresstype )
       and (v_progressnoteInsertedby IS NULL OR PN.insertedby:: character varying = v_progressnoteInsertedby OR PN.updatedby:: character varying = v_progressnoteInsertedby)
       and (v_progressnoteid IS NULL OR PN.progressnoteid:: character varying = v_progressnoteid)
       
       -- FIXED: Clean check evaluating elements using native cross-array comparisons without serialization failure risk
       and (v_actor IS NULL OR jsonb_array_length(v_actor) = 0 OR PN.progressnoteid in 
              (SELECT cp.progressnoteid
              FROM contactparticipant cp
              WHERE cp.progressnoteid = PN.progressnoteid AND cp.activeflag = 1 AND cp.intakeservicerequestactorid :: character varying = ANY
              (SELECT jsonb_array_elements_text(v_actor))));					
		        		        
END IF; 
END;

$function$
;