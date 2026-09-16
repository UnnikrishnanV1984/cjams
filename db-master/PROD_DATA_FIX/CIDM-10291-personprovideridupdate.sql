/*
Issue Description: 10291: Person providerid Cleanup
Category/Module: Person
Data/Code fix ticket#: CIDM-10291
*/
-- Change History
-- 03/28/2025 providerid cleanup - Manasa/Vineet 
-- 1.nullify the providerid where the providerid is not null and provider id is 0
update person 
set providerid = null
where activeflag = 1 and providerid is not null;

-- 2.Updating the providerid in the person table where the record is not in intakeservicerequestactor table but in adoptioncaseactor table.
with provider_id_fix as
(
select tab.personid,
    coalesce(tab.parent1providerid, tab.adop_rate_provider_id) as provider_id
from (
select acr.adoptioncaseid, 
    pr.cjamspid, 
    acr.personid, 
    agr.parent1providerid,
    (select adr.provider_id 
        from adoptioncaseagreementrate adr
    where adr.adoptionagreementid = agr.adoptionagreementid
        and adr.activeflag = 1
        and adr.status = 'Approved'
        and adr.provider_id is not null
    order by adr.startdate desc
    limit 1
    ) as adop_rate_provider_id,
    pr.providerid
from adoptioncaseactor acr,
    adoptioncaseagreement agr,
    person pr
where acr.adoptioncaseid = agr.adoptioncaseid
    and acr.personid = pr.personid
    and acr.activeflag = 1 
    and agr.activeflag = 1 
    and pr.activeflag = 1 
    and acr.actortypekey  in ('ADOPTIVEPARENT')
    and (select count(*) 
        from intakeservicerequestactor i 
        where i.personid = acr.personid 
            and i.activeflag = 1 
            and i.intakeservicerequestpersontypekey in ('APLCNT','COAPLCNT')
        ) = 0
) tab
)

/*
select p.cjamspid, p.providerid, provider_id_fix.provider_id
from person p,
provider_id_fix 
where provider_id_fix.personid = p.personid
    and p.providerid is null 
    and p.activeflag = 1 
    ;
*/

update person p
    set providerid = provider_id_fix.provider_id
from provider_id_fix 
where provider_id_fix.personid = p.personid
    and (p.providerid is null or p.providerid = 0)
    and p.activeflag = 1 
    ;
-- 3.Updating the providerid for the person where the role is apllicant and co applicant in intakeservicerequestactor table.
with provider_id_fix1 as
(
select tab2.personid,
    tab2.objectid,
    tp.provider_id,
    (select pah.provider_id::bigint 
       from providerapprovalphaserecord pah 
            ,prov.tb_provider pr
       where pah.provider_id::bigint = pr.provider_id 
           and ( pah.applicant_id = tab2.objectid or pah.referral_id = tab2.objectid )
        -- and pah.active_flag = 1
           and pr.delete_sw = 'N'
        and ( pah.provider_id is not null and btrim(pah.provider_id ) <> '' )
     order by pah.create_ts desc
     limit 1
    ) as app_provider_id
from (
select tab1.personid, 
    (select i2.objectid 
     from intakeservicerequestactor i2 
        where i2.personid = tab1.personid 
            and i2.activeflag = 1
            and i2.intakeservicerequestpersontypekey in ('APLCNT','COAPLCNT')
        order by i2.insertedon 
      desc limit 1
     ) as objectid
from (
select  p1.personid
  from person p1 where p1.activeflag = 1 and (p1.providerid is null or p1.providerid = 0)
  and 
  (select count(*) 
    from intakeservicerequestactor i 
    where i.personid = p1.personid 
    and i.activeflag = 1
    and i.intakeservicerequestpersontypekey in ('APLCNT','COAPLCNT')
    ) > 0
) tab1
) tab2
    left join prov.tb_provider tp on tp.provider_id::character varying = tab2.objectid::character varying
          and tp.delete_sw = 'N'
)

-- select * from provider_id_fix1
-- where provider_id is null and app_provider_id is null 
-- where provider_id is not null  or app_provider_id is not null ;

update person p
    set providerid = coalesce(provider_id_fix1.provider_id, provider_id_fix1.app_provider_id)
from provider_id_fix1 
where provider_id_fix1.personid = p.personid and (p.providerid is null or p.providerid = 0)
 and p.activeflag = 1 and (provider_id is not null or app_provider_id is  not null);