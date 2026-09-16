const AT_BIRTH = 'At Birth';
const FIRST_MONTH = '1 Mo';
const BIRTH_TO_17 = 'BIRTH_TO_17_M';
const MONTH_18_TO_YEAR_18 = '18_M_TO_18_Y';
const YEAR_19_TO_YEAR_65 = 'YEAR_19_TO_YEAR_21';
const AGE_INDEPENDENT = 'AGE_INDEPENDENT';

export class ImmunizationConstants {

    public static filterDates = [
        {
            key: 'UPDATED_ON',
            value: 'Updated on'
        },
        {
            key: 'VACC_DATE',
            value: 'Vaccination Date'
        }
    ]
    
    public static ageGroups = [
        {
            key: BIRTH_TO_17,
            value: 'Birth to 17 Months'
        },
        {
            key: MONTH_18_TO_YEAR_18,
            value: '18 Months to 18 Years'
        },
        {
            key: YEAR_19_TO_YEAR_65,
            value: '19 Years to 21 Years'
        },
        {
            key: AGE_INDEPENDENT,
            value: 'Age Independent'
        }
    ]
    
    public static headerInfo = [{
        'title': 'Vaccine',
        'ageType': BIRTH_TO_17
    },
    {
        'title': AT_BIRTH,
        'ageType': BIRTH_TO_17
    },
    {
        'title': FIRST_MONTH,
        'ageType': BIRTH_TO_17
    },
    {
        'title': '2 Mos',
        'ageType': BIRTH_TO_17
    },
    {
        'title': '3 Mos',
        'ageType': BIRTH_TO_17
    },
    {
        'title': '6 Mos',
        'ageType': BIRTH_TO_17
    },
    {
        'title': '9 Mos',
        'ageType': BIRTH_TO_17
    },
    {
        'title': '12 Mos',
        'ageType': BIRTH_TO_17
    },
    {
        'title': '15 Mos',
        'ageType': BIRTH_TO_17
    },
    {
        'title': '16 Mos',
        'ageType': BIRTH_TO_17
    },
    {
        'title': '17 Mos',
        'ageType': BIRTH_TO_17
    },
    {
        'title': 'Vaccine',
        'ageType': MONTH_18_TO_YEAR_18
    },
    {
        'title': '18 Mos',
        'ageType': MONTH_18_TO_YEAR_18
    },
    {
        'title': '19-23 Mos',
        'ageType': MONTH_18_TO_YEAR_18
    },
    {
        'title': '2-3 yrs',
        'ageType': MONTH_18_TO_YEAR_18
    },
    {
        'title': '4-6 yrs',
        'ageType': MONTH_18_TO_YEAR_18
    },
    {
        'title': '7-10 yrs',
        'ageType': MONTH_18_TO_YEAR_18
    },
    {
        'title': '11-12 yrs',
        'ageType': MONTH_18_TO_YEAR_18
    },
    {
        'title': '13-15 yrs',
        'ageType': MONTH_18_TO_YEAR_18
    },
    {
        'title': '16 yrs',
        'ageType': MONTH_18_TO_YEAR_18
    },
    {
        'title': '17-18 yrs',
        'ageType': MONTH_18_TO_YEAR_18
    },
    {
        'title': 'Vaccine',
        'ageType': YEAR_19_TO_YEAR_65
    },
    {
        'title': '19-21 yrs',
        'ageType': YEAR_19_TO_YEAR_65
    },
    {
        'title': '22-26 yrs',
        'ageType': YEAR_19_TO_YEAR_65
    },
    {
        'title': '27-49 yrs',
        'ageType': YEAR_19_TO_YEAR_65
    },
    {
        'title': '50-64 yrs',
        'ageType': YEAR_19_TO_YEAR_65
    },
    {
        'title': '>=65 yrs',
        'ageType': YEAR_19_TO_YEAR_65
    }
];

