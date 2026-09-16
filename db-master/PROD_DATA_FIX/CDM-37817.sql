
/*
   Issue Description: CDM-37817
   Category/ Module  : Updating gapsuspension dates
   Root cause: user requeseted to change it
   Fix provided: Did data fix to update start date and removed the enddate 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update cjams.gapsuspension set startdate  ='2020-06-16 04:00:00.000', enddate  = null, updatedby ='CDM-37817', updatedon  = now()
where gapsuspensionid  ='e5ba1764-518f-4832-8577-7dc72d90e7a3';

update cjams.gapsuspensionrevision set startdate  ='2020-06-16 04:00:00.000',  approvaldate = now() ,enddate  = null, updatedby ='CDM-37817', updatedon  = now()
where suspensionid  ='e5ba1764-518f-4832-8577-7dc72d90e7a3';



Delete from gapagreementrevision where insertedby = 'CDM-37817' ;

insert into cjams.gapagreementrevision
( gapagreementrevisionid, gapagreementid, gapid,
iscomprehensivehomestudy, iscgawardedcustody, isplacementenddate, ischildreceivetca, startdate,
enddate, signaturedate, guardianonedate, guardiantwodate, ldssdate,
activeflag, effectivedate, insertedby, insertedon, updatedby,
updatedon, old_id, tcaamount, isfianotified, fianotifieddate, isrcnotifiedcontact,
iscsnotifiedtocustody, approvalstatustypekey, approvaldate
)
values
( gen_random_uuid(),  'a86eae10-c7d4-402a-aedf-b719b09666a0'::uuid, 'c93e6bc3-7deb-4b10-8632-1aa33c91607e'::uuid,
true, true, true, false, '2016-07-01 00:00:00.000',
'2023-12-31 00:00:00.000', '2016-07-01 00:00:00.000', '2016-07-01 00:00:00.000', NULL, '2016-07-01 00:00:00.000',
1, '2016-07-01 00:00:00.000', 'CDM-37817', now(), 'CDM-37817',
now(), NULL, NULL, 0, NULL,
0, 0, '3047', now()
);