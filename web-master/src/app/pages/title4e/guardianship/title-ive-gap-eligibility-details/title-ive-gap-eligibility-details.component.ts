import {Component, Injector, OnInit, ViewChild} from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { FormGroup, FormBuilder } from '@angular/forms';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { AlertService } from '../../../../@core/services/alert.service';
import { MatDialog } from '@angular/material/dialog';
import { DataStoreService, AuthService } from '../../../../@core/services';
import { Title4eService } from '../../services/title4e.service';
import { AppConstants } from '../../../../@core/common/constants';
import {Titile4eUrlConfig} from '../../_entities/title4e-dashboard-url-config';
import {RecordingNotes} from '../../title-ive-foster-car/narratives/iveNarrativeModel';
import { SignatureFieldComponent } from '../../../../shared/modules/common-controls/signature-field/signature-field.component';

declare var Formio: any;

@Component({
    selector: 'title-ive-gap-eligibility-details',
    templateUrl: './title-ive-gap-eligibility-details.component.html',
    styleUrls: ['./title-ive-gap-eligibility-details.component.scss'],
    standalone: false
})
export class TitleIveGapEligibilityDetailsComponent implements OnInit {

  progressNote: RecordingNotes = new RecordingNotes();
  @ViewChild(SignatureFieldComponent) public signaturePad!: SignatureFieldComponent;
  isCLW: any;
  isSupervisor = false;
  isSpecialist = false;
  getUsersList: any[]=[];
  selectedPerson: any;
  client_id!: string;
  removal_id!: string;
  userInfo: any;
  approvalusername: any;
  gapAuditList: any = [];
  approvalid : any;
  gapmessages : any;
  gapwarnings : any;
  warningdate: any;
  selectedItem: any;
  showSnapshot: boolean = false;
  selectedItemSnapshot: any;
  eligibilityDetailsChilds: boolean = true;
  submitForApprovalRemark = '';
  period: any;
  sqnm_sw: any;
  previouseligibilitydetails: any;
  previousnarrativeornot: boolean = false;
  editnarrative: boolean = false;
  eligibilityPeriodId: any;
  sendforApprovalForNarrative: boolean = false;
  progressNoteId: any;
  displayprogressnote: any;
  narrativeInfodisplay: boolean = false;
  narrativeMessage: any;
  displayinitialPDF: boolean = false;
  initialdeterminationdata: any;
  approvesignaturebutton: boolean = false;
  ivesignperiod: any;
  ivesigneligibilityId: any;
  approvedEligibilityId: any;
  sendforApprovalForSignature: boolean = false;
  signatureForm!: FormGroup;
  rolename!: string;
  userroledesc: any;
  isreadonly: any;
  selectedPeriodInfo: any = null;
  narrativesavepopupid = '#narrativesave';
  signaturepopupid = '#signature';
  addsignaturemsg = 'Please add Signature to proceed.';
  currentItem: any;
  private _commonHttpService: CommonHttpService;
  private _alertService: AlertService;
  private title4eService: Title4eService;
  private _dataStoreService: DataStoreService;
  private _formBuilder: FormBuilder;
  public _authService: AuthService;
  private activatedRoute: ActivatedRoute;

