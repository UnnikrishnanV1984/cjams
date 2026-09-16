-- CIDM-5492 - SAFE-C Data Fix needed (bulk cases)
/*
-- Issue Description: 
   Safe-C Assessments with missing child info. 
  
-- Category/ Module: Case Management
-- Root cause: Code was having falw and fix was deployed in production.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Yrs",
      "clientid": "4416673",
      "childname": "PAIGE MYERS"
    },
    {
      "age": "1 Yrs",
      "clientid": "200312430",
      "childname": "Autumn Anderson"
    },
    {
      "age": "1 Month(s)",
      "clientid": "200926676",
      "childname": "Ariyn Anderson"
    }
    ]')
--	,updatedby = 'CIDM-5492-R8'
--	,updatedon = now()
where assessmentid = 'f8a751a8-17ce-4dbf-b1e0-c5249c1cd4fa'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Day(s)",
      "clientid": "200936406",
      "childname": "Adrian Cronin-Wright"
    }
    ]')
--	,updatedby = 'CIDM-5492-R8'
--	,updatedon = now()
where assessmentid = '76ab0803-893c-4d49-aa1e-219df4aa288a'
	and activeflag = 1 ;
	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200663794",
      "childname": "isla Wright"
    }
    ]')
--	,updatedby = 'CIDM-5492-R8'
--	,updatedon = now()
where assessmentid = '69ef5b4d-a48a-443a-9995-fe3f0cbb184e'
	and activeflag = 1 ;
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "3105370",
      "childname": "ANGELINA MICHELLE WRITT"
    },
    {
      "age": "6 Yrs",
      "clientid": "3873743",
      "childname": "MASON T PEYTON"
    },
    {
      "age": "2 Yrs",
      "clientid": "200663670",
      "childname": "Crystal Dunevant"
    },
    {
      "age": "7 Month(s)",
      "clientid": "200937837",
      "childname": "Brantley Dunevant"
    }
    ]')
--	,updatedby = 'CIDM-5492-R8'
--	,updatedon = now()
where assessmentid = '5cc94e04-3231-40d8-8710-abce8d82f0eb'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "3105326",
      "childname": "ZACKORY WRITT"
    }
    ]')
--	,updatedby = 'CIDM-5492-R8'
--	,updatedon = now()
where assessmentid = '7c9aeafb-f7ea-4f05-a884-4a4a995d3a53'
	and activeflag = 1 ;
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "2041381",
      "childname": "NINA Rain GALE"
    }
    ]')
--	,updatedby = 'CIDM-5492-R8'
--	,updatedon = now()
where assessmentid = 'ba4b3391-b0df-4a68-a8eb-70dabd90269f'
	and activeflag = 1 ;
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "2041381",
      "childname": "NINA Rain GALE"
    },
    {
      "age": "12 Yrs",
      "clientid": "200939660",
      "childname": "Jamar Tenner"
    },
    {
      "age": "13 Yrs",
      "clientid": "2793681",
      "childname": "KENAN HODGES"
    },
    {
      "age": "10 Yrs",
      "clientid": "3399658",
      "childname": "LAMAR MARQUEL TENNER"
    },
    {
      "age": "10 Yrs",
      "clientid": "3697488",
      "childname": "KALANI GALE"
    },
    {
      "age": "7 Yrs",
      "clientid": "200939624",
      "childname": "Erick Jalen Marquel Tenner"
    }
    ]')
--	,updatedby = 'CIDM-5492-R8'
--	,updatedon = now()
where assessmentid = 'a123fb14-c8b5-40a0-9a26-f0f053b21269'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
     {
      "age": "17 Yrs",
      "clientid": "4031237",
      "childname": "FATHIA ALATIYYAT"
    },
	{
      "age": "17 Yrs",
      "clientid": "4338665",
      "childname": "JORDANNA AL ATIYYAT"
    },
    {
      "age": "15 Yrs",
      "clientid": "200939598",
      "childname": "Samira A Al-Atiyyat"
    },
    {
      "age": "13 Yrs",
      "clientid": "200939599",
      "childname": "Dahlia P Al-Atiyyat"
    },
    {
      "age": "10 Yrs",
      "clientid": "200939600",
      "childname": "Adam M Al-Atiyyat"
    }
    ]')
--	,updatedby = 'CIDM-5492-R8'
--	,updatedon = now()
where assessmentid = '4399313a-1ecb-453a-8485-c4f58dcca4cb'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "200673346",
      "childname": "Mikah Mekeithen"
    }
    ]')
--	,updatedby = 'CIDM-5492-R8'
--	,updatedon = now()
where assessmentid = 'ce19f67f-44a4-48c6-b2fe-d3165f43347b'
	and activeflag = 1 ;
