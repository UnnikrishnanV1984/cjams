/*
   Issue Description: CJAMS-67599
   Root cause: User requested to delete the cases from intake transfer dashboard
   Fix Provided : Data fix is done to delete the cases from intake transfer dashboard
   Pull request# for code fix:  N/A
*/

update intaketransfers 
set activeflag =0, updatedby ='CJAMS-67599', updatedon =now()
where intaketransferid ='fd8ceb36-48b4-4b94-8fdd-bba9106fcc32' and intakenumber ='I231010577454';

update intaketransfers 
set activeflag =0, updatedby ='CJAMS-67599', updatedon =now()
where intaketransferid ='37071da7-271d-4188-8183-a47bba2b7b2e' and intakenumber ='I221010297212';

update routing 
set activeflag =0, updatedby ='CJAMS-67599', updatedon =now()
where objectid ='fd8ceb36-48b4-4b94-8fdd-bba9106fcc32' and activeflag =1;

update routing 
set activeflag =0, updatedby ='CJAMS-67599', updatedon =now()
where objectid ='37071da7-271d-4188-8183-a47bba2b7b2e' and activeflag =1;