update gapagreement
set activeflag =0, updatedon =now(), updatedby ='CDM-7900'
where gapagreementid ='389d6c1b-f367-463c-bac8-2c84b49bf4c9';

update gapagreementrevision
set activeflag =0, updatedon =now(), updatedby ='CDM-7900'
where gapagreementid ='389d6c1b-f367-463c-bac8-2c84b49bf4c9';

update gapagreementrate
set activeflag =0, updatedon =now(), updatedby ='CDM-7900'
where gapagreementid ='389d6c1b-f367-463c-bac8-2c84b49bf4c9';

update gapratesrevision
set activeflag =0, updatedon =now(), updatedby ='CDM-7900'
where gaprateid ='3a5119d4-68fd-4267-8089-39b76040f937';

update routing 
set activeflag =0, updatedon =now(), updatedby ='CDM-7900'
where objectid in ('389d6c1b-f367-463c-bac8-2c84b49bf4c9','3a5119d4-68fd-4267-8089-39b76040f937');