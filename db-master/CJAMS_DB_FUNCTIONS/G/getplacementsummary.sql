CREATE OR REPLACE FUNCTION cjams.getplacementsummary (
   IN v_personid     uuid,
   IN pagenumber     BIGINT,
   IN pagesize       BIGINT,
   IN v_status       CHARACTER VARYING,
   IN i_searchtext   CHARACTER VARYING,
   IN v_nolimit      BOOLEAN DEFAULT FALSE)
   RETURNS TABLE
           (
              totalcount                                 BIGINT,
              placementid                                uuid,
              startdatetime                              TIMESTAMP WITHOUT TIME ZONE,
              intakeserviceid                            uuid,
              servicerequestnumber                       CHARACTER VARYING,
              intakenumber                               CHARACTER VARYING,
              fieldworkerid                              BIGINT,
              fieldworkeruuid                            CHARACTER VARYING,
              fieldworkername                            TEXT,
              cop                                        BOOLEAN,
              placingfolder                              CHARACTER VARYING,
              providername                               CHARACTER VARYING,
              placementunit                              CHARACTER VARYING,
              addate                                     DATE,
              adtime                                     TIME WITHOUT TIME ZONE,
              releasedate                                DATE,
              statustypekey                              CHARACTER VARYING,
              projectedrelease                           DATE,
              placementadmissionclassificationkey        CHARACTER VARYING,
              placementadmissionclassificationdesc       CHARACTER VARYING,
              placementadmissiontypekey                  CHARACTER VARYING,
              placementadmissiontypedesc                 CHARACTER VARYING,
              placementadmissionauthorizationtypekey     CHARACTER VARYING,
              placementadmissionauthorizationtypedesc    CHARACTER VARYING,
              placementprimaryadmissionreasontypekey     CHARACTER VARYING,
              placementprimaryadmissionreasontypedesc    CHARACTER VARYING,
              countyname                                 CHARACTER VARYING,
              jcounty                                    CHARACTER VARYING,
              placementprimaryapprovedalttypekey         CHARACTER VARYING,
              placementprimaryapprovedalttypedesc        CHARACTER VARYING,
              exitreasontypekey                          CHARACTER VARYING,
              exitreasontypekeydesc                      CHARACTER VARYING,
              releasereason                              CHARACTER VARYING,
              releasecomments                            CHARACTER VARYING,
              leavetype                                  CHARACTER VARYING,
              whereabouts                                CHARACTER VARYING,
              releasetonames                             CHARACTER VARYING,
              releasetocategory                          CHARACTER VARYING,
              detentionalternative                       CHARACTER VARYING,
              status                                     TEXT
           )
   LANGUAGE 'plpgsql'
   VOLATILE
   NOT LEAKPROOF
   SECURITY INVOKER
   PARALLEL UNSAFE
   ROWS 1000
AS
$$

DECLARE
   v_pageoffset   INT;
   v_pagenumber   INT;
