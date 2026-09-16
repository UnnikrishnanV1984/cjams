-- CIDM-5492 - SAFE-C Data Fix needed (bulk cases)
/*
-- Issue Description: 
   Safe-C Assessments with missign child info. 
  
-- Category/ Module: Case Management
-- Root cause: Code was having falw and fix was deployed in production.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "2602159",
      "childname": "KEIRA C DOWLING"
    },
    {
      "age": "5 Yrs",
      "clientid": "4183639",
      "childname": "JACOB DOWLING-COVINGTON"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '034285e7-b01f-4c51-bf55-fb09e6517332'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "0 Yrs",
      "clientid": "200937205",
      "childname": "Emma Jiang"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '64409a18-7eca-4480-b577-02e0d0a18eaf'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "200934338",
      "childname": "Lupita Ortega Rivera"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = 'b6c93656-5f26-4dea-8c36-2d5640c28973'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200654792",
      "childname": "Bronx Queensbury"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '808cf384-1a0a-433f-bed5-4371345869d9'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "200933723",
      "childname": "Maria A Lobianco"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = 'aa58718b-fd84-4e37-bf93-d63fae50e75d'
	and activeflag = 1 ;

update assessment	
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "4371723",
      "childname": "LANDON CHANCE STACKHOUSE"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '4487202f-9ff6-474d-8182-ad2f51a800c0'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200938657",
      "childname": "Journee E Howard"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '18eb0156-db64-4fa3-9dbb-2db62861730d'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "3200600",
      "childname": "ALEAH M STRAWDER"
    },
    {
      "age": "11 Yrs",
      "clientid": "3418659",
      "childname": "DONTAY JONES"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '082ad74c-11f9-4069-8482-af7603a8d7e0'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Yrs",
      "clientid": "3744080",
      "childname": "ISAAC JAY"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '28204c05-1f6f-4a0c-825e-a9698b9d2dad'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200007775",
      "childname": "CAMERON CRAIG"
    },
    {
      "age": "2 Yrs",
      "clientid": "200007610",
      "childname": "Skarlet Craig"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '61567a7d-669f-4eaa-91a4-b60ca1399056'
	and activeflag = 1 ;
	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "200008243",
      "childname": "HANNAH RHI WILEY"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '0c3bd301-2da3-4332-8a91-28110b9ab11d'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "0 Yrs",
      "clientid": "200905187",
      "childname": "Nevaeh Dunscomb"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '90708eb5-6ab8-44e7-a7b5-a068a7315568'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200819998",
      "childname": "Amari Guthrie"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = 'c30428ba-8704-4a3b-b21a-9f17a75abf78'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "2219849",
      "childname": "ISAIAH YASHAN SPRINKLE"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '6de1fc6c-1e27-4dc6-a35e-6a9b46b0966b'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200912432",
      "childname": "Javairh Sims"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = 'a1802b8a-9065-4fcb-911e-20d23c4ae563'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200883155",
      "childname": "Kash Dewitt"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '03497a49-e0f1-4a3e-a111-f5eb0e0ee21c'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "4358911",
      "childname": "JEFFREY EMLET"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '302dd680-4586-4a9e-918c-f44dad4558ff'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "200922310",
      "childname": "Nevaldo Ford"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '763fce7f-87da-4a19-85f4-a402671562d5'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "200922310",
      "childname": "Nevaldo Ford"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '3bbb8159-e8f8-4356-80a0-a2f9f7f0111d'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200923937",
      "childname": "Zemirah Clarke"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
   
where assessmentid = '021db8ca-bea8-4665-8914-a556ee461edd'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "0 Yrs",
      "clientid": "200945565",
      "childname": "Estella Roberts Rodenzo"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = 'eab7356a-c68a-49fc-b866-2d6874c952ef'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200911768",
      "childname": "Dakota A Shrader"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '1895cf3b-b326-467d-a942-16ff60b2792f'
	and activeflag = 1 ;
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "4121029",
      "childname": "August Liam Bass"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = 'e005fc41-0fb6-46fd-826b-6e9cc2bf9cf3'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "200933543",
      "childname": "Amina Glasgow"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '1c97a6db-550c-4a5d-86cb-5fe09e489952'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "200929642",
      "childname": "Adison Barrett"
    },
    {
      "age": "6 Yrs",
      "clientid": "200934039",
      "childname": "avery barrett"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '8242c71f-9839-4183-95b7-6a0a0dbae23a'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "200171741",
      "childname": "Ashton Gabriel Woodland"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '9bdd6664-f277-41cc-ad53-91aee678be19'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200934293",
      "childname": "Kalina L Miller"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = 'e722c75e-11d4-4ceb-83f0-b78890ab3aef'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "3801126",
      "childname": "LILIANA UTZ"
    },
    {
      "age": "14 Yrs",
      "clientid": "3801125",
      "childname": "CHRISTIAN UTZ"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = 'bb18e390-d821-4b6d-bc18-e7502f98e1d6'
	and activeflag = 1 ;
	
update assessment
set submissiondata =  jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "200935162",
      "childname": "Ashley Hernandez Sorto"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '8ba79815-5a3a-41dd-b590-00ea256cb6e1'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "200808903",
      "childname": "Antoine S Mccard Jr"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '42ab49fb-0fe9-457f-8edc-a24832bce0d3'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "200019093",
      "childname": "Elias Trout"
    },
    {
      "age": "6 Yrs",
      "clientid": "200019092",
      "childname": "Oliver Trout"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '16a5bde2-6bbb-44fa-a43a-2a2c27b3bf60'
	and activeflag = 1 ;
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200895637",
      "childname": "Gia Renee Savoy"
    },
    {
      "age": "4 Yrs",
      "clientid": "4390855",
      "childname": "AVA-MARIE DYSON"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = 'c0ac1f99-7e5f-4cf8-ac50-f8adbe08a2aa'
	and activeflag = 1 ;

	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "0 Yrs",
      "clientid": "200936966",
      "childname": "Ladonte Lamar Hawkins"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = 'de25cd61-5567-485d-a558-d3373d7dbc9f'
	and activeflag = 1 ;
	
update assessment	
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Yrs",
      "clientid": "200843685",
      "childname": "Uriah Long"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '69da212d-b235-4584-b91a-bddb4380ba55'
	and activeflag = 1 ;
	
update assessment	
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "200847815",
      "childname": "Calliope Goggins"
    }
    ]')
--	,updatedby = 'CIDM-5492-R1'
--	,updatedon = now()
where assessmentid = '560450b6-3433-46fe-8cf0-07aa10b2eae3'
	and activeflag = 1 ;
