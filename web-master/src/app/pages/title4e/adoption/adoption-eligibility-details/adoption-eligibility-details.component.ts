import { Component, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { AlertService } from '../../../../@core/services/alert.service';
import { ActivatedRoute } from '@angular/router';
import { Title4eService } from '../../services/title4e.service';
import { AuthService, DataStoreService} from '../../../../@core/services';
import { AppConstants } from '../../../../@core/common/constants';
import { CASE_STORE_CONSTANTS } from '../../../case-worker/_entities/caseworker.data.constants';
import { MatDialog } from '@angular/material/dialog'
import _ from 'lodash';
import {Titile4eUrlConfig} from '../../_entities/title4e-dashboard-url-config';
import {RecordingNotes} from '../../title-ive-foster-car/narratives/iveNarrativeModel';
@Component({
    selector: 'adoption-eligibility-details',
    templateUrl: './adoption-eligibility-details.component.html',
    styleUrls: ['./adoption-eligibility-details.component.scss'],
    standalone: false
})
export class AdoptionEligibilityDetailsComponent implements OnInit {

  progressNote: RecordingNotes = new RecordingNotes();
  isCLW: any;
  id: string='';
  adoptionAuditList: any = [];
  client_id: string='';
  removalid: any;
  approveRejectDisabled = true;
  approvalid: any;
  isSupervisor = false;
  isSpecialist = false;
  adoptionmessages: any;
  adoptionwarnings: any;
  eligibilityDetailsChilds = true;
  getUsersList: any[]=[];
  userInfo: any;
  approvalusername: any;
  warningdate: any;
  selectedPerson: any;
  selectedItem: any;
  selectedItemSnapshot: any;
  showSnapshot: boolean = false;
  submitForApprovalRemark = '';
  period: any;
  sqnm_sw: any;
  displayinitialPDF: boolean = false;
  initialdeterminationdata: any;
  previouseligibilitydetails: any;
  previousnarrativeornot: boolean = false;
  editnarrative: boolean = false;
  eligibilityPeriodId: any;
  sendforApprovalForNarrative: boolean = false;
  progressNoteId: any;
  displayprogressnote: any;
  narrativeInfodisplay: boolean = false;
  narrativeMessage: any;
  rolename: string='';
  isreadonly: any;
  selectedPeriodInfo: any = null;
  narrativesavepopupid = '#narrativesave';

  constructor(public dialog: MatDialog,
    private _commonHttpService: CommonHttpService,
    private _alertService: AlertService,
    public _authService: AuthService,
    private titleIVeService: Title4eService, private _datastore: DataStoreService,
    private activatedRoute: ActivatedRoute) { }

  ngOnInit() {
    this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.IVE_SUPERVISOR) || this._authService.selectedRoleIs('IV-E Eligibility Quality Assurance') || this._authService.selectedRoleIs('IV-E Eligibility Administrator');
    this.isSpecialist = this._authService.selectedRoleIs(AppConstants.ROLES.IVE_SPECIALIST) || this._authService.selectedRoleIs('IV-E Eligibility Analyst');
    this.userInfo = this._authService.getCurrentUser();
    this.rolename = this.userInfo.role.key ? this.userInfo.role.key : this.userInfo.user.userprofile.teammemberassignment.teammember.teammemberroletype.roletypekey;
    this._datastore.currentStore.subscribe((item) => {
      if (item['isivereadonly']) {
        this.isreadonly = item['isivereadonly'];
      }
    });
    this.client_id = this.activatedRoute.snapshot.paramMap.get('clientid')?? "";
    this.removalid = this.activatedRoute.snapshot.paramMap.get('removalId');
    if (this.removalid) {
        this.eligibilityDetails();
    }
    this.isTabSwitched();
    if (this.userInfo && this.userInfo.user) {
          this.approvalusername = this.userInfo.user.userprofile.firstname + ' ' + this.userInfo.user.userprofile.lastname;
    }
  }

  isTabSwitched(){
    $('.intake-tabs a').on('shown.bs.tab', (event) => {
      var x = $(event.target).text();
      if(x.includes("DETAILS")){
        this.eligibilityDetails();
      }
    });
  }

  toggleChildren(category: any) {
    const filterChildrenData: any = {
      category,
      isParent: false
    }

    const filterParentData: any = {
      category,
      isParent: true
    }

    _.filter(this.adoptionAuditList, filterChildrenData).forEach((period : any)=>{
      period.isVisible = !period.isVisible;
    });

    _.filter(this.adoptionAuditList, filterParentData).forEach((period : any)=>{
      period.isCollapsed = !period.isCollapsed;
    });
  }

  eligibilityDetails() {
    this.showSnapshot = false;
    this._commonHttpService
    .getArrayList(
      {
        method: 'get',
        page: 1,
        limit: 10,
        where: { clientid: this.client_id }
      },
      'tb_ive_adoption_audit/list?filter'
    ).subscribe(res => {
      this.adoptionAuditList = null;
        if (res && res.length > 0) {
            let previousDet = "";
            this.adoptionAuditList = [];
            res.forEach(element => {
              element.isParent = true;
              element.isVisible = true;
              element.isCollapsed = true;
              if (element.category === previousDet) {
                element.isParent = false;
                element.isVisible = false;
                element.isCollapsed = false;
              }
              this.adoptionAuditList.push(element);
              previousDet = element.category;
            });
        }
      });
  }

    pdfInitialDownload(item: any) {
        if (item !== null && item.category === 'I') {
            this.initialdeterminationdata = item;
            this.displayinitialPDF = true;
        } else {
            this.displayinitialPDF = false;
        }
    }

    downloadWorksheet(item:any) {
        const modal = {
            method: 'post',
            where: {
                documenttemplatekey: ['adoptioneligibilityform'],
                status: 'fostercare',
                removalId: this.removalid,
                clientId: Number(this.client_id),
                eligibilityId: item.eligibility_period_id,
                // removalId: this.removalid,
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
                link.download = `adoptioneligibilityform.pdf`;
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            });
    }

  showSupervisorList(periodinfo:any) {
      this.submitForApprovalRemark = '';
      this.period = periodinfo.category;
      this.eligibilityPeriodId = periodinfo.eligibility_period_id;
      this.progressNoteId = periodinfo.progressnoteid ? periodinfo.progressnoteid : this.getpreviousnarrativedetails(this.period);
      this.displayprogressnote = periodinfo.ivenarrativesection;
      this.getNarrative(this.client_id, this.progressNoteId, false, this.displayprogressnote);
      this.sendforApprovalForNarrative = true;
      this.editnarrative = periodinfo.isParent;
      (<any>$(this.narrativesavepopupid)).modal('show');
  }

    updateNarrativeInformation(periodinfo:any, toApprove:any) {
        this.period = periodinfo.category;
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
            this.progressNote.entitytype = 'IVEADOP';
            this.addNarrativeUpdateApiFn();
            (<any>$(this.narrativesavepopupid)).modal('hide');
            if(this.selectedPeriodInfo) {
              this.ApproveReject('APPROVED', this.selectedPeriodInfo.approvalid, this.selectedPeriodInfo.category)
            }
            if (this.sendforApprovalForNarrative) {
                this.addUpdateNarrativeSendAppFn();
            }
        } else {
            this._alertService.error('Please add Narrative to proceed.');
        }

    }

  private addNarrativeUpdateApiFn() {
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
  }

  private addUpdateNarrativeSendAppFn() {
    this.titleIVeService.getUsersList().subscribe(result => {
      if (this.rolename == AppConstants.ROLES.TITLE_IVE_ANALYST) {
        this.getUsersList = result.data.filter(user => (user.rolecode === AppConstants.ROLES.TITLE_IVE_Quality_Assurance || user.rolecode === AppConstants.ROLES.TITLE_IVE_ADMINISTRATOR));
      } else {
        this.getUsersList = result.data.filter(user => user.rolecode === AppConstants.ROLES.TITLE_IVE_SUPERVISOR);
      }
    });
    (<any>$('#assignsupervisor')).modal('show');
  }

    getpreviousnarrativedetails(periodid:any) {
        const lastnarrativedetails:any[] = [];
        if (this.adoptionAuditList && this.adoptionAuditList.length > 0 ) {
            this.adoptionAuditList.forEach((element:any) => {
                if (periodid === element.category) {
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
                    entitytype: 'IVEADOP'},
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

  selectPerson(item:any) {
    this.selectedPerson = item;
  }

  RejectDetermination(approvalid:any, sqnm_sw:any){
    this.approvalid = approvalid;
    this.sqnm_sw = sqnm_sw;
    (<any>$('#rejectcomment')).modal('show');
  }

  sendForApproval() {
    if (this.selectedPerson) {
      this._commonHttpService.create(
        {
          'where': {
            'clientid': this.client_id,
            'removalid': this.removalid,
            'status': '{68}',
            'eventType': 'Adoption',
            "sqnm_sw": this.period
          },
            'page': 1,
            'limit' : 10
        },
        'titleive/ive/approval-status'
      ).subscribe(response => {
        if (response && response.data && response.data.length > 0) {
          let reviewperiodfornotification;
          if (this.period === 'I') {
              reviewperiodfornotification = 'Initial';
          } else {
              reviewperiodfornotification = 'Redetermination';
          }
          const params = {
            "assignedtoid": this.selectedPerson.userid,
            "eventcode": "ABLR",
            "status": "SplReview",
            "notifymsg": 'Adoption Determination for ' + reviewperiodfornotification + ' '  + this.client_id + ' was sent for review',
            "routeddescription": "route",
            "comments": 'Request for Review - ' + this.submitForApprovalRemark,
            "adoptionbreakthelinkid": response.data[0].sp_ive_status_approval,
            "signText": "Signed",
            "touserrole": this.selectedPerson.rolecode,
            "userprofilerole": this.rolename
          }
          this.routingUpdate(params, 'Review');
        }
      },
        (error) => {
          this._alertService.error('Unable to process');
          return false;
        }
      );
    } else {
      this._alertService.error('Select a Supervisor');
    }
  }


  ApproveReject(status:any, approvalid:any, sqnm_sw:any) {
      let approvalRejectComments :string= '';
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
    (<any>$('#rejectcomment')).modal('hide');
    this._commonHttpService.create(
      {
        'where': {
          'approval_id': this.approvalid,
          'approval_status': status,
          'placement_type': 'Adoption',
          'approveduser': this.approvalusername ? this.approvalusername : null
        },
          'page': 1,
          'limit' : 10
      },
      'titleive/ive/ivespv-approval'
    ).subscribe(response => {
      if (response && response.data && response.data.length > 0) {
        let reviewperiodfornotification;
        if (this.sqnm_sw === 'I') {
          reviewperiodfornotification = 'Initial';
        } else {
            reviewperiodfornotification = 'Redetermination';
        }
        const params = {
          'eventcode': 'ABLR',
          'status': approvalRejectStatus,
          'notifymsg': 'Adoption Determination for ' + reviewperiodfornotification + ' ' + this.client_id + ' was ' + status,
          'routeddescription': 'route',
          'comments': approvalRejectComments,
          'adoptionbreakthelinkid': this.approvalid,
          'signText': 'Signed',
          'servicecaseid': this.id,
          'userprofilerole': this.rolename,
          }
        this.routingUpdate(params, status);
        this.approvalid = null;
        this.submitForApprovalRemark = '';
        this.selectedPeriodInfo = null;
      }
    },
      (error) => {
        this._alertService.error('Unable to process');
        return false;
      }
    );

  }


  adoptionerrors(item:any, logtype:any) {
    this.adoptionmessages = null;
    this.adoptionwarnings = null;
    this.selectedItem = item;
    this.showSnapshot = false;
    this._commonHttpService.getById(item.eligibility_period_id, 'iveadoption/adoption/audit-messages').subscribe(
        (response: any) => {
          this.adoptionmessages = [];
          this.adoptionwarnings = [];
          this.warningdate = item.insertedon;
            if (response && response.data && response.data.length > 0) {
                if (item.adoptioneligibilitystatus === 'Eligible Reimbursable') {
                    response.data = response.data.filter((a:any) => a.severity !== 'Warning');
                    this.adoptionmessages = response.data;
                } else {
                    this.adoptionmessages = response.data;
                }
                    this.adoptionmessages = response.data;
                    for (const adoptionwarning of response.data) {
                        this.selectedItemSnapshot = adoptionwarning.pagesnapshot;
                        if (adoptionwarning.severity === 'Warning') {
                            this.adoptionwarnings.push(adoptionwarning);
                        }
                    }
            }

            if (logtype === 'W') {
              this.adoptionmessages = null;
            }

            if (logtype === 'L') {
                this.adoptionwarnings = null;
            }

        },
        (error) => {
          return false;
        }
      );
}

  routingUpdate(params:any, status:any) {
    this._commonHttpService.create(
      {
        'where': params
      },
      'titleive/ive/routingUpdate'
    ).subscribe(response => {
      this.eligibilityDetails();
      (<any>$('#assignsupervisor')).modal('hide');
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


}