  constructor(private injector: Injector, public dialog: MatDialog) {
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this.title4eService = this.injector.get<Title4eService>(Title4eService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._authService = this.injector.get<AuthService>(AuthService);
    this.activatedRoute = this.injector.get<ActivatedRoute>(ActivatedRoute);
   }

  ngOnInit() {
    this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.IVE_SUPERVISOR) || this._authService.selectedRoleIs('IV-E Eligibility Quality Assurance') || this._authService.selectedRoleIs('IV-E Eligibility Administrator');
    this.isSpecialist = this._authService.selectedRoleIs(AppConstants.ROLES.IVE_SPECIALIST) || this._authService.selectedRoleIs('IV-E Eligibility Analyst');
    this.userInfo = this._authService.getCurrentUser();
    this.rolename = this.userInfo.role.key ? this.userInfo.role.key : this.userInfo.user.userprofile.teammemberassignment.teammember.teammemberroletype.roletypekey;
    this.userroledesc = this.userInfo.role.name;
    this._dataStoreService.currentStore.subscribe((item) => {
        if (item['isivereadonly']) {
          this.isreadonly = item['isivereadonly'];
        }
      });
    this.client_id = this.activatedRoute.snapshot.paramMap.get('clientid')?? "";
    this.removal_id = this.activatedRoute.snapshot.paramMap.get('removalId')?? "";
    this.eligibilityDetails();
    this.isTabSwitched();
    if (this.userInfo && this.userInfo.user) {
          this.approvalusername = this.userInfo.user.userprofile.firstname + ' ' + this.userInfo.user.userprofile.lastname;
    }
    this.signatureForm = this._formBuilder.group({
          specalistSignature: null,
          supervisorSignature: null,
          specalistName: null,
          specalistsignedDate: null,
          supervisorName: null,
          supervisorSignedDate: null
    });
  }

  isTabSwitched(){
    $('.intake-tabs a').on('shown.bs.tab', (event) => {
      var x = $(event.target).text();
      if(x.includes("DETAILS")){
        this.eligibilityDetails();
      }
    });
  }


  showSupervisorList(periodinfo:any) {
    this.submitForApprovalRemark = '';
      this.submitForApprovalRemark = '';
      this.period = periodinfo.sqnm_sw;
      this.eligibilityPeriodId = periodinfo.eligibility_period_id;
      this.progressNoteId = periodinfo.progressnoteid ? periodinfo.progressnoteid : this.getpreviousnarrativedetails(this.period);
      this.displayprogressnote = periodinfo.ivenarrativesection;
      this.getNarrative(this.client_id, this.progressNoteId, false, this.displayprogressnote);
      this.sendforApprovalForNarrative = true;
      this.sendforApprovalForSignature = true;
      this.editnarrative = periodinfo.isParent;
      (<any>$(this.narrativesavepopupid)).modal('show');
  }

    updateNarrativeInformation(periodinfo:any, toApprove:any) {
        this.period = periodinfo.sqnm_sw;
        this.eligibilityPeriodId = periodinfo.eligibility_period_id;
        this.progressNoteId = periodinfo.progressnoteid ? periodinfo.progressnoteid : this.getpreviousnarrativedetails(this.period);
        this.displayprogressnote = periodinfo.ivenarrativesection;
        this.sendforApprovalForNarrative = false;
        this.selectedPeriodInfo = toApprove ? periodinfo : null;
        if (periodinfo.approvalstatus === 'APPROVED') {
            this.editnarrative = false;
        } else {
            this.editnarrative = periodinfo.isParent;
        }
        this.getNarrative(this.client_id, this.progressNoteId, false, this.displayprogressnote);
        (<any>$(this.narrativesavepopupid)).modal('show');
    }

    addUpdateNarrative(period:any) {
        if (this.progressNote.description && this.progressNote.description.length > 0)  {
            if (this.previousnarrativeornot) {
                this.progressNoteId = null;
            }
            // hard coded progressnotetypeid to 'note' type and entitytype to 'IVE'
            this.progressNote.progressnotetypeid = 'a1f78e9f-ea8d-4f0b-8df5-7d4c0eda21cc';
            this.progressNote.entitytypeid = this.client_id.toString();
            this.progressNote.eligilityperiodid = period;
            this.progressNote.eligibilityprogressnoteid = this.progressNoteId ? this.progressNoteId : null;
            this.progressNote.entitytype = 'IVEGAP';
            this._commonHttpService
                .create(
                    this.progressNote,
                    Titile4eUrlConfig.EndPoint.addUpdateNarrative
                )
                .subscribe(
                    (response: any) => {
                        this.eligibilityDetails();
                        if (response) {
                            this._alertService.success('Narrative saved successfully.');
                            this.getNarrative(this.client_id, this.progressNoteId, false, this.displayprogressnote);
                        }
                    },
                    error => {
                        this._alertService.error('Unable to save narrative.');
                        this.getNarrative(this.client_id, this.progressNoteId, false, this.displayprogressnote);
                        return false;
                    }
                );
            (<any>$(this.narrativesavepopupid)).modal('hide');
            if(this.selectedPeriodInfo) {
                this.ApproveSignature('APPROVED', this.selectedPeriodInfo);
            }
            if (this.sendforApprovalForNarrative) {
                this.getivesignatures(this.client_id, this.eligibilityPeriodId);
                (<any>$(this.signaturepopupid)).modal('show');
            }
        } else {
            this._alertService.error('Please add Narrative to proceed.');
        }

    }

