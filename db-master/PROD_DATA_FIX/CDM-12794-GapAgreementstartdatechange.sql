-- 2021-04-28 17:42:14
update gapagreement set startdate = '2020-10-15 18:34:36',updatedon = now(), updatedby = 'CDM-12794' 
where gapagreementid = '20b5c7eb-025b-4f16-a799-05bbbafda52e';

update gapagreementrevision set startdate = '2020-10-15 18:34:36',updatedon = now(),approvaldate = now(), updatedby = 'CDM-12794' 
where gapagreementid = '20b5c7eb-025b-4f16-a799-05bbbafda52e';

update gapagreementrate set startdate = '2020-10-15 18:34:36',enddate = '2021-10-14 18:34:36',updatedon = now(), updatedby = 'CDM-12794'
where gapagreementrateid = 'd8b19d50-705a-4e05-be2f-f56ee634423c';

update gapratesrevision set approvaldate = now(),updatedon = now(),updatedby  = 'CDM-12794' where guardiansubsidyid = '9db719dc-ac0a-4372-a32d-4e8c5ff316fa';
