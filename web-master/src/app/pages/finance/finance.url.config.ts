const getpicklistfilterurl = 'tb_picklist_values/getpicklist?filter';
const getpicklisturl = 'tb_picklist_values/getpicklist';
export class FinanceUrlConfig {
    public static EndPoint = {
        general: {
            dropdownURL: getpicklistfilterurl,
            userCounty: 'tb_provider/getFinanceCounty'
        },
        placement: {
            getPlacementInfo: `finance/getPlacementInfo`
            // `FinancePlacements/getPlacementInfo`
        },
        guardianship: {
            getGuardianshipInfo: `finance/getGuardianshipInfo`
            // `FinanceGuardianships/getGuardianshipInfo`
        },
        ssiSsaTracking: {
            listSsiSsaClientDetails: `tb_client_account/listSsiSsaClientDetails`,
            eligibilityEvents: `tb_client_account/listEligibilityEvents`,
            addEligibilityEvents: `tb_client_account/addEligibilityEvents`,
            paymentList: `tb_client_account/listSsaTracking`
        },
        accountsPayable: {
            getAccountsPayableInfo: `tb_payment_header/getAccountsPayableInfo`,
            getPaymentList: `tb_payment_header/getAccountsPayableHeader`,
            // 'Intakedastagings/getpaymentheaderdetails'
            listPayableApproval: 'purchaseAuthorizations/listPayableApprovels',
            listPayableApprovalHistory: 'purchaseAuthorizations/listPayableApprovelsHistory',
            listPaymentDetail: 'purchaseAuthorizations/getpapaymentdetails',
            ServiceLogApproval: 'purchaseAuthorizations/routingPurchaseAuthorization',
            PaymentPickList: getpicklisturl,
            AncillaryAdjustment: {
                reject: 'tb_payment_header/rejectbypaymentid/'
            },
            approval : {
                groupCategory: 'purchaseAuthorizations/listGroupbyCategoryCode',
                categoryApproval: 'purchaseAuthorizations/routingPurchaseAuthorizationbyCategoryCode',
                purchaseAuthorizationGet: 'purchaseAuthorizations/getPurchaseAuthorize',
                fiscalCodes: 'fiscalCodes/agencyservices',
                PurchaseAuthorizationReject: 'tb_account_transaction/rejectbyAuthId/'
            },
            history: {
                searchFundingAllocation: 'tb_client_account/listFundingSrcClientDetails', // 'tb_client_account/listSsiSsaClientDetails',
                listFundingAllocation: 'tb_client_account/listFundingAllocationMaster',
                fundingSourceHistory: 'tb_client_account/listFundingAllocatioHistory',
                updatePurchaseAuthorizationGet: 'purchaseAuthorizations/updatepurchaseauthorization'
            }

        },
        accountsReceivable: {
            search: {
                list: 'tb_receivable_detail/getproviderclientsearchDashboard',
                dashboardList: 'tb_receivable_detail/getproviderclientsearchDashboardWriteOff'
            },
            overpayments: {
                list: 'tb_receivable_detail/getProviderOverPaymentList?filter',
                update: 'tb_receivable_detail/updateProviderOverPaymentList'
            },
            manualOverPayment: {
                request: 'tb_receivable_detail/addManualReceivable',
                approve: 'tb_receivable_detail/approveManualReceivable',
                dashboardList: 'tb_receivable_detail/listManualReceivableDashboard'
            },
            history: {
                overpayments: {
                    list: 'tb_receivable_detail/getOverPaymentList?filter',
                    subList: 'tb_receivable_detail/getOverPaymentListDetails?filter'
                },
                receipt: {
                    list: 'tb_payment_receipt/list?filter',
                    addUpdate: 'tb_payment_receipt/addupdate',
                    deleteReceipt: 'tb_payment_receipt/deletePayment',
                    ReversalAdd: 'tb_payment_receipt/receiptreversal',
                    dashboardList: 'tb_payment_receipt/getreversalreceiptlist?filter',
                    ReversalApproval: 'tb_payment_receipt/approvereceiptreversal'
                }
            },
            paymentplan: {
                list: 'tb_payment_plan/getPaymentPlan?filter'
            },
            provider: {
                providerSearch: 'tb_receivable_detail/accreceivableprovidersearch',
                paymentHistory: 'tb_receivable_detail/getpaymenthistory'
            },
            audit: {
                auditList: 'tb_receivable_detail/getauditlog?filter',
                placement_validation: 'tb_receivable_detail/get_audit_log_placement_validation?filter',
                overpayments: 'tb_receivable_detail/get_audit_log_account_receivables?filter',
                adjustment: 'tb_receivable_detail/get_audit_log_system_adjustments?filter',
            }
        },
        adoption: {
            getAdoptionInfo: `finance/getAdoptionInfo`
        },
        childAccounts: {
            getchildaccountslistUrl: 'tb_client_account/getchildaccountsdetailslist',
            addChildAccountUrl: 'tb_client_account/addchildaccounts',
            getchilddetailslistUrl: 'tb_client_account/getchilddetailslist',
            pickListUrl: getpicklistfilterurl,
            updateAccountUrl: 'tb_client_account/updatechildaccounts',
            getCommingledAccountsUrl: 'tb_client_account/getCommingledAccountList',
            getCostofCarelistUrl: 'tb_services/costofcarelist',
            disbursementReject: 'tb_child_account_disbursement/rejectForDisbursement/',
            transactionSource: 'tb_account_transaction/getTransactionSource',
            transactionApproval: 'tb_client_account/clientErrorCorrectionDashboard'
        },
        commingledAccounts: {
            getcommingledAccountslistUrl: 'tb_client_account/getcommingledAccountsdetailslist',
            getchilddetailslistUrl: 'tb_client_account/getchilddetailslist',
            pickListUrl: getpicklistfilterurl,
            deleteAccountUrl: 'tb_client_account',

            addCommingledAccountUrl: 'tb_commingled_account/addCommingledAccounts',
            getCommingledAccountUrl: 'tb_commingled_account/getCommingledList',
            updateAccountUrl: 'tb_commingled_account/updateCommingledAccounts',
            deleteCommingledAccount: 'tb_commingled_account/deletecommingledaccount',
            interestTransactions: {
                commingledDropdownList: 'tb_commingled_account?filter',
                list: 'tb_comm_acct_transactions/listCommAccountTransaction?filter',
                add: 'tb_comm_acct_transactions/addCommAccountTransaction',
                update: 'tb_comm_acct_transactions/editCommAccountTransactionApprove/',
                approveUpdate: 'tb_comm_acct_transactions/editCommAccountTransaction/',
                delete: 'tb_comm_acct_transactions/deleteCommAccountTransaction/',
                rejectUpdate: 'tb_comm_acct_transactions/rejectErrorCrct/'
            },
            errorCorection: 'tb_comm_acct_transactions/errorCorrectionDashboard'

        },
        interestTransactions: {
            addTransactionUrl: 'tb_client_transaction/addtransactions',
            getdetailslistUrl: 'tb_client_transaction/getdetailslist',
            pickListUrl: getpicklistfilterurl,
            updateTransactionUrl: 'tb_client_transaction/updatetransactions',
            getTransactionsUrl: 'tb_account_transaction/getClientAccountTransactions',
            deleteTransaction: 'tb_commingled_account/deletetransaction',
            addNewTransactionUrl: 'tb_account_transaction/addClientTransaction',
            EditTransactionUrl: 'tb_account_transaction/updateClientTransaction/',
            adjustmentRequest: 'tb_account_transaction/clientTransactionErrorCorrection',
            adjustmentApproval: 'tb_account_transaction/clientTransactionErrorCorrectionApproval',
            adjustmentReject: 'tb_account_transaction/clientTransactionErrorCorrectionReject'
        },
        fosterCareRate: {
            listFosterCare: 'tb_foster_care_rate/list',
            fosterCareRateHist: 'tb_foster_care_rate/hist',
            addUpdateFosterCare: 'tb_foster_care_rate/addupdate',
            deleteFosterCare: 'tb_foster_care_rate/deletePayment',
            rateType: getpicklisturl,
            serviceType: 'tb_services/getplacementstructureslist',
            countyList: 'admin/county/countylist'
        },
        receiptFastEntry: {
            receiptPicklist: getpicklisturl,
            receiptEntryList: 'tb_payment_receipt/getReceiptFastPayment',
            receiptSave: 'tb_account_fast_entry/add',
            receiptPostUpdate: 'tb_account_fast_entry/updatePostEntry'
        },

        providerChecklist:{
            listProviderChecklistdetails :'tb_provider/getproviderchecklistsearch',

        }

    };
}
