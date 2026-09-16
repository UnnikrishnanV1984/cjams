/* Issue Description: CDM-13337 Acounts Payable
   Category/ Module  :  Purchase authorization
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update routing set tosecurityusersid='5bd8f401-272c-45c0-9bd1-d38a1e359d4a', updatedby='CDM-13337', 
updatedon=now() where routingid in ('9ac07242-8756-4200-99c6-cafbeecbd79f','0afdfdc5-e12f-474f-a7b4-5077ce0463f4','91603775-1f24-4a32-b750-6cacff3986f1')
and objectid in (1770323,1770324,1770325);

update routing set fromsecurityusersid='5bd8f401-272c-45c0-9bd1-d38a1e359d4a',
teamid='b431ff54-c49b-4b06-9c1d-bef4b09c62b8', updatedby='CDM-13337', 
updatedon=now() where routingid in ('733458d7-044e-4ac4-b9ee-4918fa815360','9e3324e3-3444-4f85-93fe-ce95c59d9f19','4292ccde-36f3-42cb-b0d1-84e3309fa1f4') 
and objectid in (1770323,1770324,1770325);
