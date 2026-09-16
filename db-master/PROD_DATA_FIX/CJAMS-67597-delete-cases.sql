/*
   Issue Description: CJAMS-67597
   Root cause: User requested to delete the cases from intake transfer dashboard
   Fix Provided : Data fix is done to delete the cases from intake transfer dashboard
   Pull request# for code fix:  N/A
*/


update intaketransfers 
set activeflag =0, updatedby ='CJAMS-67597', updatedon =now()
where intaketransferid ='3034c90d-b7e2-4ade-92a2-ac8bcc4febd2' and intakenumber ='I231010545781';

update intaketransfers 
set activeflag =0, updatedby ='CJAMS-67597', updatedon =now()
where intaketransferid ='6ee99f34-a651-4ace-bc88-6de42be0c309' and intakenumber ='I231010623496';
