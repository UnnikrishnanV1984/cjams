-- CIDM-6042 - SAFE-C Data Fix needed (bulk cases)
/*
-- Issue Description: 
   Safe-C Assessments with missing child info. 
  
-- Category/ Module: Case Management
-- Root cause: Code was having falw and fix was deployed in production.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

-- 254 - (8/1 To 8/25) New - Start

-- 221030015739			562f32cf-f350-49f2-a3cd-29a50fc45f78	PID= 200901488 , PID= 200901492
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "18 Yrs",
      "clientid": "200901488",
      "childname": "Evelyn Antoniou"
    },
    {
      "age": "15 Yrs",
      "clientid": "200901492",
      "childname": "Georgia Antoniou"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '562f32cf-f350-49f2-a3cd-29a50fc45f78'
	and activeflag = 1 ;
	
-- 221030015745			7992714c-6bac-45e2-85de-5061de7945a5	PID - 200902507
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Month(s)",
      "clientid": "200902507",
      "childname": "Jermaine Pearson"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '7992714c-6bac-45e2-85de-5061de7945a5'
	and activeflag = 1 ;	
	
-- 221030016167			2e561e88-5a06-4ec9-bcda-9a53c3a69a4d	PID= 200911548
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "200911548",
      "childname": "Cayden Kyle Ellis"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '2e561e88-5a06-4ec9-bcda-9a53c3a69a4d'
	and activeflag = 1 ;
	

-- 221030017580			cea316d5-3bd2-4d15-a726-a0c03b6a7d6c	
-- CJAMS PID# for 5 kids:  200931954,  200929989, 200931953, 200931948,  200929991
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200931954",
      "childname": "Kelsey Carrier"
    },
    {
      "age": "6 Yrs",
      "clientid": "200929989",
      "childname": "Sara Elizabeth Carrier"
    },
    {
      "age": "8 Yrs",
      "clientid": "200931953",
      "childname": "John Carrier"
    },
    {
      "age": "11 Yrs",
      "clientid": "200931948",
      "childname": "Landon Anthony Carrier"
    },
    {
      "age": "12 Yrs",
      "clientid": "200929991",
      "childname": "Leon Carrier"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = 'cea316d5-3bd2-4d15-a726-a0c03b6a7d6c'
	and activeflag = 1 ;
	
-- 221030017604			5bd004c2-397c-442f-bba7-82ed9abc04c6	
-- Ma-hari Poole CIS#200939566, 
-- Jordyn Shivers CIS#3409010, 
-- Ma-king Holmes CIS#200939563, 
-- Majesty Poole CIS#200939570
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "200939566",
      "childname": "Ma-Hari Poole"
    },
    {
      "age": "10 Yrs",
      "clientid": "3409010",
      "childname": "JORDYN SHIVERS"
    },
    {
      "age": "2 Yrs",
      "clientid": "200939563",
      "childname": "Ma-King Holmes"
    },
    {
      "age": "4 Month(s)",
      "clientid": "200939570",
      "childname": "Majesty Poole"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '5bd004c2-397c-442f-bba7-82ed9abc04c6'
	and activeflag = 1 ;


-- CPS-AR 221020224434		b94ff12c-fac6-4b9e-8c2d-af81162ab235	
-- CJAMS PID # 200873314 and 200873317
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200873314",
      "childname": "John Banker"
    },
    {
      "age": "7 Month(s)",
      "clientid": "200873317",
      "childname": "Sophia Figueroa"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = 'b94ff12c-fac6-4b9e-8c2d-af81162ab235'
	and activeflag = 1 ;

-- CPS-AR 221020225901		fe6ce42a-597b-4567-9f9a-ad428d4fc188	3514054 and  4039091
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "3514054",
      "childname": "TAYLOR GREEN"
    },
    {
      "age": "6 Yrs",
      "clientid": "4039091",
      "childname": "DYLAN RUCKER"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = 'fe6ce42a-597b-4567-9f9a-ad428d4fc188'
	and activeflag = 1 ;
	
														
-- CPS-AR 221020237530		6511a7bb-10f2-49bd-8c00-e2a60796329d
-- 4322274, 4322272, 4322273
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "4322274",
      "childname": "MICHAEL DIGGS"
    },
    {
      "age": "3 Yrs",
      "clientid": "4322272",
      "childname": "AVA A DIGGS"
    },
    {
      "age": "14 Yrs",
      "clientid": "4322273",
      "childname": "DIAMOND DIGGS"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '6511a7bb-10f2-49bd-8c00-e2a60796329d'
	and activeflag = 1 ;
	
-- CPS-IR 221020218147		7b469cb0-f0a8-4ec7-ac43-1c805b41979c
-- 200911464, 200911466, 200906657, 200813202
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "200911464",
      "childname": "Leiah Campbell"
    },
    {
      "age": "13 Yrs",
      "clientid": "200911466",
      "childname": "janiya campbell"
    },
    {
      "age": "14 Yrs",
      "clientid": "200906657",
      "childname": "William Chism"
    },
    {
      "age": "16 Yrs",
      "clientid": "200813202",
      "childname": "Nia Hester"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '7b469cb0-f0a8-4ec7-ac43-1c805b41979c'
	and activeflag = 1 ;
	

-- CPS-IR 221020218154		3a2b1d9c-d4a9-426c-93e5-2e095aa88940
-- 3642037, 2149422
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "3642037",
      "childname": "JEREMIAH C BLACKWELL"
    },
    {
      "age": "15 Yrs",
      "clientid": "2149422",
      "childname": "JAIVIANA E KEENE"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '3a2b1d9c-d4a9-426c-93e5-2e095aa88940'
	and activeflag = 1 ;
	
-- CPS-IR 221020220940		7d87cbae-a707-4b1c-be0a-8af31b99f914
-- 200914948- Ava Allen, 200914950 - Olivia Allen
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200914948",
      "childname": "Ava Allen"
    },
    {
      "age": "1 Yrs",
      "clientid": "200914950",
      "childname": "Olivia Allen"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '7d87cbae-a707-4b1c-be0a-8af31b99f914'
	and activeflag = 1 ;
	
-- CPS-IR 221020221557		4fd750a8-c5d7-4e50-adea-665756592986
-- 2855597, 2855603
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "2855597",
      "childname": "AYLA LEWIS-JONES"
    },
    {
      "age": "13 Yrs",
      "clientid": "2855603",
      "childname": "TRACEY LEWIS JONES"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '4fd750a8-c5d7-4e50-adea-665756592986'
	and activeflag = 1 ;
	
-- CPS-IR 221020233010		cc626d6d-33bf-40c6-ab46-d9936f8919dd
-- Add 4047421, 4047422, 3374586 to the top
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
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = 'cc626d6d-33bf-40c6-ab46-d9936f8919dd'
	and activeflag = 1 ;
	
-- CPS-IR 221020235426		f7765cd0-8558-43b3-b970-f907f1b77aa2
-- 200784357, 200786267, and 200786265
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "200784357",
      "childname": "Fanta G Myers"
    },
    {
      "age": "8 Yrs",
      "clientid": "200786267",
      "childname": "Tony Myers"
    },
    {
      "age": "4 Yrs",
      "clientid": "200786265",
      "childname": "Derrick Myers"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = 'f7765cd0-8558-43b3-b970-f907f1b77aa2'
	and activeflag = 1 ;
	
-- CPS-IR 221020238089		3f4f5601-6620-4265-bdc7-d47d634577fe
-- Jason Duvall  4065323 and Tyler Duvall 4065324
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "4065323",
      "childname": "JASON TYLER DUVALL"
    },
    {
      "age": "7 Yrs",
      "clientid": "4065324",
      "childname": "TYLER EUGENE DUVALL"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '3f4f5601-6620-4265-bdc7-d47d634577fe'
	and activeflag = 1 ;
	

-- CPS-IR 221020239132		2a4f559a-e270-4f1d-8f10-e4afa14f0ece
/*
Alora N Divine(CJAMS PID#:  200646753)
Sophia Grace Divine(CJAMS PID#: 200646750)
Jadynn Divine(CJAMS PID#: 200653512)
Other household
Matthew Logan Lopez(CJAMS PID#: 200893204)
Marshall L Ringler(CJAMS PID#: 200939613)
Lilyana M Lagasse(CJAMS PID#: 200939614)
*/

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
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
    },
    {
      "age": "6 Yrs",
      "clientid": "200893204",
      "childname": "Matthew Logan Lopez"
    },
    {
      "age": "4 Yrs",
      "clientid": "200939613",
      "childname": "Marshall L Ringler"
    },
    {
      "age": "1 Yrs",
      "clientid": "200939614",
      "childname": "Lilyana M Lagasse"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '3f4f5601-6620-4265-bdc7-d47d634577fe'
	and activeflag = 1 ;
		
-- 254 - (8/1 To 8/25) New - End	
	
	
		
-- 318 - CJAMS Go Live to Till 8/1 - Start

-- CPS-IR  221020222304	fb3553ac-234a-4bd3-815d-befd84214353
-- 200903810-Santana Harris, 200916711-Raelynn Harris, 200146796- Ashton Harris
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200903810",
      "childname": "Santana Harris"
    },
    {
      "age": "3 Month(s)",
      "clientid": "200916711",
      "childname": "Raelynn Harris"
    },
    {
      "age": "3 Yrs",
      "clientid": "200146796",
      "childname": "ASHTON HARRIS"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = 'fb3553ac-234a-4bd3-815d-befd84214353'
	and activeflag = 1 ;
	
-- CPS-IR 221020236159	90e0c8a9-b302-4f8b-a9d2-103cd6e072e0
-- Tristen A Benton 200934327, Shayla Z Ockimey 200944668, 
-- Trinity Benton 200944664, Taylor Creek 200944665
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "200934327",
      "childname": "Tristen A Benton"
    },
    {
      "age": "1 Yrs",
      "clientid": "200944668",
      "childname": "Shayla Z Ockimey"
    },
    {
      "age": "12 Yrs",
      "clientid": "200944664",
      "childname": "Trinity Benton"
    },
    {
      "age": "14 Yrs",
      "clientid": "200944665",
      "childname": "Taylor A Creek"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '90e0c8a9-b302-4f8b-a9d2-103cd6e072e0'
	and activeflag = 1 ;
	
-- CPS-IR 221020225598	22655aa1-6ccc-4dc4-a122-07204852c832	
-- Unknown, Unknown 200920860
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "122 Yrs",
      "clientid": "200920860",
      "childname": "Unknown Unknow"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '22655aa1-6ccc-4dc4-a122-07204852c832'
	and activeflag = 1 ;	
	
	
-- CPS-IR 221020235552	186267b3-477e-4759-97e4-cba53b66394d	
-- 3759496- Vernon, 3759760- Tyree, 3759711- Vernon, 
-- 3759761- Tyrek, 3759740- Tyshawna, 3759748- Lamont, 
-- 3759759- Damont, 3759758- Jamont
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "22 Yrs",
      "clientid": "3759496",
      "childname": "VERNON MARK BATSON"
    },
    {
      "age": "9 Yrs",
      "clientid": "3759760",
      "childname": "TYREE WILLIAMS"
    },
    {
      "age": "25 Yrs",
      "clientid": "3759711",
      "childname": "VERNON DANIEL BATSON"
    },
    {
      "age": "9 Yrs",
      "clientid": "3759761",
      "childname": "TYREK WILLIAMS"
    },
    {
      "age": "17 Yrs",
      "clientid": "3759740",
      "childname": "TYSHAWNA M J HAYES"
    },
    {
      "age": "10 Yrs",
      "clientid": "3759748",
      "childname": "LAMONT ANTWAN WILLIAMS"
    },
    {
      "age": "10 Yrs",
      "clientid": "3759759",
      "childname": "DAMONT WILLIAMS"
    },
    {
      "age": "10 Yrs",
      "clientid": "3759758",
      "childname": "JAMONT WILLIAMS"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '186267b3-477e-4759-97e4-cba53b66394d'
	and activeflag = 1 ;
	
-- CPS-AR 221020225101	f7ad8956-6194-4f02-8049-992b482cddca
-- 200920187,  200920189,  200933256
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "200920187",
      "childname": "Jordan Travo Raynard Campbell"
    },
    {
      "age": "15 Yrs",
      "clientid": "200920189",
      "childname": "Justin Campbell"
    },
    {
      "age": "12 Yrs",
      "clientid": "200933256",
      "childname": "Jayla Bush"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = 'f7ad8956-6194-4f02-8049-992b482cddca'
	and activeflag = 1 ;

-- CPS-IR 221020230044	6c157e87-bedc-4060-b2e9-93534a5b1dd4
-- 3581411-Jude Senn, 3536646-Sarah Senn, 3536647-Kayla Senn
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "3581411",
      "childname": "JUDE V SENN"
    },
    {
      "age": "13 Yrs",
      "clientid": "3536646",
      "childname": "SARAH P SENN"
    },
    {
      "age": "11 Yrs",
      "clientid": "3536647",
      "childname": "KAYLA B SENN"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '6c157e87-bedc-4060-b2e9-93534a5b1dd4'
	and activeflag = 1 ;
	
-- CPS-IR 221020236523	9fd026d2-f4b7-4399-b8ad-1c70081537c0
-- 200928802-Luciana Watford, 200651343-Sharlya Watford
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Month(s)",
      "clientid": "200928802",
      "childname": "Lucciano Watford"
    },
    {
      "age": "1 Yrs",
      "clientid": "200651343",
      "childname": "Charlaya Watford"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '9fd026d2-f4b7-4399-b8ad-1c70081537c0'
	and activeflag = 1 ;
	
-- CPS-IR 221020213775	c67461a2-9bbe-4ff0-8758-e42cfffcec1e
-- 2538110, 200922706, 200922705 CHRISTINA SUMPTER
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "2538110",
      "childname": "TYSHAWN SUMPTER"
    },
    {
      "age": "3 Yrs",
      "clientid": "200922706",
      "childname": "Jabrea Kosh"
    },
    {
      "age": "3 Yrs",
      "clientid": "200922705",
      "childname": "Jabril Kosh"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = 'c67461a2-9bbe-4ff0-8758-e42cfffcec1e'
	and activeflag = 1 ;
	
-- CPS-IR 221020213775	4293f0ae-0cc9-4649-b395-31b789aa563f
-- 2538110, 200922706, 200922705 CHRISTINA SUMPTER
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "2538110",
      "childname": "TYSHAWN SUMPTER"
    },
    {
      "age": "3 Yrs",
      "clientid": "200922706",
      "childname": "Jabrea Kosh"
    },
    {
      "age": "3 Yrs",
      "clientid": "200922705",
      "childname": "Jabril Kosh"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '4293f0ae-0cc9-4649-b395-31b789aa563f'
	and activeflag = 1 ;
	

-- CPS-IR 221020226585	a2a683d8-295e-4ff0-b633-40bb1861929f
-- 2538110,  200922706, 200922705 CHRISTINA SUMPTER
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "2538110",
      "childname": "TYSHAWN SUMPTER"
    },
    {
      "age": "3 Yrs",
      "clientid": "200922706",
      "childname": "Jabrea Kosh"
    },
    {
      "age": "3 Yrs",
      "clientid": "200922705",
      "childname": "Jabril Kosh"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = 'a2a683d8-295e-4ff0-b633-40bb1861929f'
	and activeflag = 1 ;

-- CPS-IR 221020223681	9eba7fe1-3a9f-4828-b06e-31e676ea33f4
-- 200918586, 200937318/435062929, 200937315, 200937320, 4440977  BLANCA ENAMORADO
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200918586",
      "childname": "Meia Natalie"
    },
    {
      "age": "11 Yrs",
      "clientid": "200937318",
      "childname": "Gerson Silva"
    },
    {
      "age": "13 Yrs",
      "clientid": "200937315",
      "childname": "Marila Silva"
    },
    {
      "age": "2 Yrs",
      "clientid": "200937320",
      "childname": "Blanca Emerita"
    },
    {
      "age": "15 Yrs",
      "clientid": "4440977",
      "childname": "MILEYDI SILVA"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '9eba7fe1-3a9f-4828-b06e-31e676ea33f4'
	and activeflag = 1 ;
	
-- CPS-IR 221020223681	20afde0b-9a76-4281-b97c-7a8d8313645e
-- 200918586, 200937318/435062929, 200937315, 200937320, 4440977  BLANCA ENAMORADO
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200918586",
      "childname": "Meia Natalie"
    },
    {
      "age": "11 Yrs",
      "clientid": "200937318",
      "childname": "Gerson Silva"
    },
    {
      "age": "13 Yrs",
      "clientid": "200937315",
      "childname": "Marila Silva"
    },
    {
      "age": "2 Yrs",
      "clientid": "200937320",
      "childname": "Blanca Emerita"
    },
    {
      "age": "15 Yrs",
      "clientid": "4440977",
      "childname": "MILEYDI SILVA"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '20afde0b-9a76-4281-b97c-7a8d8313645e'
	and activeflag = 1 ;
	
-- CPS-IR 221020237348	bdfcae3b-79c9-423c-b536-3e70cfe02605
-- Kamaya-3747291, Kamal-3754679,Oshyn-200886001,Ta'leya 200814534
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "3747291",
      "childname": "KAMYA PEARSON"
    },
    {
      "age": "10 Yrs",
      "clientid": "3754679",
      "childname": "KAMAL ALLEN LITTLE"
    },
    {
      "age": "8 Yrs",
      "clientid": "200886001",
      "childname": "Oshyn Preston"
    },
    {
      "age": "5 Yrs",
      "clientid": "200814534",
      "childname": "Ta''Leya Griffin"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = 'bdfcae3b-79c9-423c-b536-3e70cfe02605'
	and activeflag = 1 ;
	
-- CPS-AR 221020223308	96ea8308-2514-4b3f-817f-c8761ad5b698
-- 200917923-Kinnadi Tayette Morris, 200936555-Mason Jay
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "200917923",
      "childname": "Kinnadi Tayette Morris"
    },
    {
      "age": "5 Yrs",
      "clientid": "200936555",
      "childname": "Mason Jay"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '96ea8308-2514-4b3f-817f-c8761ad5b698'
	and activeflag = 1 ;
	
-- CPS-AR 221020225505	e3237475-6ca2-4aea-a245-d0c635f2abc6
-- 200827987-Brandon Askew, 200920348-Jayden Askew
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200827987",
      "childname": "Branden S Askew"
    },
    {
      "age": "3 Yrs",
      "clientid": "200920348",
      "childname": "Jayden Askew"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = 'e3237475-6ca2-4aea-a245-d0c635f2abc6'
	and activeflag = 1 ;
	
-- CPS-IR 221020238140	df43d2fd-f3da-4058-872a-8dc3d24c352a
-- 200937746, 200937743, and 200825275
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200937746",
      "childname": "Kai A Brown"
    },
    {
      "age": "11 Yrs",
      "clientid": "200937743",
      "childname": "Eli N Brown"
    },
    {
      "age": "14 Yrs",
      "clientid": "200825275",
      "childname": "Maya Naomi Walker-Crowder"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = 'df43d2fd-f3da-4058-872a-8dc3d24c352a'
	and activeflag = 1 ;

-- CPS-IR 221020237107	a14e5ef5-fded-4163-9de1-0b399479f1a5
-- 200935780 and 200935781, 2791715
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "200935780",
      "childname": "Edwin A Navas Florencio"
    },
    {
      "age": "17 Yrs",
      "clientid": "200935781",
      "childname": "Sebastian Navas Florencio"
    },
    {
      "age": "18 Yrs",
      "clientid": "2791715",
      "childname": "MARIANNA NAVAS"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = 'a14e5ef5-fded-4163-9de1-0b399479f1a5'
	and activeflag = 1 ;
	

-- 202102905679	fc4284fd-6aa5-4e7f-8b1c-3398ea363e8c
-- Jade Chase PID:200921837 and Caleb Chase PID:200921831
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200921837",
      "childname": "Jade Elaine Chase"
    },
    {
      "age": "1 Month(s)",
      "clientid": "200921831",
      "childname": "Caleb Jasik Chase"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = 'fc4284fd-6aa5-4e7f-8b1c-3398ea363e8c'
	and activeflag = 1 ;
	
-- 221030017406	142565ad-43fd-490f-9d46-35f3607dcd97
-- "CJAMS PID#	:	4294520"
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "4294520",
      "childname": "KENNEDY L TILGHMAN"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '142565ad-43fd-490f-9d46-35f3607dcd97'
	and activeflag = 1 ;	
	

-- 211030013076	7feda4f5-a2ff-44a6-8fc8-d4f81b8c275f
-- Evee Brown 200848091, Elija B 200640519
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Month(s)",
      "clientid": "200848091",
      "childname": "Evee Brown"
    },
    {
      "age": "1 Yrs",
      "clientid": "200640519",
      "childname": "Elija Brown"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '7feda4f5-a2ff-44a6-8fc8-d4f81b8c275f'
	and activeflag = 1 ;
	

-- CPS-IR 221020215859	9cf51a03-c092-4568-86b1-c2474de2bdda
-- 200537268- Bre'asia Smith 200909402 -Adrianna Smith 200909424- Derrell Briscoe
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "200537268",
      "childname": "BRE''ASIA E SMITH"
    },
    {
      "age": "9 Yrs",
      "clientid": "200909402",
      "childname": "Adrianna Smith"
    },
    {
      "age": "2 Yrs",
      "clientid": "200909424",
      "childname": "Derrell J Briscoe"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '9cf51a03-c092-4568-86b1-c2474de2bdda'
	and activeflag = 1 ;
	
-- 221030015770	edcc59cc-c64d-44ed-817c-2942d0f78018
-- John Casalegno-200882179, Yotzan Casalegno- 200882180
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "18 Yrs",
      "clientid": "200882179",
      "childname": "John Casalegno"
    },
    {
      "age": "16 Yrs",
      "clientid": "200882180",
      "childname": "Yotzan Casalegno"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = 'edcc59cc-c64d-44ed-817c-2942d0f78018'
	and activeflag = 1 ;
	

-- 3303573	340f1825-3715-4a09-97d7-c99972bdf9fd
-- CJAMS PID#: 200937526 SAFE-C: 06/10/2022 04:26 PM
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200937526",
      "childname": "Unknown unknow"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '340f1825-3715-4a09-97d7-c99972bdf9fd'
	and activeflag = 1 ;
	

-- CPS-IR 211020139229	e4bd3946-f28a-49c5-a150-1a69ef34f093
-- CJAMS PID#: 200804586 CJAMS PID#: 4283365 
-- SAFE-C: 01/10/2022 05:16 PM SAFE-C: 11/10/2021 05:04 PM
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Month(s)",
      "clientid": "200804586",
      "childname": "Josiah Williams"
    },
    {
      "age": "6 Yrs",
      "clientid": "4283365",
      "childname": "MICHAEL A HILL-GIBSON"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = 'e4bd3946-f28a-49c5-a150-1a69ef34f093'
	and activeflag = 1 ;
	
-- 221030013443	55dc6c9a-6c71-4766-a501-bf4d91bbc1a7
-- 200829082
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "200829082",
      "childname": "Kendall Simmons"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '55dc6c9a-6c71-4766-a501-bf4d91bbc1a7'
	and activeflag = 1 ;
	
-- 211030012460	4743d43a-f689-413c-8b40-8bb1711e8ed3
-- Dulawyn Gray El(CJAMS PID#:  2681212)
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "2681212",
      "childname": "DULAWYN GRAY EL"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '4743d43a-f689-413c-8b40-8bb1711e8ed3'
	and activeflag = 1 ;
	
-- 211030012460	d56995ed-2c8e-40e4-a58b-b7c4adfeaaea
-- Dulawyn Gray El(CJAMS PID#:  2681212)
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "2681212",
      "childname": "DULAWYN GRAY EL"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = 'd56995ed-2c8e-40e4-a58b-b7c4adfeaaea'
	and activeflag = 1 ;
	
-- CPS-IR 221020181269	04527c72-8b9c-479d-8132-82fa537765e3
-- Josiah Williams 200804586, Michael Hill Gibson 4283365
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Month(s)",
      "clientid": "200804586",
      "childname": "Josiah Williams"
    },
    {
      "age": "6 Yrs",
      "clientid": "4283365",
      "childname": "MICHAEL A HILL-GIBSON"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '04527c72-8b9c-479d-8132-82fa537765e3'
	and activeflag = 1 ;
	
-- 2021010507290	acd55182-de87-4cd1-8520-edf6863714d0
-- Kevin Lemus Guzman(CJAMS PID#:200646899)
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "200646899",
      "childname": "Kevin Lemus Guzman"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = 'acd55182-de87-4cd1-8520-edf6863714d0'
	and activeflag = 1 ;
	
-- 2021010507290	0e292c80-cd07-4980-a51e-7d0c06f41ae0
-- Kevin Lemus Guzman(CJAMS PID#:200646899)
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "200646899",
      "childname": "Kevin Lemus Guzman"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '0e292c80-cd07-4980-a51e-7d0c06f41ae0'
	and activeflag = 1 ;
	
-- CPS-IR 211020139229	22000771-c4a2-4074-a47d-e3f43fd20463
-- CJAMS PID#: 200804586 CJAMS PID#: 4283365 SAFE-C: 01/10/2022 05:16 PM SAFE-C: 11/10/2021 05:04 PM
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Month(s)",
      "clientid": "200804586",
      "childname": "Josiah Williams"
    },
    {
      "age": "6 Yrs",
      "clientid": "4283365",
      "childname": "MICHAEL A HILL-GIBSON"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '22000771-c4a2-4074-a47d-e3f43fd20463'
	and activeflag = 1 ;
	
-- 3298058	94c62e5e-338a-42f6-9f81-f4d34c525630
-- 2100287, 3755244
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "2100287",
      "childname": "BRIAN TYRONE COOPER"
    },
    {
      "age": "8 Yrs",
      "clientid": "3755244",
      "childname": "GRACE MARIE COOPER"
    }
    ]')
--	,updatedby = 'CIDM-6042-R1'
--	,updatedon = now()
where assessmentid = '94c62e5e-338a-42f6-9f81-f4d34c525630'
	and activeflag = 1 ;
		
-- 318 - CJAMS Go Live to Till 8/1 - End	


-- Failed - Start
/*
221030015592	009f6cb9-fba5-418c-bbca-54b76f57e891	
Aidan Rameriz 12/23/2008
Audrey Guzman 05/24/2010
Edwin Fuentes 10/22/2018

On the second Safe-C
Luis Guzman 03/05/2012
Giovanna Fuentes 07/11/2016
Second Assesment child is not updated - Child Name is missing
*/

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "200934919",
      "childname": "Aidan Rameriz"
    },
    {
      "age": "12 Yrs",
      "clientid": "200889908",
      "childname": "Audrey M Guzman"
    },
    {
      "age": "3 Yrs",
      "clientid": "200889946",
      "childname": "Edwin Fuentes"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '46e18cd0-7003-43d8-aa5a-c1acd110c827'
	and activeflag = 1 ;


/*
221030015592	46e18cd0-7003-43d8-aa5a-c1acd110c827	
Aidan Rameriz 12/23/2008
Audrey Guzman 05/24/2010
Edwin Fuentes 10/22/2018

On the second Safe-C
Luis Guzman 03/05/2012 - 200899030 is not available ????
Giovanna Fuentes 07/11/2016 - 200899025
Second Assesment child is not updated - Child Name is missing
*/

update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "6 Yrs",
		"name": "Giovannah Fuentes",
		"cjamspid": "200899025"
	},
	{
		"age": "10 Yrs",
		"name": "Luis Guzman",
		"cjamspid": "200899030"
	},
	{
		"age": "13 Yrs",
		"name": "Aidan Rameriz",
		"cjamspid": "200934919"
    },
    {
		"age": "12 Yrs",
		"name": "Audrey M Guzman",
		"cjamspid": "200889908"
    },
    {
		"age": "3 Yrs",
		"name": "Edwin Fuentes",
		"cjamspid": "200889946"	
    }]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '009f6cb9-fba5-418c-bbca-54b76f57e891'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "200934919",
      "childname": "Aidan Rameriz"
    },
    {
      "age": "12 Yrs",
      "clientid": "200889908",
      "childname": "Audrey M Guzman"
    },
    {
      "age": "3 Yrs",
      "clientid": "200889946",
      "childname": "Edwin Fuentes"
    },
	{
      "age": "6 Yrs",
      "clientid": "200899025",
      "childname": "Giovannah Fuentes"
    },
	{
      "age": "10 Yrs",
      "clientid": "200899030",
      "childname": "Luis Guzman"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '009f6cb9-fba5-418c-bbca-54b76f57e891'
	and activeflag = 1 ;


-- CPS-IR 221020226100	eacb89e5-2679-4dce-822d-7dadb8588ac9	
-- Brave Madden 200019959 , Bria Madden 200019964	Bria Madden 
-- child name is missing

update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "10 Yrs",
		"name": "BRIA M MADDEN",
		"cjamspid": "200019964"
	},
	{
		"age": "12 Yrs",
		"name": "BRAVE MADDEN",
		"cjamspid": "200019959"
    }]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'eacb89e5-2679-4dce-822d-7dadb8588ac9'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "200019959",
      "childname": "BRAVE MADDEN"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'eacb89e5-2679-4dce-822d-7dadb8588ac9'
	and activeflag = 1 ;

