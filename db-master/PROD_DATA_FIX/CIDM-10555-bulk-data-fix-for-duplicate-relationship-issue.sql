/*
Issue Description:CIDM-10555 Bulk data fix ticket to remove the duplicate relationships.
Category/Module: Relationship
Root cause: Duplicate relationship id's are inserted in the actorrelationship table due to code issue and this was fixed as the part
            of CIDM-10513 to correct the actor relationship.
            Data fix also needed for this ticket to correct the duplicate relationship records that are already inserted as the part of 
            previous transactions.
Fix provided: Data fix is done to correct the duplicate relationship issue.
Data/Code fix ticket#: CIDM-10555
Regression Impacts: N/A
Is Code fix Required?: yes
Code fix ticket#: CIDM-10513
Reason why no related code fix: N/A
*/

--update servicecaseid or intakeserviceid or intakenumber based on intakeservicerequestactorid  in  actorrelationship table

UPDATE actorrelationship ac
SET 
  intakeserviceid = i.intakeserviceid,
  servicecaseid = i.servicecaseid,
  intakenumber = i.intakenumber,
  updatedby = 'CIDM-10555',
  updatedon = NOW()
FROM intakeservicerequestactor i
WHERE 
  i.intakeservicerequestactorid = ac.intakeservicerequestactorid
  AND ac.activeflag = 1
  AND ac.intakeserviceid IS NULL
  AND ac.servicecaseid IS NULL
  AND ac.intakenumber IS NULL
  and ac.intakeservicerequestactorid not in 
  (
    select i1.intakeservicerequestactorid
    from intakeservicerequestactor i1,
        intakeservicerequest isr1
    WHERE i1.intakeserviceid = isr1.intakeserviceid    
        and coalesce(isr1.teamtypekey, 'CW') = 'AS'
    union all 
    select i2.intakeservicerequestactorid
    from intakeservicerequestactor i2,
        intakedastaging ids2
    WHERE i2.intakenumber = ids2.intakenumber    
        and ids2.activeflag = 1
        and coalesce(ids2.teamtypekey, 'CW') = 'AS'
 );

--De-activate duplicate records from actorrelationship table matching with person1id and person2id and servicecaseid or intakeserviceid or intakenumber taking the latest record
WITH duplicates AS (
    SELECT ar1.actorrelationshipid
    FROM actorrelationship ar1
    JOIN (
        SELECT 
            person1id,
            person2id,
            servicecaseid,
            MAX(insertedon) AS latestrecord
        FROM actorrelationship
        WHERE activeflag = 1
        and person1id is not null
        and person2id is not null 
        and servicecaseid is not null
        GROUP BY person1id, person2id, servicecaseid
        HAVING COUNT(*) > 1
    ) dup ON ar1.person1id = dup.person1id
         AND ar1.person2id = dup.person2id
         AND ar1.servicecaseid = dup.servicecaseid
         AND ar1.insertedon < dup.latestrecord
    WHERE ar1.activeflag = 1 and ar1.servicecaseid is not null
)
UPDATE actorrelationship ar
SET activeflag = 0,
	updatedon = now(),
	updatedby = 'CIDM-10555'
FROM duplicates d
WHERE ar.actorrelationshipid = d.actorrelationshipid;

--De-activate duplicate records from actorrelationship table matching with person1id and person2id and intakeserviceid 
WITH duplicates AS (
    SELECT ar1.actorrelationshipid,
           COALESCE(
               (SELECT isr.teamtypekey 
                FROM intakeservicerequest isr
                WHERE isr.intakeserviceid = ar1.intakeserviceid
                ORDER BY isr.insertedon DESC
                LIMIT 1),
               'CW'
           ) AS teamtypekey
    FROM actorrelationship ar1
    JOIN (
        SELECT 
            person1id,
            person2id,
            intakeserviceid,
            MAX(insertedon) AS latestrecord
        FROM actorrelationship
        WHERE activeflag = 1 
          AND person1id IS NOT NULL
          AND person2id IS NOT NULL
          AND intakeserviceid IS NOT NULL
        GROUP BY person1id, person2id, intakeserviceid
        HAVING COUNT(*) > 1
    ) dup 
      ON ar1.person1id = dup.person1id
     AND ar1.person2id = dup.person2id
     AND ar1.intakeserviceid = dup.intakeserviceid
     AND ar1.insertedon < dup.latestrecord
    WHERE ar1.activeflag = 1
)
UPDATE actorrelationship ar
SET activeflag = 0,
    updatedon = now(),
    updatedby = 'CIDM-10555'
