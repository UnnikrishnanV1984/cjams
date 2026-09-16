update gapagreement
set startdate ='2020-09-14'::date, guardianonedate ='2020-09-14'::date, ldssdate ='2020-09-14'::date, updatedon =now(), updatedby ='CDM-7924'
where gapagreementid ='0be40557-4636-49b3-aa45-51c032bd2f24';

update gapagreementrate
set startdate ='2020-09-14'::date, enddate = '2021-09-13'::date, status ='Approved', updatedon =now(), updatedby ='CDM-7924'
where gapagreementrateid ='daaad5fd-d2dd-4874-81fa-52436256cd78';

update gapratesrevision
set ratestartdate ='2020-09-14'::date, rateenddate = '2021-09-13'::date, approvalstatustypekey ='3047', approvaldate =now(), updatedon =now(), updatedby ='CDM-7924'
where gapratesrevisionid ='72f8e402-9382-4aba-be25-b902c7b94b69';

update routing 
set routingstatustypeid =16, updatedon =now(), updatedby ='CDM-7924'
where routingid ='bbbd0f38-9a94-4c56-9fdd-7a7d66b3d432';