    public static vaccines = [
        {
            "totalcount": "3",
            "personimmunizationconfigid": "f67577ce-69b7-47ce-844e-84c827e5a263",
            "value_text": "Hepatitis B",
            "description": "HepB",
            "uiconfig": [
                {
                    "date": null,
                    "dose": "1st dose",
                    "colspan": 1,
                    "comments": ""
                },
                {
                    "date": null,
                    "dose": "2nd dose",
                    "colspan": 2,
                    "comments": ""
                },
                {
                    "date": null,
                    "dose": null,
                    "colspan": 1,
                    "comments": ""
                },
                {
                    "date": null,
                    "dose": "3rd dose",
                    "colspan": 4,
                    "comments": ""
                }
            ],
            "agetype": "B"
        },
        {
            "totalcount": "3",
            "personimmunizationconfigid": "da507720-99a0-4970-90a9-22a7ced1a0ef",
            "value_text": "Rotavirus",
            "description": "RV RV1",
            "uiconfig": [
                {
                    "date": null,
                    "dose": null,
                    "colspan": 2,
                    "comments": ""
                },
                {
                    "date": null,
                    "dose": "1st dose",
                    "colspan": 1,
                    "comments": ""
                },
                {
                    "date": null,
                    "dose": "2nd dose",
                    "colspan": 1,
                    "comments": ""
                },
                {
                    "date": null,
                    "dose": null,
                    "colspan": 2,
                    "comments": ""
                },
                {
                    "date": null,
                    "dose": "3rd dose",
                    "colspan": 2,
                    "comments": ""
                }
            ],
            "agetype": "B"
        },
        {
            "totalcount": "3",
            "personimmunizationconfigid": "66491538-4857-4cfc-9aa3-cfc07fc13000",
            "value_text": "Diptheria, tetanus &  acelluar pertussis",
            "description": "(DTaP: <7yrs)",
            "uiconfig": [
                {
                    "date": null,
                    "dose": null,
                    "colspan": 2,
                    "comments": ""
                },
                {
                    "date": null,
                    "dose": "1st dose",
                    "colspan": 1,
                    "comments": ""
                },
                {
                    "date": null,
                    "dose": "2nd dose",
                    "colspan": 1,
                    "comments": ""
                },
                {
                    "date": null,
                    "dose": null,
                    "colspan": 2,
                    "comments": ""
                },
                {
                    "date": null,
                    "dose": "3rd dose",
                    "colspan": 2,
                    "comments": ""
                }
            ],
            "agetype": "B"
        }
    ]
    /* [
        {
            'totalcount': '39',
            'picklist_value_cd': '2592',
            'picklist_type_id': 231,
            'value_tx': 'Hepatitis B',
            'description_tx': 'HepB',
            'config': [
                {
                    'dose': '1st dose',
                    'date': null,
                    'comments': '',
                    'colspan': 1
                },
                {
                    'dose': '2nd dose',
                    'date': null,
                    'comments': '',
                    'colspan': 2 // 
                },
                {
                    'dose': null,
                    'date': null,
                    'comments': '',
                    'colspan': 1 // 
                },
                {
                    'dose': '3rd dose',
                    'date': null,
                    'comments': '',
                    'colspan': 4
                }
            ]
        },
        {
            'totalcount': '39',
            'picklist_value_cd': '2593',
            'picklist_type_id': 231,
            'value_tx': 'Rotavirus',
            'description_tx': 'RV RV1',
            'config': [
                {
                    'dose': null,
                    'date': null,
                    'comments': '',
                    'colspan': 2
                },
                {
                    'dose': '1st dose',
                    'date': null,
                    'comments': '',
                    'colspan': 1 // 
                },
                {
                    'dose': '2nd dose',
                    'date': null,
                    'comments': '',
                    'colspan': 1 // 
                },
                {
                    'dose': null,
                    'date': null,
                    'comments': '',
                    'colspan': 4
                }
            ]
        },
        {
            'totalcount': '39',
            'picklist_value_cd': '2594',
            'picklist_type_id': 231,
            'value_tx': 'Diptheria, tetanus &  acelluar pertussis',
            'description_tx': 'DTAP',
            'config': [
                {
                    'dose': null,
                    'date': null,
                    '   ': '',
                    'colspan': 2
                },
                {
                    'dose': '1st dose',
                    'date': null,
                    'comments': '',
                    'colspan': 1 // 
                },
                {
                    'dose': '2nd dose',
                    'date': null,
                    'comments': '',
                    'colspan': 1 // 
                },
                {
                    'dose': '3rd dose',
                    'date': null,
                    'comments': '',
                    'colspan': 1
                },
                {
                    'dose': null,
                    'date': null,
                    'comments': '',
                    'colspan': 2
                },
                {
                    'dose': '4th dose',
                    'date': null,
                    'comments': '',
                    'colspan': 1
                }
            ]
        },
        {
            'totalcount': '39',
            'picklist_value_cd': '2595',
            'picklist_type_id': 231,
            'value_tx': 'Haernophilus influenzae type b',
            'description_tx': 'Hib',
            'config': [
                {
                    'dose': null,
                    'date': null,
                    'comments': '',
                    'colspan': 2
                },
                {
                    'dose': '1st dose',
                    'date': null,
                    'comments': '',
                    'colspan': 1 // 
                },
                {
                    'dose': '2nd dose',
                    'date': null,
                    'comments': '',
                    'colspan': 1 // 
                },
                {
                    'dose': null,
                    'date': null,
                    'comments': '',
                    'colspan': 2
                },
                {
                    'dose': '3rd dose',
                    'date': null,
                    'comments': '',
                    'colspan': 2
                }
            ]
        }
    ] */
}
