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
      "age": "16 Yrs",
      "clientid": "4222170",
      "childname": "GARRIN K DAVIS"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '35eafa0c-a345-465c-8f10-6b447cbc0eda'
	and activeflag = 1 ;

								
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "0 Yrs",
      "clientid": "200821204",
      "childname": "Alonzo Hill-Benton"
    },
    {
      "age": "2 Yrs",
      "clientid": "4479339",
      "childname": "QUINZELL HILL BENTON"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '21f917b9-e7a6-40c5-b569-c59a0b1659f3'
	and activeflag = 1 ;



update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "4439436",
      "childname": "DANIEL L BOLEAN"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '170fd2fb-a522-4784-a641-07ccca2a2338'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Yrs",
      "clientid": "200937933",
      "childname": "Ivania Colindres- Solorzano"
    },
    {
      "age": "6 Yrs",
      "clientid": "200937943",
      "childname": "Emilio Omar- Ramirez"
    },
    {
      "age": "9 Yrs",
      "clientid": "200868566",
      "childname": "Andrea Rivera Solorzano"
    },
    {
      "age": "10 Yrs",
      "clientid": "200937940",
      "childname": "Christopher Alas- Corado"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '0b79585b-6785-4a3f-9ac7-a8a3797b6fdc'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200657456",
      "childname": "Messiah Jackson"
    },
    {
      "age": "6 Yrs",
      "clientid": "4428947",
      "childname": "KYLEE N BENTON"
    },
    {
      "age": "2 Yrs",
      "clientid": "200657458",
      "childname": "Brooklyn Jackson"
    },
    {
      "age": "9 Yrs",
      "clientid": "3686703",
      "childname": "ISAIAH JACKSON"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '1f678240-8f19-4bc8-9ae0-321ebe6ec38e'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "4445908",
      "childname": "ERIC BROWN"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = 'aa4eae12-944d-4d60-ac7a-521f4f53a8d3'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200937915",
      "childname": "Miles Thompson"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = 'e3284af4-5d30-4cdf-bb08-45b10200c929'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200938156",
      "childname": "Josiah Johnson"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '32ce60fc-8fb2-45c6-9799-ae815903acb5'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "200903851",
      "childname": "Vanessa Quintanilla Machado"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '82faa351-8ca8-4ccb-8cfb-6a37e1a036cc'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200938494",
      "childname": "Isabelle Layton"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = 'f3896aff-549b-4a5d-8f14-1e93dd368733'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "4387807",
      "childname": "KATRINA HICKS"
    },
    {
      "age": "6 Yrs",
      "clientid": "4387808",
      "childname": "ROBBIE HICKS"
    },
    {
      "age": "14 Yrs",
      "clientid": "4387806",
      "childname": "KALINA HICKS"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '641a5daa-f361-4f9f-99a2-05da718df763'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "3263397",
      "childname": "DELANTE F TYLER"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '06babab6-ab34-4c4f-a486-bc06323dde9d'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "200808004",
      "childname": "Jakiya Mills"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '92dc4ddb-3670-4c79-ab60-75617af5d8fd'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200918357",
      "childname": "Shokhruza makhmudova"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = 'e078edad-b1de-4afa-a742-e0c09e5d1101'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "200920247",
      "childname": "Blake Jester"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '2a1b5442-06ed-4f61-8a38-0950ea2bce93'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "200843948",
      "childname": "Mya Johnson"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '93255baf-3ebd-437e-b05c-41c26ad96a08'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "200920908",
      "childname": "Kaylee Seipler"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '8562ef60-62e2-4927-9748-c380d798acca'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "200922030",
      "childname": "Joelle D Tranquille"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '99fa3f8a-26c7-4bdb-bb12-870e70c34916'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "4489303",
      "childname": "DAVONIA BOOTH"
    },
    {
      "age": "13 Yrs",
      "clientid": "3116067",
      "childname": "DIOR BOOTH"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = 'a550de18-b8a8-4692-b2a9-600750dd555c'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "3334747",
      "childname": "JI''LEN KIJUAN SMITH"
    },
    {
      "age": "12 Yrs",
      "clientid": "3334746",
      "childname": "JAYLEN KIVAUGHN SMITH"
    },
    {
      "age": "8 Yrs",
      "clientid": "4237968",
      "childname": "ZURIONNA SMITH"
    },
    {
      "age": "5 Yrs",
      "clientid": "4265010",
      "childname": "ZI''AIRE SMITH"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '2c25ecde-5c8a-4df0-8a22-1b6c16af7ff6'
	and activeflag = 1 ;										
										
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "200917767",
      "childname": "Juel Unknown"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '9da8e1cd-fa5b-406f-80c0-dfead9e2420d'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "4238837",
      "childname": "NATHAN ONDOUA"
    },
    {
      "age": "6 Yrs",
      "clientid": "4238841",
      "childname": "DANIEL A ONDOUA"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = 'a82eb403-655f-4e1c-83fd-6cde05577be2'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200797681",
      "childname": "Jackson Murson"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '3618dfa8-e680-43df-8c68-863918827c23'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200921810",
      "childname": "Ja''Mouri Thompson"
    },
    {
      "age": "7 Yrs",
      "clientid": "200921812",
      "childname": "James Thompson"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '551a3cad-0b9d-4064-98f4-34f4b2fcc2fb'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "200923029",
      "childname": "Jefferson Lemus"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '6c8f95b1-db9f-47a0-83e1-0590c353302f'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200912623",
      "childname": "Kazimir Loyal"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = 'd022f40f-d85a-4ac2-958b-3dd25e014ce4'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "4188389",
      "childname": "JALEEL TATE"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = 'ff64a063-c944-463c-b8c8-c3eaba28d07a'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "3382602",
      "childname": "ROBERT J LITTLE"
    },
    {
      "age": "7 Yrs",
      "clientid": "3905804",
      "childname": "EMMA LITTLE"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '6d0cf7b8-def9-48c6-9405-af2c0280821f'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200935638",
      "childname": "Jose E Centeno"
    },
    {
      "age": "6 Yrs",
      "clientid": "200935633",
      "childname": "Gabriela Camila Umana"
    },
    {
      "age": "12 Yrs",
      "clientid": "200939684",
      "childname": "Deysi Paula Rivas Cruz"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '59d523fe-1e75-479e-8d16-ae69ac158073'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "200936758",
      "childname": "Landon McDonald"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '9b7941ac-507a-4a47-87ae-9138c15e4659'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200938275",
      "childname": "David Hernandez-Diaz"
    },
    {
      "age": "7 Yrs",
      "clientid": "200936903",
      "childname": "Dilma Hernandez"
    },
    {
      "age": "5 Yrs",
      "clientid": "200936906",
      "childname": "Melany Hernandez"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '0df2f7cb-f9fc-4df4-b490-fa886f4cbb1e'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Yrs",
      "clientid": "4008753",
      "childname": "FATIMA J MOORE"
    },
    {
      "age": "9 Yrs",
      "clientid": "4006340",
      "childname": "NISA MOORE"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = 'aed69be7-80e6-4353-8063-6d81f28a7426'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "200938937",
      "childname": "Imtiaz Almas"
    },
    {
      "age": "3 Yrs",
      "clientid": "200939541",
      "childname": "Sarai A Abodunrin"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '4e17fc12-2157-481e-8d3c-961abb2a5919'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "200942672",
      "childname": "Ameera Mansaray"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = 'e6b8469d-069f-4f39-b7f1-1f1206ab7d0d'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "4257633",
      "childname": "FALYNN O MAYFIELD"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = 'fc3bfb09-2616-4378-9718-28ef16207163'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "200307229",
      "childname": "Milan Ashe"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '4995d6b6-fe7e-4099-9848-3b8b998913b1'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "3033944",
      "childname": "CEYDEE GOGGINS"
    },
    {
      "age": "9 Yrs",
      "clientid": "200847815",
      "childname": "Calliope Goggins"
    },
    {
      "age": "5 Yrs",
      "clientid": "4490921",
      "childname": "COEN GOGGINS"
    },
    {
      "age": "8 Yrs",
      "clientid": "200857013",
      "childname": "Caius Goggins"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = 'cf303fb1-db4d-4551-9f9c-39305512f079'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "200912565",
      "childname": "Valyn Smith"
    }
    ]')
--	,updatedby = 'CIDM-5492-R2'
--	,updatedon = now()
where assessmentid = '9dac20b9-f182-4435-b4bc-8cc7808c2a0c'
	and activeflag = 1 ;
