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
      "age": "5 Yrs",
      "clientid": "200931293",
      "childname": "Ann Marie Cook"
    },
    {
      "age": "0 Yrs",
      "clientid": "200926919",
      "childname": "Trevor Parks-Cooks"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = '72486adf-ae95-4f97-a9e2-9b8a7a9837a1'
	and activeflag = 1 ;										

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "200931293",
      "childname": "Ann Marie Cook"
    },
    {
      "age": "0 Yrs",
      "clientid": "200926919",
      "childname": "Trevor Parks-Cooks"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = '02da0a8b-d2a3-4065-83ef-a51ad006e872'
	and activeflag = 1 ;										

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "200931293",
      "childname": "Ann Marie Cook"
    },
    {
      "age": "0 Yrs",
      "clientid": "200926919",
      "childname": "Trevor Parks-Cooks"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = '6e26adf7-2916-4936-a994-8698237b00c3'
	and activeflag = 1 ;										

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "200926063",
      "childname": "Giabella M Mamone"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = '1caa1ba8-fee0-4af9-b257-3b6dc731dfcb'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "0 Yrs",
      "clientid": "200930000",
      "childname": "Jamal Sutton"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = 'c9dacfac-bb15-48f3-858e-0c755444787d'
	and activeflag = 1 ;
										
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "4074436",
      "childname": "JOHN COLTON BOWLING"
    },
    {
      "age": "14 Yrs",
      "clientid": "4074167",
      "childname": "JAMES WILLIAM BOWLING"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = '5ba002f9-53e2-42bb-8adc-305ce3327b45'
	and activeflag = 1 ;										

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "200930650",
      "childname": "Collins Amedu"
    },
    {
      "age": "4 Yrs",
      "clientid": "200930651",
      "childname": "Bryan Amedu"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = '8b49c0dd-2bd5-4ce3-afd2-353d9781eda6'
	and activeflag = 1 ;										

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "200936906",
      "childname": "Melany Hernandez"
    },
    {
      "age": "8 Yrs",
      "clientid": "200936903",
      "childname": "Dilma Hernandez"
    },
    {
      "age": "2 Yrs",
      "clientid": "200938275",
      "childname": "David Hernandez-Diaz"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = 'f6803d10-4b9b-48e9-94d4-fb370aa6583c'
	and activeflag = 1 ;										

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200936929",
      "childname": "Ashley A Castillo Manzanares"
    },
    {
      "age": "4 Yrs",
      "clientid": "200936932",
      "childname": "Allison M Castillo Manzanares"
    },
    {
      "age": "1 Yrs",
      "clientid": "200936947",
      "childname": "Elias G Ramirez"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = '95f8e4f6-022c-4b95-86ce-6887bdc9a5a8'
	and activeflag = 1 ;										

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "3785665",
      "childname": "VIOLETTA E ESPARZA"
    },
    {
      "age": "2 Yrs",
      "clientid": "200915343",
      "childname": "Erik Esparza"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = 'efb8c2cd-4142-4426-a6d7-52a48e7930c5'
	and activeflag = 1 ;										

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "200933881",
      "childname": "Eva Maria Vicente"
    },
    {
      "age": "18 Yrs",
      "clientid": "200933880",
      "childname": "Daniel Vicente"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = '11c7af2f-3c4d-4982-8373-d2d65c7e2970'
	and activeflag = 1 ;										

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "200919596",
      "childname": "Faith Khamis"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = '12b86a1d-e153-4166-a975-a929f7eafd99'
	and activeflag = 1 ;
										
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "200919596",
      "childname": "Faith Khamis"
    },
    {
      "age": "8 Yrs",
      "clientid": "200938738",
      "childname": "Zola Robin Ghafouri"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = '66c5fad6-0a2d-43e7-87bc-1102a6eca914'
	and activeflag = 1 ;										

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "200920060",
      "childname": "Amir Argoum"
    },
    {
      "age": "16 Yrs",
      "clientid": "200920042",
      "childname": "Marwa Argoum"
    },
    {
      "age": "14 Yrs",
      "clientid": "200920057",
      "childname": "Safa Argoum"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = 'f3938b41-3c46-47b8-a94c-6e1e5a7194a3'
	and activeflag = 1 ;										

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "200931643",
      "childname": "Mackenzie Slusher"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = 'cd4500ec-3562-4a93-b5f3-478cc80a33dc'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200932174",
      "childname": "Brooke Di Renzo"
    },
    {
      "age": "4 Yrs",
      "clientid": "200932119",
      "childname": "Lily Di Renzo"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = '7b96cd39-4334-4db6-816a-4fcf308e789f'
	and activeflag = 1 ;										

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "200931842",
      "childname": "Stephanie Vargas Flores"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = '5fab75e0-cee2-4aee-aa11-f44197dde0cf'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200908250",
      "childname": "Angel Y Diaz Rovira"
    },
    {
      "age": "10 Yrs",
      "clientid": "200908239",
      "childname": "Fernando A Diaz Rovira"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = 'f9d71fba-5999-4eee-b772-51fff5589aec'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "4028238",
      "childname": "JAXXON CUMMINGS"
    },
    {
      "age": "4 Yrs",
      "clientid": "4271724",
      "childname": "LOLA A CUMMINGS"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = '33a8b7ed-8d73-4e49-a10c-545fae4db80e'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "3783084",
      "childname": "NYKEEM ANTHONY DENNIS"
    },
    {
      "age": "7 Yrs",
      "clientid": "200938867",
      "childname": "Zariyah Henderson"
    },
    {
      "age": "6 Yrs",
      "clientid": "3918282",
      "childname": "NYLAH PEARL HENDERSON"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = 'd4521b97-ac38-4b1d-8bb9-27872ab96b73'
	and activeflag = 1 ;										

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "4092739",
      "childname": "CRYSTAL RENEE SMITH"
    },
    {
      "age": "1 Yrs",
      "clientid": "200938235",
      "childname": "Michael Berry"
    },
    {
      "age": "2 Yrs",
      "clientid": "200938234",
      "childname": "Myrical Berry"
    },
    {
      "age": "3 Yrs",
      "clientid": "200938231",
      "childname": "Makiyah Berry"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = 'ea0a89b7-8ec3-4a5d-be57-48dc6ca40993'
	and activeflag = 1 ;										

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200938433",
      "childname": "Melissa A Rivera Argueta"
    },
    {
      "age": "5 Yrs",
      "clientid": "200938428",
      "childname": "Damian A Rivera Argueta"
    },
    {
      "age": "6 Yrs",
      "clientid": "200938431",
      "childname": "Dariana Argueta Rivera"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = '190df294-e436-49cf-98db-b48e725ee4db'
	and activeflag = 1 ;										

/*
# 238 waiting for usre confirmation on Other childrens
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200646753",
      "childname": "Alora N Divine"
    },
    {
      "age": "3 Yrs",
      "clientid": "200646750",
      "childname": "Sophia Grace Divine"
    },
    {
      "age": "15 Yrs",
      "clientid": "200653512",
      "childname": "Jadynn Divine"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = '2a4f559a-e270-4f1d-8f10-e4afa14f0ece'
	and activeflag = 1 ;										

update assessment
set submissiondata = jsonb_set(submissiondata, '{addchildren}','[
	{
		"seconeage": "6 Yrs",
		"seconename": "Matthew Logan Lopez"
	}, {
		"seconeage": "4 Yrs",
		"seconename": "Marshall L Ringler"
	}, {
		"seconeage": "2 Yrs",
		"seconename": "Lilyana M Lagasse"
	}
	]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = '2a4f559a-e270-4f1d-8f10-e4afa14f0ece'
	and activeflag = 1 ;
	
Insert into assessmentactor for addchildren
*/	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200938562",
      "childname": "Summer Perry"
    },
    {
      "age": "7 Yrs",
      "clientid": "200938563",
      "childname": "Marissa Perry"
    }
    ]')
--	,updatedby = 'CIDM-5492-R6'
--	,updatedon = now()
where assessmentid = '1bea49a3-69d4-4ea5-8869-55410623a11f'
	and activeflag = 1 ;										
