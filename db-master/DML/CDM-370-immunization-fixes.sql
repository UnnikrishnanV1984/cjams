update personimmunizationconfig set uiconfig = '[
    {
        "date": null,
        "dose": "1st dose",
        "colspan": 3,
        "comments": ""
    }, {
        "date": null,
        "dose": "2nd dose",
        "colspan": 3,
        "comments": ""
    }, {
        "date": null,
        "dose": "3rd dose",
        "colspan": 3,
        "comments": ""
    }
]' where description = '(Tdap: ≥7 yrs)' and agetype = 'BIRTH_TO_15_M';

update personimmunizationconfig set uiconfig = '[
    {
        "date": null,
        "dose": null,
        "colspan": 1,
        "comments": ""
    }, {
        "date": null,
        "dose": "1st dose",
        "colspan": 1,
        "comments": ""
    }, {
        "date": null,
        "dose": null,
        "colspan": 2,
        "comments": ""
    }, {
        "date": null,
        "dose": "2nd dose",
        "colspan": 1,
        "comments": ""
    }
]' where description = '(Tdap: ≥7 yrs)' and agetype = '18_M_TO_18_Y';

