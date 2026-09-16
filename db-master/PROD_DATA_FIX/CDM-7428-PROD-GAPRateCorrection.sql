update gapagreementrate 
set paymentamout =800, updatedon =now(), updatedby ='CDM-7428'
where gapagreementrateid ='1a6c8ec8-50af-4635-b306-d55a688830f0';

update gapratesrevision 
set paymentamt =800, approvaldate =now(), updatedon =now(), updatedby ='CDM-7428'
where gaprateid ='1a6c8ec8-50af-4635-b306-d55a688830f0';