BEGIN
   v_pagenumber := pagenumber - 1;

   v_pageoffset = v_pagenumber * pagesize;

   IF COALESCE (pagesize, 0) < 1
   THEN
      pagesize := 10;
   END IF;

   IF COALESCE (pagenumber, 0) < 1
   THEN
      pagenumber := 1;
   END IF;


   RETURN QUERY
        SELECT DISTINCT
               count (1) OVER () AS totalcount,
               pl.placementid,
               pl.startdatetime,
               isr.intakeserviceid,
               isr.servicerequestnumber,
               isr.intakenumber,
               up.cjamspid AS fieldworkerid,
               up.securityusersid AS fieldworkeruuid,
               CONCAT (up.lastname, ',', up.firstname) AS fieldworkername,
               pl.cop,
               ft.description AS placingfolder,
               pr.providername,
               pr.providerunit AS placementunit,
               pl.addate,
               pl.adtime,
               pl.releasedate,
               pl.statustypekey,
               pl.releasedate AS projectedrelease,
               pl.placementadmissionclassificationkey,
               pac.description AS placementadmissionclassificationdesc,
               pl.placementadmissiontypekey,
               pat.description AS placementadmissiontypedesc,
               pl.placementadmissionauthorizationtypekey,
               ppaa.description AS placementadmissionauthorizationtypedesc,
               pl.placementprimaryadmissionreasontypekey,
               ppar.description AS placementprimaryadmissionreasontypedesc,
               cnt.countyname,
               pl.jcounty,
               pl.placementprimaryapprovedalttypekey,
               ppaat.description AS placementprimaryapprovedalttypedesc,
               pl.exitreasontypekey,
               rfv.description AS exitreasontypekeydesc,
               rf.description AS releasereason,
               pre.releasecomments,
               plr.leavetypekey AS leavetype,
               pre.whereabouts,
               pre.releasetoname AS releasetonames,
               pre.releasecategory AS releasetocategory,
               pl.detainer AS detentionalternative,
               (CASE
                   WHEN pl.enddatetime IS NULL THEN 'open'
                   WHEN pl.enddatetime IS NOT NULL THEN 'Closed'
                END) AS status
          FROM placement pl
               LEFT JOIN provider pr ON pr.providerid = pl.providerid
               LEFT JOIN intakeservicerequest isr
                  ON isr.intakeserviceid = pl.intakeserviceid
               LEFT JOIN foldertype ft ON ft.foldertypekey = isr.foldertypekey
               --LEFT JOIN person p on
               --p.personid = v_personid and p.activeflag=1
               --LEFT JOIN actor a on
               --a.personid = p.personid  and a.activeflag =1
               --join focuspersoncasestatus fp on
               --fp.personid=p.personid and fp.activeflag=1
               --LEFT JOIN intakeservicerequestactor isra on
               --isra.actorid = a.actorid and isra.activeflag =1 and isra.intakeservicerequestpersontypekey =''Youth''
               LEFT JOIN placementadmissiontype pat
                  ON pat.placementadmissiontypekey =
                     pl.placementadmissiontypekey
               LEFT JOIN placementadmissionclassificationtype pac
                  ON pac.placementadmissionclassificationkey =
                     pl.placementadmissionclassificationkey
               LEFT JOIN placementadmissionauthorizationtype ppaa
                  ON ppaa.placementadmissionauthorizationtypekey =
                     pl.placementadmissionauthorizationtypekey
               LEFT JOIN placementprimaryadmissionreasontype ppar
                  ON ppar.placementprimaryadmissionreasontypekey =
                     pl.placementprimaryadmissionreasontypekey
               LEFT JOIN placementprimaryapprovedalttype ppaat
                  ON ppaat.placementprimaryapprovedalttypekey =
                     pl.placementprimaryapprovedalttypekey
               LEFT JOIN exitreasontype ert
                  ON ert.exitreasontypekey = pl.exitreasontypekey
               LEFT JOIN userprofile up ON up.securityusersid = pl.updatedby
               LEFT JOIN county cnt ON cnt.countyid = pl.county
               LEFT JOIN referencevalues rfv
                  ON rfv.value_text = pl.exitreasontypekey
               LEFT JOIN placementrelease pre
                  ON pre.placementid = pl.placementid
               LEFT JOIN placementleavereturn plr
                  ON plr.placementid = pl.placementid
               LEFT JOIN referencevalues rf
                  ON rf.value_text = pre.releasereason
         WHERE     pl.intakeserviceid IN
                      (SELECT DISTINCT INTSR.intakeserviceid
                         FROM intakeservicerequest INTSR
                              INNER JOIN intakeservicerequestactor INSRA
                                 ON     INSRA.intakeserviceid =
                                        INTSR.intakeserviceid
                                    AND INSRA.activeflag = 1
                              INNER JOIN actor ACC
                                 ON     ACC.actorid = INSRA.actorid
                                    AND ACC.activeflag = 1
                                    AND ACC.actortype = 'Youth'
                              INNER JOIN person p
                                 ON     Acc.personid = p.personid
                                    AND p.activeflag = 1
                              INNER JOIN focuspersoncasestatus fp
                                 ON     fp.personid = p.personid
                                    AND fp.activeflag = 1
                        WHERE     ACC.personid = v_personid
                              AND CASE
                                     WHEN (    i_searchtext != ''
                                           AND i_searchtext IS NOT NULL)
                                     THEN
                                        fp.focuspersonstatustypekey =
                                        i_searchtext
                                     ELSE
                                        1 = 1
                                  END)
               AND CASE
                      WHEN v_status = 'open'
                      THEN
                         pl.enddatetime IS NULL
                      WHEN v_status = 'closed'
                      THEN
                         pl.enddatetime IS NOT NULL
                      WHEN v_status = 'all'
                      THEN
                         pl.enddatetime IS NULL OR pl.enddatetime IS NOT NULL
                   END
      ORDER BY pl.startdatetime NULLS FIRST
         LIMIT CASE WHEN v_nolimit = FALSE THEN pagesize END
        OFFSET CASE WHEN v_nolimit = FALSE THEN v_pageoffset END;
END;
$$