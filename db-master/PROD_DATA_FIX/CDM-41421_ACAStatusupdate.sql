-- CDM-41421 - ACA Review Status
/* Issue Description: User Error updated ACA instead of Adoption initial Eligibility

-- Root cause: ACA previously completed and approved. CJAMS is showing the ACA in "Review Status". 
-- Fix Provided: Datafix has been provided to update ivestatus
-- Pull request# N/A

*/

/*
 COMPLETED,	Child tested positive for amphetamines and methadone. Mother was positive for methadone, amphetamines and benzodiazepines. Mother has history of heroin and cocaine use. Mother has been diagnosed with ADHD, mood disorder, depression and an eating disorder.
*/
update adoptionapplicabilityinfo set ivestatus = 'APPROVED',
raceorethnicitywithoneofthesabove = 'Child tested positive for amphetamines and methadone. Mother was positive for methadone, amphetamines and benzodiazepines. Mother has history of heroin and cocaine use. Mother has been diagnosed with ADHD, mood disorder, depression and an eating disorder.',
updatedby = 'CDM-41421', updatedon= now()
where adoptionapplicabilityid = '7abce2eb-7693-4d28-af1d-bf06b0db9912';

