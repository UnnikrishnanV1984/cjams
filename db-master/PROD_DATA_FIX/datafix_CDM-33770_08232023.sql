-- CDM-33770 - Commingled Account missing
/*
-- Issue Description: 
   Commingled account is NOT linked to Foster Care Youth Saving Accounts

-- Montgomery County (1442)
-- Commingled Account ID: 1000401 (Bank of America) - 446026601717

   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: User Error
-- Fix provided: Datafix has been promoted to Link Commingled account and reuested Foster Care Youth Saving Accounts.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Associate Commingled Account and FCYS Accounts (CDM-33770)

-- CLIENT ID: 3937689 (YADIEL MILKYAS ANDEBO) - 3b502b7e-29eb-4b59-967c-f30c7912e280
-- Foster Care Youth Saving	Account ID:  1017715 - F738193

-- CLIENT ID: 3682589 (DOMINIC NATHANIEL ARJUNE) - 8eff0f38-f93f-4707-846d-4e67d07717dd
-- Foster Care Youth Saving	Account ID: 1017712	- F433256

-- CLIENT ID: 2220711 (DEMAYA A	COOK) - d54a9be6-7717-4a23-bf2d-9037a7684c3a
-- Foster Care Youth Saving	Account ID: 1017717 - F576043

-- CLIENT ID: 3422426 (ALAYA MICHELLE MILLHOUSE) - 71c8e09d-5eb3-4828-a305-bd342a588df5
-- Foster Care Youth Saving	Account ID: 1017777	- F1075804

-- CLIENT ID: 4391542 (DENSTINY	P POOLE) - 9e287b36-3925-41d2-b992-4616700554a3
-- Foster Care Youth Saving	Account ID: 1017719 - F544776

-- CLIENT ID: 1984767 (LILLYANNA POOLE) - 4c954117-d444-49b5-9ea4-622566c9a06e
-- Foster Care Youth Saving	Account ID: 1017714 - F1078792

-- CLIENT ID: 4411585 (JESSIAH Tatianna RAMSEY) - ccf2ac99-6903-4723-adcd-fa6a5da5feb4
-- Foster Care Youth Saving	Account ID: 1017720 - F893069

-- CLIENT ID: 3696265 (RECO	L RIVERS) - 7fd1e522-b847-4a48-8946-3c6f1d2cea72
-- Foster Care Youth Saving	Account ID: 1017713 - F100578

-- CLIENT ID: 1504270 (MILAN SOSO) - 9fbf69a2-264e-4c94-b2ef-a691d95cd950
-- Foster Care Youth Saving	Account ID: 1017778 - F823943

-- CLIENT ID: 3732657 (MELAK SEYOUM	SPATES) - df339e41-fa8f-4c58-87ee-f8a1c038db75
-- Foster Care Youth Saving	Account ID: 1017721 - F579950

-- CLIENT ID: 4042105 (ANAIYA SARAI	WRIGHT) - f7d2410f-120f-4076-a569-681947c6ff47
-- Foster Care Youth Saving	Account ID: 1017718 - F737755

select account_type_cd, account_exists_sw, bank_nm, account_no_tx, comm_account_id, update_ts, update_user_id 
   from cjams.tb_client_account  
where client_account_id 
		in ( 1017715, 1017712, 1017717, 1017777, 1017719, 1017714, 1017720, 1017713, 1017778, 1017721, 1017718 ) 
  and delete_sw  = 'N' ;

update cjams.tb_client_account  
set comm_account_id = 1000401, -- Bank of America - 446026601717
	update_user_id = 'CDM-33770',
	update_ts = now()
where client_account_id 
		in ( 1017715, 1017712, 1017717, 1017777, 1017719, 1017714, 1017720, 1017713, 1017778, 1017721, 1017718 ) 
  and delete_sw  = 'N' ;

-- Update Commingled Account Balance
select comm_account_id, bank_nm, total_balance_no, update_ts, update_user_id 
    from cjams.tb_commingled_account  
where comm_account_id = 1000401
    and delete_sw = 'N' ;
                        
update cjams.tb_commingled_account
    set total_balance_no = ( select sum(coalesce(total_balance_no,0))
                                from cjams.tb_client_account
                             where comm_account_id = 1000401
                                and delete_sw = 'N' ),
        update_ts = now(),
        update_user_id = 'CDM-33770'
where comm_account_id = 1000401
    and delete_sw = 'N' ;