/*
   Issue Description: CDM-37716
   Category/ Module  :No Physical abuse
   Root cause: There should not be a maltreatment type of Physical Abuse on this tab as that was not a finding that was needed. 
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update investigationallegation set activeflag=0, updatedby='CDM-37716', updatedon = now()
where allegationid='627b574e-aa98-48c1-98c3-cf6f5d155eff' and investigationid='c67febbf-f25e-416a-8a6e-382c8e7f4c30' and activeflag=1;

update Investigationmaltreatment set activeflag=0, updatedby='CDM-37716', updatedon = now()
where maltreatmentid='50c11733-78eb-4563-90ef-3800b4a51ca6' and investigationid='c67febbf-f25e-416a-8a6e-382c8e7f4c30' and activeflag=1;

update Investigationmaltreatmentactor set activeflag=0, updatedby='CDM-37716', updatedon = now()
where  maltreatmentid='50c11733-78eb-4563-90ef-3800b4a51ca6' and investigationmaltreatmentactorid='22ba0ff7-24f0-4d84-9e01-bc29b05596a6' and activeflag=1;