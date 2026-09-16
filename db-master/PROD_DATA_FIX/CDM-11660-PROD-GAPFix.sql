update gapagreement 
set enddate ='2021-03-31 00:00:00', updatedon =now(), updatedby ='CDM-11660'
where gapagreementid ='e605e04c-0706-4d82-ab65-186776c9939e';

update gapagreementrevision 
set enddate ='2021-03-31 00:00:00', updatedon =now(), updatedby ='CDM-11660'
where gapagreementid ='e605e04c-0706-4d82-ab65-186776c9939e';

update gapagreementrate 
set enddate ='2021-03-31 00:00:00', updatedon =now(), updatedby ='CDM-11660'
where gapagreementrateid ='ab1b8b32-3527-435d-9fec-e9adada5a0f4';

update gapratesrevision 
set rateenddate ='2021-03-31 00:00:00', updatedon =now(), updatedby ='CDM-11660'
where gaprateid ='ab1b8b32-3527-435d-9fec-e9adada5a0f4';