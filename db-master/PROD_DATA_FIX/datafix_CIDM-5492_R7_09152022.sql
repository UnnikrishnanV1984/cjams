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

-- Age 0 years re-validation & Fix - Start
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "200931293",
      "childname": "Ann Marie Cook"
    },
    {
      "age": "1 Month(s)",
      "clientid": "200926919",
      "childname": "Trevor Parks-Cooks"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
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
      "age": "1 Month(s)",
      "clientid": "200926919",
      "childname": "Trevor Parks-Cooks"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
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
      "age": "1 Month(s)",
      "clientid": "200926919",
      "childname": "Trevor Parks-Cooks"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = '6e26adf7-2916-4936-a994-8698237b00c3'
	and activeflag = 1 ;										

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Month(s)",
      "clientid": "200930000",
      "childname": "Jamal Sutton"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = 'c9dacfac-bb15-48f3-858e-0c755444787d'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Month(s)",
      "clientid": "200889857",
      "childname": "Braelynn Conley"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = '39c8c9c0-635d-443d-b725-a146971057b4'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200773716",
      "childname": "Kayden Wells"
    },
    {
      "age": "12 Day(s)",
      "clientid": "200938086",
      "childname": "Journey Wells"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = '4a6670be-6ac8-46d6-b268-13b091adbe62'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Day(s)",
      "clientid": "200937759",
      "childname": "Dakarei Holmes"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = '3ee3e091-255d-4cf9-9a24-59144cdd15ef'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Day(s)",
      "clientid": "200937669",
      "childname": "Phaeva Young"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = '53d3fcb7-fafc-4dc8-bbb3-b6b0278f25f1'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Day(s)",
      "clientid": "200938258",
      "childname": "MILO KENJI THOMAS"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = '745d3d1b-1bb6-496a-9f1f-a77ac3988ba3'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Day(s)",
      "clientid": "200938250",
      "childname": "Brynleigh Bruns"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = 'a5e3ae40-460f-4d56-8708-3049882310f1'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "200936578",
      "childname": "Emmanuel Tanis"
    },
    {
      "age": "24 Day(s)",
      "clientid": "200936580",
      "childname": "Jonathan Tanis"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = '9dc87373-3099-4ca0-aea4-a6402409ea1b'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "24 Day(s)",
      "clientid": "200936580",
      "childname": "Jonathan Tanis"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = '9b9dab53-9507-4fcc-b62b-f8e1fd13dc32'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "28 Day(s)",
      "clientid": "200931773",
      "childname": "Violet Morley"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = '62c88734-ead9-4c35-b85e-f58f126969d7'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200933148",
      "childname": "Blair Randolph"
    },
    {
      "age": "5 Yrs",
      "clientid": "200933147",
      "childname": "Brandi Samuels"
    },
    {
      "age": "17 Day(s)",
      "clientid": "200933150",
      "childname": "Brandon Randolph"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = '8042b988-9811-48f2-ab8b-5fe47b28d4ec'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Month(s)",
      "clientid": "200928621",
      "childname": "lillia love"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = '61e33b86-7425-4078-a4fb-794395543938'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Month(s)",
      "clientid": "200929216",
      "childname": "Isabella Ogbunigwe"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = 'fd3b1fa9-ee52-4d8a-9b87-a5fd2d399231'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Month(s)",
      "clientid": "200938137",
      "childname": "KAIDEN ELIAS JACKSON"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = '001d1364-8205-448b-858a-6e9d9855b873'
	and activeflag = 1 ;
								
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Month(s)",
      "clientid": "200821204",
      "childname": "Alonzo Hill-Benton"
    },
    {
      "age": "2 Yrs",
      "clientid": "4479339",
      "childname": "QUINZELL HILL BENTON"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = '21f917b9-e7a6-40c5-b569-c59a0b1659f3'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Day(s)",
      "clientid": "200937205",
      "childname": "Emma Jiang"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = '64409a18-7eca-4480-b577-02e0d0a18eaf'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Month(s)",
      "clientid": "200905187",
      "childname": "Nevaeh Dunscomb"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = '90708eb5-6ab8-44e7-a7b5-a068a7315568'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Month(s)",
      "clientid": "200945565",
      "childname": "Estella Roberts Rodenzo"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = 'eab7356a-c68a-49fc-b866-2d6874c952ef'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Month(s)",
      "clientid": "200936966",
      "childname": "Ladonte Lamar Hawkins"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = 'de25cd61-5567-485d-a558-d3373d7dbc9f'
	and activeflag = 1 ;
	
-- Age 0 years re-validation & Fix - End

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200937713",
      "childname": "Anthony Williams"
    },
    {
      "age": "6 Yrs",
      "clientid": "200937710",
      "childname": "Alexander Williams"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = '4a6d4600-a2f7-4e07-96aa-9900c71c4a65'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "200938407",
      "childname": "Praise Anagho"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = 'b2034350-1397-4e5d-9e4b-cac8c4572363'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "200537268",
      "childname": "BRE''ASIA E SMITH"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = 'ef7e08aa-36a7-46b2-8885-4c6df5e68e21'
	and activeflag = 1 ;
										
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200644992",
      "childname": "Genesis G Ramos Lemus"
    },
    {
      "age": "14 Yrs",
      "clientid": "200644984",
      "childname": "Denia J Ramos Lemus"
    },
    {
      "age": "7 Yrs",
      "clientid": "200645008",
      "childname": "Alison D Ramos Lemus"
    },
    {
      "age": "10 Yrs",
      "clientid": "200644981",
      "childname": "Braiden A Ramos"
    },
    {
      "age": "17 Yrs",
      "clientid": "200644986",
      "childname": "Kendy V Ramos Lemus"
    }
    ]')
--	,updatedby = 'CIDM-5492-R7'
--	,updatedon = now()
where assessmentid = 'b8162bd4-55ce-49ae-b965-f4b25f7f2838'
	and activeflag = 1 ;