    getpreviousnarrativedetails(periodid:any) {
        const lastnarrativedetails :any[]= [];
        if (this.gapAuditList && this.gapAuditList.length > 0 ) {
            this.gapAuditList.forEach((element:any) => {
                if (periodid === element.sqnm_sw) {
                    lastnarrativedetails.push(element);
                }
            });
        }
        if (lastnarrativedetails && lastnarrativedetails.length) {
            for (const element of lastnarrativedetails) {
                if (element.progressnoteid !== null && element.eligibility_period_id <= this.eligibilityPeriodId) {
                    this.previousnarrativeornot = true;
                    return element.progressnoteid;
                }
            }
        }
        return null;
    }

    getNarrative(clientId:any, progressNoteId:any, narrativedisplay:any, ivenarrativesection:any) {
        this._commonHttpService
            .create(
                {entitytypeid: clientId,
                    progressnoteid: progressNoteId ? progressNoteId : null,
                    entitytype: 'IVEGAP'},
                Titile4eUrlConfig.EndPoint.getNarrative
            )
            .subscribe(
                (response: any) => {
                    if (response && response.length > 0 && response[0] !== '') {
                            this.progressNote = response[0];
                    } else {
                        this.progressNote.description = '';
                    }
                },
                error => {
                    return false;
                }
            );
    }

    updateSignatureInfo(periodinfo:any) {
        // this.period = periodinfo.period
        this.ivesigneligibilityId = periodinfo.eligibility_period_id;
        this.sendforApprovalForSignature = false;
        this.approvesignaturebutton = false;
        this.approvedEligibilityId = false;
        this.getivesignatures(this.client_id, this.ivesigneligibilityId);
        (<any>$(this.signaturepopupid)).modal('show');
    }

    getivesignatures(clientId:any, eligibiltyperiodId:any) {
        this.clearSignature();
        this.signatureForm.reset();
        this.signatureForm.controls['supervisorSignature'].patchValue(null);
        this.signatureForm.controls['specalistSignature'].patchValue(null);
        this._commonHttpService
            .create(
                {
                    clientid: clientId,
                    eligibilityperiodid: eligibiltyperiodId ? eligibiltyperiodId : this.eligibilityPeriodId,
                },
                Titile4eUrlConfig.EndPoint.getgapsignature
            )
            .subscribe(
                (response: any) => {
                    if (response && response.data.length > 0 && response.data[0] !== '') {
                        this.signatureForm.controls['supervisorSignature'].patchValue(response.data[0].supervisorsignature);
                        this.signatureForm.controls['specalistSignature'].patchValue(response.data[0].specialistsignature);
                        this.signatureForm.controls['specalistsignedDate'].patchValue(response.data[0].specialistsubmissiondate);
                        this.signatureForm.controls['supervisorSignedDate'].patchValue(response.data[0].supervisorsubmissiondate);
                    }
                },
                error => {
                    return false;
                }
            );
    }

