import { WriteoffApprovalComponent } from './writeoff-approval/writeoff-approval.component';
import { DashboardInputs } from '../../title4e/_entities/home-dash-entities';
import { AncillaryPaymentAdjustmentComponent } from './ancillary-payment-adjustment/ancillary-payment-adjustment.component';
import { PurchaseAuthorizationComponent } from './purchase-authorization/purchase-authorization.component';
import { SupervisorApprovalComponent } from './supervisor-approval/supervisor-approval.component';
import { CommingledTransactionApprovalComponent } from './commingled-transaction-approval/commingled-transaction-approval.component';
import { DirectorApprovalComponent } from './director-approval/director-approval.component';
import { ProgramManagerApprovalComponent } from './program-manager-approval/program-manager-approval.component';
import { ChildTransactionApprovalComponent } from './child-transaction-approval/child-transaction-approval.component';
import { ManualReceivableComponent } from './manual-receivable/manual-receivable.component';
import { ArReversalReceiptComponent } from './ar-reversal-receipt/ar-reversal-receipt.component';
import { FiscalUnitTicklersComponent } from './fiscal-unit-ticklers/fiscal-unit-ticklers.component';
import { CfeRetainerPaymentComponent } from './cfe-retainer-payment/cfe-retainer-payment.component';

const fiscalunitticklers = 'Fiscal Unit Ticklers';
const ancillarypaymentadjustment = 'Ancillary Payment Adjustment';
const manualreceivabledetails = 'Manual Receivable Details';
const reversalreceiptdetails = 'Reversal Receipt Details';
export class FinanceDashboardWidgetConfig {
    public static master = {
        FW: [
            {
                number: 22,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: FiscalUnitTicklersComponent,
                title: fiscalunitticklers,
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 1,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: WriteoffApprovalComponent,
                title: 'Write Off Details',
                input: new DashboardInputs(),
                show: true
            },
            /* {
                number: 2,
                cols: 12,
                rows: 1,
                y: 5,
                x: 0,
                component: ConservedAcBalanceAlertComponent,
                title: 'Conserved Balance Alert',
                input: new DashboardInputs(),
                show: true
            }, */
            {
                number: 14,
                cols: 12,
                rows: 1,
                y: 1,
                x: 0,
                component: CommingledTransactionApprovalComponent,
                title: 'Commingled Transaction Details',
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 15,
                cols: 12,
                rows: 1,
                y: 2,
                x: 0,
                component: AncillaryPaymentAdjustmentComponent,
                title: ancillarypaymentadjustment,
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 16,
                cols: 12,
                rows: 1,
                y: 3,
                x: 0,
                component: SupervisorApprovalComponent,
                title: 'Disbursement View',
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 17,
                cols: 12,
                rows: 1,
                y: 4,
                x: 0,
                component: PurchaseAuthorizationComponent,
                title: 'Purchase Authorization - Pending Approval',
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 9,
                cols: 12,
                rows: 1,
                y: 1,
                x: 0,
                component: CfeRetainerPaymentComponent,
                title: 'Provider Ancillary Payments',
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 18,
                cols: 12,
                rows: 1,
                y: 6,
                x: 0,
                component: ChildTransactionApprovalComponent,
                title: 'Child Account Transaction Error Correction',
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 19,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: ManualReceivableComponent,
                title: manualreceivabledetails,
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 21,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: ArReversalReceiptComponent,
                title: reversalreceiptdetails,
                input: new DashboardInputs(),
                show: true
            }
        ],
        FS: [
            {
                number: 22,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: FiscalUnitTicklersComponent,
                title: fiscalunitticklers,
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 6,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: PurchaseAuthorizationComponent,
                title: 'Purchase Authorization - Pending Approval',
                input: new DashboardInputs(),
                show: true
            }, {
                number: 19,
                cols: 12,
                rows: 1,
                y: 5,
                x: 0,
                component: ChildTransactionApprovalComponent,
                title: 'Child Account Transaction Error Correction',
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 9,
                cols: 12,
                rows: 1,
                y: 1,
                x: 0,
                component: AncillaryPaymentAdjustmentComponent,
                title: ancillarypaymentadjustment,
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 9,
                cols: 12,
                rows: 1,
                y: 1,
                x: 0,
                component: CfeRetainerPaymentComponent,
                title: 'Provider Ancillary Payments',
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 10,
                cols: 12,
                rows: 1,
                y: 2,
                x: 0,
                component: SupervisorApprovalComponent,
                title: 'Disbursement Approval',
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 8,
                cols: 6,
                rows: 1,
                y: 3,
                x: 0,
                component: CommingledTransactionApprovalComponent,
                title: 'Commingled Transaction Approval',
                input: new DashboardInputs(),
                show: true
            },
            /* {
                number: 11,
                cols: 6,
                rows: 1,
                y: 3,
                x: 6,
                component: ConservedAcBalanceAlertComponent,
                title: 'Conserved Balance Alert',
                input: new DashboardInputs(),
                show: true
            }, */
            {
                number: 12,
                cols: 12,
                rows: 1,
                y: 4,
                x: 0,
                component: WriteoffApprovalComponent,
                title: 'WriteOff Approval',
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 20,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: ManualReceivableComponent,
                title: manualreceivabledetails,
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 21,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: ArReversalReceiptComponent,
                title: reversalreceiptdetails,
                input: new DashboardInputs(),
                show: true
            }
        ],
        DF : [
            {
                number: 13,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: DirectorApprovalComponent,
                title: 'Purchase Authorization - Director Pending Approval',
                input: new DashboardInputs(),
                show: true
            }
        ],
        PM : [
            {
                number: 23,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: ProgramManagerApprovalComponent,
                title: 'Purchase Authorization - Program Manager Pending Approval',
                input: new DashboardInputs(),
                show: true
            }
        ],
        PMDF : [
            {
                number: 23,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: ProgramManagerApprovalComponent,
                title: 'Purchase Authorization - Program Manager Pending Approval',
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 13,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: DirectorApprovalComponent,
                title: 'Purchase Authorization - Director Pending Approval',
                input: new DashboardInputs(),
                show: true
            }
        ],
        CF : [
            {
                number: 22,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: FiscalUnitTicklersComponent,
                title: fiscalunitticklers,
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 9,
                cols: 12,
                rows: 1,
                y: 1,
                x: 0,
                component: AncillaryPaymentAdjustmentComponent,
                title: ancillarypaymentadjustment,
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 12,
                cols: 12,
                rows: 1,
                y: 4,
                x: 0,
                component: WriteoffApprovalComponent,
                title: 'WriteOff Approval',
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 20,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: ManualReceivableComponent,
                title: manualreceivabledetails,
                input: new DashboardInputs(),
                show: true
            },
            {
                number: 21,
                cols: 12,
                rows: 1,
                y: 0,
                x: 0,
                component: ArReversalReceiptComponent,
                title: reversalreceiptdetails,
                input: new DashboardInputs(),
                show: true
            }
        ]
    };
}
