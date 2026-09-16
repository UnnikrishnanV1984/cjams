DROP FUNCTION IF EXISTS cjams.expungemaltreatortables(v_inputprocname character varying) ;

CREATE OR REPLACE FUNCTION cjams.expungemaltreatortables(v_inputprocname character varying, OUT al_sqlcode integer, OUT as_error character varying) 
RETURNS Record 
LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 11/17/2025 Manasa Kasula - Implementation for Expungement Job for Sexual Abuse Cases (CIDM-10890)
------------------------------------------------------------------------ 

DECLARE
    v_rec RECORD;
    v_intakedastatusid text[];
    v_intakedastaging_id text[];
    v_intakeservicerequestsdmid text[];
    v_rec3 RECORD;
    v_investigationfindingid text[];
    v_intakesnapshotid text[];
    v_intakeservicereqid text[];
    v_intakeservicerequestactorid text[];
    v_actorid text[];
    v_sdmmaltreatmentid text[];
    v_progressnoteid text[];
    v_progressnotedetailid text[];
    v_contactparticipantid text[];
	v_investigationallegationid text[];
    v_investigationallegationmaltreatorsid text[];
    v_investigationid text[];
    v_investigationmaltreatmentactorid text[];
    v_intakenumber character varying;
    v_personid uuid[];
    v_generictableexpungement int;