    addUpdateSignature() {
        if (this.isSpecialist && (this.signatureForm.value.specalistSignature === '' || this.signatureForm.value.specalistSignature === null)) {
            this._alertService.error(this.addsignaturemsg);
        } else if (this.isSupervisor && (this.signatureForm.value.supervisorSignature === '' || this.signatureForm.value.supervisorSignature === null)) {
            this._alertService.error(this.addsignaturemsg);
        } else {
            this.addUpdateSignatureElseCondition();
        }
    }

    private addUpdateSignatureElseCondition() {
        const payload = {
            clientid: this.client_id,
            periodid: this.ivesigneligibilityId ? this.ivesigneligibilityId : this.eligibilityPeriodId,
            specalistsign: this.isSpecialist ? this.signatureForm.value.specalistSignature : null,
            supervisorsign: this.isSupervisor ? this.signatureForm.value.supervisorSignature : null,
            specalistname: this.isSpecialist ? this.approvalusername : null,
            supervisorname: this.isSupervisor ? this.approvalusername : null,
            specalistsigndt: this.isSpecialist ? this.signatureForm.value.specalistsignedDate : null,
            supervisorsigndt: this.isSupervisor ? this.signatureForm.value.supervisorSignedDate : null,
            roletype: this.rolename ? this.rolename : null,
        };
        this.gapSignatureUpdateFn(payload);
        (<any>$(this.signaturepopupid)).modal('hide');
        if (this.sendforApprovalForSignature) {
            this.gapAddUpdateSignatureSendAppFn();
        }
    }

    private gapAddUpdateSignatureSendAppFn() {
        this.title4eService.getUsersList().subscribe(result => {
            if (this.rolename === AppConstants.ROLES.TITLE_IVE_ANALYST) {
                this.getUsersList = result.data.filter(user => (user.rolecode === AppConstants.ROLES.TITLE_IVE_Quality_Assurance || user.rolecode === AppConstants.ROLES.TITLE_IVE_ADMINISTRATOR));
            } else {
                this.getUsersList = result.data.filter(user => user.rolecode === AppConstants.ROLES.TITLE_IVE_SUPERVISOR);
            }
        });
        (<any>$('#assign')).modal('show');
    }

    private gapSignatureUpdateFn(payload: any) {
        this._commonHttpService
            .create(
                payload,
                Titile4eUrlConfig.EndPoint.gapsignatureupdate
            )
            .subscribe(
                (response: any) => {
                    this.eligibilityDetails();
                    if (response) {
                        this._alertService.success('Signature saved successfully.');
                        this.getivesignatures(this.client_id, this.ivesigneligibilityId);
                    }
                },
                error => {
                    this._alertService.error('Unable to save Signature.');
                    this.getivesignatures(this.client_id, this.ivesigneligibilityId);
                    return false;
                }
            );
    }

    ApproveSignature(approvalid:any, item:any) {
        this.approvalid = item.approvalid;
        this.ivesigneligibilityId = item.eligibility_period_id;
        this.getivesignatures(this.client_id, this.ivesigneligibilityId);
        this.approvesignaturebutton = true;
        (<any>$(this.signaturepopupid)).modal('show');
    }

    public clearSignature(): void {
        this.signaturePad.clear();
    }


