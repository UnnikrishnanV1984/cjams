update serviceplan
set
serviceplancandidacy = '{
    "candidates": [
        {
            "id": "3113667",
            "name": "DIAMOND SANAE LYLES ",
            "candidacy": "0"
        },
        {
            "id": "3113666",
            "name": "WILLIAM LYLES ",
            "candidacy": "0"
        },
        {
            "id": "3673602",
            "name": "DOMINIC SAVAGE ",
            "candidacy": "0"
        },
        {
            "id": "4390950",
            "name": "DREYTON PETERS ",
            "candidacy": "0"
        },
        {
            "id": "4439673",
            "name": "LORENZO LOUIS HARRIS ",
            "candidacy": "0"
        }
    ]
}',
updatedon = now(),
updatedby = 'CDM-12231'
 where serviceplanid = '421ab592-3aad-4f9d-8ba6-abe177d5a814';