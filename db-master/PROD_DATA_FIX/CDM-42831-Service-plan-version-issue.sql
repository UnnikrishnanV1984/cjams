/*
Issue Description: Please do the needful Data fix as needed (service plan)
Category/Module: Error
Root cause: Users cannot save Traditional eligibility data in old plans after recent update
Fix provided: DB query to edit service plan and show the traditional eligibility data
Code/Data fix ticket#: CDM-42831
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CDM-42831
Reason why no related code fix:
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update serviceplan 
set
serviceplancandidacy =
'{
    "candidates": [],
    "candidatestraditional": [
        {
            "id": "200177173",
            "ebp": {
                "notes": null,
                "utilized": null,
                "utilizedtypes": null,
                "additionalinfo": null,
                "noadditionalinfo": "No",
                "isebpreferralmade": "No"
            },
            "name": "Sequoia Hamill ",
            "details":  "NONE",
            "candidacy": "0",
            "disabledate": false,
            "disablefield": false,
            "candidacydate": "2024-11-20T17:31:29.896Z",
            "imminentrisks": [
                "NONE"
            ]
        },
        {
            "id": "200177174",
            "ebp": {
                "notes": null,
                "utilized": null,
                "utilizedtypes": null,
                "additionalinfo": null,
                "noadditionalinfo": "No",
                "isebpreferralmade": "No"
            },
            "name": "Liam Murphy ",
            "details": "NONE",
            "candidacy": "0",
            "disabledate": false,
            "disablefield": false,
            "candidacydate": "2024-11-20T17:31:20.275Z",
            "imminentrisks": [
                "NONE"
            ]
        },
        {
            "id": "200177176",
            "ebp": {
                "notes": null,
                "utilized": null,
                "utilizedtypes": null,
                "additionalinfo": null,
                "noadditionalinfo": "No",
                "isebpreferralmade": "No"
            },
            "name": "Rylee E Murphy ",
            "details": "NONE",
            "candidacy": "0",
            "disabledate": false,
            "disablefield": false,
            "candidacydate": "2024-11-20T17:31:36.122Z",
            "imminentrisks": [
                "NONE"
            ]
        },
        {
            "id": "200177177",
            "ebp": {
                "notes": null,
                "utilized": null,
                "utilizedtypes": null,
                "additionalinfo": null,
                "noadditionalinfo": "No",
                "isebpreferralmade": "No"
            },
            "name": "Jack Murphy ",
            "details": "NONE",
            "candidacy": "0",
            "disabledate": false,
            "disablefield": false,
            "candidacydate": "2024-11-20T17:31:37.369Z",
            "imminentrisks": [
                "NONE"
            ]
        }
    ]
}' :: jsonb,
involvedpersons = '{
    "persons": [
        {
            "name": "Sequoia Hamill ",
            "id": "200177173",
            "imminentrisks": [
                "NONE"
            ],
            "comment": null,
            "disabledit": false,
            "livingininformalkinship": null,
            "enablelivinginink": false,
            "previousriskreasonids": [
                "NONE"
            ],
            "ebp": {
                "isebpreferralmade": "No",
                "utilized": null,
                "utilizedtypes": null,
                "additionalinfo": null,
                "noadditionalinfo": "No",
                "notes": null
            }
        },
        {
            "name": "Liam Murphy ",
            "id": "200177174",
            "imminentrisks": [
                "NONE"
            ],
            "comment": null,
            "disabledit": false,
            "livingininformalkinship": null,
            "enablelivinginink": false,
            "previousriskreasonids": [
                "NONE"
            ],
            "ebp": {
                "isebpreferralmade": "No",
                "utilized": null,
                "utilizedtypes": null,
                "additionalinfo": null,
                "noadditionalinfo": "No",
                "notes": null
            }
        },
        {
            "name": "Rylee E Murphy ",
            "id": "200177176",
            "imminentrisks": [
                "NONE"
            ],
            "comment": null,
            "disabledit": false,
            "livingininformalkinship": null,
            "enablelivinginink": false,
            "previousriskreasonids": [
                "NONE"
            ],
            "ebp": {
                "isebpreferralmade": "No",
                "utilized": null,
                "utilizedtypes": null,
                "additionalinfo": null,
                "noadditionalinfo": "No",
                "notes": null
            }
        },
        {
            "name": "Jack Murphy ",
            "id": "200177177",
            "imminentrisks": [
                "NONE"
            ],
            "comment": null,
            "disabledit": false,
            "livingininformalkinship": null,
            "enablelivinginink": false,
            "previousriskreasonids": [
                "NONE"
            ],
            "ebp": {
                "isebpreferralmade": "No",
                "utilized": null,
                "utilizedtypes": null,
                "additionalinfo": null,
                "noadditionalinfo": "No",
                "notes": null
            }
        }
    ]
}',
updatedby = 'CDM-42831', updatedon = now()
where serviceplanid='a0c72786-cb43-4243-80df-1b5749ae21fa' and activeflag=1;