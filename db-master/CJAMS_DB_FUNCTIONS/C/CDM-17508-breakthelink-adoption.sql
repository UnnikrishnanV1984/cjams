select * from createadoptioncase(
'3f53743b-a882-4561-9fb3-54fc9750ac5a':: uuid,
'f90f2de0-be97-4dc4-9c80-0c7625fedb9d' :: uuid,
'[
    {
      "personid": "1ab5bfba-2a4e-4dbe-ba96-cac058164e48",
      "firstname": "AYDEN",
      "lastname": "PAGE",
      "middlename": "SHERARD",
      "dob": "2012-02-14T05:00:00.000Z",
      "gendertypekey": "M",
      "role": "RC",
      "address": [
        {
          "address": "906 Valley St",
          "address2": "Newcomb",
          "personaddresstypekey": "C",
          "zipcode": "99999",
          "city": "albaniya",
          "state": "AR",
          "country": "USA",
          "county": "MD"
        }
      ],
      "contact": [
        {
          "personphonetypekey": "P",
          "phonenumber": "199999949",
          "phoneextension": ""
        }
      ]
    }
  ]':: jsonb,
'ba2dbc8f-3213-4b1b-9905-d643e1692db1':: character varying, 
'ba2dbc8f-3213-4b1b-9905-d643e1692db1' :: character varying);