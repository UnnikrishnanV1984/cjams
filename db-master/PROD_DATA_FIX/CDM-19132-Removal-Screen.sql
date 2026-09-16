/*
 Issue Description: Removal Screen
 Category/ Module: Removal
 Root cause: update
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update routing set activeflag =0, updatedby = 'CDM-19132', updatedon = now() where routingid in ('045f0228-918f-4fac-8fac-f3549f34af43','d00f8b6c-498b-408a-b78c-4a703a3f2a3b','506a225d-d875-4503-a2fc-088fd4021690','c04641e4-b04d-4530-b94c-f118175d9c05');
update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-19132', updatedon = now() where intakeservreqchildremovalid in ('63b4e631-5bf2-4846-9db8-9b64be13e9d1','fd27153b-cb8a-419e-bb7e-254b1e594570','6cdc608a-69de-4a2e-b647-e2c8e7e7728e','564f1992-f82f-4f69-b01a-0005df6838ba');