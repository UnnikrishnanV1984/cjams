/*
   Issue Description: CDM-25712
   Category/ Module  : change placement end date
   Root cause: user requeseted to change placement end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update placement  set enddatetime ='2021-01-12 00:00:00.000', endtime='15:30', updatedby ='CDM-25712', updatedon =now()

where placementid ='20bf6135-1e08-4f7c-888a-b2137443e304';



update placementrevision  set exitdate ='2021-01-12 00:00:00.000', exittime='15:30', updatedby ='CDM-25712', updatedon =now()

where placementid ='20bf6135-1e08-4f7c-888a-b2137443e304' and placementrevisionid in ('56292e7c-1692-4cba-9a62-0ce177b9f579','56cdca86-1bd7-4f1e-b304-97c8706ecd38');



--there is no record in this table for this id
select * from  cjams.tb_placement_validation where placement_id ='1560199';


