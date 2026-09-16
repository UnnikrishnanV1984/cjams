update personnytddetail 
set activeflag =0, validatedflag =0, updatedon =now(), updatedby ='CDM-9984'
where summaryid ='f5544c6f-9f28-4e1e-a42c-da2439867dac';

update personnytdsummary 
set activeflag =0, validationflag =0, updatedon =now(), updatedby ='CDM-9984'
where summaryid ='f5544c6f-9f28-4e1e-a42c-da2439867dac';