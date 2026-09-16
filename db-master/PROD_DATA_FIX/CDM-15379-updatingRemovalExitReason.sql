 /*
  Issue Description: CDM-15379
   Category/ Module  :  Removing the duplicate removal exit reason
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update referencevalues set activeflag = 0, updatedby = 'CDM-15379', updatedon = now() where referencetypeid = '343' and ref_key in ('ADP','AF');

-- 'AF'
update intakeservreqchildremoval set removalexitreason = 'ADPFIN', updatedby = 'CDM-15379', updatedon = now() where intakeservreqchildremovalid in 
('c4c4e295-417e-43de-bd98-162e3bae7b57',
'64e73ba0-8c02-41ee-aa8c-6791e2156a83',
'c40356c9-08cb-42eb-87e4-cfba088d3a4a',
'e8dbe4e0-5cee-45c0-bb81-e36f7ceabcaa') and removalexitreason = 'AF';
