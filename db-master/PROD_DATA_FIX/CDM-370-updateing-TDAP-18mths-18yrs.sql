update personimmunizationconfig set uiconfig = '[
    {
        "date": null,
        "dose": null,
        "colspan": 1,
        "comments": ""
    }, {
        "date": null,
        "dose": "4th dose",
        "colspan": 1,
        "comments": ""
    }, {
        "date": null,
        "dose": null,
        "colspan": 2,
        "comments": ""
    }, {
        "date": null,
        "dose": "5th dose",
        "colspan": 1,
        "comments": ""
    }
]' where description = '(Tdap: ≥7 yrs)' and agetype = '18_M_TO_18_Y';