-- 221030017234	80cbd278-4c0d-4a68-bed0-8461f6ffd866	
-- CJAMS PID # 2657192	Chid name is missing

update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "15 Yrs",
		"name": "TRINITY FALCON",
		"cjamspid": "2657192"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '80cbd278-4c0d-4a68-bed0-8461f6ffd866'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "2657192",
      "childname": "TRINITY FALCON"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '80cbd278-4c0d-4a68-bed0-8461f6ffd866'
	and activeflag = 1 ;
	
	
-- CPS-AR 221020236133	039a74d6-1202-4856-902b-1fb6752b5626	
-- CJAMS PID # 200935940	Chid name is missing

update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "1 Yrs",
		"name": "Kenneth Vanorsdale",
		"cjamspid": "200935940"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '039a74d6-1202-4856-902b-1fb6752b5626'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200935940",
      "childname": "Kenneth Vanorsdale"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '039a74d6-1202-4856-902b-1fb6752b5626'
	and activeflag = 1 ;
	
-- CPS-IR 221020228077	c5002cd5-0600-4df6-bf2d-cca47d84fc66	
-- CJAMS PID#: 200924160 SAFE-C: 06/22/2022 06:09PM
-- The child name is not updated

update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "2 Month(s)",
		"name": "Chayse Holbrook",
		"cjamspid": "200924160"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'c5002cd5-0600-4df6-bf2d-cca47d84fc66'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Month(s)",
      "clientid": "200924160",
      "childname": "Chayse Holbrook"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'c5002cd5-0600-4df6-bf2d-cca47d84fc66'
	and activeflag = 1 ;	
	
