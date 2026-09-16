/*
 * CDM-35093 - Datafix on Imminent Risk Reason
 * Customer Email ID:taryn.shambaugh@maryland.gov
 * Customer Name:Taryn Shambaugh
 * Focus Area:Services: Service Plan
 * imminentrisks - case 3213584 (JAXSON BOSTJANCIC) from "none" to "Complex Psychological or Behavioral Needs"
 * Eligibility Determination need to be change to YES
 * 
 */

--select involvedpersons, * from serviceplan where serviceplanid = '92a8acd7-5c17-4ebc-84e1-4cc1d961bf80';
--select * from referencevalues where referencetypeid = 516;
update serviceplan set involvedpersons = jsonb_set(involvedpersons::jsonb, '{persons}', 		 
			jsonb_set((involvedpersons->'persons')::jsonb, '{2}', 
			jsonb_set((involvedpersons->'persons'->2)::jsonb, '{imminentrisks}', '["CPBN"]'))
			)
			,updatedby = 'CDM-35093', updatedon = now()
where serviceplanid = '92a8acd7-5c17-4ebc-84e1-4cc1d961bf80';

--select serviceplancandidacy, * from serviceplan where serviceplanid = '92a8acd7-5c17-4ebc-84e1-4cc1d961bf80';
update serviceplan set serviceplancandidacy = '{"candidates": [{"id": "2905228", "name": "TRYNITIE NEVAEH BOSTJANCIC ", "candidacy": "0", "candidacydate": "2023-06-08T12:03:09.579Z"}, {"id": "3336858", "name": "COLTEN A BOSTJANCIC ", "candidacy": "0", "candidacydate": "2023-06-08T12:03:09.579Z"}, {"id": "4288662", "name": "JAXSON BOSTJANCIC ", "candidacy": "1", "candidacydate": "2023-06-08T12:03:09.579Z"}], "candidatestraditional": [{"id": "2905228", "name": "TRYNITIE NEVAEH BOSTJANCIC ", "candidacy": "0", "candidacydate": "2023-06-08T12:03:22.698Z"}, {"id": "3336858", "name": "COLTEN A BOSTJANCIC ", "candidacy": "0", "candidacydate": "2023-06-08T12:03:23.169Z"}, {"id": "4288662", "name": "JAXSON BOSTJANCIC ", "candidacy": "1", "candidacydate": "2023-06-08T12:03:23.696Z"}]}',
updatedby = 'CDM-35093', updatedon = now() 
where serviceplanid ='92a8acd7-5c17-4ebc-84e1-4cc1d961bf80';
