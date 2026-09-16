/*
   Issue Description: CDM-23648
   Category/ Module  :  Traditional Candidacy List
   Root cause: ImminentRisks moved back to None from SDU
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update serviceplan set involvedpersons =
'{"persons":[{"name":"KYLIE R SIMMS ","id":"3912468",
"imminentrisks":["NONE"],"comment":null,
"livingininformalkinship":null,
"enablecomment":null,"enablelivinginink":null,
"previousriskreasonids":["SUD"]},
{"name":"Gracelynn Simms ","id":"200160902",
"imminentrisks":["NONE"],"comment":null,"livingininformalkinship":null,"enablecomment":null,"enablelivinginink":null,"previousriskreasonids":["SUD"]}]}', updatedby = 'CDM-23648', updatedon = now()
  where serviceplanid = '3f66f600-8510-43aa-bda8-6cb3969a681c';