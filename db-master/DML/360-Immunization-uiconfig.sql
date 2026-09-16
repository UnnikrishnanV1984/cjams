update personimmunizationconfig 
set uiconfig = '[
  {
    "date": null,
    "dose": "1st dose",
    "colspan": 2,
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
    "dose": "3rd dose",
    "colspan": 2,
    "comments": ""
  },
  {
    "date": null,
    "dose": "4th dose",
    "colspan": 1,
    "comments": ""
  },
  {
    "date": null,
    "dose": "5th dose",
    "colspan": 1,
    "comments": ""
  },
  {
    "date": null,
    "dose": "6th dose",
    "colspan": 1,
    "comments": ""
  }
]'::json
where personimmunizationconfigid ='1b33670b-e60d-4cb8-aa0d-d76bb4e74a7f' and agetype = '18_M_TO_18_Y';

update personimmunizationconfig 
set uiconfig = '[
  {
    "date": null,
    "dose": "4th dose",
    "colspan": 9,
    "comments": ""
  }
]'::json
where personimmunizationconfigid ='e168a53c-5ace-47e0-baff-b157c932d714' and agetype = '18_M_TO_18_Y';


update personimmunizationconfig 
set uiconfig = '[
  {
    "date": null,
    "dose": "3rd dose",
    "colspan": 1,
    "comments": ""
  },
  {
    "date": null,
    "dose": "4th dose",
    "colspan": 2,
    "comments": ""
  },
  {
    "date": null,
    "dose": "5th dose",
    "colspan": 1,
    "comments": ""
  },
  {
    "date": null,
    "dose": null,
    "colspan": 5,
    "comments": ""
  }
]'::json
where personimmunizationconfigid ='55d437f0-d602-4c34-a16c-f5fcdfd5cdcd' and agetype = '18_M_TO_18_Y';

update personimmunizationconfig 
set uiconfig = '[
  {
    "date": null,
    "dose": "1st dose",
    "colspan": 2,
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
    "colspan": 5,
    "comments": ""
  }
]'::json
where personimmunizationconfigid ='3b8bda19-3bd8-4ee4-84a0-835a51c7ecaa' and agetype = '18_M_TO_18_Y';

update personimmunization
set dose = '1st dose'
where personimmunizationid = 'c314ece3-4748-4b21-b186-4da1b32aece1';

update personimmunization
set dose = '2nd dose'
where personimmunizationid = '667eb18d-2892-4c62-95d7-176eb81e4d8e';