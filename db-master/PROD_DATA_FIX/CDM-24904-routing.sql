
 /*
  Issue Description:CDM-24904
   Category/ Module  :  Supervisor is not "seeing" items in her approval box.
   Root cause:
   Pull request# for code fix: Fixed as part of user story
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update routing set activeflag=0,
updatedby='CDM-24904', updatedon=now()
where objectid in (
'6b22f0a6-9172-41b0-bb4c-8610cadbb213',
'3ef362d6-73fb-4043-8a29-c5120dc9130a',
'a1c5fa43-49ce-4694-bfdc-377444c4df3e',
'40235521-0fad-4eca-b187-248a8a1edacf'
)
and routingstatustypeid=15 and activeflag=1;
