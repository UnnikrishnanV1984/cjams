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
      "age": "4 Yrs",
      "clientid": "4145120",
      "childname": "MASON A DAVIS"
    },
    {
      "age": "14 Yrs",
      "clientid": "200938035",
      "childname": "Kaylee Smith"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '88b0e9cc-4549-453a-80fa-21e67e0a01bb'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "200935084",
      "childname": "Samard Van"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '4476e9e1-8ef8-47b5-80e5-fcdd6885a629'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Month(s)",
      "clientid": "200930592",
      "childname": "Azari Brown"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'afd93f3a-eca7-4666-b10b-e97dce573cb1'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200900460",
      "childname": "Esther Bisono"
    },
    {
      "age": "12 Yrs",
      "clientid": "3938763",
      "childname": "MOISES BENJAMIN BISONO"
    },
    {
      "age": "3 Month(s)",
      "clientid": "200928496",
      "childname": "Maicol Jose Urias De La Cruz"
    },
    {
      "age": "6 Yrs",
      "clientid": "200890307",
      "childname": "Eva Bisono"
    },
    {
      "age": "8 Yrs",
      "clientid": "3938762",
      "childname": "NAYELI L DIUZA BISONO"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'aca529c7-0c34-4dfd-bc39-9357e8b27677'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Day(s)",
      "clientid": "200935464",
      "childname": "Isabella Brown"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'df1ebf74-b257-4210-90dc-6a55ea240ac3'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "3580783",
      "childname": "AVA MARIE WATERS"
    },
    {
      "age": "8 Yrs",
      "clientid": "3580781",
      "childname": "LAYLA MONAE WATERS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '72c92fb6-64a2-47c8-8c75-735b35aaa0fc'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Yrs",
      "clientid": "3750619",
      "childname": "MALIK MATTHEWS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '6291ec51-4a7b-4b5e-8c06-3ea7ac86efc7'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Month(s)",
      "clientid": "200901273",
      "childname": "Jahlil Reaves"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '41e63ed8-fb3d-4c16-9e66-e4c68c62bfd3'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200911444",
      "childname": ""
    },
    {
      "age": "2 Month(s)",
      "clientid": "200911445",
      "childname": "Corine Lee"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '7b197ca9-e0d2-4ce9-94e4-afa60ce43ac6'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "4156795",
      "childname": "CARMELO ROBINSON"
    },
    {
      "age": "9 Yrs",
      "clientid": "4156796",
      "childname": "MARIAH MAKAYLA ROBINSON"
    },
    {
      "age": "7 Yrs",
      "clientid": "4156804",
      "childname": "MARQUIS ROBINSON"
    },
    {
      "age": "6 Yrs",
      "clientid": "4156813",
      "childname": "MADISON M ROBINSON"
    },
    {
      "age": "3 Yrs",
      "clientid": "4341331",
      "childname": "MYA J ROBINSON"
    },
    {
      "age": "2 Yrs",
      "clientid": "200899347",
      "childname": "Zion T Robinson"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '0ac71f14-5f62-4f92-b2ed-9f20d65476ba'
	and activeflag = 1 ;
	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "4358911",
      "childname": "JEFFREY EMLET"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '2b8a2810-3cde-4761-a17f-ada50c7bb3c0'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "3898721",
      "childname": "JULIANA FOSTER"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'c59e17f9-2313-4c63-8cd6-384af978879a'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "200667551",
      "childname": "Ashlyn Sill"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '0a8c42f1-3168-4dc3-a5da-e6e6699a6ac5'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Day(s)",
      "clientid": "200935666",
      "childname": "Dwayne Walker"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'd4175675-2ffb-444e-b574-9a2a2749c7c1'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Day(s)",
      "clientid": "200934157",
      "childname": "Coda Aki"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '2fc49737-b684-4e3c-a3a4-18c0635ae7ee'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Day(s)",
      "clientid": "200937703",
      "childname": "Sawyer Pumphrey"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '1a47a6c5-69ff-4b1d-8beb-da987a3c22f8'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200934857",
      "childname": "Erial Parker"
    },
    {
      "age": "3 Yrs",
      "clientid": "4272014",
      "childname": "DEMETRIUS PARKER"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '13c9ef46-c65d-4ccb-a356-d27bce91219f'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "3329101",
      "childname": "KELLSEEY JOLLIEE PRAMPIN"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '405e3ee8-f20d-4e26-bee0-551b27396171'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Day(s)",
      "clientid": "200936327",
      "childname": "Lamir Harris"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '4117941b-95d5-4c32-84f9-74b63eab2c32'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Day(s)",
      "clientid": "200936327",
      "childname": "Lamir Harris"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '86f0cf3d-a199-45cf-bfae-bcc1a3ca8e75'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "3356177",
      "childname": "ARIEANNA MAE WHEELER"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'e039cb93-0f1d-4157-bb47-331d40815da1'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Yrs",
      "clientid": "200934098",
      "childname": "SEBASTIAN OLIVERA"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'daffeb29-47d1-4d59-bb09-48ec10c9ee23'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "29 Day(s)",
      "clientid": "200928165",
      "childname": "Kobe Best"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'd653fe25-75ca-4312-8fd0-0fd3d15ce355'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "4358911",
      "childname": "JEFFREY EMLET"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '5bd7c017-473c-4c3f-8c34-47a4bfa1e216'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "200571494",
      "childname": "Bradley M Faulkner"
    },
    {
      "age": "8 Month(s)",
      "clientid": "200175318",
      "childname": "Natilynn Willin"
    },
    {
      "age": "4 Day(s)",
      "clientid": "200936649",
      "childname": "Brooklynn Willin"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '771cd4f8-778f-40ea-9f52-a525cdd2da93'
	and activeflag = 1 ;	
		
-- 10/19
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "3275565",
      "childname": "MAKAYLA R WASHINGTON"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '2fdfeb66-e6ae-4ca5-b65d-646b91bf7ddc'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "2248863",
      "childname": "LARISSA BELOTE"
    },
    {
      "age": "10 Yrs",
      "clientid": "200155929",
      "childname": "D''Aire Townsend"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '496213e0-f580-46ac-9bca-5b4375aeec2e'
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
where assessmentid = '70a96871-aead-46ce-ba15-9f415d31fedb'
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
where assessmentid = '6c7383b0-70a0-4ef9-92b3-a1a2d585aea2'
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
where assessmentid = '26cad39a-631d-45a2-8265-3bafcf59c2cf'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200023986",
      "childname": "Lakia Cousar"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'cca961e5-ebbc-41c3-b97f-bfde8bf174fd'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "200019275",
      "childname": "REBEKAH A CHRETIEN"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '2d12b2ff-03bc-443b-9e21-240ed238fc5e'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "200019275",
      "childname": "REBEKAH A CHRETIEN"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'a189a3ac-0495-4f1c-a5f1-389b49f29e61'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200023986",
      "childname": "Lakia Cousar"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '2bbbf7ec-4fa4-41fc-b436-ca309d185363'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "1866784",
      "childname": "CHLOE CATLIN"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'aacd69f4-4084-472b-93e3-062e8d52fb19'
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
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "4487377",
      "childname": "MADELINE N MENDEZ"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'd25f6214-a0a0-47b9-b2a2-cecf6be1d0fc'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "4487377",
      "childname": "MADELINE N MENDEZ"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '28ab7f15-1036-4f04-a38f-ad5b4e2041f7'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200664082",
      "childname": "Khloe Manley"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '4e73d506-6c7d-4676-b877-d50c9a0c078f'
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
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "4407673",
      "childname": "AMBER S MCDONALD"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '6c57afc2-2976-4473-930e-36fd46b11d29'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "3059984",
      "childname": "EMMA JOHNSON"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'd22e2232-8666-487b-a80e-300ee73a75aa'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "2750800",
      "childname": "KAMIAH JEFFERSON"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'd58e2bca-34a3-448f-bbaf-ae3133aabeef'
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

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200664082",
      "childname": "Khloe Manley"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '38e39139-c98b-4d6e-b5b1-5d08eb48b764'
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
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "200779012",
      "childname": "Connor Clawson"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'f04cbff0-46a9-40c6-8d03-b2ba532ab054'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "4301749",
      "childname": "PHAROAH DOVE-HARCUM"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '832fe98c-4722-4125-b02f-4a565bcc0c6c'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "4206290",
      "childname": "AMYYAH GARDNER"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '80b73eb1-16a8-4e63-b414-e892922d47b2'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "3267400",
      "childname": "ALIZABETH DAVIS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'f3741017-5529-4cc0-b20c-9ac9f3c4abff'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "200145113",
      "childname": "Donnelle Smith"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'fe43db1f-07dc-4346-99fd-30f8c7f39a74'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "200773911",
      "childname": "Trevon Darden"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '522cbf65-3170-4e83-ab99-b7cb7383e11d'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "4122145",
      "childname": "KINGSTON AMYIR JOHNSON"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'a5c1837a-0920-4910-95ac-0e9a584fb1f3'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "3276244",
      "childname": "JEREMY DAVIS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '631411a7-6c4b-4d8e-be8b-028314e36f26'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "3496824",
      "childname": "MARGARET ALLEN"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '976d77e5-d6f5-4b9b-9a7a-419f157ac96b'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "3690053",
      "childname": "ADRIAN PERDOMO"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '67c6f37a-bcd4-4dd2-b85a-fa4fd609fa49'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "3619715",
      "childname": "BRICEN MOHAMED KEITA"
    },
    {
      "age": "5 Yrs",
      "clientid": "4231058",
      "childname": "OUSMANE M KEITA"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '59547353-0367-45f9-97da-e619887271ca'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "4415999",
      "childname": "ROBERT MOULDEN"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'c0401e8c-d36c-4a11-90c7-bac2a9d6eeed'
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
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Month(s)",
      "clientid": "200791414",
      "childname": "Hector MAAS "
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
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "2486906",
      "childname": "KEYON JACKSON"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '4de3ac99-d513-4808-976e-67bf687dc156'
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
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Month(s)",
      "clientid": "200803667",
      "childname": "Caiden Brereton"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '3009312a-569e-422f-8665-6159d1fab7e3'
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
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "1708336",
      "childname": "DEJANAE S MOORE"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '46a950b1-b365-4212-a1c1-f8281ca5b64e'
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

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "4122145",
      "childname": "KINGSTON AMYIR JOHNSON"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'c6406154-7af6-441c-9ceb-d93d228d145d'
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
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "2248863",
      "childname": "LARISSA BELOTE"
    },
    {
      "age": "11 Yrs",
      "clientid": "200155929",
      "childname": "D''Aire Townsend"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'ce711dc7-0f80-43e0-a07f-edb5001bcdf6'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "1569958",
      "childname": "KIMMEL I WILSON"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '7300fc8c-d461-4a68-a465-34e013aa40a4'
	and activeflag = 1 ;	
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "3031045",
      "childname": "MAURICIO ALEXANDER EPPARD"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'ebd46664-0790-41bf-ae94-659ee18554ed'
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
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "4301749",
      "childname": "PHAROAH DOVE-HARCUM"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'b5815c6a-e791-4d8d-a398-96bac0aac247'
	and activeflag = 1 ;	
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Yrs",
      "clientid": "3840940",
      "childname": "DEJON ANDRE TAYLOR"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'ab79a809-e6a2-4826-9ebc-da85c11c7f31'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "3579977",
      "childname": "JEREMIAH THOMAS JESSOP"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '098651a4-d931-48f0-b2a6-f8dca6d29297'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "3458151",
      "childname": "JADEN AUSTIN"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '5d881d1d-fcbc-4efc-8064-8ec38ad19e91'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "4460286",
      "childname": "LUKE BRANDON THOMAS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'bdde9474-5265-4257-a723-aff0d6142ebf'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "4460286",
      "childname": "LUKE BRANDON THOMAS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'eb290921-7c52-4fe6-a285-31d892c78e7e'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "4460286",
      "childname": "LUKE BRANDON THOMAS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '0f8ae56b-2d47-4af0-8cb0-ebd1bc96f4ad'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "4460286",
      "childname": "LUKE BRANDON THOMAS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'e2d40777-91f1-4502-969d-cc540892f260'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200664082",
      "childname": "Khloe Manley"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '42d79a6b-f062-4a65-a87f-b26c04851511'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "200807391",
      "childname": "Seaun McDowney"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '0ffc6b32-6b5d-4163-90e1-f8c710084a9a'
	and activeflag = 1 ;	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200570452",
      "childname": "Ny''sir Herbin"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'f4adfb73-96c8-4203-a8e4-1fef1b9d53d6'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200570452",
      "childname": "Ny''sir Herbin"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'ab764169-5450-4cf8-89d5-650b2f3341e9'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "4227638",
      "childname": "SAMANTHA CAPEL"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'da8c756e-889d-4258-8702-535ac6c39b3e'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "200862542",
      "childname": "Sebastian Adorno Garcia"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'f4a38a2f-1d38-495f-bff8-110cfc44ea4c'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "3973234",
      "childname": "CHARLES E BAKER"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '6e5b5e4c-dfaa-4b30-909f-b29243a53a88'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "1801705",
      "childname": "MEKEL TATEERVIN"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '4a83d441-bf4b-464e-9ae6-a82ff926f824'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "1801705",
      "childname": "MEKEL TATEERVIN"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'ac19eb91-8805-4d8b-afa9-d5767925f020'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "3104378",
      "childname": "JAYDEN MICHAEL PEREGOY"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'db86908c-f5c3-4a70-a2a7-1e0d2f81e4c6'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Yrs",
      "clientid": "4329673",
      "childname": "LIAM M WORSLEY"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '6858f104-2471-48d3-b512-a7e3c3275c24'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "3973234",
      "childname": "CHARLES E BAKER"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'dcef1a5f-2aeb-4278-943a-782ca25de756'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "3458151",
      "childname": "JADEN AUSTIN"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '0b69c30a-d9e5-451b-968d-81c99c5464b4'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "200916726",
      "childname": "Monique Monteiro Perez"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'd758cdd1-0421-4c8d-9b3b-3c86211c98a5'
	and activeflag = 1 ;	
	
/*
--11/04	
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
*/	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "4328927",
      "childname": "DEJUAN I JACOBS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'ade6a015-63aa-43e9-b4d2-8b7dd07b2363'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200932747",
      "childname": "Liam Tselenchuk"
    },
    {
      "age": "3 Yrs",
      "clientid": "200932745",
      "childname": "Anne Fleur Zevenhuizen"
    },
    {
      "age": "2 Yrs",
      "clientid": "200932748",
      "childname": "Nathan Glandon"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'af9acbd2-d08c-4b90-b8a4-cb7a47fd0101'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "200926162",
      "childname": "Lena Taylor"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'acbd461a-c0e1-484c-8f86-7d1831f7f8c8'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Month(s)",
      "clientid": "200888486",
      "childname": "Carson Moberly"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '23b09d0d-a4f8-4729-9f15-6c6c9a80b098'
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
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "200857428",
      "childname": "Layla V Collins"
    },
    {
      "age": "12 Yrs",
      "clientid": "200857429",
      "childname": "London Madeline Collins"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'dd4c9202-4012-4c44-9858-2ba33569f8f3'
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
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Month(s)",
      "clientid": "200905096",
      "childname": "Forgiveness Mumford"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '14c1da90-cb6d-4fea-9267-bd21d22841cb'
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
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "3953338",
      "childname": "NATHANIEL MATTHEW LEAK"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '905e9e79-4641-4f12-88d1-345e80126bbc'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "200797113",
      "childname": "Joshua Vick"
    },
    {
      "age": "7 Yrs",
      "clientid": "200872727",
      "childname": "Kayden Howell"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '79576374-23c5-4245-aa44-192cf580903d'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200912708",
      "childname": "Zarriyah Welch"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '07a1736c-8060-490a-afea-7b1b28da53de'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "4382951",
      "childname": "LARRY A TAYLOR"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'f5db6e85-d8d6-444f-85b2-89af2d102f62'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "3168523",
      "childname": "MADISON COLLINS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'e0ee4ef7-32d7-43ea-a6e8-3409d400646b'
	and activeflag = 1 ;	
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "3449928",
      "childname": "MAYWAND POPAL"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '005b9865-ca18-40c7-b0fc-4c1adba4fe29'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200773491",
      "childname": "Lucius Peterson"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '55a9806f-b144-4f9b-83e0-957e1c7c33da'
	and activeflag = 1 ;	
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "2127638",
      "childname": "SPENCER THOMAS BEECHER"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '96963478-f17e-498d-a49f-6375b00a2c5d'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "200921257",
      "childname": "Johann Gunter"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '627297e8-0c12-4a66-9857-44102a5d8422'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200933042",
      "childname": "Zyair Leacock"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'b9bc54a2-3a32-4a4f-84c5-5d9528c46dff'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200850132",
      "childname": "Aliannah Mae Sexton"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '76dfe5ff-7a8e-45b0-a4ce-5441d7bd2a84'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "1050037",
      "childname": "JEFFREY THOMAS DARLING"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '1f74c501-3b4c-4b8b-bf8d-87b977397d5f'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200916126",
      "childname": "Marli Kalia Mccall"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '24dcc4fb-ed24-493f-b947-f47cd41c0a36'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "200930467",
      "childname": "Michael J Martin"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '741ec1cb-5560-4032-b318-bd01e3edb04d'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "4294520",
      "childname": "KENNEDY L TILGHMAN"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '142565ad-43fd-490f-9d46-35f3607dcd97'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200936044",
      "childname": "Tatiana Polk"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '51b9a8c6-ca60-47fc-bb8d-0b0bb8d7814c'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "200002939",
      "childname": "Michael Clemens"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '56ac01d9-a1db-450c-9999-751fc0ea047f'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "200002938",
      "childname": "Michelle Clemens"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'f6b02e51-261b-439c-85a9-523a69229407'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Yrs",
      "clientid": "200934372",
      "childname": "Rylen Powell"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '5fd86fba-302f-4d08-a004-c1e745b4a33d'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "4347120",
      "childname": "NEVAEH IRBY"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '9e55957d-ab2c-4a50-832b-8dc21feae697'
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
where assessmentid = '40771282-c7f1-49c1-85de-95efa774171a'
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
where assessmentid = '89bc0aa3-ab9c-4fc4-99d0-f7c0835025a5'
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
where assessmentid = 'a8310af5-0b33-45b1-b8e4-dec19fed32ec'
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
where assessmentid = 'e7c8b3d3-0105-476e-b304-af099881faab'
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
where assessmentid = 'af78e21f-2542-4d70-b77b-ea06a1049a5d'
	and activeflag = 1 ;
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200656828",
      "childname": "Rayleen Safari Marie Melvin"
    },
    {
      "age": "7 Yrs",
      "clientid": "200656824",
      "childname": "Ayden Melvin"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '59f695c8-df77-40b3-8fa1-227b2ab8c6ff'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200302466",
      "childname": "Rosanna Schissler"
    },
    {
      "age": "16 Day(s)",
      "clientid": "200856502",
      "childname": "Elena Butcher"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'f001d6c3-218f-40ad-b70f-f21fa48814c3'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200936282",
      "childname": "Stephanie Rose Marino"
    },
    {
      "age": "3 Yrs",
      "clientid": "200933054",
      "childname": "Ethan John Marino"
    },
    {
      "age": "11 Day(s)",
      "clientid": "200936281",
      "childname": "David Marino "
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '9faac1f2-41d1-44cd-83ee-23f8734cbe3a'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "3899819",
      "childname": "ARIANNA YANEZ MARTINEZ"
    },
    {
      "age": "11 Yrs",
      "clientid": "3747135",
      "childname": "CINDY MARTINEZ"
    },
    {
      "age": "12 Yrs",
      "clientid": "200938390",
      "childname": "Amen Estiphanos"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '3dfd509a-497f-4415-941c-a9dedc1368d2'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Yrs",
      "clientid": "4084696",
      "childname": "STELLA GREEN"
    },
    {
      "age": "2 Yrs",
      "clientid": "200153969",
      "childname": "MADDOX MICHAEL GREEN"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '17e2b8fc-716c-443c-8e3a-6ed906e08f1d'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Month(s)",
      "clientid": "200922941",
      "childname": "Gianna Prim"
    },
    {
      "age": "7 Yrs",
      "clientid": "200925231",
      "childname": "Jacob Leo Sullivan"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'c4e12935-6931-4742-aa9e-f9e5144f2f10'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "3471673",
      "childname": "RAFAEL AMAYA"
    },
    {
      "age": "11 Yrs",
      "clientid": "3471675",
      "childname": "HENRY R AMAYA"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '23346843-408f-4420-aa19-241ac98baca2'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Yrs",
      "clientid": "200928794",
      "childname": "Moises Hernandez Santos"
    },
    {
      "age": "13 Yrs",
      "clientid": "200909220",
      "childname": "Karla Rosales Santos"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '777a19c2-e616-42b0-82e1-8eb6a1e3562a'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "200916224",
      "childname": "Cristian A Hernandez Hernandez"
    },
    {
      "age": "6 Yrs",
      "clientid": "200916220",
      "childname": "Ashley Nicole Hernandez Hernandez"
    },
    {
      "age": "12 Yrs",
      "clientid": "200916216",
      "childname": "Lesly L Hernandez Quintero"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'e971967d-6c53-4a21-8158-7ad17739b2b4'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "200916224",
      "childname": "Cristian A Hernandez Hernandez"
    },
    {
      "age": "6 Yrs",
      "clientid": "200916220",
      "childname": "Ashley Nicole Hernandez Hernandez"
    },
    {
      "age": "12 Yrs",
      "clientid": "200916216",
      "childname": "Lesly L Hernandez Quintero"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '6bc03eb4-19cb-4dee-8130-b054d600e500'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200925490",
      "childname": "Lunaestrella Linares"
    },
    {
      "age": "2 Yrs",
      "clientid": "200925491",
      "childname": "Lesley Linares"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'c5820f05-728d-41f6-9dbe-2f150101dc81'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200937975",
      "childname": "Kamryn Hunter"
    },
    {
      "age": "3 Day(s)",
      "clientid": "200937973",
      "childname": "Kayden Hunter"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '2124906d-a9aa-4fde-a929-9a9fa90fa11e'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200782437",
      "childname": "Ka''Syn Pulley"
    },
    {
      "age": "10 Yrs",
      "clientid": "200782436",
      "childname": "Gianni Chambers"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '8dca643e-2800-4536-b6e8-200a2d9b48c5'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "4469101",
      "childname": "CHLOE GAMMEL"
    },
    {
      "age": "11 Yrs",
      "clientid": "4469100",
      "childname": "ZOE GAMMEL"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '0bc18c60-a8a8-4b89-9e1b-099348665382'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200179272",
      "childname": "Jahala R Boston"
    },
    {
      "age": "1 Yrs",
      "clientid": "200777156",
      "childname": "Jamori Sheppard"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '3f02ba52-b0a6-4873-849b-92727d2fa585'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Day(s)",
      "clientid": "200934705",
      "childname": "Garrett Ferguson"
    },
    {
      "age": "4 Yrs",
      "clientid": "200934707",
      "childname": "Blakely Ferguson"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'b76839a7-6159-47ab-ad80-fe64af43cc5d'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "4317809",
      "childname": "DEAN HALEY"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'f6abcd0d-59ed-418c-a2b4-a7d80e6a4e27'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "200865157",
      "childname": "Serenity Gibson"
    },
    {
      "age": "7 Yrs",
      "clientid": "200865158",
      "childname": "Davon Jamal Johnson"
    },
    {
      "age": "5 Yrs",
      "clientid": "200865159",
      "childname": "Mahilia I Johnson"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'df67632a-1b56-40f4-b478-e884fce0d4b2'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "200935974",
      "childname": "Mahari Bean"
    },
    {
      "age": "7 Yrs",
      "clientid": "200936886",
      "childname": "Michael Haynie"
    },
    {
      "age": "6 Month(s)",
      "clientid": "200936888",
      "childname": "Adore Bean"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'e9b4d844-8965-4a0e-bfe0-5676823f4423'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200140381",
      "childname": "Clyde O''conner "
    },
    {
      "age": "1 Month(s)",
      "clientid": "200916143",
      "childname": "Finnegan O''Conner"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '621a88bd-caf4-4bfd-8ab3-ddb179ea9126'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Month(s)",
      "clientid": "200936544",
      "childname": "Aleyna Sophia Machado"
    },
    {
      "age": "4 Yrs",
      "clientid": "200821368",
      "childname": "StephanieB Machado"
    },
    {
      "age": "5 Yrs",
      "clientid": "200821376",
      "childname": "Natalie Machado"
    },
    {
      "age": "4 Yrs",
      "clientid": "200804774",
      "childname": "Mia Alvarado"
    },
    {
      "age": "8 Yrs",
      "clientid": "4474345",
      "childname": "DOMINIC I ALVARADO"
    },
    {
      "age": "6 Yrs",
      "clientid": "4474346",
      "childname": "NICOLAS A ALVARADO"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '1c09fc2a-55e2-4ec2-8b08-92e458ff48d4'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "200935887",
      "childname": "Maria Sosa Urrutia"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '8a261ae7-7c48-4470-ba75-6befbbf9d2a2'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "4473500",
      "childname": "ERICK Montes Juica"
    },
    {
      "age": "3 Yrs",
      "clientid": "200909544",
      "childname": "Sophia D Garcia Juica"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '635d5a68-daec-436b-b116-f13dd67ab2d8'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Month(s)",
      "clientid": "200935074",
      "childname": "Lincoln Hall"
    },
    {
      "age": "2 Yrs",
      "clientid": "200937586",
      "childname": "Eliza Hall"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '72fe6a73-713c-4a1d-aed9-37a98c8d2619'
	and activeflag = 1 ;
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "200834818",
      "childname": "Gabriel Olivas"
    },
    {
      "age": "9 Yrs",
      "clientid": "200834830",
      "childname": "Leonardo C Castro Olivas"
    },
    {
      "age": "7 Yrs",
      "clientid": "200848861",
      "childname": "Eduardo F Castro Olivas"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '45d92f7b-83bc-40f3-bdee-beb589650412'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "200915326",
      "childname": "Genesis Tejada Ortiz"
    },
    {
      "age": "11 Yrs",
      "clientid": "200915324",
      "childname": "Suany Clavel Aguilar"
    },
    {
      "age": "3 Yrs",
      "clientid": "200938077",
      "childname": "Eider Joseph Ramos"
    },
    {
      "age": "7 Yrs",
      "clientid": "200915334",
      "childname": "Ashly Ortiz Aguilar"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '38e4d8ea-7a06-4a4f-a398-072798b6f94e'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "4384401",
      "childname": "XAIN GUDGER"
    },
    {
      "age": "11 Yrs",
      "clientid": "4384403",
      "childname": "IMARI GUDGER"
    },
    {
      "age": "2 Yrs",
      "clientid": "200898782",
      "childname": "Kingston June"
    },
    {
      "age": "8 Yrs",
      "clientid": "4384400",
      "childname": "REGAN GUDGER"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '3f29207e-4fa6-4f18-9ca2-c117e25dfabc'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200914352",
      "childname": "Santiago Sanchez"
    },
    {
      "age": "7 Yrs",
      "clientid": "200914359",
      "childname": "Matteo Sanchez"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '6f8f4fad-14bd-4ccc-b2c2-b23f080aa1b7'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "4441456",
      "childname": "ARIELLA NOLASCO"
    },
    {
      "age": "14 Yrs",
      "clientid": "4441455",
      "childname": "CALI NOLASCO"
    },
    {
      "age": "11 Yrs",
      "clientid": "4441457",
      "childname": "GIONNI NOLASCO"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'fb08a2f8-b3b2-4013-ac72-5a9cb7347756'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "3946704",
      "childname": "MARCOS RAFAEL ESCANOQUEZADA"
    },
    {
      "age": "17 Yrs",
      "clientid": "3946703",
      "childname": "CYNTHIA D PANIAGUA QUEZADA"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '9089f28e-ffa7-468b-8498-8f5b747a13f6'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "200914084",
      "childname": "Ifeoma Uche-Uzokwe"
    },
    {
      "age": "14 Yrs",
      "clientid": "200914074",
      "childname": "Oge Uche-Uzokwe"
    },
    {
      "age": "16 Yrs",
      "clientid": "200914078",
      "childname": "Mitchelle Uche-Uzokwe"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'f9467ac5-fac3-4374-9b84-c3477e7ff358'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "200020069",
      "childname": "JOSIAH M DOWERY"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '718c6f35-e7c8-4b41-9de8-a2cd1ab0fba7'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200935198",
      "childname": "James R Pumphrey"
    },
    {
      "age": "9 Yrs",
      "clientid": "200935199",
      "childname": "Juliana Snavely"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '7095c0b7-0e6c-4083-98e1-47d1534436a1'
	and activeflag = 1 ;
	

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200934805",
      "childname": "Carter T Mccready"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'efcaf1a0-a5dc-4102-9f56-6c281e0df25c'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "3712178",
      "childname": "KILEIAN G COLLINS"
    },
    {
      "age": "10 Yrs",
      "clientid": "3712159",
      "childname": "CASH REUBEN COLLINS"
    },
    {
      "age": "6 Yrs",
      "clientid": "3982123",
      "childname": "KINGSTYN TIDUS-LEE COLLINS"
    },
    {
      "age": "4 Yrs",
      "clientid": "4195382",
      "childname": "CYLUS K YOUNKIN"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'da7669ea-f302-4866-9ff9-ca54470319f9'
	and activeflag = 1 ;
	
/*
--11/04	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "200019959",
      "childname": "BRAVE MADDEN"
    },
    {
      "age": "10 Yrs",
      "clientid": "200019964",
      "childname": "BRIA M MADDEN"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'eacb89e5-2679-4dce-822d-7dadb8588ac9'
	and activeflag = 1 ;
*/
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "200936478",
      "childname": "Cristina Valeria Orozco"
    },
    {
      "age": "7 Yrs",
      "clientid": "200936481",
      "childname": "Kevin Justin Martinez"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'c0f61517-6409-494d-bd86-cf1483379550'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "3333337",
      "childname": "WILLIAM LYON"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'a26f8d9f-e514-468a-94b5-5e90293e71dc'
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

/*											
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "4314010",
      "childname": ""
    },
    {
      "age": "4 Yrs",
      "clientid": "4314010",
      "childname": ""
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = ''
	and activeflag = 1 ;
*/
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "4365365",
      "childname": "KAYLANI WEBSTER"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '4600b71c-9ced-4046-9e00-b622a4db4c44'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "4374610",
      "childname": "MICHAEL MALIK D HEIGHT"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '6dc0ee67-1038-4e8f-8b42-4daac08b16ad'
	and activeflag = 1 ;	
										
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "3416455",
      "childname": "A''MERE SHATIA YEARWOOD-GIBBONS"
    },
    {
      "age": "1 Yrs",
      "clientid": "200881488",
      "childname": "A''moura Bishop"
    },
    {
      "age": "6 Month(s)",
      "clientid": "200881489",
      "childname": "Journee Bishop"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'c54a45d0-5537-448e-80d7-3fcdf5a509dc'
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
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "3348954",
      "childname": "CORNELL PARKS"
    },
    {
      "age": "10 Yrs",
      "clientid": "3255183",
      "childname": "CAMILLE PARKS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '05db9a45-a305-470a-b804-6cf6a593cc7d'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "200778338",
      "childname": "Zahkiyha Vines"
    },
    {
      "age": "14 Yrs",
      "clientid": "200778336",
      "childname": "Keontey Vines"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'e661d954-f600-40c1-8ce7-45a41108588d'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200824841",
      "childname": "Olufemi Christiana Ajayi"
    },
    {
      "age": "5 Yrs",
      "clientid": "200824840",
      "childname": "Ayotunde Ajayi"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '3c9f527e-b5f2-4468-818b-966325a89fe5'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Yrs",
      "clientid": "4341844",
      "childname": "ALISSANDRIA Marye MAY"
    },
    {
      "age": "6 Yrs",
      "clientid": "4341846",
      "childname": "ASHTON Drake-Atticus MAY"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '1de2d458-1094-4471-ae43-61df313aaba1'
	and activeflag = 1 ;
		
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "200906423",
      "childname": "Gwendolyn McKinney-Smith"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'a2a9ed2b-3a72-4d54-8b59-50fb75922cbe'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "200906423",
      "childname": "Gwendolyn McKinney-Smith"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '4ab6feec-95ba-4723-9fb7-46b236b4afc4'
	and activeflag = 1 ;	
						
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "200919197",
      "childname": "Jamon Butler"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '0d4f7a07-ab23-4557-86ac-4eaff3cde957'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "200919197",
      "childname": "Jamon Butler"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'd879eb6a-484d-41e8-a454-a5ca1e2e2190'
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
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "1744024",
      "childname": "KAYLEIGH SHAY HALL"
    },
    {
      "age": "12 Yrs",
      "clientid": "3313570",
      "childname": "BENJAMIN ELIJAH BARLOW-MILLER"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '3ffffbb0-e6cd-4744-98b2-6d4e0fcf0690'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200922098",
      "childname": "Liam Hamilton"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '01d27600-aab0-49c1-97e1-7e935cffbeae'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200902259",
      "childname": "Kalaiyah G Spencer"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'dc55b527-48eb-4d9e-a293-aeb6e0283388'
	and activeflag = 1 ;	

/*
--11/04											
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "200899030",
      "childname": "Luis Guzman"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '46e18cd0-7003-43d8-aa5a-c1acd110c827'
	and activeflag = 1 ;	
*/	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{all_childs_json}','[{
		"age": "6 Yrs",
		"name": "Giovannah Fuentes",
		"cjamspid": "200899025"
	}]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '46e18cd0-7003-43d8-aa5a-c1acd110c827'
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
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "3420978",
      "childname": "RICKY JOHNSON"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'e6e8b40b-79a0-431f-9ece-dc1147ffcf00'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "3420978",
      "childname": "RICKY JOHNSON"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'd3fbf9c3-3ee7-4ce5-87c0-cf49d2fa4749'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "3579977",
      "childname": "JEREMIAH THOMAS JESSOP"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '76d06f69-cd52-4537-8674-b9e648697b35'
	and activeflag = 1 ;	
											
/*
-- 10/04											
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
where assessmentid = '009f6cb9-fba5-418c-bbca-54b76f57e891'
	and activeflag = 1 ;
*/
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "1070296",
      "childname": "YKEEM T MOSS"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '61fcbb38-e7b5-4809-a6dd-2b2938085e2a'
	and activeflag = 1 ;	
	
-- 211030008265 - SAFE-C July 7, 2021
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
where assessmentid = '631411a7-6c4b-4d8e-be8b-028314e36f26'
	and activeflag = 1 ;
	
-- 211030008265 - SAFE-C July 27, 2021 
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
where assessmentid = 'f3741017-5529-4cc0-b20c-9ac9f3c4abff'
	and activeflag = 1 ;
	
-- 211030008265 - SAFE-C March 29, 2022
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
where assessmentid = '2b89030a-36ea-42c3-836b-601bc9e4a66e'
	and activeflag = 1 ;
	
-- 211030008265 - SAFE-C May 20, 2022
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
where assessmentid = '809ef988-dd77-4795-95cd-a0d8a0aaeaed'
	and activeflag = 1 ;
	

-- 3253865
-- SAFE-C: 05/11/2022 08:19 AM
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "3046465",
      "childname": "SERENITY DAWSON"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '0181bea5-19aa-478d-b8a1-ca3c5d8f100d'
	and activeflag = 1 ;	
	
	
-- 221030015084
-- SAFE-C: 05/13/2022 11:50 AM
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "200889252",
      "childname": "Carleigh Nicole Stocks"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '3e9f546c-d9e5-48f0-b5bc-0547428b5807'
	and activeflag = 1 ;	
	
	
-- 221030015756 - SAFE-C: 05/11/2022 12:50 PM
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200902259",
      "childname": "Kalaiyah G Spencer"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'dc55b527-48eb-4d9e-a293-aeb6e0283388'
	and activeflag = 1 ;	
											
-- 221030015756 - SAFE-C: 05/11/2022 12:50 PM
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Month(s)",
      "clientid": "200902259",
      "childname": "Kalaiyah G Spencer"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '10c19742-9958-4798-ae2b-42e451a67921'
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
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "4304638",
      "childname": "Island E Williams"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'b2d9daa4-6332-406b-9877-94cfb9f3469f'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "4034480",
      "childname": "AYMIRAH DERNITA JOHNSON"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'd5cc6dc5-88ec-4439-8da2-e0cc65d54931'
	and activeflag = 1 ;	
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "8 Yrs",
      "clientid": "200895842",
      "childname": "Kamran Proctor"
    },
    {
      "age": "6 Yrs",
      "clientid": "4027779",
      "childname": "NOAH CHASE"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'f6c86a1c-259a-4a3e-9246-f71e80b85e5f'
	and activeflag = 1 ;	
											
	
-- 221030014993 - SAFE-C March 31, 2022
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "200019492",
      "childname": "HENRY J PARKER"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '85a69d15-2585-4122-8cd4-1e2b2e0d4864'
	and activeflag = 1 ;	
							
-- SAFE-C: 04/08/2022 02:05 AM
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
where assessmentid = 'ece8ab17-f355-410a-a571-ef5077b55870'
	and activeflag = 1 ;	
	

-- SAFE-C: 01/25/2022 03:03 PM
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
where assessmentid = '6317409b-2a69-4371-91e0-13426fcbc1a2'
	and activeflag = 1 ;	
	
-- SAFE-C: 02/04/2022 03:10 PM
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
where assessmentid = 'd006fe21-f8d0-472c-84c2-433cf6e7b807'
	and activeflag = 1 ;	
	
																				
-- SAFE-C: 03/31/2022 02:56 PM
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "1725263",
      "childname": "KA''RON J DOUGHTY"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '59572c08-48d6-4d73-a9de-9483882f4d07'
	and activeflag = 1 ;	
	

-- SAFE-C: 01/10/2022 02:36 PM
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "1725263",
      "childname": "KA''RON J DOUGHTY"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'c26b2af6-c1ee-4f72-9f32-6bc51cf7926e'
	and activeflag = 1 ;	
	
-- SAFE-C: 04/05/2022 10:37 AM
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
	
	
-- 211030011739 - SAFE-C April 6, 2022
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "3274111",
      "childname": "DANIELLE JAYLEN CARTER"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = 'd30721ab-66ae-4afb-8a2f-83b9fec2d590'
	and activeflag = 1 ;	
	
	
-- SAFE-C March 18, 2022
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "200813414",
      "childname": "Demetrius James Carter"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '0ffc560c-5056-4ad8-9059-5dda13b0d771'
	and activeflag = 1 ;	
	
	
-- SAFE-C October 25, 2021 
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "3274113",
      "childname": "DARIUS JAYDEN CARTER"
    }
    ]')
--	,updatedby = 'CIDM-5785-R2'
--	,updatedon = now()
where assessmentid = '862af639-803c-470d-8be9-72501d8c6b01'
	and activeflag = 1 ;	
	
-- 420b7cd9-b175-419a-984d-7ded128813f6	Not Required

-- 1f4b5a64-7fe5-4095-8247-761594787602	 ???