-- CPS-IR 221020203314	30afefb1-3257-4468-9146-8135bec09f23	
-- CJAMS PID#: 200881028 SAFE-C: 06/16/2022 03:20PM
-- The child name is not updated
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "3 Month(s)",
		"name": "Brooke Tashay Wall",
		"cjamspid": "200881028"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '30afefb1-3257-4468-9146-8135bec09f23'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Month(s)",
      "clientid": "200881028",
      "childname": "Brooke Tashay Wall"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '30afefb1-3257-4468-9146-8135bec09f23'
	and activeflag = 1 ;	
	
-- CPS-IR 221020223997	3aa9b898-7feb-4b68-9b75-3dcc575513e0	
-- CJAMS PID#: 200792834 CJAMS PID#: 200918910 SAFE-C: 06/07/2022 09:21 PM
-- The child name is not updated

update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "9 Month(s)",
		"name": "Matteo Yhamni Johnson",
		"cjamspid": "200792834"
	},
	{
		"age": "11 Yrs",
		"name": "Solomon Ringgold",
		"cjamspid": "200918910"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '3aa9b898-7feb-4b68-9b75-3dcc575513e0'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Month(s)",
      "clientid": "200792834",
      "childname": "Matteo Yhamni Johnson"
    },
    {
      "age": "11 Yrs",
      "clientid": "200918910",
      "childname": "Solomon Ringgold"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '3aa9b898-7feb-4b68-9b75-3dcc575513e0'
	and activeflag = 1 ;
	
-- 221030015775	2d1277b8-1302-4a0f-80c3-a7ae0b7e68dc	
-- SAFE-C: 05/04/2022 02:22 PM
-- Child’s CJAMS PID: 1651137 Child’s Name: Anton Smith
-- Child’s CJAMS PID: 3362542 Child’s Name: Antonya Smith
-- Child name not updated
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "17 Yrs",
		"name": "ANTON SMITH",
		"cjamspid": "1651137"
	},
	{
		"age": "10 Yrs",
		"name": "ANTONYA SMITH",
		"cjamspid": "3362542"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '2d1277b8-1302-4a0f-80c3-a7ae0b7e68dc'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "1651137",
      "childname": "ANTON SMITH"
    },
    {
      "age": "10 Yrs",
      "clientid": "3362542",
      "childname": "ANTONYA SMITH"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '2d1277b8-1302-4a0f-80c3-a7ae0b7e68dc'
	and activeflag = 1 ;
	
	
-- CPS-IR 221020195374	88c6afc7-5e10-45ac-aa77-81148327b832	
-- CJAMS PID#: 200882766 SAFE-C: 04/05/2022 10:37 AM
-- Child name is not updated
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "17 Yrs",
		"name": "Ryan Crouch",
		"cjamspid": "200882766"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '88c6afc7-5e10-45ac-aa77-81148327b832'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "200882766",
      "childname": "Ryan Crouch"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '88c6afc7-5e10-45ac-aa77-81148327b832'
	and activeflag = 1 ;
	

-- 221030013644	ece8ab17-f355-410a-a571-ef5077b55870	
/*
CJAMS PID#: 200857074
SAFE-C: 04/08/2022 02:05 AM
SAFE-C: 02/04/2022 03:10 PM
SAFE-C: 01/25/2022 03:03 PM
Child name is not updated

221030013644	d006fe21-f8d0-472c-84c2-433cf6e7b807	
CJAMS PID#: 200857074
SAFE-C: 04/08/2022 02:05 AM
SAFE-C: 02/04/2022 03:10 PM
SAFE-C: 01/25/2022 03:03 PM
Child name is not updated

221030013644	6317409b-2a69-4371-91e0-13426fcbc1a2	
CJAMS PID#: 200857074
SAFE-C: 04/08/2022 02:05 AM
SAFE-C: 02/04/2022 03:10 PM
SAFE-C: 01/25/2022 03:03 PM
Child name is not updated
*/
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "2 Month(s)",
		"name": "Chrstopher Nicholas North",
		"cjamspid": "200857074"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid in ( 'ece8ab17-f355-410a-a571-ef5077b55870',
						'd006fe21-f8d0-472c-84c2-433cf6e7b807',
						'6317409b-2a69-4371-91e0-13426fcbc1a2'
					  )			
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Month(s)",
      "clientid": "200857074",
      "childname": "Chrstopher Nicholas North"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid in ( 'ece8ab17-f355-410a-a571-ef5077b55870',
						'd006fe21-f8d0-472c-84c2-433cf6e7b807',
						'6317409b-2a69-4371-91e0-13426fcbc1a2'
					  )			
	and activeflag = 1 ;	
	
	
-- CPS-IR 221020197889	6ab5b63d-bc06-402a-89d0-f9baa8584f31	
-- Mecca Sofidiya (CJAMS PID - 200885816)	
-- Child name not updated
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "3 Month(s)",
		"name": "Mecca Sofidiya",
		"cjamspid": "200885816"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '6ab5b63d-bc06-402a-89d0-f9baa8584f31'			
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Month(s)",
      "clientid": "200885816",
      "childname": "Mecca Sofidiya"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '6ab5b63d-bc06-402a-89d0-f9baa8584f31'
	and activeflag = 1 ;
	
	
-- 3299976	af78e21f-2542-4d70-b77b-ea06a1049a5d	
/*
Lamar Davis- 3349998
Jilnae Davis- 3350001
Xavier Butler- 3349923
Julian Butler- 3349889
Ava Butler- 3780984
Child name not updated


3299976	e7c8b3d3-0105-476e-b304-af099881faab	
Lamar Davis- 3349998
Jilnae Davis- 3350001
Xavier Butler- 3349923
Julian Butler- 3349889
Ava Butler- 3780984
Child name not updated
*/
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "14 Yrs",
		"name": "LAMAR KHALIL DAVIS",
		"cjamspid": "3349998"
	},
	{
		"age": "3 Month(s)",
		"name": "JILNAE LASHAUNA DAVIS",
		"cjamspid": "3350001"
	},
	{
		"age": "12 Yrs",
		"name": "XAIVER JAMAL BUTLER",
		"cjamspid": "3349923"
	},
	{
		"age": "10 Yrs",
		"name": "JULIAN JAMEL BUTLER",
		"cjamspid": "3349889"
	},
	{
		"age": "7 Yrs",
		"name": "AVA NICOLE BUTLER",
		"cjamspid": "3780984"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid in ( 'af78e21f-2542-4d70-b77b-ea06a1049a5d',
						'e7c8b3d3-0105-476e-b304-af099881faab',
						'40771282-c7f1-49c1-85de-95efa774171a'
					  )	
	and activeflag = 1 ;
	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "3349998",
      "childname": "LAMAR KHALIL DAVIS"
    },
    {
      "age": "13 Yrs",
      "clientid": "3350001",
      "childname": "JILNAE LASHAUNA DAVIS"
    },
    {
      "age": "12 Yrs",
      "clientid": "3349923",
      "childname": "XAIVER JAMAL BUTLER"
    },
    {
      "age": "10 Yrs",
      "clientid": "3349889",
      "childname": "JULIAN JAMEL BUTLER"
    },
    {
      "age": "7 Yrs",
      "clientid": "3780984",
      "childname": "AVA NICOLE BUTLER"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid in ( 'af78e21f-2542-4d70-b77b-ea06a1049a5d',
						'e7c8b3d3-0105-476e-b304-af099881faab',
						'40771282-c7f1-49c1-85de-95efa774171a'
					  )	
	and activeflag = 1 ;
	
	
-- 221030014145	382d660b-4ede-4ff2-983b-fae25482c6d0	
-- Isaiah S Edwards(CJAMS PID#: 3305883)	
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "14 Yrs",
		"name": "ISAIAH S EDWARDS",
		"cjamspid": "3305883"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '382d660b-4ede-4ff2-983b-fae25482c6d0'			
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "3305883",
      "childname": "ISAIAH S EDWARDS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '382d660b-4ede-4ff2-983b-fae25482c6d0'
	and activeflag = 1 ;	
	
	
-- CPS-IR 211020172104	10c2bce2-6279-4cfe-a8fa-d0b57a93e910	
-- Layla Knighton(CJAMS PID#	:200851340)
-- Child name not updated
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "3 Month(s)",
		"name": "Layla Knighton",
		"cjamspid": "200851340"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '10c2bce2-6279-4cfe-a8fa-d0b57a93e910'			
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Month(s)",
      "clientid": "200851340",
      "childname": "Layla Knighton"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '10c2bce2-6279-4cfe-a8fa-d0b57a93e910'
	and activeflag = 1 ;	
	
-- 221030013763	fad0bfbb-03ac-4b97-9f56-465ca98aaa99	
-- Anijah 4181597, Kyrie 200850830, K'Ron 200174231, Na'Liek 200850825	
-- Child name not updated
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "4 Yrs",
		"name": "ANIJAH WARREN",
		"cjamspid": "4181597"
	},
	{
		"age": "2 Yrs",
		"name": "Kyrie BREAZIL",
		"cjamspid": "200850830"
	},
	{
		"age": "1 Yrs",
		"name": "K''ron Barnes",
		"cjamspid": "200174231"
	},
	{
		"age": "7 Yrs",
		"name": "Na''liek J Clark",
		"cjamspid": "200850825"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'fad0bfbb-03ac-4b97-9f56-465ca98aaa99'			
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "4181597",
      "childname": "ANIJAH WARREN"
    },
    {
      "age": "2 Yrs",
      "clientid": "200850830",
      "childname": "Kyrie BREAZIL"
    },
    {
      "age": "1 Yrs",
      "clientid": "200174231",
      "childname": "K''ron Barnes"
    },
    {
      "age": "7 Yrs",
      "clientid": "200850825",
      "childname": "Na''liek J Clark"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'fad0bfbb-03ac-4b97-9f56-465ca98aaa99'
	and activeflag = 1 ;	
	
-- 3297186	d6986258-dacb-476f-8fe1-98ef5e60072a	
-- CJAMS PID - 200811919	
-- child name is missing
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "6 Yrs",
		"name": "Ashton May",
		"cjamspid": "200811919"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'd6986258-dacb-476f-8fe1-98ef5e60072a'			
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200811919",
      "childname": "Ashton May"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'd6986258-dacb-476f-8fe1-98ef5e60072a'
	and activeflag = 1 ;	
	
	

-- 211030011767	501a387f-88e1-4111-946a-f02fad894a9d	
-- Milan Miller - CJAMS PID# 200800028	
-- child name missing
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "4 Yrs",
		"name": "milan miller",
		"cjamspid": "200800028"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '501a387f-88e1-4111-946a-f02fad894a9d'			
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200800028",
      "childname": "milan miller"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '501a387f-88e1-4111-946a-f02fad894a9d'
	and activeflag = 1 ;		
	
	
-- 202106106308	c6d2ffb6-4f8a-4bf6-a65e-e5861d1e004d	
-- 3612355	
-- child name is missing
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "22 Yrs",
		"name": "JEONNA DESIRE JOHNSON",
		"cjamspid": "3612355"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'c6d2ffb6-4f8a-4bf6-a65e-e5861d1e004d'			
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "22 Yrs",
      "clientid": "3612355",
      "childname": "JEONNA DESIRE JOHNSON"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'c6d2ffb6-4f8a-4bf6-a65e-e5861d1e004d'
	and activeflag = 1 ;	

-- CPS-IR 211020129968	c43c4f58-ba53-4850-83fe-bd763d39d0df	
-- 200791414, 200791520, 200791524
-- child name is missing

update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "4 Month(s)",
		"name": "Hector MAAS",
		"cjamspid": "200791414"
	},
	{
		"age": "6 Yrs",
		"name": "Jose Angel Melendres",
		"cjamspid": "200791520"
	},
	{
		"age": "3 Yrs",
		"name": "Daniela Quintana",
		"cjamspid": "200791524"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'c43c4f58-ba53-4850-83fe-bd763d39d0df'			
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{addchildren}','[
	{
		"seconeage": 6,
		"seconename": "Jose Angel Melendres"
	}, {
		"seconeage": 3,
		"seconename": "Daniela Quintana"
	}
	]')
--	,updatedby = 'CIDM-5785-R1'
--	,updatedon = now()
where assessmentid = 'c43c4f58-ba53-4850-83fe-bd763d39d0df'			
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Month(s)",
      "clientid": "200791414",
      "childname": "Hector MAAS"
    },
    {
      "age": "6 Yrs",
      "clientid": "200791520",
      "childname": "Jose Angel Melendres"
    },
    {
      "age": "3 Yrs",
      "clientid": "200791524",
      "childname": "Daniela Quintana"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'c43c4f58-ba53-4850-83fe-bd763d39d0df'
	and activeflag = 1 ;


-- 211030010385	b599081b-b63c-4ee7-abf3-cda695d4d06f	
-- 3388041	
-- child name is missing
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "10 Yrs",
		"name": "AARON JONES",
		"cjamspid": "3388041"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'b599081b-b63c-4ee7-abf3-cda695d4d06f'			
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "3388041",
      "childname": "AARON JONES"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'b599081b-b63c-4ee7-abf3-cda695d4d06f'
	and activeflag = 1 ;
	
-- 211030010247	562b2910-07bb-486c-97bb-b877866bd813	
-- 3922680	
-- child name is missing
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "34 Yrs",
		"name": "ASHLEY GILLISPIE",
		"cjamspid": "3922680"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '562b2910-07bb-486c-97bb-b877866bd813'			
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "34 Yrs",
      "clientid": "3922680",
      "childname": "ASHLEY GILLISPIE"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '562b2910-07bb-486c-97bb-b877866bd813'
	and activeflag = 1 ;
	
-- CPS-IR 211020131504	af60f4f1-fbee-4169-8aae-0539e776839e	
-- 200137825	
-- child name is missing
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "2 Yrs",
		"name": "JABARI WATKINS",
		"cjamspid": "200137825"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'af60f4f1-fbee-4169-8aae-0539e776839e'			
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200137825",
      "childname": "JABARI WATKINS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'af60f4f1-fbee-4169-8aae-0539e776839e'
	and activeflag = 1 ;
	
-- 211030010271	d866c027-d367-4363-9d6e-ad717cd03382	
-- 200800028 & 200796740
-- child names missing
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "4 Yrs",
		"name": "milan miller",
		"cjamspid": "200800028"
	},
	{
		"age": "4 Yrs",
		"name": "Milan Jaide Miller",
		"cjamspid": "200796740"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'd866c027-d367-4363-9d6e-ad717cd03382'			
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200800028",
      "childname": "milan miller"
    },
    {
      "age": "4 Yrs",
      "clientid": "200796740",
      "childname": "Milan Jaide Miller"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'd866c027-d367-4363-9d6e-ad717cd03382'
	and activeflag = 1 ;
	
-- CPS-IR 211020131504	96266033-0a85-4690-8ccd-17ec7133cc90	
-- 200137825	
-- child name missing
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "2 Yrs",
		"name": "JABARI WATKINS",
		"cjamspid": "200137825"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '96266033-0a85-4690-8ccd-17ec7133cc90'			
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200137825",
      "childname": "JABARI WATKINS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '96266033-0a85-4690-8ccd-17ec7133cc90'
	and activeflag = 1 ;		
	
-- 211030009725	e28f5281-5c89-4d4b-994e-a7e41544b7fc	
-- 4091611, 4091615, 4112512 & 4112513
-- child names missing
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "10 Yrs",
		"name": "DEMETRIUS ALEXANDER",
		"cjamspid": "4091611"
	},
	{
		"age": "9 Yrs",
		"name": "CHRISTIAN ALEXANDER",
		"cjamspid": "4091615"
	},
	{
		"age": "6 Yrs",
		"name": "AIDEN THOMAS",
		"cjamspid": "4112512"
	},
	{
		"age": "4 Yrs",
		"name": "NATALIA R THOMAS",
		"cjamspid": "4112513"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'af60f4f1-fbee-4169-8aae-0539e776839e'			
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "4091611",
      "childname": "DEMETRIUS ALEXANDER"
    },
    {
      "age": "9 Yrs",
      "clientid": "4091615",
      "childname": "CHRISTIAN ALEXANDER"
    },
    {
      "age": "6 Yrs",
      "clientid": "4112512",
      "childname": "AIDEN THOMAS"
    },
    {
      "age": "4 Yrs",
      "clientid": "4112513",
      "childname": "NATALIA R THOMAS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'e28f5281-5c89-4d4b-994e-a7e41544b7fc'
	and activeflag = 1 ;	
	


-- 211030009604	25665328-cd24-4424-9b48-4a9c8fa6e9f9	
-- Adriana Coulter 3510028, Dakota Coulter 200786439	
-- child and client names missing
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "10 Yrs",
		"name": "ADRIANA COULTER",
		"cjamspid": "3510028"
	},
	{
		"age": "3 Yrs",
		"name": "Dakota Coulter",
		"cjamspid": "200786439"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '25665328-cd24-4424-9b48-4a9c8fa6e9f9'			
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "3510028",
      "childname": "ADRIANA COULTER"
    },
    {
      "age": "3 Yrs",
      "clientid": "200786439",
      "childname": "Dakota Coulter"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '25665328-cd24-4424-9b48-4a9c8fa6e9f9'
	and activeflag = 1 ;	
	
	

/*
211030008265	f3741017-5529-4cc0-b20c-9ac9f3c4abff	
SAFE-C May 20, 2022
Child CJAMS PID: 3276244  Child Name: Jeremy Davis
Child CJAMS PID: 436042713 Child Name: Alizabeth Davis

SAFE-C March 29, 2022
Child CJAMS PID: 3276244 Child Name: Jeremy Davis
Child CJAMS PID: 436042713 Child Name: Alizabeth Davis

SAFE-C July 27, 2021 
Child CJAMS PID: 3276244  Child Name: Jeremy Davis
Child CJAMS PID: 436042713 Child Name: Alizabeth Davis

SAFE-C July 7, 2021
Child CJAMS PID: 3276244 Child Name: Jeremy Davis
Child CJAMS PID: 436042713 Child Name: Alizabeth Davis
Client id not matching 

211030008265	631411a7-6c4b-4d8e-be8b-028314e36f26	
SAFE-C May 20, 2022 
Child CJAMS PID: 3276244 Child Name: Jeremy Davis
Child CJAMS PID: 436042713 Child Name: Alizabeth Davis

SAFE-C March 29, 2022
Child CJAMS PID: 3276244 Child Name: Jeremy Davis
Child CJAMS PID: 436042713 Child Name: Alizabeth Davis

SAFE-C July 27, 2021 
Child CJAMS PID: 3276244  Child Name: Jeremy Davis
Child CJAMS PID: 436042713 Child Name: Alizabeth Davis

SAFE-C July 7, 2021
Child CJAMS PID: 3276244 Child Name: Jeremy Davis
Child CJAMS PID: 436042713 Child Name: Alizabeth Davis
Clinet id is incorrect
*/
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "9 Yrs",
		"name": "JEREMY DAVIS",
		"cjamspid": "3276244"
	},
	{
		"age": "11 Yrs",
		"name": "ALIZABETH DAVIS",
		"cjamspid": "3267400"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid in ( '631411a7-6c4b-4d8e-be8b-028314e36f26', 'f3741017-5529-4cc0-b20c-9ac9f3c4abff' )
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "3276244",
      "childname": "JEREMY DAVIS"
    },
	{
      "age": "11 Yrs",
      "clientid": "3267400",
      "childname": "ALIZABETH DAVIS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid in ( '631411a7-6c4b-4d8e-be8b-028314e36f26', 'f3741017-5529-4cc0-b20c-9ac9f3c4abff' )
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "10 Yrs",
		"name": "JEREMY DAVIS",
		"cjamspid": "3276244"
	},
	{
		"age": "12 Yrs",
		"name": "ALIZABETH DAVIS",
		"cjamspid": "3267400"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid in ( '2b89030a-36ea-42c3-836b-601bc9e4a66e', '809ef988-dd77-4795-95cd-a0d8a0aaeaed' )
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "3276244",
      "childname": "JEREMY DAVIS"
    },
	{
      "age": "12 Yrs",
      "clientid": "3267400",
      "childname": "ALIZABETH DAVIS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid in ( '2b89030a-36ea-42c3-836b-601bc9e4a66e', '809ef988-dd77-4795-95cd-a0d8a0aaeaed' )
	and activeflag = 1 ;
	
/*	
2020029403718	6c7383b0-70a0-4ef9-92b3-a1a2d585aea2	
Erick Rivera Recinos
CJAMS PID#	:4473023"	
child name is missing

2020029403718	26cad39a-631d-45a2-8265-3bafcf59c2cf	
Erick Rivera Recinos
CJAMS PID#	:4473023
child name is missing
*/
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "11 Yrs",
		"name": "ERICK RIVERA RECINOS",
		"cjamspid": "4473023"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid in ( '6c7383b0-70a0-4ef9-92b3-a1a2d585aea2', '26cad39a-631d-45a2-8265-3bafcf59c2cf')
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "4473023",
      "childname": "ERICK RIVERA RECINOS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid in ( '6c7383b0-70a0-4ef9-92b3-a1a2d585aea2', '26cad39a-631d-45a2-8265-3bafcf59c2cf')
	and activeflag = 1 ;	
	
	
-- CPS-IR 211020112969	a6385099-dd74-4957-a3c8-931c276390d5	
-- Mikhale Marie Kra
-- child name is missing
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "9 Month(s)",
		"name": "Mikhale Marie Kra",
		"cjamspid": "200670136"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'a6385099-dd74-4957-a3c8-931c276390d5'			
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Month(s)",
      "clientid": "200670136",
      "childname": "Mikhale Marie Kra"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'a6385099-dd74-4957-a3c8-931c276390d5'
	and activeflag = 1 ;		
	
-- 211030008298	18a6254c-8ff9-4d45-adde-2373b185f8e4	
-- 200670320 & 200670321	
-- child name is missing
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "5 Yrs",
		"name": "Ariyah Hayward",
		"cjamspid": "200670320"
	},
	{
		"age": "3 Yrs",
		"name": "Gide Viyah Jetinet",
		"cjamspid": "200670321"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '18a6254c-8ff9-4d45-adde-2373b185f8e4'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "200670320",
      "childname": "Ariyah Hayward"
    },
    {
      "age": "3 Yrs",
      "clientid": "200670321",
      "childname": "Gide Viyah Jetinet"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '18a6254c-8ff9-4d45-adde-2373b185f8e4'
	and activeflag = 1 ;
	
-- Failed - End
