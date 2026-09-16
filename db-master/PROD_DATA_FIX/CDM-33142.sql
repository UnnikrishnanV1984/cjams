/*
   Issue Description: CDM-33142
   Category/ Module  :  Approval inbox 
   Root cause: due to securityuserid issue and multiclick functionality   
    Fix Provided: Did data fix to remove the extra approval record  
*/

update cjams.routing set activeflag =0, updatedby ='CDM-33142', updatedon = now()
where routingid in ('4527b03b-7f9b-45a6-a4fb-1b8870dc38f6',
'520060b9-457a-435f-bc59-73948d0416ca',
'696eb820-8f3a-4bbb-9b05-9425998c16d4',
'6980e0e4-1798-4140-ab1b-f457e1bc67eb',
'2b51a75f-cf38-4025-8e5f-b89c0080052d',
'42e7a321-8917-4c17-99d8-3842644c3dcf');