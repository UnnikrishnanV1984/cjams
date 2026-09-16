/*
   Issue Description: CDM-32534
   Category/ Module  : TPR Court  
   Root cause: data insertion missing due to code issue, code implementation done after this records insertion   
   Fix Provided: Did data fix to insert proper data 
   This issie code fix was done by the ticket CDM-32534--B-155782 - TPR Subtab
*/

-- iscontested value as well 

update cjams.tprdetails set tprpetitiondate ='2021-05-24 00:00:00',iscontested='false', tprdecisiondate ='2021-12-01 00:00:00' , updatedby ='CDM-32534', updatedon = now()
where tprdetailsid in ('3d48ccaa-66fe-49fe-bebb-3ec5e52172fb');


update cjams.tprdetails set tprpetitiondate ='2021-05-24 00:00:00',iscontested='false',tprdecisiondate ='2021-12-01 00:00:00', updatedby ='CDM-32534', updatedon = now()
where tprdetailsid in ('239d3b97-b36b-424b-bbac-36e733f4742c');


update cjams.tprdetails set tprpetitiondate ='2021-05-24 00:00:00',iscontested='false', updatedby ='CDM-32534', updatedon = now()
where tprdetailsid in ('ced1b82b-df16-4d6d-aeaa-b9d775c608cb');


update cjams.tprdetails set tprpetitiondate ='2021-05-24 00:00:00',iscontested='false', updatedby ='CDM-32534', updatedon = now()
where tprdetailsid in ('7f5eb46f-5a1e-4295-acf4-025d582e2274');
