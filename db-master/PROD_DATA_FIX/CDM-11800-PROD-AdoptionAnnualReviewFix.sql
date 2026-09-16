update adoptioniverenewal 
set activeflag =0, updatedon =now(), updatedby ='CDM-11800'
where adoptioniverenewalid ='7a2eab19-622b-45f0-a66f-308238ddef63';

update routing 
set activeflag =0, updatedon =now(), updatedby ='CDM-11800'
where routingid ='cc585175-162f-490f-baae-3ce92cf2f680';