    selectPerson(item:any) {
    this.selectedPerson = item;
  }


sendForApproval(){
    if(this.selectedPerson){
    this._commonHttpService.create(
      {
        "where":{
          "clientid": this.client_id,
          "removalid": this.removal_id,
          "status":"{73}",
          "eventType":"Gap",
          "sqnm_sw": this.period
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
          const params = {
            "assignedtoid": this.selectedPerson.userid,
            "eventcode": "GAAR",
            "status": "SplReview",
            "notifymsg": 'Gap Determination for ' + reviewperiodfornotification + ' '  + this.client_id + ' was sent for review',
            "routeddescription": "route",
            "comments": 'Request for Review - ' + this.submitForApprovalRemark,
            "gapagreementid": response.data[0].sp_ive_status_approval,
            "signText": "Signed",
            "touserrole": this.selectedPerson.rolecode,
            "userprofilerole": this.rolename
          }
          this.routingUpdate(params, 'Review');
          this.eligibilityDetails();
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

  toggleChildren(sqnmSw: any, isCollapsed: any){
    this.gapAuditList.forEach((element: any) => {
        if (element.sqnm_sw == sqnmSw && isCollapsed) {
            element.isCollapsed = false;
            element.isVisible = true;
        } else {
            if (element.isParent) {
                element.isVisible = true;
                element.isCollapsed = true;
            } else {
                element.isVisible = false;
            }
        }
    });
}

    pdfInitialDownload(item: any) {
      if (item !== null && item.sqnm_sw === 'I') {
          this.initialdeterminationdata = item;
          this.displayinitialPDF = true;
      } else {
          this.displayinitialPDF = false;
      }
    }

  routingUpdate(params:any, status:any){
    this._commonHttpService.create(
      {
        "where": params
      },
      'titleive/ive/routingUpdate'
    ).subscribe(response => {
      this.eligibilityDetails();
      (<any>$('#assign')).modal('hide');
      if(status === 'Review'){
        this._alertService.success('Sent For Approval');
      }
      else
      {
        this._alertService.success('Determination is ' + status);
      }
    },
      (error) => {
        this._alertService.error('Unable To Process');
        return false;
      }
    );
  }


  gaperrors(item:any,logtype:any){
    this.gapmessages = null;
    this.gapwarnings = null;
    this.selectedItem = item;
    this.showSnapshot = false;
    this._commonHttpService.getById(item.eligibility_period_id,'ivegap/gap/audit-messages').subscribe(
        (response: any) => {
            this.gapmessages = [];
            this.gapwarnings = [];
            this.warningdate = item.insertedon;
            if (response && response.data && response.data.length > 0) {
                if (item.gapeligibilitystatus === 'Eligible Reimbursable') {
                    response.data = response.data.filter((a :any) => a.severity !== 'Warning');
                    this.gapmessages = response.data;
                } else {
                    this.gapmessages = response.data;
                }
                    this.gapmessages = response.data;
                    for (const gapwarning of response.data) {
                        this.selectedItemSnapshot = gapwarning.pagesnapshot;
                        if (gapwarning.message.indexOf(']') !== -1) {
                            gapwarning.message = gapwarning.message.substr(gapwarning.message.indexOf(']') + 1).trim();
                        }
                        if (gapwarning.severity === 'Warning') {
                            this.gapwarnings.push(gapwarning);
                        }
                    }
            }

            if(logtype === 'W'){
                this.gapmessages = null;
            }

            if(logtype === 'L'){
                this.gapwarnings = null;
            }

        },
        (error) => {
          return false;
        }
      );
}

    downloadWorksheet(item:any) {
        const modal = {
            method: 'post',
            where: {
                documenttemplatekey: ['gapeligibilityform'],
                status: 'fostercare',
                // removalId: this.removalid,
                clientId: this.client_id,
                eligibilityId: item.eligibility_period_id,
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
                link.download = `gapeligibilityform.pdf`;
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            });
    }

    eligibilityDetails(){
    this.showSnapshot = false;
    this._commonHttpService
    .getArrayList(
      {
        method: 'get',
        page: 1,
        limit: 10,
        where: { clientid: this.client_id, removalid : this.removal_id }
      },
      'tb_ive_gapaudit/list?filter'
    ).subscribe(res => {
      this.gapAuditList = null;
      if (res && res.length > 0) {
        let previousDet = "";
        this.gapAuditList = [];
        res.forEach(element => {
          element.isParent = true;
          element.isVisible = true;
          element.isCollapsed = true;
          if (element.sqnm_sw === previousDet) {
            element.isParent = false;
            element.isVisible = false;
            element.isCollapsed = false;
          }
          this.gapAuditList.push(element);
          previousDet = element.sqnm_sw;
        });
      }
      this.currentItem = JSON.parse(sessionStorage.getItem('currentItem') || '{}');
      if (this.currentItem && this.currentItem !== '{}') {
          this.checkCaseDetails();
      }
    });
}

checkCaseDetails() { //CIDM-8407 (migrated records only appear in the migrated episodes when clicking the GAP subsidy)
    if (this.currentItem.client_id && this.currentItem.guardian_subsidy_id) {
        this._commonHttpService.getAll('ivegap/gap/gap-history/' + this.currentItem.client_id).subscribe(data => {
            this.processGapHistory(data);
            
        });
    }
  }

  private processGapHistory(data: any){
    data.forEach((element: any) => {
        if (this.currentItem.guardian_subsidy_id === element.guardian_subsidy_id) {
            if (element.ivegapassigneduser && element.ivegapassigneduser !== '') {
                if (this.gapAuditList && Array.isArray(this.gapAuditList)) { // Check if gapAuditList exists and is an array
                    this.gapAuditList.forEach(item => {
                        item.isVisible = !!item.sqnm_sw;
                    });
                }
            }
        }
    });
  }

RejectDetermination(approvalid: any, sqnm_sw: any){
  this.approvalid = approvalid;
  this.sqnm_sw = sqnm_sw;
  (<any>$('#comments')).modal('show');
}

ApproveReject(status:any, approvalid:any ,sqnm_sw:any) {
    let approvalRejectComments = '';
    let approvalRejectStatus = '';
  if (status === 'APPROVED') {
    this.approvalid = approvalid;
    this.sqnm_sw = sqnm_sw;
    approvalRejectComments = '';
    approvalRejectStatus = 'SpvApproved';
  } else if (status === 'REJECTED') {
      approvalRejectComments = 'Rejected for : ' + this.submitForApprovalRemark;
      approvalRejectStatus = 'SpvRejected';
  }
  (<any>$('#comments')).modal('hide');
    if (status === 'APPROVED' && (this.signatureForm.value.supervisorSignature === '' || this.signatureForm.value.supervisorSignature === null)) {
        this._alertService.error(this.addsignaturemsg);
    } else {
        if (status === 'APPROVED') {
            this.addUpdateSignature();
        }
        this.ivespvApprovalFn(status, approvalRejectStatus, approvalRejectComments);
    }

}


    private ivespvApprovalFn(status: any, approvalRejectStatus: string, approvalRejectComments: string) {
        this._commonHttpService.create(
            {
                'where': {
                    'approval_id': this.approvalid,
                    'approval_status': status,
                    'placement_type': 'Gap',
                    'approveduser': this.approvalusername ? this.approvalusername : null
                },
                'page': 1,
                'limit': 10
            },
            'titleive/ive/ivespv-approval'
        ).subscribe(response => {
            if (response && response.data && response.data.length > 0) {
                this.ivespvApprovalFnResponse(response, approvalRejectStatus, status, approvalRejectComments);
            }
        },
            (error) => {
                this._alertService.error('Unable to process');
                return false;
            }
        );
    }

    private ivespvApprovalFnResponse(response: any, approvalRejectStatus: string, status: any, approvalRejectComments: string) {
        let reviewperiodfornotification;
        if (this.sqnm_sw === 'I') {
            reviewperiodfornotification = 'Initial';
        } else {
            reviewperiodfornotification = 'Redetermination';
        }
        const params = {
            "eventcode": "GAAR",
            "status": approvalRejectStatus,
            "notifymsg": 'GAP Determination for ' + reviewperiodfornotification + ' ' + this.client_id + ' was ' + status,
            "routeddescription": "route",
            "comments": approvalRejectComments,
            "gapagreementid": this.approvalid,
            "signText": "Signed",
            'userprofilerole': this.rolename,
        };
        this.routingUpdate(params, status);
        this.approvalid = null;
        this.eligibilityDetails();
        this.submitForApprovalRemark = '';
        this.selectedPeriodInfo = null;
    }
}
