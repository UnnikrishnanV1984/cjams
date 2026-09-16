/*
   Issue Description: CDM-35583
   Category/ Module  : Permanency Plan
   Root cause: user requested  to remove Need Data Fix to Delete the two subsidy rate slab (Review & Incomplete).So that break the line can be send for approval
   Pull request# for data fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
select *from adoptionagreementraterevision 
where adoptionagreementrateid in ('c20c39c9-bce2-4001-a79e-78ccbc9ad81c','2f009e8a-bb77-4c72-8885-d01e5eacc9eb')
and activeflag = 1;


update adoptionagreementraterevision 
set activeflag=0, 
updatedby ='CDM-35583',
updatedon =now()
where adoptionagreementrateid in('c20c39c9-bce2-4001-a79e-78ccbc9ad81c','2f009e8a-bb77-4c72-8885-d01e5eacc9eb') 
and activeflag =1 ;

select *from routing 
where objectid in ('c20c39c9-bce2-4001-a79e-78ccbc9ad81c','2f009e8a-bb77-4c72-8885-d01e5eacc9eb')
and eventcode = 'AARR'
and activeflag = 1;

update routing set 
activeflag=0,
updatedby ='CDM-35583',
updatedon =now()
where objectid in ('c20c39c9-bce2-4001-a79e-78ccbc9ad81c','2f009e8a-bb77-4c72-8885-d01e5eacc9eb')
and eventcode = 'AARR'
and activeflag = 1;