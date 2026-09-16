/*
   Issue Description: CDM-29563
   Category/ Module  :Incorrect adoption subisdy rate
   Root cause: :Adoption Case #231040075751 (Noah) and Case# 231040075718 (Bianca)rates were entered incorrectly as per diem, not mothly. Monthly subsidy rate needs to be corrected to reflect monthly rate of $1,008 for each child/case.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/


update adoptioncaseagreementrate set paymentamout =1008, updatedby ='CDM-29563', updatedon = now()  where  adoptionagreementrateid= 'fcbf0628-e692-4c4a-8682-187c9af33572';
update adoptioncaseagreementrate set paymentamout =1008, updatedby ='CDM-29563', updatedon = now()  where  adoptionagreementrateid= 'b21084c2-0a7c-4593-b32f-c28cb03e29af';



update adoptioncaserevision set paymentamout =1008, updatedby ='CDM-29563', updatedon = now(), approvaldate = now()    where  adoptionagreementrateid= 'fcbf0628-e692-4c4a-8682-187c9af33572';
update adoptioncaserevision set paymentamout =1008, updatedby ='CDM-29563', updatedon = now(), approvaldate = now()    where  adoptionagreementrateid= 'b21084c2-0a7c-4593-b32f-c28cb03e29af';