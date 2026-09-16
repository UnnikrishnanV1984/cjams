update caseassignment c set activeflag = 0, updatedby = 'CDM-11109', updatedon = now() where objectid in (
'cbd9c993-c2ba-4fe7-90b2-c59e4972191c',
'5eccf4fe-c5f1-42b7-8539-82bef71587a3',
'4c97d703-9dd1-4688-9b61-c2a7f60bed70',
'6b4dcf17-94da-4bea-bc1a-58d94bdc2057',
'a5d712e7-c9d9-408f-bfd1-bfb038ee2cfd',
'b0d7a67c-de10-4f4b-b363-44085ba017dc',
'1f43813a-b256-4561-ae73-3c9da75b74fe',
'c55c9b5e-ae8f-4ac5-a44d-7c341cc03271',
'ca607440-1a62-4351-b224-a62fa1b818b5',
'460deed7-2669-4bb7-bb52-04ca48d2eff1',
'06c8d424-c10b-4b2b-9f94-0f21def8a262',
'79d352e3-ad25-4720-b22c-227fa2a8db5c',
'9d273ef5-b7f1-4e86-a0c6-2e781b0beeca',
'7743958d-0c2b-4e4e-8f0e-a2e46e95e757'
) and activeflag = 1