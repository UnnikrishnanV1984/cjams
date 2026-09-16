update routing 
set activeflag = 0, updatedon = now(), updatedby = 'S20200239014782'
where routingid in ('96ccb4bd-4eef-4c2a-ab42-534121ce5bec','74205195-fb4d-4f23-b889-1b0788421fc0','8a7c10ea-4574-464f-88fd-891b5f325af2');

update gapagreement 
set activeflag = 0, updatedon = now(), updatedby = 'S20200239014782'
where gapagreementid = '3758d6a8-0118-431a-86e7-0d452fc6cff4';