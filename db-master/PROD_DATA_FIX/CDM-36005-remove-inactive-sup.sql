/*
   Issue Description: CDM-36005
   Category/ Module  : Deleted sups showing 
   Root cause: Colleen Bokman is showing up as the person is having pending assessments.
   Resolution: Updated routing to remove the supervisor with pending assessments.
   Pull request# N/A
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: data fix
*/


select activeflag, * from routing 
where routingid in ('2e9259e3-0dd8-448d-a78a-66ea14c4680b', '8e66b7c9-1b65-4190-b572-41b1219e6461',
       'e537a34f-8c1e-4810-85ad-ec14c0edfad1');   
      
update routing set activeflag = 0, updatedby='CDM-36005', updatedon=now()
where routingid in ('2e9259e3-0dd8-448d-a78a-66ea14c4680b', '8e66b7c9-1b65-4190-b572-41b1219e6461',
       'e537a34f-8c1e-4810-85ad-ec14c0edfad1');