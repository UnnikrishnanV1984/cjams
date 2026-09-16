/*
   Issue Description: CDM-42194 Incorrect GAP subsdy provider paymant
   Category/ Module  :  GAP Subsidy
   Root cause: Incorrect Subsidy provider in the GAP case
   Fix Provided: Data fix to correct the provider id for GAP subsidy rate as requested by the user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
*/

update gapagreementrate 
set provider_id = '5083542', 
    updatedby='CDM-42194', 
    updatedon = now() 
where gapagreementid='7c279667-3e34-4c3a-967b-ee69074e046e' and gapagreementrateid = 'e15e591c-88a8-468b-a502-0ee443514026';


update gapratesrevision 
set provider_id = '5083542', 
    updatedby='CDM-42194', 
    updatedon = now() 
where gaprateid = 'e15e591c-88a8-468b-a502-0ee443514026';