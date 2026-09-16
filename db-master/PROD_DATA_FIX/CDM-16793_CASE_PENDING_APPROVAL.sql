/*
   Issue Description: CDM-16793
   Category/ Module  : case approvals
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   
*/


update routing set activeflag  = 0, updatedby = 'CDM-16793', updatedon = now()
	where routingid in ('266770b7-5590-4018-96fa-ea5fa8e9ed6d', '85a24a97-40f8-4a09-954f-02c8aee37c56', '0e3b2c59-3d9f-4d1e-bc52-5af7ebd128c1', '5bd1be30-20b9-4ecd-935d-99725c173d08', 'a7edf52b-c39a-417c-8776-f49622772975');
