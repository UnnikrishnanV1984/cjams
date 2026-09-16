update youthtransitionplan

set 

moneymanagement_json = '{
    "goals": [
        {
            "goal": "Open a bank account",
            "actions": [
                {
                    "action_plan": "Go to bank"
                }
            ],
            "projected_date": "2021-01-31T05:00:00.000Z",
            "responsible_parties": {
                "lastname": "FRACZKOWSKI",
                "personid": "171bdcdc-0ed8-4dca-a361-2e580ba97cd7",
                "firstname": "HEAVEN"
            }
        }
    ],
    "doyouknow": [
        {
            "value": 0,
            "comments": "Too young to obtain one.",
            "question": "Your credit score?"
        },
        {
            "value": 1,
            "comments": "Too young to obtain one.",
            "question": "Why credit history is so important?"
        },
        {
            "value": 1,
            "comments": "Too young to obtain one.",
            "question": "The importance of having a bank account (i.e. savings/checking) and budgeting?"
        }
    ],
    "goalAmount": 0,
    "accountDesc": null,
    "isCompleted": true,
    "isNoAccount": true,
    "savingMoney": 0,
    "monthlyAmount": 0,
    "isInaccuracies": 0,
    "sourceofIncome": "0.00",
    "isSavingsAccount": null,
    "receivedFreeCopy": 0,
    "ischeckingAccount": null,
    "currentAmountSaved": 0,
    "keepingMonthlyBudget": 0
}',

sracc_json = '{
    "goals": [],
    "isCompleted": true,
    "longTermGoals": "communicate.",
    "spiritualSupport": "NA",
    "effortstoIdentify": "NA",
    "involvedinCommunity": 0,
    "currentSystemSupport": "Keith Carter. Mr. Carter is like father figure.  Mr. Carter supports her mentally and educationally. He care about her future.",
    "involvedinCommunityDesc": null
}',

health_json = '{
    "goals": [],
    "doyouknow": [
        {
            "value": 1,
            "comments": "",
            "question": "Regular exams and annual physicals are important to maintain good health."
        },
        {
            "value": 1,
            "comments": "",
            "question": "The purpose of each medication you’ve been prescribed?"
        }
    ],
    "isCompleted": true,
    "health_goals": "Make and keep medicals appointment.",
    "healthissues": [],
    "medical_plan": "Apply for Maryland connections medical insurance.",
    "health_status": "No health concerns.",
    "make_decision": "Keith Carter.",
    "health_care_agent": true,
    "advance_directive_health": true
}',
updatedon = now(),

updatedby = 'CDM-10331'

where  youthtransitionplanid = '70aa1e5d-22d4-4d19-80d0-e215e9e17241';