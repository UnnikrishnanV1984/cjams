import {Component, OnInit, ViewChild} from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { FormBuilder, FormGroup} from '@angular/forms';
import { CommonHttpService, AlertService, AuthService, DataStoreService } from '../../../../@core/services';
import { AppConstants } from '../../../../@core/common/constants';
import  _  from 'lodash';
import { Titile4eUrlConfig } from '../../_entities/title4e-dashboard-url-config';
import { Title4eService } from '../../services/title4e.service';
import { environment } from '../../../../../environments/environment';
import {RecordingNotes} from '../narratives/iveNarrativeModel';
import { SignatureFieldComponent } from '../../../../shared/modules/common-controls/signature-field/signature-field.component';

declare var $: any;
declare const Formio: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'eligible-details',
    templateUrl: './eligible-details.component.html',
    styleUrls: ['./eligible-details.component.scss'],
    standalone: false
})
export class EligibleDetailsComponent implements OnInit {

    // @Input() eligibilityPerioodData: any[];
    progressNote: RecordingNotes = new RecordingNotes();
    @ViewChild(SignatureFieldComponent) public signaturePad!: SignatureFieldComponent;
    isCLW: any;
    isSupervisor = false;
    isSpecialist = false;
    eligibilityPeriodAccordion: any[]=[];
    eligibilityPeriodData: any[] = [];
    eligibilityPeriodstatuscheck: any;
    latestInitialDet: any;
    eventTableData: any[] = [];
    detStatusDetails: any[] = [];
    isShowEventTable = false;
    messages: any;
    fieldMessages: any;
    fieldName!: string;
    clientId!: number;
    removalId!: number;
    fostercareEvents: any;
    periodInfo: any;
    narrativeInfodisplay: boolean = false;
    approvesignaturebutton: boolean = false;
    narrativeMessage: any;
    userInfo: any;
    multiroleuserid: any;
    approvalusername: any;
    submitForApprovalRemark = '';
    approvalid : any;
    reviewPeriodInfo: any;
    getUsersList: any[]=[];
    selectedPerson: any;
    showSnapshot: boolean = false;
    worksheetType!: string;
    eligibilitysummaryinfo: any;
    previouseligibilitydetails: any;
    previousnarrativeornot: boolean = false;
    deemedclientid: any;
    period: any;
    eligibilityPeriodId: any;
    ivesignperiod: any;
    ivesigneligibilityId: any;
    approvedEligibilityId: any;
    IVEReferralProdCheck: any;
    editnarrative: boolean = false;
    sendforApprovalForNarrative: boolean = false;
    sendforApprovalForSignature: boolean = false;
    progressNoteId: any;
    displayprogressnote: any;
    signatureForm!: FormGroup;
    rolename!: string;
    userroledesc: any;
    isreadonly: any;
    selectedPeriodInfo: any = null;
    today = new Date();
    maxDate = new Date(this.today.getFullYear(), this.today.getMonth(), this.today.getDate());
    narrativesavepopupid = '#narrativesave';
    signaturepopupid = '#signature';
    addsignaturemsg = 'Please add Signature to proceed.';
    constructor(
        private _commonHttpService: CommonHttpService,
        private _alertService: AlertService,
        private _dataStoreService: DataStoreService,
        public _authService: AuthService,
        private _formBuilder: FormBuilder,
        private titleIVeService: Title4eService,
        private route: ActivatedRoute,
    ) {
    }

