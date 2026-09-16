drop view cjams.sdr_personemail_vw;
alter table  personemail  alter column email  type varchar(100);
alter table  personimmunization  alter column  reportedby type   varchar;  
alter table intakeservicerequestpetition alter column courtcaseno type  varchar(50);  
alter table progressnote alter column  screeningfortheservicetext type  varchar;  
alter table  livingarrangement alter column pager type  varchar(50);  

CREATE OR REPLACE VIEW cjams.sdr_personemail_vw AS
 SELECT personemail.personemailid::character varying(100) AS personemailid,
    personemail.personid::character varying(100) AS personid,
    personemail.activeflag,
    personemail.personemailtypekey,
    personemail.email,
    personemail.updatedby,
    personemail.updatedon,
    personemail.insertedby,
    personemail.insertedon,
    personemail.effectivedate,
    personemail.expirationdate,
    personemail.old_id,
    personemail."timestamp",
    personemail.startdate,
    personemail.enddate
   FROM personemail;