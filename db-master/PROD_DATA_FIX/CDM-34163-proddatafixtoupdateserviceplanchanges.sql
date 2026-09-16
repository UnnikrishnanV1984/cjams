/*
   Issue Description: CDM-32799
   Category/ Module  : Prod data fix to remove the Person program area for a dummy case
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- None
update serviceplan set involvedpersons = jsonb_set(involvedpersons::jsonb, '{persons}', 		 
			jsonb_set((involvedpersons->'persons')::jsonb, '{0}', 
			jsonb_set((involvedpersons->'persons'->0)::jsonb, '{imminentrisks}', '["DJSI"]'))
			)
			,updatedby = 'CDM-34163', updatedon = now()
where serviceplanid = '98a6c1f4-cc8e-4d32-8bd7-f7cb9b73d756';

-- None
update serviceplan set involvedpersons = jsonb_set(involvedpersons::jsonb, '{persons}', 		 
			jsonb_set((involvedpersons->'persons')::jsonb, '{1}', 
			jsonb_set((involvedpersons->'persons'->1)::jsonb, '{imminentrisks}', '["DJSI"]'))
			)
			,updatedby = 'CDM-34163', updatedon = now()
where serviceplanid = '98a6c1f4-cc8e-4d32-8bd7-f7cb9b73d756';



/*
{"candidates": [{"id": "4417028", "name": "TANOSHIA S CANNON ", "candidacy": "0", "disabledate": false, "candidacydate": "2023-07-24T20:35:37.592Z"}, {"id": "4417029", "name": "STEF T WHALEY ", "candidacy": "0", "disabledate": false, "candidacydate": "2023-07-24T20:35:37.593Z"}], "candidatestraditional": [{"id": "4417028", "name": "TANOSHIA S CANNON ", "candidacy": null, "disablefield": false, "candidacydate": null}, {"id": "4417029", "name": "STEF T WHALEY ", "candidacy": null, "disablefield": false, "candidacydate": null}]}
*/

update serviceplan set serviceplancandidacy = '{
    "candidates": [
        {
            "candidacy": "1",
            "candidacydate": "2023-07-24T20:35:37.592Z",
            "disabledate": true,
            "id": "4417028",
            "name": "TANOSHIA S CANNON "
        },
        {
            "candidacy": "1",
            "candidacydate": "2023-07-24T20:35:37.593Z",
            "disabledate": true,
            "id": "4417029",
            "name": "STEF T WHALEY "
        }
    ],
    "candidatestraditional": [
    ]
}',updatedby = 'CDM-34163', updatedon = now()
where serviceplanid = '98a6c1f4-cc8e-4d32-8bd7-f7cb9b73d756';