    ngOnInit() {
        // Get client id from route params
        this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.IVE_SUPERVISOR) || this._authService.selectedRoleIs('IV-E Eligibility Quality Assurance') || this._authService.selectedRoleIs('IV-E Eligibility Administrator');
        this.isSpecialist = this._authService.selectedRoleIs(AppConstants.ROLES.IVE_SPECIALIST) || this._authService.selectedRoleIs('IV-E Eligibility Analyst');
        this.userInfo = this._authService.getCurrentUser();
        if (this.userInfo.role && this.userInfo.role.key) {
            this.rolename = this.userInfo.role.key
        } else if (this.userInfo.user && this.userInfo.user.userprofile.teammemberassignment && this.userInfo.user.userprofile.teammemberassignment.teammember && this.userInfo.user.userprofile.teammemberassignment.teammember.teammemberroletype) {
           this.rolename =  this.userInfo.user.userprofile.teammemberassignment.teammember.teammemberroletype.roletypekey;
        }
        if (this.userInfo.role && this.userInfo.role.name) {
         this.userroledesc = this.userInfo.role.name;
       }
        this.clientId = this.route.snapshot.params['clientId'];
        // Get removal id from route params
        this.removalId = this.route.snapshot.params['removalId'];
        this._dataStoreService.currentStore.subscribe((item) => {
            if (item['isivereadonly']) {
              this.isreadonly = item['isivereadonly'];
            }
          });
        this.IVEReferralProdCheck = environment.IVEReferralCSMSCall;
        this.getEligibilityHistory();
        this.isTabSwitched();
        this.buildSignatureformGroup();
        if (this.userInfo && this.userInfo.user) {
            this.multiroleuserid = this.userInfo.user.securityusersid;
            this.approvalusername = this.userInfo.user.userprofile.firstname + ' ' + this.userInfo.user.userprofile.lastname;
        }
    }

    isTabSwitched(){
        $('.intake-tabs a').on('shown.bs.tab', (event :any) => {
            var x = $(event.target).text();
            if(x.includes("DETAILS")){
                this.getEligibilityHistory();
            }
        });
    }

    buildSignatureformGroup() {
        this.signatureForm = this._formBuilder.group({
            specalistSignature: null,
            supervisorSignature: null,
            specalistName: null,
            specalistsignedDate: null,
            supervisorName: null,
            supervisorSignedDate: null
        });
    }

    onPeriodStartDate(period:any) {
        this.isShowEventTable = period[0].v_sqnm_sw.split('').includes('E');
        if (!this.isShowEventTable) {
            this.detStatusDetails = period;
        }
        period = _.orderBy(period, 'v_start_dt');
        this.eventTableData = _.orderBy(period, 'v_eventreason');

    }

    toggleChildren(period: any): void {
        const filterChildrenData: any = {
            period,
            isParent: false
        }

        const filterParentData: any = {
            period,
            isParent: true
        }

        _.filter(this.eligibilityPeriodData, filterChildrenData).forEach((_period : any)=>{
            _period.isVisible = !_period.isVisible;
        });

        _.filter(this.eligibilityPeriodData, filterParentData).forEach((_period : any)=>{
            _period.isCollapsed = !_period.isCollapsed;
        });
    }


    getEligibilityHistory() {
        this.periodInfo = {};
        this.narrativeInfodisplay = false;
        if (this.clientId && this.removalId) {
            this._commonHttpService.getAll(`${Titile4eUrlConfig.EndPoint.eligibilityHistory}/${this.clientId}/${this.removalId}`).subscribe(
                (responsearray: any) => {
                    this.eligibilitysummaryinfo = responsearray.summaryInfo;
                    const response = responsearray.history;
                    this.previouseligibilitydetails = responsearray.history;
                    this.eligibilityPeriodData = [];
                    this.latestInitialDet = _.get(response, "I.0");
                    this.getEligibilityHistoryResponse(response);
                },
                (error) => {
                    this._alertService.error('Unable to get Audit Messages, please try again.');
                    return false;
                }
            );
        }
    }

    private getEligibilityHistoryResponse(response: any) {
        let previousDet = "";
        for (const key in response) {
            if (key && _.isArray(response[key])) {
                response[key].forEach((element:any) => {
                    element.isParent = true;
                    element.isVisible = true;
                    element.isCollapsed = true;
                    if (element.period === previousDet) {
                        element.isParent = false;
                        element.isVisible = false;
                        element.isCollapsed = false;
                    }
                    // D-24177 Period Reason Change
                    if (element.period_fostercareevents) {
                        this.updateReasonCd(element);
                    }
                    this.eligibilityPeriodData.push(element);
                    previousDet = element.period;
                });
            }
        }
    }

    private updateReasonCd(element: any) {
        element.period_fostercareevents.forEach((reason:any)=> {
            if (reason.reason_cd === 'CT') {
                reason.reason_cd = 'Court';
            } else if (reason.reason_cd === 'PC') {
                reason.reason_cd = 'Change in placement';
            } else if (reason.reason_cd === 'CC') {
                reason.reason_cd = 'Change in custody';
            } else if (reason.reason_cd === 'RE') {
                reason.reason_cd = 'Reasonable Efforts';
            } else if (reason.reason_cd === 'DE') {
                reason.reason_cd = 'Demographic';
            } else if (reason.reason_cd === 'RB') {
                reason.reason_cd = 'Remove Barrier Details';
            } else if (reason.reason_cd === 'ED') {
                reason.reason_cd = 'Education Details';
            } else if (reason.reason_cd === 'EM') {
                reason.reason_cd = 'Employment Details';
            } else if (reason.reason_cd === 'CD') {
                reason.reason_cd = 'Child Disability Details';
            } else if (reason.reason_cd === 'None') {
                reason.reason_cd = 'No 18-21 criteria met';
            } else if (reason.reason_cd === 'DM') {
                reason.reason_cd = 'SSI/SSA';
            }
        });
    }

    ApproveReject(status:any, approvalid:any) {

        let approvalRejectComments = '';
        let approvalRejectStatus = '';
        if (status === 'APPROVED') {
            this.approvalid = approvalid;
            approvalRejectComments = '';
            approvalRejectStatus = 'SpvApproved';
        } else if (status === 'REJECTED') {
            approvalRejectComments = 'Rejected for : ' + this.submitForApprovalRemark;
            approvalRejectStatus = 'SpvRejected';
        }
        $('#comments').modal('hide');
        if (status === 'APPROVED' && !(this.signatureForm?.value?.supervisorSignature)) {
            this._alertService.error(this.addsignaturemsg);
        } else if (status === 'APPROVED' && !(this.signatureForm?.value?.supervisorSignedDate)) {
            this._alertService.error('Please add Date to proceed.');
        } else {
            this.approverRejectElseCondition(status, approvalRejectStatus, approvalRejectComments);
        }

    }

    private approverRejectElseCondition(status: any, approvalRejectStatus: string, approvalRejectComments: string) {
        if (status === 'APPROVED') {
            return this.addUpdateSignature(status, approvalRejectStatus, approvalRejectComments);
        }
        $(this.signaturepopupid).modal('hide');
        this._commonHttpService.create(
            {
                'where': {
                    'approval_id': this.approvalid,
                    'approval_status': status,
                    'placement_type': 'Fostercare',
                    'approveduser': this.approvalusername ? this.approvalusername : null
                },
                'page': 1,
                'limit': 10
            },
            'titleive/ive/ivespv-approval'
        ).subscribe(response => {
            this.ivespvApprovalResponse(response, approvalRejectStatus, status, approvalRejectComments);
        },
            (error) => {
                this._alertService.error('Unable to process');
                return false;
            }
        );
    }


    private approveEligibility(status: any, approvalRejectStatus: string, approvalRejectComments: string) {
        $(this.signaturepopupid).modal('hide');
        this._commonHttpService.create(
            {
                'where': {
                    'approval_id': this.approvalid,
                    'approval_status': status,
                    'placement_type': 'Fostercare',
                    'approveduser': this.approvalusername ? this.approvalusername : null
                },
                'page': 1,
                'limit': 10
            },
            'titleive/ive/ivespv-approval'
        ).subscribe(response => {
            this.ivespvApprovalResponse(response, approvalRejectStatus, status, approvalRejectComments);
        },
            (error) => {
                this._alertService.error('Unable to process');
                return false;
            }
        );
    }

    private ivespvApprovalResponse(response: any, approvalRejectStatus: string, status: any, approvalRejectComments: string) {
        if (response && response.data && response.data.length > 0) {
            const reviewperiodfornotification = this.latestInitialDet.period === 'I' ? 'Initial' : 'Redetermination';
            const params = {
                'eventcode': 'PLTR',
                'status': approvalRejectStatus,
                'notifymsg': 'Foster care Determination for ' + reviewperiodfornotification + ' ' + this.clientId + ' was ' + status,
                'routeddescription': 'route',
                'userprofilerole': this.rolename,
                'placementid': this.approvalid,
                'comments': approvalRejectComments,
                'signText': 'Signed'
            };
            this.routingUpdate(params, status);
            this.approvalid = null;
            this.getEligibilityHistory();
            this.submitForApprovalRemark = '';
            this.selectedPeriodInfo = null;
        }
    }

    showSupervisorList(periodinfo:any) {
        this.submitForApprovalRemark = '';
        this.period = periodinfo.period;
        this.eligibilityPeriodId = periodinfo.transactionid;
        this.progressNoteId = periodinfo.progressnoteid ? periodinfo.progressnoteid : this.getpreviousnarrativedetails(this.period);
        this.displayprogressnote = periodinfo.ivenarrativesection;
        this.getNarrative(this.clientId, this.progressNoteId, false, this.displayprogressnote);
        this.sendforApprovalForNarrative = true;
        this.sendforApprovalForSignature = true;
        this.editnarrative = periodinfo.isParent;
        $(this.narrativesavepopupid).modal('show');
    }

    updateNarrativeInformation(periodinfo:any, toApprove:any) {
        this.period = periodinfo.period;
        this.eligibilityPeriodId = periodinfo.transactionid;
        this.progressNoteId = periodinfo.progressnoteid ? periodinfo.progressnoteid : this.getpreviousnarrativedetails(this.period);
        this.displayprogressnote = periodinfo.ivenarrativesection;
        if (periodinfo.approvalstatus === 'APPROVED') {
            this.editnarrative = false;
        } else {
            this.editnarrative = periodinfo.isParent;
        }
        this.sendforApprovalForNarrative = false;
        this.selectedPeriodInfo = toApprove ? periodinfo : null;
        this.getNarrative(this.clientId, this.progressNoteId, false, this.displayprogressnote);
        $(this.narrativesavepopupid).modal('show');
    }

    updateSignatureInfo(periodinfo:any) {
        this.period = periodinfo.period
        this.ivesigneligibilityId = periodinfo.transactionid;
        this.sendforApprovalForSignature = false;
        this.approvesignaturebutton = false;
        this.approvedEligibilityId = false;
        this.getivesignatures(this.clientId, this.ivesigneligibilityId);
        $(this.signaturepopupid).modal('show');
    }

    setSignaturesList(item:any) {
        this.ivesignperiod = item.period;
        this.ivesigneligibilityId = item.transactionid;
        this.getivesignatures(this.clientId, this.ivesigneligibilityId);
        this.sendforApprovalForSignature = true;
        $(this.signaturepopupid).modal('show');
    }


    getpreviousnarrativedetails(periodid:any) {
        const lastnarrativedetails:any[] = [];
        if (this.eligibilityPeriodData && this.eligibilityPeriodData.length > 0 ) {
            this.eligibilityPeriodData.forEach(element => {
                if (periodid === element.period) {
                    lastnarrativedetails.push(element);
                }
            });
        }
        if (lastnarrativedetails && lastnarrativedetails.length) {
            for (const element of lastnarrativedetails) {
                if (element.progressnoteid !== null) {
                    this.previousnarrativeornot = true;
                    return element.progressnoteid;
                }
            }
        }
        return null;
    }

    addUpdateNarrative(period:any) {
        if (this.progressNote.description && this.progressNote.description.length > 0)  {
            if (this.previousnarrativeornot) {
                this.progressNoteId = null;
            }
            // hard coded progressnotetypeid to 'note' type and entitytype to 'IVE'
            this.progressNote.progressnotetypeid = 'a1f78e9f-ea8d-4f0b-8df5-7d4c0eda21cc';
            this.progressNote.entitytypeid = this.clientId.toString();
            this.progressNote.eligilityperiodid = period;
            this.progressNote.eligibilityprogressnoteid = this.progressNoteId ? this.progressNoteId : null;
            this.progressNote.entitytype = 'IVE';
            this._commonHttpService
                .create(
                    this.progressNote,
                    Titile4eUrlConfig.EndPoint.addUpdateNarrative
                )
                .subscribe(
                    (response: any) => {
                        this.getEligibilityHistory();
                        if (response) {
                            this._alertService.success('Narrative saved successfully.');
                            this.getNarrative(this.clientId, this.progressNoteId, false, this.displayprogressnote);
                        }
                    },
                    error => {
                        this._alertService.error('Unable to save narrative.');
                        this.getNarrative(this.clientId, this.progressNoteId, false, this.displayprogressnote);
                        return false;
                    }
                );
            $(this.narrativesavepopupid).modal('hide');
            if(this.selectedPeriodInfo) {
                this.ApproveSignature('APPROVED', this.selectedPeriodInfo)
            }
            if (this.sendforApprovalForNarrative) {
                this.getivesignatures(this.clientId, this.eligibilityPeriodId);
                $(this.signaturepopupid).modal('show');
            }
        } else {
            this._alertService.error('Please add Narrative to proceed.');
        }

    }

    getNarrative(clientId:any, progressNoteId:any, narrativedisplay:any, ivenarrativesection:any) {
        this._commonHttpService
            .create(
                {
                    entitytypeid: clientId,
                    progressnoteid: progressNoteId ? progressNoteId : null,
                    entitytype: 'IVE'
                },
                Titile4eUrlConfig.EndPoint.getNarrative
            )
            .subscribe(
                (response: any) => {
                    if (response && response.length > 0 && response[0] !== '') {
                        if (progressNoteId === null && ivenarrativesection === 'YES') {
                            this.progressNote.description = '';
                        } else {
                            this.progressNote = response[0];
                        }
                    } else {
                        this.progressNote.description = '';
                    }
                },
                error => {
                    return false;
                }
            );
    }

    getivesignatures(clientId:any, eligibiltyperiodId:any) {
        this._commonHttpService
            .create(
                {
                    clientid: clientId,
                    eligibilityperiodid: eligibiltyperiodId ? eligibiltyperiodId : this.eligibilityPeriodId,
                },
                Titile4eUrlConfig.EndPoint.getivesignature
            )
            .subscribe(
                (response: any) => {
                    this.clearSignature();
                    this.signatureForm.reset();
                    if (response && response.data.length > 0 && response.data[0] !== '') {
                        this.signatureForm.controls['supervisorSignature'].patchValue(response.data[0].supervisorsignature);
                        this.signatureForm.controls['specalistSignature'].patchValue(response.data[0].specialistsignature);
                        this.signatureForm.controls['specalistsignedDate'].patchValue(response.data[0].specialistsubmissiondate);
                        this.signatureForm.controls['supervisorSignedDate'].patchValue(response.data[0].supervisorsubmissiondate);
                        if (this.isSupervisor && response.data[0].supervisorname) {
                            this.approvalusername =  response.data[0].supervisorname;
                        }
                        if (this.isSpecialist && response.data[0].specialistname) {
                            this.approvalusername =  response.data[0].specialistname;
                        }
                    }
                },
                error => {
                    return false;
                }
            );
    }

    public clearSignature(): void {
        this.signaturePad.clear();
    }

    addUpdateSignature(status?:any, approvalRejectStatus?:string, approvalRejectComments?:string) {
        if ((this.isSpecialist && !(this.signatureForm?.value?.specalistSignature)) || (this.isSupervisor && !(this.signatureForm?.value?.supervisorSignature))) {
            this._alertService.error(this.addsignaturemsg);
        } else if ((this.isSpecialist && !(this.signatureForm?.value?.specalistsignedDate)) || (this.isSupervisor && !(this.signatureForm?.value?.supervisorSignedDate))) {
            this._alertService.error('Please add Date to proceed.');
        } else {
            const payload :any= {
                clientid: this.clientId,
                periodid: this.returnPeriodid(),
                specalistsign: this.returnSpecalistsign(),
                supervisorsign: this.returnSupervisorsign(),
                specalistname: this.returnSpecalistname(),
                supervisorname: this.returnSupervisorname(),
                specalistsigndt: this.returnSpecalistsigndt(),
                supervisorsigndt: this.returnSupervisorsigndt(),
                roletype: this.returnRoletype(),

            };
            if(payload && payload.roletype) {
               this.ivesignatureupdateResponseFn(payload, status, approvalRejectStatus, approvalRejectComments);
            } else {
              return this._alertService.error('Please try again');
            }
            $(this.signaturepopupid).modal('hide');
            if (this.sendforApprovalForSignature) {
                this.sendforApprovalForSignatureTrueFn();
            }
        }
    }

    private returnRoletype() {
        return this.rolename ? this.rolename : null;
    }

    private returnSupervisorsigndt() {
        return this.isSupervisor ? this.signatureForm.value.supervisorSignedDate : null;
    }

    private returnSpecalistsigndt() {
        return this.isSpecialist ? this.signatureForm.value.specalistsignedDate : null;
    }

    private returnSupervisorname() {
        return this.isSupervisor ? this.approvalusername : null;
    }

    private returnSpecalistname() {
        return this.isSpecialist ? this.approvalusername : null;
    }

    private returnSupervisorsign() {
        return this.isSupervisor ? this.signatureForm.value.supervisorSignature : null;
    }

    private returnSpecalistsign() {
        return this.isSpecialist ? this.signatureForm.value.specalistSignature : null;
    }

    private returnPeriodid() {
        return this.ivesigneligibilityId ? this.ivesigneligibilityId : this.eligibilityPeriodId;
    }

    private ivesignatureupdateResponseFn(payload: { clientid: number; periodid: any; specalistsign: any; supervisorsign: any; specalistname: any; supervisorname: any; specalistsigndt: any; supervisorsigndt: any; roletype: string; }, status:any, approvalRejectStatus:any, approvalRejectComments:any) {
        this._commonHttpService
            .create(
                payload,
                Titile4eUrlConfig.EndPoint.ivesignatureupdate
            )
            .subscribe(
                (response: any) => {
                    if (response) {
                        this._alertService.success('Signature saved successfully.');
                        if(status == 'APPROVED') {
                           this.approveEligibility(status, approvalRejectStatus, approvalRejectComments)
                        }
                        this.getivesignatures(this.clientId, this.ivesigneligibilityId);
                    }
                },
                error => {
                    this._alertService.error('Unable to save Signature.');
                    this.getivesignatures(this.clientId, this.ivesigneligibilityId);
                    return false;
                }
            );
    }

    private sendforApprovalForSignatureTrueFn() {
        this.titleIVeService.getUsersList().subscribe(result => {
            if (this.rolename === AppConstants.ROLES.TITLE_IVE_ANALYST) {
                this.getUsersList = result.data.filter(user => (user.rolecode === AppConstants.ROLES.TITLE_IVE_Quality_Assurance || user.rolecode === AppConstants.ROLES.TITLE_IVE_ADMINISTRATOR));
            } else {
                this.getUsersList = result.data.filter(user => user.rolecode === AppConstants.ROLES.TITLE_IVE_SUPERVISOR);
            }
        });
        $('#assign').modal('show');
    }

    RejectDetermination(approvalid:any) {
        this.approvalid = approvalid;
        $('#comments').modal('show');
    }

    ApproveSignature(approvalid:any, item:any) {
        this.approvalid = item.approvalid;
        this.ivesigneligibilityId = item.transactionid;
        this.reviewPeriodInfo = item.period;
        this.getivesignatures(this.clientId, this.ivesigneligibilityId);
        this.approvesignaturebutton = true;
        $(this.signaturepopupid).modal('show');
    }

    selectPerson(item:any) {
        this.selectedPerson = item;
    }

    sendForApproval() {
        if (this.selectedPerson) {
            this._commonHttpService.create(
                {
                    "where":{
                        "clientid": this.clientId,
                        "removalid": this.removalId,
                        "sqnm_sw": this.period,
                        "status":"{70}",
                        "eventType":"Fostercare"
                    },
                    "page": 1,
                    "limit" : 10
                },
                'titleive/ive/approval-status'
            ).subscribe(response => {
                    if(response && response.data && response.data.length > 0){
                        let reviewperiodfornotification;
                        if (this.period === 'I') {
                            reviewperiodfornotification = 'Initial';
                        } else {
                            reviewperiodfornotification = 'Redetermination';
                        }
                        var params = {
                            'assignedtoid': this.selectedPerson.userid,
                            'eventcode': 'PLTR',
                            'status': 'SplReview',
                            'userprofilerole': this.rolename,
                            'notifymsg':  'Foster care Determination for ' + reviewperiodfornotification + ' '  + this.clientId + ' was sent for review',
                            'routeddescription': 'route',
                            'comments': 'Request for Review - ' + this.submitForApprovalRemark,
                            'placementid': response.data[0].sp_ive_status_approval,
                            'signText': 'Signed',
                            'touserrole': this.selectedPerson.rolecode
                        }
                        this.routingUpdate(params, 'Review');
                    }
                },
                (error) => {
                    this._alertService.error('Unable to process');
                    return false;
                }
            );
        }else{
            this._alertService.error('Select a Supervisor');
        }

    }


    routingUpdate(params:any, status:any){
        this._commonHttpService.create(
            {
                'where': params
            },
            'titleive/ive/routingUpdate'
        ).subscribe(response => {
                $('#assign').modal('hide');
                if (status === 'Review') {
                    this.getEligibilityHistory();
                    this._alertService.success('Sent For Approval');
                } else  {
                   if (status === 'APPROVED' && this.IVEReferralProdCheck) {
                       this.sendApprovalInfomation();
                   }
                    this.getEligibilityHistory();
                    this._alertService.success('Determination is ' + status);
                }

            },
            (error) => {
                this._alertService.error('Unable To Process');
                return false;
            }
        );
    }


    // Trigger to pass the CJAMS information to CSMS
    sendApprovalInfomation() {
        this._commonHttpService.create(
            {
                'where': {
                    'clientId': Number(this.clientId),
                    'removalId': Number(this.removalId),
                    'reviewperiod': this.reviewPeriodInfo
                },
            },
            Titile4eUrlConfig.EndPoint.ivecsmsinformation
        ).subscribe(response => {
                return true;
            },
            (error) => {
                return false;
            });
    }

    formatStatus(str: string): string{
        return _.replace(str, /_/g, " ");
    }

    getEligibilityDetails(period: any){
        this.fieldMessages = [];
        this.periodInfo = period;
        this.showSnapshot = false;
        if(this.latestInitialDet && this.periodInfo['period_fostercarecomponents'].length > 0 && this.latestInitialDet['period_fostercarecomponents'].length > 0){
            this.periodInfo['period_fostercarecomponents'][7].component_status_cd = this.periodInfo['period_fostercarecomponents'][7].component_status_cd ? this.periodInfo['period_fostercarecomponents'][7].component_status_cd : this.latestInitialDet['period_fostercarecomponents'][7].component_status_cd; // removaltype
            this.periodInfo['period_fostercarecomponents'][6].component_status_cd = this.periodInfo['period_fostercarecomponents'][6].component_status_cd ? this.periodInfo['period_fostercarecomponents'][6].component_status_cd : this.latestInitialDet['period_fostercarecomponents'][6].component_status_cd; // removalhome
            this.periodInfo['period_fostercarecomponents'][4].component_status_cd = this.periodInfo['period_fostercarecomponents'][4].component_status_cd ? this.periodInfo['period_fostercarecomponents'][4].component_status_cd : this.latestInitialDet['period_fostercarecomponents'][4].component_status_cd; //income
            this.periodInfo['period_fostercarecomponents'][0].component_status_cd = this.periodInfo['period_fostercarecomponents'][0].component_status_cd ? this.periodInfo['period_fostercarecomponents'][0].component_status_cd : this.latestInitialDet['period_fostercarecomponents'][0].component_status_cd; //assets
            this.periodInfo['period_fostercarecomponents'][3].component_status_cd = this.periodInfo['period_fostercarecomponents'][3].component_status_cd ? this.periodInfo['period_fostercarecomponents'][3].component_status_cd : this.latestInitialDet['period_fostercarecomponents'][3].component_status_cd; //deprivation
        }
    }


    getMessages(item:any, fieldName:any): void {
        if (item.forstercareeligibilitystatus === 'Eligible Reimbursable') {
            item.period_messages = item.period_messages.filter((a:any) => a.severity !== 'Warning');
        }
        this.fieldMessages = item.period_messages.filter((a:any) => {
            return this.returnDemographic(item.period_fostercareevents,a,fieldName);
        });
    }

    private returnDemographic(fostercareeventcheck: any[], a: any, fieldName: string): any {
        if ((a.message.search(/ReceiptOfOtherBenefits|Age|Citizenship|SILAAgreement|18BDAY_Youth_18_21|Youth_Event_Types|Initialize|Demographic/) !== -1) && a.message.indexOf("]") != -1) {
            a.dispMessage = this.returnDispMessage(a);
            return true;
        }
        if (fostercareeventcheck !== null && fostercareeventcheck[0].notes_tx.includes('YE')) {
            if ((a.message.search(/Youth_18_21/) !== -1) && a.message.indexOf(']') !== -1) {
                a.dispMessage = a.message.substr(a.message.indexOf(']') + 1).trim();
                return true;
            }
        }
        return this.returnCourtStatus(a,fieldName);
    }

    private returnCourtStatus(a: any, fieldName: string): any {
        if ((a.message.search(/Legal_Court_Ordered_Or_VPA_Removals|Judicial_Determination_of_REFPP_Removal_after_27_March_2000___First_Re_Determination|Judicial_Determination_of_REFPP_Removal_after_27_March_2000_Subsequent_Re_Determination |Judicial_Determination_of_REFPP_Removal_after_27_March_2000___Subsequent_Re_Determination/) !== -1 || a.message.search(/Judicial_Determination_of_REFPP_Removal_before_27_March_2000_First_Re_Determination|Judicial_Determination_of_REFPP_Removal_before_27_March_2000_Subsequent_Re_Determination|Voluntary_Placement_Removals_First_Re_Determination|Voluntary_Placement_Removals_Subsequent_Re_Determination|Voluntary_Placement_Removals_ChildDisabilityVPAEAVPA_First_Re_Determination|Voluntary_Placement_Removals_ChildDisabilityVPAEAVPA_Subsequent_Re_Determination|Voluntary_Placement_Removals_TimeLimitedVPA_First_Re_Determination|Voluntary_Placement_Removals_TimeLimitedVPA_Subsequent_Re_Determination|CourtStatus/) !== -1) && a.message.indexOf("]") != -1) {
            a.dispMessage = this.returnDispMessage(a);
            return true;
        }
        return this.returnRemovalHome(a,fieldName);
    }

    private returnRemovalHome(a: any, fieldName: string): any {
        if ((a.message.search(/Child_In_FosterCare_for_12_Months_or_More|Child_Not_In_FosterCare_for_12_Months_or_More_REFPP_Not_Due|RemovalHome/) != -1) && a.message.indexOf("]") != -1) {
            a.dispMessage = this.returnDispMessage(a);
            return true;
        }
        return this.returnDeprivation(a,fieldName);
    }

    private returnDeprivation(a: any, fieldName: string): any {
        if ((a.message.search(/MultipleDeprivation|Deprivation/) != -1) && a.message.indexOf("]") != -1) {
            a.dispMessage = this.returnDispMessage(a);
            return true;
        }
        return this.returnRemovalType(a,fieldName)
    }

    private returnRemovalType(a: any, fieldName: string): any {
        if ((a.message.search(/RemovalTypeReasonCodeStatus|RemovalType/) != -1) && a.message.indexOf("]") != -1) {
            a.dispMessage = this.returnDispMessage(a);
            return true;
        } else {
            if (a.message.indexOf(fieldName) != -1 && a.message.indexOf("]") != -1) {
                a.dispMessage = this.returnDispMessage(a);
                return true;
            }
        }
        return false;
    }

    private returnDispMessage(a: any): any {
        return a.message.substr(a.message.indexOf("]") + 1).trim();
    }

    displayWorksheet(worksheet:string, clientId:any, transactionid:any, removalid?:number){
        this.worksheetType = worksheet;
        this.deemedclientid = clientId;
        let _childjurisdiction = '';
        if(this?.eligibilitysummaryinfo && this?.eligibilitysummaryinfo[0] && this?.eligibilitysummaryinfo[0]?.childjurisdiction){
            _childjurisdiction = this?.eligibilitysummaryinfo[0]?.childjurisdiction;
        }
        const modal = {
            method: 'post',
            where: {
                documenttemplatekey: ['ivefostercarePDF'],
                status: 'fostercare',
                transactionid: transactionid,
                removalid: removalid,
                childJurisdiction: _childjurisdiction,
                type: worksheet,
                isheaderrequired: false
            },
            limit: 10,
            order: 'desc',
            page: 1,
            count: -1
        };
        this._commonHttpService.download('evaluationdocument/generateintakedocument', modal)
            .subscribe(res => {
                const blob = new Blob([new Uint8Array(res)]);
                const link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                if(worksheet ==='DEEMEDINCOME'){
                    link.download = `ivefostercaredeemed.pdf`;
                } else if (worksheet==='INCOMEASSET') {
                    link.download = `ivefostercareincomeasset.pdf`;
                } else if (worksheet==='INITIAL') {
                    link.download = `ivefostercareinitialeligibility.pdf`;
                } else if (worksheet==='REDETERMINATION') {
                    link.download = `ivefostercareredeterminationeligibility.pdf`;
                }
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            });

    }


    getStatusDetails(status:string) {
        this.detStatusDetails = [status];

    }

    onCourtStatus(item:any) {
        //No operation needed here
    }

}