BEGIN
    IF(v_inputprocname = 'expungmaltreatorsallegation') then 
        FOR v_rec in select * from tmp_expungsexualabusemaltreators 
        LOOP
            select ARRAY(select investigationallegationid::text from investigationallegation iva
                WHERE iva.investigationallegationid = v_rec.investigationallegationid and iva.activeflag = 1           
	        ) into v_investigationallegationid;

            select ARRAY(select investigationfindingid::text from investigationfinding ivf
                WHERE ivf.investigationallegationid = v_rec.investigationallegationid and ivf.activeflag = 1           
	        ) into v_investigationfindingid;

            select ARRAY(select investigationallegationmaltreatorsid::text from investigationallegationmaltreators im 
                    where im.intakeservicerequestactorid = v_rec.intakeservicerequestactorid AND im.investigationallegationid = v_rec.investigationallegationid    
	        ) into v_investigationallegationmaltreatorsid;

            select ARRAY(select intakeservicerequestactorid::text from intakeservicerequestactor ia where ia.intakeservicerequestactorid = v_rec.intakeservicerequestactorid
                    AND ia.intakeservicerequestpersontypekey = 'AM' and ia.activeflag = 1
                    AND 0 = (SELECT COUNT(1)
                    from investigationallegationmaltreators im 
                    inner join investigationallegation i2 on im.investigationallegationid = i2.investigationallegationid and i2.activeflag = 1 and i2.investigationallegationid != v_rec.investigationallegationid                               
                    inner join expungement i on i2.maltreatmentid = i.maltreatmentid and i.activeflag = 1
                    where i.donotexpunge = true and im.intakeservicerequestactorid =v_rec.intakeservicerequestactorid AND im.activeflag = 1)   
	        ) into v_intakeservicerequestactorid;

            
            UPDATE contactparticipant cp SET intakeservicerequestactorid = (SELECT MAX(isa.intakeservicerequestactorid::character varying)::UUID
            FROM intakeservicerequestactor isa
            WHERE isa.activeflag = 1 and isa.intakeserviceid = v_rec.intakeserviceid and isa.intakeservicerequestactorid::text != any(v_intakeservicerequestactorid)
            GROUP BY isa.intakeserviceid, isa.personid limit 1), updatedby= 'EXPUNG',updatedon = now()
            WHERE cp.intakeservicerequestactorid::text = any(v_intakeservicerequestactorid);

            select generictableexpungement into v_generictableexpungement from generictableexpungement('investigationallegation', v_investigationallegationid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('investigationfinding', v_investigationfindingid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('investigationallegationmaltreators', v_investigationallegationmaltreatorsid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('intakeservicerequestactor', v_intakeservicerequestactorid);
            -- select generictableexpungement into v_generictableexpungement from  generictableexpungement('contactparticipant', v_contactparticipantid);
        END LOOP;
    ELSEIF(v_inputprocname = 'expungmaltreatorsinvestigation') then 
        FOR v_rec3 in select * from tmp_expungsexualabuseinvestigation
        LOOP
             SELECT ir.intakenumber into v_intakenumber FROM intakeservicerequest ir where ir.intakeserviceid = v_rec3.intakeserviceid and ir.activeflag = 1;
            select ARRAY(
                select isr.intakeserviceid::text from intakeservicerequest isr
                where isr.intakeserviceid = v_rec3.intakeserviceid and isr.activeflag = 1
	        ) into v_intakeservicereqid;

            select ARRAY(select intakedastatusid::text from intakedastatus WHERE intakenumber = v_intakenumber
                and activeflag = 1
            ) into v_intakedastatusid;

            select ARRAY(select id::text from intakedastaging WHERE intakenumber = v_intakenumber
                 and activeflag = 1
             ) into v_intakedastaging_id;

            select ARRAY(select intakesnapshotid::text from intakesnapshot WHERE intakenumber = v_intakenumber
                        and activeflag = 1
            ) into v_intakesnapshotid; 

            select ARRAY(select intakeservicerequestsdmid::text from intakeservicerequestsdm sm 
                        WHERE sm.intakeserviceid = v_rec3.intakeserviceid AND sm.activeflag = 1
            ) into v_intakeservicerequestsdmid;

            select ARRAY(
                select iv.investigationid::text from investigation iv
                where iv.investigationid = v_rec3.investigationid and iv.activeflag = 1
	        ) into v_investigationid;
           
            select ARRAY(select isma.investigationmaltreatmentactorid::text from investigationmaltreatmentactor isma 
                    inner join investigationallegation ia ON isma.maltreatmentid = ia.maltreatmentid and isma.investigationmaltreatmentactorid = ia.investigationmaltreatmentactorid
                    where ia.investigationid =  v_rec3.investigationid AND isma.activeflag = 1
            ) into v_investigationmaltreatmentactorid;

            select ARRAY(select intakeservicerequestactorid::text from intakeservicerequestactor isra 
                        where ((isra.intakeserviceid =  v_rec3.intakeserviceid) or
                        (isra.intakenumber = v_intakenumber))
                        AND isra.activeflag = 1
            ) into v_intakeservicerequestactorid;

            select ARRAY(select actorid::text from actor a 
                        where ((a.intakeserviceid =  v_rec3.intakeserviceid) or
                        (a.intakenumber = v_intakenumber)) 
                        AND a.activeflag = 1
            ) into v_actorid;

            select ARRAY(select distinct personid from actor a 
                        where ((a.intakeserviceid =  v_rec3.intakeserviceid) or
                        (a.intakenumber = v_intakenumber)) 
                        AND a.activeflag = 1
            ) into v_personid;

            select ARRAY(select sdmmaltreatmentid::text from intakeservrequestsdmmaltreatment sm 
                        where sm.intakeservicerequestsdmid::text = Any(v_intakeservicerequestsdmid) AND sm.activeflag = 1
            ) into v_sdmmaltreatmentid;

            select ARRAY(select progressnoteid::text from progressnote pn 
                        where (pn.intakeserviceid = v_rec3.intakeserviceid or pn.entitytypeid = v_intakenumber) AND pn.activeflag = 1
            ) into v_progressnoteid;

            select ARRAY(select progressnotedetailid::text from progressnotedetail pnd 
                where pnd.progressnoteid::text = any(v_progressnoteid) AND pnd.activeflag = 1
            ) into v_progressnotedetailid;

            select ARRAY(select contactparticipantid::text from contactparticipant cp 
                where cp.progressnoteid::text = any(v_progressnoteid) AND cp.activeflag = 1
            ) into v_contactparticipantid;

            select generictableexpungement into v_generictableexpungement from  generictableexpungement('intakeservicerequest', v_intakeservicereqid);            
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('intakedastatus',v_intakedastatusid);            
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('intakedastaging',v_intakedastaging_id);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('intakesnapshot', v_intakesnapshotid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('intakeservicerequestsdm',v_intakeservicerequestsdmid);            
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('investigation', v_investigationid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('investigationmaltreatmentactor',v_investigationmaltreatmentactorid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('intakeservicerequestactor',v_intakeservicerequestactorid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('actor',v_actorid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('intakeservrequestsdmmaltreatment',v_sdmmaltreatmentid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('progressnotedetail',v_progressnotedetailid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('contactparticipant',v_contactparticipantid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('progressnote',v_progressnoteid);
            
            UPDATE Person 
            SET updatedby = 'expung_updt' , updatedon = now()
            WHERE personid = any(v_personid);

        End Loop;

    ELSEIF(v_inputprocname = 'expungscreenoutintakes') then 
        
        FOR v_rec in select * from tmp_expungsexualabusescreenout
        LOOP
            SELECT ir.intakenumber into v_intakenumber FROM intakeservicerequest ir where ir.intakeserviceid = v_rec.intakeserviceid and ir.activeflag = 1;
            select ARRAY(
                select isr.intakeserviceid::text from intakeservicerequest isr
                where isr.intakeserviceid = v_rec.intakeserviceid
	        ) into v_intakeservicereqid;

            select ARRAY(select intakedastatusid::text from intakedastatus WHERE intakenumber = v_intakenumber
                and activeflag = 1
            ) into v_intakedastatusid;

            select ARRAY(select id::text from intakedastaging WHERE intakenumber = v_intakenumber
                and activeflag = 1
             ) into v_intakedastaging_id;

            select ARRAY(select intakesnapshotid::text from intakesnapshot WHERE intakenumber = v_intakenumber
                and activeflag = 1
            ) into v_intakesnapshotid; 

            select ARRAY(select intakeservicerequestsdmid::text from intakeservicerequestsdm sm 
                WHERE sm.intakeserviceid = v_rec.intakeserviceid AND sm.activeflag = 1
            ) into v_intakeservicerequestsdmid;

            select ARRAY(select intakeservicerequestactorid::text from intakeservicerequestactor isra 
                        where ((isra.intakeserviceid =  v_rec.intakeserviceid) or
                            (isra.intakenumber = v_intakenumber))
                        AND isra.activeflag = 1 AND isra.servicecaseid IS NULL
            ) into v_intakeservicerequestactorid;

            select ARRAY(select actorid::text from actor a 
                        where ((a.intakeserviceid =  v_rec.intakeserviceid) or
                        (a.intakenumber = v_intakenumber))
                        AND a.activeflag = 1 AND a.servicecaseid IS NULL
            ) into v_actorid;

            select ARRAY(select distinct personid from actor a 
                        where ((a.intakeserviceid =  v_rec.intakeserviceid) or
                        (a.intakenumber = v_intakenumber)) 
                        AND a.activeflag = 1 AND a.servicecaseid IS NULL
            ) into v_personid;

            select ARRAY(select sdmmaltreatmentid::text from intakeservrequestsdmmaltreatment sm 
                        where sm.intakeservicerequestsdmid::text = Any(v_intakeservicerequestsdmid) AND sm.activeflag = 1
            ) into v_sdmmaltreatmentid;

            select ARRAY(select progressnoteid::text from progressnote pn 
                        where (pn.intakeserviceid = v_rec.intakeserviceid or pn.entitytypeid = v_intakenumber) AND pn.activeflag = 1
            ) into v_progressnoteid;

            select ARRAY(select progressnotedetailid::text from progressnotedetail pnd 
                where pnd.progressnoteid::text = any(v_progressnoteid) AND pnd.activeflag = 1
            ) into v_progressnotedetailid;

            select ARRAY(select contactparticipantid::text from contactparticipant cp 
                where cp.progressnoteid::text = any(v_progressnoteid) AND cp.activeflag = 1
            ) into v_contactparticipantid;

            select generictableexpungement into v_generictableexpungement from  generictableexpungement('intakeservicerequest', v_intakeservicereqid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('intakedastatus',v_intakedastatusid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('intakedastaging',v_intakedastaging_id);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('intakeservicerequestsdm',v_intakeservicerequestsdmid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('intakesnapshot', v_intakesnapshotid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('intakeservicerequestactor',v_intakeservicerequestactorid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('actor',v_actorid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('intakeservrequestsdmmaltreatment',v_sdmmaltreatmentid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('progressnotedetail',v_progressnotedetailid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('contactparticipant',v_contactparticipantid);
            select generictableexpungement into v_generictableexpungement from  generictableexpungement('progressnote',v_progressnoteid);

            UPDATE Person 
            SET updatedby = 'expung_updt' , updatedon = now()
            WHERE personid = any(v_personid);
    
        END LOOP;
        
    END IF;
    al_sqlcode:= 1;
    as_error:= 'SUCCESS';
			
END;
 
$function$
;
