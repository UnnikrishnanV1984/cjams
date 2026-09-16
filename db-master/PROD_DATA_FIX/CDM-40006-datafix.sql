/*
   Issue Description: CDM-40006
   Category/ Module  : Application
   Root cause:user requested to remove  the two rejected suspension and  Update the suspension end-date from 05/01/2024 to 04/30/2024
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update gapsuspension 
set activeflag =0, updatedby ='CDM-40006', updatedon =now()
where gapsuspensionid in('ee4e60b1-dce8-4eca-be83-6de51646b290','13ff48b1-e503-4a18-a5df-65a0ebef4bb9') and activeflag =1;

---- No active records in gapsuspensionrevision

update gapsuspension 
set enddate ='2024-04-30 04:00:00.000', updatedby ='CDM-40006', updatedon =now()
 where  gapsuspensionid ='8d4d6467-2e68-4e64-bd08-e04cff2cde66' and activeflag =1;

update gapsuspensionrevision
set enddate ='2024-04-30 04:00:00.000', updatedby ='CDM-40006', updatedon =now(),approvaldate = now()
where  suspensionid ='8d4d6467-2e68-4e64-bd08-e04cff2cde66' and activeflag =1;
