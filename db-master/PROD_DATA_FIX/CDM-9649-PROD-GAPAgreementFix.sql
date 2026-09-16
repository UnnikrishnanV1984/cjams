update gapagreement 
set activeflag =0, updatedon =now(), updatedby ='CDM-9649'
where gapagreementid ='186986c6-6f71-4287-b9aa-ab2f564ac849';

update gapagreementrate 
set activeflag =0, updatedon =now(), updatedby ='CDM-9649'
where gapagreementid ='186986c6-6f71-4287-b9aa-ab2f564ac849';

update gapagreementrevision 
set activeflag =0, updatedon =now(), updatedby ='CDM-9649'
where gapagreementid ='186986c6-6f71-4287-b9aa-ab2f564ac849';

update gapratesrevision 
set activeflag =0, updatedon =now(), updatedby ='CDM-9649'
where gaprateid ='00df6396-aabf-4ce9-b1fb-465217bdb7c3';

update routing 
set activeflag =0, updatedon =now(), updatedby ='CDM-9649'
where routingid in ('855f4807-d357-4fa9-98e0-1ca827db32d7','2126d8be-860e-4b7e-adc4-0a2207abc44a');