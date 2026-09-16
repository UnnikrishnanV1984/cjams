DROP FUNCTION IF EXISTS cjams.CW_transactions_dataclenup(character varying,character varying, character varying);

DROP FUNCTION IF EXISTS cjams.CW_transactions_dataclenup(character varying,character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION cjams.CW_transactions_dataclenup(transaction_type character varying,transaction_id character varying, ticketno character varying , personid character varying DEFAULT NULL::character varying, OUT message character varying )

 LANGUAGE plpgsql
AS $function$

------------------------------------------------------------------------
-- SQL Stored Procedure
-- Auhor: Sai Teja Chintha
-- Date : 02/13/2025
-- Description: CIDM-10195-Delete intake, placement or child removal SP to soft delete all active records in respective tables.
-- Date : 06/02/2026 -- CIDM-11464-Delete person from intake, CPS or service SP ,Assessment AND Contact to soft delete all active records in respective tables.


------------------------------------------------------------------------

DECLARE
vu_intakenumber character varying;
vu_placementid uuid;
vu_intakeservreqchildremovalid uuid;
vu_removalid integer;
vu_personid uuid;
vu_actorid uuid;
vu_intakeservicerequestactorid uuid;
vu_servicecaseid uuid;
vu_intakeserviceid uuid;
vu_personroleid uuid;
vu_progressnoteid uuid;
vu_assessmentid uuid;

BEGIN

    IF (transaction_type = 'INTKE') THEN
        vu_intakenumber := transaction_id ; 

                 RAISE NOTICE 'Transaction type is delete intake % ', vu_intakenumber;
  
     ELSE IF (transaction_type ='PLCMT' ) THEN
        vu_placementid := CAST( transaction_id AS UUID);
                        RAISE NOTICE 'Transaction type is delete placement % ', vu_placementid;

      ELSE IF(transaction_type = 'CHLDRMVL') THEN
        vu_intakeservreqchildremovalid := CAST(transaction_id AS UUID);
                            RAISE NOTICE 'Transaction type is delete child removal % ', vu_intakeservreqchildremovalid;
      
      ELSE IF (transaction_type = 'DELETEINTAKEPERSON') THEN
        vu_intakenumber := transaction_id ; 
        vu_personid := CAST(personid AS UUID);

                 RAISE NOTICE 'Transaction type is delete intake person % ', vu_intakenumber;
  
     ELSE IF (transaction_type ='DELETECPSPERSON' ) THEN
        vu_intakeserviceid := CAST( transaction_id AS UUID);
        vu_personid := CAST(personid AS UUID);
        
                        RAISE NOTICE 'Transaction type is delete CPS person % ', vu_intakeserviceid;

      ELSE IF(transaction_type = 'DELETESERVICECASEPERSON') THEN
        vu_servicecaseid := CAST(transaction_id AS UUID);
        vu_personid := CAST(personid AS UUID);

                            RAISE NOTICE 'Transaction type is delete service case person % ', vu_servicecaseid;

      ELSE IF(transaction_type = 'DELETECONTACT') THEN
        vu_progressnoteid := CAST(transaction_id AS UUID);

                            RAISE NOTICE 'Transaction type is delete contact % ', vu_progressnoteid ;
      ELSE IF(transaction_type = 'DELETEASSESSMENT') THEN
        vu_assessmentid := CAST(transaction_id AS UUID);

                            RAISE NOTICE 'Transaction type is delete assessment % ', vu_assessmentid ;

       ELSE
         RAISE NOTICE 'Transaction type is empty or didnt match' ;
          END IF;
        END IF;
       END IF;
      END IF;  
     END IF;
     END IF;
    END IF;
  END IF;  

    IF (vu_intakenumber IS NOT NULL AND transaction_type = 'INTKE') THEN
        UPDATE routing
        SET activeflag = 0, updatedon= now(), updatedby = ticketno
        WHERE objectid = vu_intakenumber :: character varying AND activeflag = 1;

        RAISE NOTICE 'Active records soft deleted from routing table. % ', vu_intakenumber;

        UPDATE intakedastatus
        SET activeflag = 0, updatedon= now(), updatedby = ticketno
        WHERE intakenumber = vu_intakenumber AND activeflag = 1;

        RAISE NOTICE 'Active records soft deleted from intakedastatus table. % ', vu_intakenumber;

        UPDATE intakedastaging
        SET activeflag = 0, updatedon= now(), updatedby = ticketno
        WHERE intakenumber = vu_intakenumber AND activeflag = 1;

        RAISE NOTICE 'Active records soft deleted from intakedastaging table. % ', vu_intakenumber;

        UPDATE intakesnapshot
        SET activeflag = 0, updatedon= now(), updatedby = ticketno
        WHERE intakenumber = vu_intakenumber AND activeflag = 1;

        RAISE NOTICE 'Active records soft deleted from intakesnapshot table. % ', vu_intakenumber;

        UPDATE intakeservicerequest
        SET activeflag = 0, updatedon= now(), updatedby = ticketno
        WHERE intakenumber = vu_intakenumber AND activeflag = 1;

        RAISE NOTICE 'Active records soft deleted from intakeservicerequest table. % ', vu_intakenumber;

        message := 'Success active intakes deleted';

      ELSE IF (transaction_type = 'PLCMT' AND vu_placementid IS NOT NULL) THEN

                    UPDATE cjams.placement
                    SET activeflag = 0, updatedon= now(), updatedby = ticketno
                    WHERE placementid = vu_placementid AND activeflag = 1;

                    RAISE NOTICE 'Active records soft deleted from placement table. % ', vu_placementid;

                    UPDATE cjams.placementrevision
                    SET activeflag = 0, updatedon= now(), updatedby = ticketno
                    WHERE placementid = vu_placementid AND activeflag = 1;

                    RAISE NOTICE 'Active records soft deleted from placementrevision table. % ', vu_placementid;

                    UPDATE cjams.livingarrangement
                    SET activeflag = 0, updatedon= now(), updatedby = ticketno
                    WHERE placementid = vu_placementid AND activeflag = 1;

                    RAISE NOTICE 'Active records soft deleted from livingarrangement table. % ', vu_placementid;

                    UPDATE cjams.routing
                    SET activeflag = 0, updatedon= now(), updatedby = ticketno
                    WHERE objectid = vu_placementid :: character varying AND activeflag = 1;

                    RAISE NOTICE 'Active records soft deleted from routing table. % ', vu_placementid;


                    message := 'Success active placement records deleted';

      ELSE IF(transaction_type = 'CHLDRMVL' AND vu_intakeservreqchildremovalid IS NOT NULL ) THEN
                    SELECT removalid INTO vu_removalid FROM intakeservreqchildremoval WHERE intakeservreqchildremovalid = vu_intakeservreqchildremovalid AND activeflag = 1;

                    UPDATE personprogramarea ppa
                    SET activeflag = 0, updatedon = now(), updatedby = ticketno
                    FROM intakeservreqchildremoval isrcr
                    INNER JOIN person p ON p.personid = isrcr.personid AND p.activeflag = 1
                    WHERE ppa.personid = p.personid 
                          AND isrcr.removaldate :: Date = ppa.startdate :: Date
                          AND (Case when ISRCR.exitdate is null then true else isrcr.exitdate :: Date = ppa.enddate :: Date end)
                          AND ppa.activeflag = 1 
                          AND isrcr.activeflag = 1
                          AND ppa.programkey = 'OOH'
                          AND isrcr.intakeservreqchildremovalid = vu_intakeservreqchildremovalid;

                    RAISE NOTICE 'Active records soft deleted from personprogramarea table. % ', vu_intakeservreqchildremovalid;
        
                    UPDATE cjams.intakeservreqchildremoval
                    SET activeflag = 0, updatedon= now(), updatedby = ticketno
                    WHERE intakeservreqchildremovalid = vu_intakeservreqchildremovalid AND activeflag = 1;

                    RAISE NOTICE 'Active records soft deleted from intakeservreqchildremoval table. % ', vu_intakeservreqchildremovalid;

                    UPDATE cjams.intakeservreqchildremoval_history
                    SET activeflag = 0, updatedon= now(), updatedby = ticketno
                    WHERE intakeservreqchildremovalid = vu_intakeservreqchildremovalid AND activeflag = 1;

                    RAISE NOTICE 'Active records soft deleted from intakeservreqchildremoval_history table. % ', vu_intakeservreqchildremovalid;

                    UPDATE cjams.routing
                    SET activeflag = 0, updatedon= now(), updatedby = ticketno
                    WHERE objectid = vu_intakeservreqchildremovalid :: character varying AND activeflag = 1;

                    RAISE NOTICE 'Active records soft deleted from routing table. % ', vu_intakeservreqchildremovalid;

                    UPDATE tb_client_eligibility
                    SET delete_sw = 'Y',update_ts = now(),update_user_id = ticketno        
                    WHERE removal_id = vu_removalid AND delete_sw = 'N' ;

                    RAISE NOTICE 'Active records soft deleted from tb_client_eligibility table. % ', vu_removalid;

                    message := 'Success active childremoval records deleted';

      ELSE IF(transaction_type  = 'DELETEINTAKEPERSON' AND vu_intakenumber IS NOT NULL) THEN

            UPDATE actor a 
            SET a.intakenumber = NULL, updatedby = ticketno, updatedon = now()
            WHERE a.personid = vu_personid AND a.intakenumber = vu_intakenumber AND  (a.intakeserviceid is not null OR a.servicecaseid is not null ) AND a.activeflag = 1 ;
              RAISE NOTICE 'Active records soft deleted from actor table. % ',vu_personid;
          
            UPDATE intakeservicerequestactor israa
            SET israa.intakenumber = NULL, updatedby = ticketno, updatedon = now()
            WHERE israa.personid = vu_personid AND israa.intakenumber = vu_intakenumber AND  (israa.intakeserviceid is not null OR israa.servicecaseid is not null ) AND israa.activeflag = 1;

                RAISE NOTICE 'Active records soft deleted from intakeservicerequestactor table. % ', vu_personid;

            UPDATE actorrelationship ar
            SET ar.intakenumber = NULL, updatedby = ticketno, updatedon = now()
            WHERE ar.intakenumber = vu_intakenumber AND  (ar.intakeserviceid is not null OR ar.servicecaseid is not null ) AND ar.person1id = vu_personid AND ar.activeflag = 1; 
                RAISE NOTICE 'Active records soft deleted from actorrelationship table. % ',vu_intakenumber;

           UPDATE personroletype prt
           SET prt.intakenumber = NULL, prt.updatedby = ticketno, prt.updatedon = now() 
           WHERE prt.personroleid in (
                select pr.personroleid
                from personrole pr
                WHERE pr.personid = vu_personid AND pr.intakenumber = vu_intakenumber AND  (pr.intakeserviceid is not null OR pr.servicecaseid is not null ) AND pr.activeflag = 1 ) AND  prt.activeflag = 1 ;
            
            UPDATE personrole pr
            SET intakenumber = NULL, updatedby = ticketno, updatedon = now()
            WHERE pr.personid = vu_personid AND pr.intakenumber = vu_intakenumber AND  (pr.intakeserviceid is not null OR pr.servicecaseid is not null ) AND pr.activeflag = 1  ;
                  RAISE NOTICE 'Active records soft deleted from personrole table. % ',vu_personid;
----------------------------------------
            UPDATE actor a 
            SET activeflag = 0, updatedby = ticketno, updatedon = now()
            WHERE a.personid = vu_personid AND  a.intakenumber = vu_intakenumber AND  a.intakeserviceid is null AND a.servicecaseid is null AND a.activeflag = 1 ;
              RAISE NOTICE 'Active records soft deleted from actor table. % ',vu_personid;
          
            UPDATE intakeservicerequestactor israa
            SET activeflag = 0, updatedby = ticketno, updatedon = now()
            WHERE israa.personid = vu_personid AND  israa.intakenumber = vu_intakenumber AND  israa.intakeserviceid is null AND israa.servicecaseid is null AND israa.activeflag = 1 ;
                RAISE NOTICE 'Active records soft deleted from intakeservicerequestactor table. % ', vu_personid;

            UPDATE actorrelationship ar
            SET activeflag = 0, updatedby = ticketno, updatedon = now()
            WHERE ar.intakenumber = vu_intakenumber AND  ar.intakeserviceid is null AND ar.servicecaseid is null AND ar.person1id = vu_personid AND ar.activeflag = 1; 
                RAISE NOTICE 'Active records soft deleted from actorrelationship table. % ',vu_intakenumber;

            UPDATE personroletype prt
            SET prt.activeflag = 0, prt.updatedby = ticketno, prt.updatedon = now() 
            WHERE prt.personroleid in (
                    select pr.personroleid
                    from personrole pr
                    WHERE pr.personid = vu_personid AND  pr.intakenumber = vu_intakenumber AND  pr.intakeserviceid is null AND pr.servicecaseid is null AND pr.activeflag = 1 )AND  prt.activeflag = 1 ;

                RAISE NOTICE 'Active records soft deleted from personroletype table. % ',vu_personid;
            
             UPDATE personrole pr
            SET activeflag = 0, updatedby = ticketno, updatedon = now()
            WHERE pr.personid = vu_personid AND  pr.intakenumber = vu_intakenumber AND  pr.intakeserviceid is null AND pr.servicecaseid is null AND pr.activeflag = 1 ;

                    RAISE NOTICE 'Active records soft deleted from personrole table. % ',vu_personid;
                        
              message := 'All tables are updated related to intake person deletion.'; 
              message := 'Need to delete person from contacts and assessment if any.'; 

      ELSE IF( transaction_type  = 'DELETECPSPERSON' AND vu_intakeserviceid IS NOT NULL) THEN

              UPDATE actor a 
              SET a.intakeserviceid = NULL, updatedby = ticketno, updatedon = now()
              WHERE a.personid = vu_personid AND  a.intakeserviceid = vu_intakeserviceid AND  (a.intakenumber is not null OR a.servicecaseid is not null ) AND a.activeflag = 1 ;
                RAISE NOTICE 'Active records soft deleted from actor table. % ',vu_personid;
            
              UPDATE intakeservicerequestactor israa
              SET israa.intakeserviceid = NULL, updatedby = ticketno, updatedon = now()
              WHERE israa.personid = vu_personid AND  israa.intakeserviceid = vu_intakeserviceid AND  (israa.intakenumber is not null OR israa.servicecaseid is not null ) AND israa.activeflag = 1 ;
                  RAISE NOTICE 'Active records soft deleted from intakeservicerequestactor table. % ', vu_personid;

              UPDATE actorrelationship ar
              SET ar.intakeserviceid = NULL, updatedby = ticketno, updatedon = now()
              WHERE ar.intakeserviceid = vu_intakeserviceid AND  (ar.intakenumber is not null OR ar.servicecaseid is not null ) AND ar.person1id = vu_personid AND ar.activeflag = 1; 
                  RAISE NOTICE 'Active records soft deleted from actorrelationship table. % ',vu_intakeserviceid;

              UPDATE personroletype prt
              SET prt.intakeserviceid = NULL, prt.updatedby = ticketno, prt.updatedon = now() 
              WHERE prt.personroleid in (
                  select pr.personroleid
                  from personrole pr
                  WHERE pr.personid = vu_personid AND  pr.intakeserviceid = vu_intakeserviceid AND  (pr.intakenumber is not null OR pr.servicecaseid is not null ) AND pr.activeflag = 1 ) AND  prt.activeflag = 1 ;
                
                 RAISE NOTICE 'Active records soft deleted from personrole table. % ',vu_personid;
                
              UPDATE personrole pr
              SET intakeserviceid = NULL, updatedby = ticketno, updatedon = now()
              WHERE pr.personid = vu_personid AND  pr.intakeserviceid = vu_intakeserviceid AND  (pr.intakenumber is not null OR pr.servicecaseid is not null ) AND pr.activeflag = 1 ;

                  RAISE NOTICE 'Active records soft deleted from personrole table. % ',vu_personid;
------------------------------------
              UPDATE actor a 
              SET activeflag = 0, updatedby = ticketno, updatedon = now()
              WHERE a.personid = vu_personid AND a.intakeserviceid = vu_intakeserviceid  AND  a.intakenumber is null AND a.servicecaseid is null AND a.activeflag = 1  ;
                RAISE NOTICE 'Active records soft deleted from actor table. % ',vu_personid;

              UPDATE intakeservicerequestactor israa
              SET activeflag = 0, updatedby = ticketno, updatedon = now()
              WHERE israa.personid = vu_personid AND  israa.intakeserviceid = vu_intakeserviceid AND  israa.intakenumber is null AND israa.servicecaseid is null AND israa.activeflag = 1 ;
                  RAISE NOTICE 'Active records soft deleted from intakeservicerequestactor table. % ', vu_personid;

              UPDATE actorrelationship ar
              SET activeflag = 0, updatedby = ticketno, updatedon = now()
              WHERE ar.intakeserviceid = vu_intakeserviceid AND ar.intakenumber is null AND ar.servicecaseid is null AND ar.person1id = vu_personid AND ar.activeflag = 1; 
                  RAISE NOTICE 'Active records soft deleted from actorrelationship table. % ',vu_actorid;

              UPDATE personroletype prt
                SET prt.activeflag = 0, prt.updatedby = ticketno, prt.updatedon = now() 
                WHERE prt.personroleid in (
                    select pr.personroleid
                    from personrole pr
                    WHERE pr.personid = vu_personid AND  pr.intakeserviceid = vu_intakeserviceid AND  pr.intakenumber is null AND pr.servicecaseid is null AND pr.activeflag = 1 )AND  prt.activeflag = 1 ;

                RAISE NOTICE 'Active records soft deleted from personroletype table. % ',vu_personid;
              
              UPDATE personrole pr
              SET activeflag = 0, updatedby = ticketno, updatedon = now()
              WHERE pr.personid = vu_personid AND  pr.intakeserviceid = vu_intakeserviceid AND  pr.intakenumber is null AND pr.servicecaseid is null AND pr.activeflag = 1 ;

                    RAISE NOTICE 'Active records soft deleted from personrole table. % ',vu_personid;

              UPDATE personprogramarea  ppa
              SET activeflag = 0, updatedby = ticketno, updatedon = now() 
              WHERE ppa.personid = vu_personid :: uuid AND ppa.objectid = vu_intakeserviceid :: character varying
              AND ppa.activeflag = 1;
                  RAISE NOTICE 'Active records soft deleted from personprogramarea table. % ',vu_personid;
                            
                  message := 'All tables are updated related to delete CPS person.'; 
                  message := 'Need to delete person from contacts and assessments if any.'; 

      ELSE IF( transaction_type  = 'DELETESERVICECASEPERSON' AND vu_servicecaseid IS NOT NULL) THEN

              UPDATE actor a 
              SET a.servicecaseid = NULL, updatedby = ticketno, updatedon = now()
              WHERE a.personid = vu_personid :: uuid AND a.objectid = vu_servicecaseid :: character varying  AND (a.intakenumber is not null
              or a.intakeserviceid is not null)  AND a.activeflag = 1 ;
                RAISE NOTICE 'Active records soft deleted from actor table. % ',vu_actorid;
            
              UPDATE intakeservicerequestactor israa
              SET israa.servicecaseid = NULL, updatedby = ticketno, updatedon = now()
              WHERE israa.personid = vu_personid :: uuid AND israa.objectid = vu_servicecaseid :: character varying  AND (israa.intakenumber is not null or israa.intakeserviceid is not null)  AND israa.activeflag = 1;
                  RAISE NOTICE 'Active records soft deleted from intakeservicerequestactor table. % ', vu_actorid;

              UPDATE actorrelationship ar
              SET ar.servicecaseid = NULL, updatedby = ticketno, updatedon = now()
              WHERE ar.servicecaseid = vu_servicecaseid AND (ar.intakenumber is not null or ar.intakeserviceid is not null) AND ar.person1id = vu_personid AND ar.activeflag = 1; 
                  RAISE NOTICE 'Active records soft deleted from actorrelationship table. % ',vu_intakenumber;

              UPDATE personroletype prt
              SET prt.servicecaseid = NULL, prt.updatedby = ticketno, prt.updatedon = now()
              WHERE prt.personroleid  in (
                SELECT pr.personroleid
                FROM personrole pr WHERE pr.personid = vu_personid :: uuid AND pr.objectid = vu_servicecaseid :: character varying AND (pr.intakenumber is not null
              or pr.intakeserviceid is not null) and pr.activeflag = 1 ) AND  prt.activeflag = 1 ;
                
                RAISE NOTICE 'Active records soft deleted from personroletype table. % ', vu_personid;
              
              UPDATE personrole pr
              SET servicecaseid = NULL, updatedby = ticketno, updatedon = now()
              WHERE pr.personid = vu_personid :: uuid AND pr.objectid = vu_servicecaseid :: character varying  AND (pr.intakenumber is not null
              or pr.intakeserviceid is not null)  AND  pr.activeflag = 1 ;
                    RAISE NOTICE 'Active records soft deleted from personrole table. % ',vu_personid;
-----------------------------------
              UPDATE actor a 
              SET activeflag = 0, updatedby = ticketno, updatedon = now()
              WHERE a.personid = vu_personid :: uuid AND a.objectid = vu_servicecaseid :: character varying  AND a.intakenumber is null
              AND a.intakeserviceid is null  AND a.activeflag = 1 ;
                RAISE NOTICE 'Active records soft deleted from actor table. % ',vu_personid;

              UPDATE intakeservicerequestactor israa
              SET activeflag = 0, updatedby = ticketno, updatedon = now()
              WHERE israa.personid = vu_personid :: uuid AND israa.objectid = vu_servicecaseid :: character varying  AND israa.intakenumber is null
              AND israa.intakeserviceid is null AND israa.activeflag = 1;
                  RAISE NOTICE 'Active records soft deleted from intakeservicerequestactor table. % ', vu_personid;

              UPDATE actorrelationship ar
              SET activeflag = 0, updatedby = ticketno, updatedon = now()
              WHERE ar.servicecaseid = vu_servicecaseid AND ar.intakenumber is null
              AND ar.intakeserviceid is null AND ar.person1id = vu_personid AND ar.activeflag = 1; 
                  RAISE NOTICE 'Active records soft deleted from actorrelationship table. % ',vu_personid;
           
              UPDATE personroletype prt
              SET prt.activeflag = 0, prt.updatedby = ticketno, prt.updatedon = now() 
              WHERE prt.personroleid  in (
                SELECT pr.personroleid
                FROM personrole pr WHERE pr.personid = vu_personid :: uuid AND pr.objectid = vu_servicecaseid :: character varying  AND pr.intakenumber is null AND pr.intakeserviceid is null  AND pr.activeflag = 1 ) AND  prt.activeflag = 1 ;
                
                RAISE NOTICE 'Active records soft deleted from personroletype table. % ', vu_personid;

              UPDATE personrole pr
              SET activeflag = 0, updatedby = ticketno, updatedon = now()
              WHERE pr.personid = vu_personid :: uuid AND pr.objectid = vu_servicecaseid :: character varying  AND pr.intakenumber is null AND pr.intakeserviceid is null  AND  pr.activeflag = 1 ;
                    RAISE NOTICE 'Active records soft deleted from personrole table. % ',vu_personid;
            
              UPDATE personprogramarea  ppa
              SET activeflag = 0, updatedby = ticketno, updatedon = now() 
              WHERE ppa.personid = vu_personid :: uuid AND ppa.objectid = vu_servicecaseid :: character varying 
              AND  ppa.activeflag = 1;
                  RAISE NOTICE 'Active records soft deleted from personprogramarea table. % ',vu_personid;

                  message := 'All tables are updated related to delete service case person.';
                  message := 'Need to delete person from contacts and assessments if any.'; 
 
      ELSE IF(transaction_type='DELETECONTACT' AND vu_progressnoteid IS NOT NULL ) THEN
              UPDATE progressnote
              SET activeflag = 0,updatedby = ticketno,updatedon = now()
              WHERE progressnoteid = vu_progressnoteid AND activeflag = 1 ;

              UPDATE progressnotedetail
              SET activeflag = 0,updatedby = ticketno,updatedon = now()
              WHERE progressnoteid = vu_progressnoteid AND activeflag = 1 ;

              UPDATE contactparticipant
              SET activeflag = 0,updatedby = ticketno,updatedon = now()
              WHERE progressnoteid = vu_progressnoteid AND activeflag = 1 ;
                  
              UPDATE progressnote_audit_detail
              SET activeflag = 0,updatedby = ticketno,updatedon = now()
              WHERE progressnoteid = vu_progressnoteid AND activeflag = 1 ;

                            message := 'All tables related to contact id are updated to inactive.'; 
          
      ELSE IF ( transaction_type = 'DELETEASSESSMENT' AND vu_assessmentid IS NOT NULL ) THEN
              UPDATE routing
              SET activeflag = 0,  updatedby = ticketno,updatedon= now()
              WHERE objectid = vu_assessmentid :: character varying AND activeflag = 1;
              
              UPDATE assessment 
              SET activeflag =0,updatedby = ticketno,updatedon =now()
              WHERE assessmentid = vu_assessmentid  AND activeflag=1;

              UPDATE assessmentactor 
              SET activeflag =0,updatedby = ticketno,updatedon =now()
              WHERE assessmentid = vu_assessmentid  AND activeflag=1;

              UPDATE assessmentcomments 
              SET activeflag =0,updatedby = ticketno,updatedon =now()
              WHERE assessmentid = vu_assessmentid AND activeflag=1;

              UPDATE assessment_history 
              SET activeflag =0,updatedby = ticketno,updatedon =now()
              WHERE assessmentid = vu_assessmentid  AND activeflag=1;

              UPDATE assessmentsubmission  
              SET activeflag =0,updatedby = ticketno,updatedon =now()
              WHERE assessmentid = vu_assessmentid  AND activeflag=1;

                            message := 'All tables related to assessment id are updated to inactive.'; 

      ELSE
               message := 'Transaction type is empty or didnt match.'; 
            END IF; 
          END IF;
        END IF;
      END IF;
    END IF;
   END IF;
 END IF;
END IF;

END;

$function$
