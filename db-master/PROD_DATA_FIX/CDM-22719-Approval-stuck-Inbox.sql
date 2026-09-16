/*
   Issue Description: CDM-22719
   All cases and assessments under Case Pending Approval 
   and Assessment Pending Approval inbox have been approved. Need to remove all from user dashboard.
*/


update routing 
set activeflag = 0, updatedby = 'CDM-22719', updatedon = now()
where routingid in ('d6b40a01-f2d8-42a4-b790-5115dd8ab853',
'59bffc19-3fb0-49c4-89c5-a292e82786a0',
'48378855-0589-49bf-8a19-1ad86d10285b',
'5d83d33a-b536-4553-81aa-511575121999',
'33526107-878d-4ab4-819d-d2ba777c46d1',
'd8d15fde-ab5b-407c-b998-348409e1f30b',
'95207133-c117-49a7-bdbe-20a281c666f6',
'ef1342f0-3e12-4edf-b13a-f9148c798002',
'680b09c2-dd76-4d32-9e84-bcd4ae04f986',
'b3795e7a-e7ad-44a9-9ec0-836928c6da88',
'8c5ee1de-a430-495d-ac22-24bcf708ce92',
'1e7b7cbe-6e7f-4ee6-806e-96f1be11513f',
'75ce8cd1-f576-498e-b55c-bc1e3a816ca5',
'fdf08cef-8f59-46c8-942f-a70cd144bc60',
'9f6cf533-9e9c-4235-a58e-5f2474a9d0e6');
