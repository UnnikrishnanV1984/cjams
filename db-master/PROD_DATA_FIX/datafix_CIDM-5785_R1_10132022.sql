-- CIDM-5785 - SAFE-C Data Fix needed (bulk cases)
/*
-- Issue Description: 
   Safe-C Assessments with missing child info. 
  
-- Category/ Module: Case Management
-- Root cause: Code was having falw and fix was deployed in production.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

-- Revision 
-- 11/04/2022 TO comment out failed Assessments

*/

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "200938532",
      "childname": "Lohgan Washington Robinson"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '103dee92-4040-4a32-bc6a-50f9fdbd3e2f'
	and activeflag = 1 ;
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "200916309",
      "childname": "Jacey Poole"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '5ffdd494-2860-423c-bdf7-bae5c31926ed'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "200920365",
      "childname": "Marie Njiomouo"
    }
	]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = 'a3a9b2cf-d706-4f57-8fbc-72cc5cf8a540'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{addchildren}','[
	{
		"seconeage": "12 Yrs",
		"seconename": "Alex Njiomouo"
	}
	]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = 'a3a9b2cf-d706-4f57-8fbc-72cc5cf8a540'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "12 Yrs",
		"name": "Alex Njiomouo",
		"cjamspid": "200920635"
	}, {
		"age": "8 Yrs",
		"name": "Marie Njiomouo",
		"cjamspid": "200920365"
	}]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = 'a3a9b2cf-d706-4f57-8fbc-72cc5cf8a540'
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
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '33a8b7ed-8d73-4e49-a10c-545fae4db80e'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "200816185",
      "childname": "King Gibbons"
    },
    {
      "age": "13 Yrs",
      "clientid": "200929050",
      "childname": "Aaliyah Shaw"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = 'd243707c-1ad2-4c66-9b20-c85bd88fe508'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "4314010",
      "childname": "SCARLETT MATAMOROS"
    },
    {
      "age": "4 Yrs",
      "clientid": "4314009",
      "childname": "ELSY VICTORIA MATAMOROS"
    },
    {
      "age": "14 Yrs",
      "clientid": "4314006",
      "childname": "CRISTIAN E ZELAYA"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = 'f9d71fba-5999-4eee-b772-51fff5589aec'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200774796",
      "childname": "Mikayla Wells"
    },
    {
      "age": "2 Yrs",
      "clientid": "200000548",
      "childname": "Mackynizie Wells"
    },
    {
      "age": "7 Day(s)",
      "clientid": "200937297",
      "childname": "Michael Wells "
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = 'b70bc7db-c4cf-4163-a656-e4d4f31ab52f'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "200786639",
      "childname": "Zoya Asif"
    },
    {
      "age": "6 Yrs",
      "clientid": "200786641",
      "childname": "Zain Asif"
    },
    {
      "age": "18 Yrs",
      "clientid": "200784216",
      "childname": "Kamran Asif"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '3b8e604a-7aa0-48f4-805d-4ee615e7b004'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "4226321",
      "childname": "AJOHN TYLER"
    },
    {
      "age": "13 Yrs",
      "clientid": "4226320",
      "childname": "TY-KIA TYLER"
    },
    {
      "age": "11 Yrs",
      "clientid": "4226319",
      "childname": "LAQUWON TYLER"
    },
    {
      "age": "10 Yrs",
      "clientid": "4388239",
      "childname": "EDDIE TYLER"
    },
    {
      "age": "9 Yrs",
      "clientid": "4226323",
      "childname": "ELI HILL TYLER"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '114d6f5b-1de4-48f5-8397-98ebcad78d2e'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "4226321",
      "childname": "AJOHN TYLER"
    },
    {
      "age": "13 Yrs",
      "clientid": "4226320",
      "childname": "TY-KIA TYLER"
    },
    {
      "age": "11 Yrs",
      "clientid": "4226319",
      "childname": "LAQUWON TYLER"
    },
    {
      "age": "10 Yrs",
      "clientid": "4388239",
      "childname": "EDDIE TYLER"
    },
    {
      "age": "9 Yrs",
      "clientid": "4226323",
      "childname": "ELI HILL TYLER"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '5a2c7b63-e1fb-40fa-b181-af78f220b4cb'
	and activeflag = 1 ;
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200909999",
      "childname": "Skylene Rodriguez"
    },
    {
      "age": "2 Yrs",
      "clientid": "200910008",
      "childname": "Sienna V Benitez"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '7fdd1e0a-f2e5-49d3-af65-43cb79e4051d'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "200936454",
      "childname": "Anushri Nambiar"
    },
    {
      "age": "15 Yrs",
      "clientid": "200936458",
      "childname": "Anuraj Nambiar"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '14d15339-a54a-4c46-8c39-776859fbb835'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200938171",
      "childname": "Luna Michelle King"
    },
    {
      "age": "1 Yrs",
      "clientid": "200938166",
      "childname": "Saheim Jimir King-Marshall"
    },
    {
      "age": "3 Yrs",
      "clientid": "200938162",
      "childname": "Lyla Marie King"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '50c9a3fb-56a2-41ca-abfd-437e33e599c3'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200938175",
      "childname": "Gemini Eve Moats"
    },
    {
      "age": "5 Yrs",
      "clientid": "4071346",
      "childname": "ISABELLA N MOATS"
    },
    {
      "age": "15 Yrs",
      "clientid": "2194581",
      "childname": "BRIAN N MOATS"
    },
    {
      "age": "12 Yrs",
      "clientid": "4071343",
      "childname": "ARTIMUS MOATS"
    },
    {
      "age": "10 Yrs",
      "clientid": "4071345",
      "childname": "SERENITY MOATS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '735f82ba-7dd7-4b18-a25a-2c07bcf78460'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "2436426",
      "childname": "RODNEY LAVETTE ANDERSON"
    },
    {
      "age": "5 Yrs",
      "clientid": "4066829",
      "childname": "TYMIR E ELLERBY"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = 'f50cf7d0-9557-4c8c-b76f-96c32b1c70d1'
	and activeflag = 1 ;
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200942680",
      "childname": "Syncere Cummings"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = 'a828da2c-8fa4-4a40-883c-cd64b4e209d3'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "200936454",
      "childname": "Anushri Nambiar"
    },
    {
      "age": "15 Yrs",
      "clientid": "200936458",
      "childname": "Anuraj Nambiar"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '20b4c30d-6fc3-4bda-984c-529754eb298b'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Yrs",
      "clientid": "200937222",
      "childname": "Paul Kloster"
    },
    {
      "age": "7 Yrs",
      "clientid": "200937218",
      "childname": "Peter Kloster"
    },
    {
      "age": "4 Yrs",
      "clientid": "200937225",
      "childname": "John Kloster"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '73e1254a-61e7-4281-84a0-fd1b67390006'
	and activeflag = 1 ;
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "200143715",
      "childname": "JAKYI STURGIS"
    },
    {
      "age": "9 Yrs",
      "clientid": "4379692",
      "childname": "MARQUEE REW"
    },
    {
      "age": "4 Yrs",
      "clientid": "4379693",
      "childname": "NIA JOHNSON"
    },
    {
      "age": "8 Month(s)",
      "clientid": "200833021",
      "childname": "Naylee Crippen"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = 'a49c292d-a157-4bf7-b184-d9ea1e6a3f05'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "3364829",
      "childname": "KALEB MARCELLO ADAMS"
    },
    {
      "age": "1 Yrs",
      "clientid": "200918674",
      "childname": "Violet Kormawa"
    },
    {
      "age": "8 Yrs",
      "clientid": "3836789",
      "childname": "JULIETA LEE MARTINEZ"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '22bf0a5a-53db-4d2d-9785-5f29ef31a8f8'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "200937112",
      "childname": "Rosa Hernandez Lopez"
    },
    {
      "age": "7 Yrs",
      "clientid": "200937111",
      "childname": "Stephani Hernandez Lopez"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '6f56f0c5-21d8-4a40-880c-b0debb65849a'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "3644736",
      "childname": "KODY WALKER"
    },
    {
      "age": "17 Yrs",
      "clientid": "3644737",
      "childname": "DALLIS WALKER"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '008ff6c8-5f39-4800-8a09-848c41222b5c'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "3644736",
      "childname": "KODY WALKER"
    },
    {
      "age": "17 Yrs",
      "clientid": "3644737",
      "childname": "DALLIS WALKER"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '08553f05-ddbc-48d3-815c-1f341d298258'
	and activeflag = 1 ;
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200939376",
      "childname": "Makaylynn L Salvetti Satterfield"
    },
    {
      "age": "7 Yrs",
      "clientid": "4071543",
      "childname": "BRIELLA SALVETTI-SATTERFIELD"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '358c0f47-60ed-4269-97d3-9b88655f529e'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "200572733",
      "childname": "Olivia King"
    },
    {
      "age": "5 Yrs",
      "clientid": "200904740",
      "childname": "Ahmad King"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = 'b46dfce9-f163-4c3a-8a11-908dd2fa5505'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200908250",
      "childname": "Angel Y Diaz Rovira"
    },
    {
      "age": "9 Yrs",
      "clientid": "200908239",
      "childname": "Fernando A Diaz Rovira"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '5b6637fb-6f30-4f88-af1e-cd01d6fcd3ec'
	and activeflag = 1 ;
	
/* 
-- 11/04 	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "4047421",
      "childname": "DEVONTA ANTIONE THOMAS"
    },
    {
      "age": "6 Yrs",
      "clientid": "4047422",
      "childname": "JERMAINE WESLEY HILL"
    },
    {
      "age": "16 Yrs",
      "clientid": "3374586",
      "childname": "ASIA Inese Moorehead ROBINSON"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = 'cc626d6d-33bf-40c6-ab46-d9936f8919dd'
	and activeflag = 1 ;
*/	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Month(s)",
      "clientid": "200936928",
      "childname": "Jason Pierre Louis"
    },
    {
      "age": "6 Yrs",
      "clientid": "4290440",
      "childname": "DAWENSKY JEAN-BAPTISTE"
    },
    {
      "age": "1 Yrs",
      "clientid": "200936961",
      "childname": "Angela Pierre Louis"
    },
    {
      "age": "4 Yrs",
      "clientid": "4289268",
      "childname": "STEPHICA FRANCOIS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '2d788f6e-9528-4f3d-9192-38b8e21ee316'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "200937021",
      "childname": "Claudia Elizabeth Schwalm"
    },
    {
      "age": "7 Yrs",
      "clientid": "200937022",
      "childname": "Emma Renee Schwalm"
    },
    {
      "age": "4 Yrs",
      "clientid": "200937025",
      "childname": "Ian C Littlefield"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '9c49426d-641e-4386-9788-7ab1ffd79cf0'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Yrs",
      "clientid": "3712959",
      "childname": "ANGELENA DEJA NICELY"
    },
    {
      "age": "5 Yrs",
      "clientid": "3999279",
      "childname": "ARIANNA LUNA NICELY"
    },
    {
      "age": "8 Yrs",
      "clientid": "3712960",
      "childname": "ALEXANDRIA LOLA NICELY"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = '9661af5c-f868-4ffd-bf6c-caf0001acab0'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "4457777",
      "childname": "MCKENNA L GRAY"
    },
    {
      "age": "6 Yrs",
      "clientid": "200937666",
      "childname": "Bryan Hartsock"
    },
    {
      "age": "14 Yrs",
      "clientid": "4457772",
      "childname": "DAKOTA S GRAY"
    }
    ]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = 'a436d822-9d61-45f5-bfd8-4850b1ebc600'
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
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = 'ba4b3391-b0df-4a68-a8eb-70dabd90269f'
	and activeflag = 1 ;
