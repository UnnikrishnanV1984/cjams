UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata,'{addchildren}', '[
        {
            "seconeage": 3,
            "seconename": "FENIKS FORENSKI"
        },
        {
            "seconeage": 16, 
            "seconename": "Hailey Lowden"
        },
        { 
            "seconeage": 14,
            "seconename": "Anthony James"
        },
        {
            "seconeage": 10,
            "seconename": "Zachary Hudnall"
        },
        {
            "seconeage": 8, 
            "seconename": "Jacob  Hudnall-Lowden"
        }
    ]')
,updatedby = 'admin-D24579'
,updatedon = now()
WHERE assessmentid = '55032357-1239-4270-af42-a17a3aadb01d'
 and servicecaseid = '4183c794-124e-4d8e-8d13-05b5004c6b1e'
  and assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418';

UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{childs_info_json}','[{"childname":"ELLIE FORENSKI","clientid":"4460810","age":"7"},{"childname":"Hailey Lowden","clientid":"200002290","age":"15"},{"childname":"Anthony James","clientid":"200002291","age":"14"},{"childname":"Zachary Hudnall","clientid":"200002292","age":"10"},{"childname":"Jacob  Hudnall-Lowden","clientid":"200002293","age":"8"}]')
,updatedby = 'admin-D24579'
,updatedon = now()
WHERE assessmentid = '55032357-1239-4270-af42-a17a3aadb01d'
 and servicecaseid = '4183c794-124e-4d8e-8d13-05b5004c6b1e'
  and assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418';

UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
        {
            "age": "7",
            "clientid": "4460810",
            "childname": "ELLIE FORENSKI"
        },
        {
            "age": "15",
            "clientid": "200002290",
            "childname": "Hailey Lowden"
        },
        {
            "age": "14",
            "clientid": "200002291",
            "childname": "Anthony James"
        },
        {
            "age": "10",
            "clientid": "200002292",
            "childname": "Zachary Hudnall"
        },
        {
            "age": "8",
            "clientid": "200002293",
            "childname": "Jacob  Hudnall-Lowden"
        }
    ]')
,updatedby = 'admin-D24579'
,updatedon = now()
WHERE assessmentid = '55032357-1239-4270-af42-a17a3aadb01d'
and servicecaseid = '4183c794-124e-4d8e-8d13-05b5004c6b1e'
and assessmenttemplateid = '0f01e16c-73db-42d8-ad84-04eeb5e26418'; 