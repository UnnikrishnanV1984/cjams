ALTER TABLE cjams.provideraddress add column adrvalidflag integer;
ALTER TABLE cjams.providerreferral ALTER COLUMN adrworkphone TYPE character varying(20);
ALTER TABLE cjams.providerreferral ALTER COLUMN adrworkxtn TYPE character varying(20);
ALTER TABLE cjams.providerreferral ALTER COLUMN adrpager TYPE character varying(20);
ALTER TABLE cjams.providerreferral ALTER COLUMN pnamesoundex TYPE character varying(30);
ALTER TABLE cjams.providerreferral ALTER COLUMN lnamesoundex TYPE character varying(30);
ALTER TABLE cjams.providerreferral ALTER COLUMN fnamesoundex TYPE character varying(30);
ALTER TABLE cjams.providerreferral ALTER COLUMN providerfirstnamesoundex TYPE character varying(30);


ALTER TABLE cjams.personhealthexamination ADD COLUMN old_id character varying (20);
ALTER TABLE cjams.actor ADD COLUMN fk_id character varying (20);
ALTER TABLE cjams.actor ADD COLUMN fk_c_id character varying (30);
ALTER TABLE cjams.intakeservrequestsdmmaltreatment ADD COLUMN client_id character varying (20);


ALTER TABLE cjams.investigationmaltreatmentactor ADD COLUMN fk_id CHARACTER VARYING (50) NULL;
ALTER TABLE cjams.investigationmaltreatmentactor ADD COLUMN fk_rcd CHARACTER VARYING (50) NULL;

ALTER TABLE cjams.expungementreport
   ALTER COLUMN chessieuserid TYPE
                  CHARACTER VARYING (50)
                  USING chessieuserid::CHARACTER VARYING (50);
				  
ALTER TABLE cjams.expungementreport
   ALTER COLUMN workerid TYPE
                  CHARACTER VARYING (50)
                  USING workerid::CHARACTER VARYING (50);

ALTER TABLE cjams.expungementreport
   ALTER COLUMN victincisid TYPE
                  CHARACTER VARYING (50)
                  USING victincisid::CHARACTER VARYING (50);

ALTER TABLE cjams.expungementreport
   ALTER COLUMN cisid TYPE
                  CHARACTER VARYING (50)
                  USING cisid::CHARACTER VARYING (50);

ALTER TABLE cjams.expungementreport
   ALTER COLUMN requestuserid TYPE
                  CHARACTER VARYING (50)
                  USING requestuserid::CHARACTER VARYING (50);		
				  
CREATE TABLE cjams.cpsresponsereassignhistory
(
    historyid uuid NOT NULL,
    referralid uuid NOT NULL,
    initialcpsresponsetypekey character varying(5) ,
    cpsresponsetypekey character varying(5) ,
    changereasonkey character varying(5) ,
    activesw integer,
    approvaltimestamp character varying(30) ,
    comments character varying(3000) ,
    insertedon timestamp without time zone NOT NULL,
    insertedby character varying(10)  NOT NULL,
    updatedon timestamp without time zone NOT NULL,
    updatedby character varying(10)  NOT NULL,
    activeflag integer,
    old_id character varying(50) 
);	


ALTER TABLE cjams.personmedications DROP COLUMN IF EXISTS personmedicationsid;
ALTER TABLE cjams.personmedications ADD COLUMN personmedicationsid uuid;


ALTER TABLE cjams.personmedications ALTER COLUMN reason TYPE character varying(100) ;
ALTER TABLE cjams.personmedications ALTER COLUMN infoother TYPE character varying(100) ;
ALTER TABLE cjams.personmedications ALTER COLUMN affiliateorg TYPE character varying(100) ;
ALTER TABLE cjams.personmedications ALTER COLUMN medicationname TYPE character varying(100) ;
ALTER TABLE cjams.personmedications ALTER COLUMN physicianname TYPE character varying(100) ;
ALTER TABLE cjams.personmedications ALTER COLUMN infoprovidedby TYPE character varying(100) ;

ALTER TABLE cjams.clntfmlymdclhstrytype ALTER COLUMN insertedon TYPE character varying(100) ;
ALTER TABLE cjams.caseplan3taskclients ALTER COLUMN insertedon TYPE character varying(100) ;
ALTER TABLE cjams.otherclients ALTER COLUMN insertedon TYPE character varying(100) ;
ALTER TABLE cjams.afcarsadoptiondetail ALTER COLUMN recordno TYPE character varying(50) ;