FROM duplicates d
WHERE ar.actorrelationshipid = d.actorrelationshipid
  AND d.teamtypekey = 'CW';

--De-activate duplicate records from actorrelationship table matching with person1id and person2id and intakenumber taking the latest record

WITH duplicates AS (
    SELECT ar1.actorrelationshipid,
           COALESCE(
               (SELECT isr.teamtypekey 
                FROM intakeservicerequest isr
                WHERE isr.intakenumber = ar1.intakenumber
                ORDER BY isr.insertedon DESC
                LIMIT 1),
               (SELECT ida.teamtypekey 
                FROM intakedastaging ida
                WHERE ida.intakenumber = ar1.intakenumber
                ORDER BY ida.insertedon DESC
                LIMIT 1),
               'CW'
           ) AS teamtypekey
    FROM actorrelationship ar1
    JOIN (
        SELECT 
            person1id,
            person2id,
            intakenumber,
            MAX(insertedon) AS latestrecord
        FROM actorrelationship
        WHERE activeflag = 1 
          AND person1id IS NOT NULL
          AND person2id IS NOT NULL
          AND intakenumber IS NOT NULL
        GROUP BY person1id, person2id, intakenumber
        HAVING COUNT(*) > 1
    ) dup 
      ON ar1.person1id = dup.person1id
     AND ar1.person2id = dup.person2id
     AND ar1.intakenumber = dup.intakenumber
     AND ar1.insertedon < dup.latestrecord
    WHERE ar1.activeflag = 1
)
UPDATE actorrelationship ar
SET activeflag = 0,
    updatedon = now(),
    updatedby = 'CIDM-10555'
FROM duplicates d
WHERE ar.actorrelationshipid = d.actorrelationshipid
  AND d.teamtypekey = 'CW';


--- Deactivate duplicate records having identical records including insertedon except actorrelationshipid (Primary Key)
WITH duplicates AS (
  SELECT ar.actorrelationshipid,
         ROW_NUMBER() OVER (
           PARTITION BY 
             insertedon, updatedon, person1id, person2id, intakeserviceid, servicecaseid, intakenumber,
             intakeservicerequestactorid, relationshiptypekey, insertedby, updatedby, "timestamp",
             effectivedate, expirationdate, old_id, client1id, client2id, caregiverflag,
             paternityestdflag, paternityestddate, paternitycourtorderflag, maternityestdflag,
             maternityestddate, maternitycourtorderflag, "comments", startdate, enddate, sysgenflag,
             origclientid, caseid, referralid, expungementflag, datavalidflag, clientmergeid,
             fk1_id, fk2_id, fk3_id, etl_userid, etl_load_date
           ORDER BY actorrelationshipid
         ) AS rownum,
         COALESCE(
           (SELECT isr.teamtypekey 
            FROM intakeservicerequest isr
            WHERE isr.intakenumber = ar.intakenumber
            ORDER BY isr.insertedon DESC
            LIMIT 1),
           (SELECT ida.teamtypekey 
            FROM intakedastaging ida
            WHERE ida.intakenumber = ar.intakenumber
            ORDER BY ida.insertedon DESC
            LIMIT 1),
            (SELECT isr.teamtypekey 
            FROM intakeservicerequest isr
            WHERE isr.intakeserviceid = ar.intakeserviceid
            ORDER BY isr.insertedon DESC
            LIMIT 1),
           'CW'
         ) AS teamtypekey
  FROM actorrelationship ar
  WHERE ar.activeflag = 1  
)
UPDATE actorrelationship ar
SET activeflag = 0,
    updatedby = 'CIDM-10555',
    updatedon = now()
FROM duplicates d
WHERE ar.actorrelationshipid = d.actorrelationshipid
  AND d.rownum > 1
  AND d.teamtypekey = 'CW';
  