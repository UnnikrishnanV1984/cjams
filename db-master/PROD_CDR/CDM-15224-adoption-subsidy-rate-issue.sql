update 
adoptionagreement
set
activeflag = 0,
updatedby = 'CDM-15224',
updatedon = now()
where adoptionagreementid in ('30a25352-12a7-4c12-85d0-52d9b1ba610d', 'fbcb59ba-4750-44a1-ade1-c1727abf4908');
