update routing 
set activeflag =0, updatedon =now(), updatedby ='CDM-7286'
where routingid in ('c4861bf0-8fa5-4bc1-a50b-0fb1057bd7cd','18a6c1e2-b788-45f6-b563-1fb302d0e8fa');