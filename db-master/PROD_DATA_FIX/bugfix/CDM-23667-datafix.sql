/*
   Issue Description: CDM-23667
   Category/ Module  : Contact notes
   Root cause: Contact Notes duplicated during PDF print
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update 	progressnotedetail 
set 	activeflag = 0,
		updatedby = 'CDM-23667',
		updatedon = now()
where 	progressnotedetailid in ('01852249-9d1f-462c-ac1f-086d397f32c2',

        'd4deefb8-e548-444c-ac15-252228742174',
        'fe852951-340e-4b1e-bc33-84c919e08739',
        '44f67cda-d464-4571-a780-c78eed923705',
        '57e566a5-5177-4818-8bc3-9f89d0f22bc2',
        'd0340074-1990-48e8-acfb-ab6356a81321',
        'd2cd1ab1-ba23-4455-ab4c-7d8f7a5dcc58',
        '1b8e028a-1455-4346-8a45-a3a1e021f273',
        '68610ddc-10b6-4cc5-bdfe-01dc350d38be',

        'abc0baba-c26e-40ee-a4bf-dd84cc00b5e7',
        '1c3f8290-7bd4-4e39-ad50-927f1be7d13e',
        'b0bb3a59-aa01-426d-a62a-6699954fe6cd',
        '3fadad9b-a8b6-4842-a23b-7790c96f6136',

        'b404eee2-9804-44e2-b628-abbaa1dbd020',
        '25cd4743-befd-4f7d-9431-0e26e8da91f5',
        'b88d71cf-a7d0-4df4-9b44-a8bbc7613897',
        
        'cf24e90d-af75-49e9-aba1-05ba29787399',
        '373b8b25-a797-4a3c-8f3c-8387813bc413',
        '2d6ec903-6a15-481f-907d-7a997f2cf3f7',

        'a0ffa939-cde7-4aa7-ac15-a38f0772ca03',

        '868864b3-a874-4be4-90d5-c29ff296845c',
        'fe19bb0a-aacd-47cb-9578-6da15aba307a',

        '1b5ba99b-e305-4ad4-9759-e506047467d8',
        '2272d9ac-1a02-429e-a79a-132ea8b32e7d',
        '19f33021-e467-4f00-8b6d-f1d7f5153acd',
        'b1de78f8-7a68-4711-8fa7-9249d7b960cf',
        '3d553baf-af5d-4ec3-8449-f4618511e829',
        '68816d26-554e-425d-9734-3616471f5d79',
        'b552dc1d-5f85-4fad-b8e0-aac6d8b4b9c6',
        '08625180-607b-45d3-91fc-a15a468a1373',
        '9ff9ba14-ed18-408b-ba94-80b63151192e',
        '0801ffc4-9f64-4e89-a08c-915e5019c050',
        'dea96f74-f054-4ebf-b080-777bb24db7ee',
        'd3a0d46c-0892-49d0-97ad-4c92fe16cdad',
        'c80a5616-2687-4155-b987-9b00df5964b7',
        '7ece38e5-60ad-466b-8f47-3bbfadcf5ce6',
        'a8505e42-dc9d-4b47-ad7a-86e32e8a4410',
        '8ef99f49-297c-4215-bf59-4de6e37434e1',
        '4ea62b28-9f7b-4438-b938-6c31c4d304e1',
        'f73ee8ef-c915-4fe7-9d71-e3b07dea0f33',
        'e725c61f-f111-455b-9f05-3636c668d73d',
        '73bd26ee-c9a1-4ad9-b83a-f47daa30073f',
        'c991f6a2-98a5-4395-a5ea-c2e806113652',
        'b2ec660c-a040-42a0-9728-60904617cb1d',
        '2629d049-9b81-488e-b4ec-e4e24be914a7',
        'c296bdc5-fbd4-409d-86be-840072bbd4fb',
        '099f5d6b-c26b-4615-ad14-09b4b0770274',
        'e631a115-e6f3-4b45-a5f1-88314b6293b2',
        '89562ca5-7811-4338-93f8-e7b39781bfd3');