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
      "age": "15 Yrs",
      "clientid": "200845672",
      "childname": "Megan Karle"
    },
    {
      "age": "8 Yrs",
      "clientid": "200846229",
      "childname": "Luke Karle"
    },
    {
      "age": "8 Yrs",
      "clientid": "200888413",
      "childname": "Finn Glotfelty"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '8ed6f3cd-9da9-48b6-8092-656d2c99a393'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "200860796",
      "childname": "Janessa Davis"
    },
    {
      "age": "5 Yrs",
      "clientid": "200860800",
      "childname": "Aniyla Jones"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = 'f33fb2cf-4004-4808-b24c-0c8b6b367b22'
	and activeflag = 1 ;

										
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200869694",
      "childname": "Kenneth Evans"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '10e519b6-597e-4ec2-8f1e-f39fb75f1300'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "200868117",
      "childname": "Lynne Adjoaayeki Asare"
    },
    {
      "age": "6 Yrs",
      "clientid": "200868128",
      "childname": "Aaron K Oppong Gyebi"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '1f5ec682-71c2-4e6a-b318-a02ace4ee882'
	and activeflag = 1 ;
										
										
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "200879271",
      "childname": "Skye E Whittaker"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '6471652e-44d2-46d9-802e-f7765502fc65'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "200019492",
      "childname": "HENRY J PARKER"
    },
    {
      "age": "11 Yrs",
      "clientid": "200019500",
      "childname": "HUNTER J PARKER"
    },
    {
      "age": "11 Yrs",
      "clientid": "200019487",
      "childname": "HAYDEN L PARKER"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '9000a7d6-2181-4407-affb-43d0cc7ce0c8'
	and activeflag = 1 ;

										
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "0 Yrs",
      "clientid": "200889857",
      "childname": "Braelynn Conley"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '39c8c9c0-635d-443d-b725-a146971057b4'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "200405624",
      "childname": "DANIEL MENDOZA HERNANDEZ"
    },
    {
      "age": "13 Yrs",
      "clientid": "200893219",
      "childname": "Manuel Mendoza Hernandez"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '9d86c1b5-484a-4b7f-9125-c3bbbd970977'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "200641009",
      "childname": "Aiden Leydig"
    },
    {
      "age": "6 Yrs",
      "clientid": "200641013",
      "childname": "Skylar Leydig"
    },
    {
      "age": "4 Yrs",
      "clientid": "200638336",
      "childname": "Emerald Fazenbaker"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = 'eb0e747c-8686-4000-a31f-ba32a04ccfd4'
	and activeflag = 1 ;

										
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "4413485",
      "childname": "MADISON RAY BERNSTEIN"
    },
    {
      "age": "2 Yrs",
      "clientid": "200835594",
      "childname": "Jackson Keiper"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '2dad1c97-79f0-4d87-a2dc-6ab78301efcd'
	and activeflag = 1 ;

										
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200773716",
      "childname": "Kayden Wells"
    },
    {
      "age": "0 Yrs",
      "clientid": "200938086",
      "childname": "Journey Wells"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '4a6670be-6ac8-46d6-b268-13b091adbe62'
	and activeflag = 1 ;

										
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "0 Yrs",
      "clientid": "200937759",
      "childname": "Dakarei Holmes"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '3ee3e091-255d-4cf9-9a24-59144cdd15ef'
	and activeflag = 1 ;
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "0 Yrs",
      "clientid": "200937669",
      "childname": "Phaeva Young"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '53d3fcb7-fafc-4dc8-bbb3-b6b0278f25f1'
	and activeflag = 1 ;
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "0 Yrs",
      "clientid": "200938258",
      "childname": "MILO KENJI THOMAS"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '745d3d1b-1bb6-496a-9f1f-a77ac3988ba3'
	and activeflag = 1 ;
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "0 Yrs",
      "clientid": "200938250",
      "childname": "Brynleigh Bruns"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = 'a5e3ae40-460f-4d56-8708-3049882310f1'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200938299",
      "childname": "Karson L Swinson"
    },
    {
      "age": "3 Yrs",
      "clientid": "200937571",
      "childname": "Jayce Lee"
    },
    {
      "age": "7 Yrs",
      "clientid": "200938303",
      "childname": "Hayden E Swinson"
    },
    {
      "age": "1 Yrs",
      "clientid": "200938285",
      "childname": "Dakota N Green"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '2880c37e-9190-4e13-95dd-85130da9de8e'
	and activeflag = 1 ;
										

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "3129296",
      "childname": "Lohgan Washington Robinson"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '103dee92-4040-4a32-bc6a-50f9fdbd3e2f'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "200938744",
      "childname": "Jayla Love Thornton"
    },
    {
      "age": "5 Yrs",
      "clientid": "200938746",
      "childname": "Cayden L Thornton"
    },
    {
      "age": "18 Yrs",
      "clientid": "2745280",
      "childname": "SURAYA LOGAN JONES"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = 'a7c5318c-ef8a-46f6-847b-bcf70c47b3b1'
	and activeflag = 1 ;
										

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "Jacey Poole",
      "childname": "DANIEL T DINGLE"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '5ffdd494-2860-423c-bdf7-bae5c31926ed'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "2156592",
      "childname": "JAYLEN M ANDERSON"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = 'e3d9ebb4-31c6-4803-bf5e-5f6f311d14c3'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200916131",
      "childname": "Marquis Antonio Ford"
    },
    {
      "age": "5 Yrs",
      "clientid": "200931206",
      "childname": "D''Moni Bethel"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '2f495e60-3024-4f47-b282-03ff275da506'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "200917427",
      "childname": "Emmanuel A Reyes Amigon"
    },
    {
      "age": "11 Yrs",
      "clientid": "200918453",
      "childname": "Amadeo Jimenez Amigon"
    },
    {
      "age": "3 Yrs",
      "clientid": "200918451",
      "childname": "Genesis A Jimenez Amigon"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '094d3d76-911a-4769-bb1c-c154462211fe'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "2765439",
      "childname": "ESIONTA JOHNSON"
    },
    {
      "age": "15 Yrs",
      "clientid": "2766015",
      "childname": "EYEEMIRIANDE BUCKHOLTZ"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '5ee55983-478a-475c-bd52-103f34b4267a'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "200920365",
      "childname": "Marie Njiomouo"
    },
    {
      "age": "12 Yrs",
      "clientid": "200920635",
      "childname": "Alex Njiomouo"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = 'a3a9b2cf-d706-4f57-8fbc-72cc5cf8a540'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200898736",
      "childname": "ETHAN JEREMIAH SANCHEZBONILLA"
    },
    {
      "age": "1 Yrs",
      "clientid": "200939777",
      "childname": "YAHSHUA JOSIAH PORTILLOBONILLA"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '2b596c99-5817-4912-9b09-ba497b49f4d8'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Yrs",
      "clientid": "4168461",
      "childname": "LONNIE H EDWARDS"
    },
    {
      "age": "4 Yrs",
      "clientid": "4181823",
      "childname": "LAROYAL EDWARDS"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = 'e724029b-65a0-4143-902c-b3475f8f178d'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "3120587",
      "childname": "FREDERICK CHARLES MCCUBBIN"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = 'a0f2a2a4-ea1d-4057-a724-266ec669847f'
	and activeflag = 1 ;
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200932519",
      "childname": "Kamiyah D Washington"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '3b424f3f-b37a-4daf-8259-01baf2a4559f'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "200141385",
      "childname": "TREAZURE L HOUSTON"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '7bf57ab4-dbb4-46b5-aa57-a6a5a369621a'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "3163361",
      "childname": "VALENTINA FLORES"
    }
    ]')
--	,updatedby = 'CIDM-5492-R4'
--	,updatedon = now()
where assessmentid = '9acfa996-775f-4352-aa12-f65c6179470d'
	and activeflag = 1 ;

