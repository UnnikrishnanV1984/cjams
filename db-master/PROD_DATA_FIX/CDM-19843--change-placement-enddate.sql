/*
   Issue Description: CDM-18439
   Category/ Module  : change placement end date
   Root cause: user requeseted to change placement end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update placement set enddatetime = '2021-11-18 00:00:00', updatedby = 'CDM-19843', updatedon = now() where placementid = '518cf7a0-fefe-4189-855c-19ce508907bd';
update placementrevision set exitdate = '2021-11-18 00:00:00', updatedby = 'CDM-19843', updatedon = now() where placementrevisionid = 'cdbd050c-8648-452c-a533-85db3c8dc8ae';

