import { Component, OnInit, Injector } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import jsPDF from 'jspdf';
import { AppUser } from '../../../../../../@core/entities/authDataModel';
import { DynamicObject, PaginationRequest, PaginationInfo } from '../../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import { AlertService } from '../../../../../../@core/services/alert.service';
import { AuthService } from '../../../../../../@core/services/auth.service';
import { CommonHttpService } from '../../../../../../@core/services/common-http.service';
import { DataStoreService } from '../../../../../../@core/services/data-store.service';
import { Agreement, GapAgreement, Gapagreementrate, GapDetails, Placement, RouteToSupervisor } from '../../_entities/placement.model';
import { PlacementGapService } from '../placement-gap.service';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { SessionStorageService, CommonDropdownsService } from '../../../../../../@core/services';
import moment from 'moment';
import { NgxfUploaderService } from 'ngxf-uploader';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { ServiceCasePlacementsService } from '../../../service-case-placements/service-case-placements.service';
import { FinanceService } from '../../../../../finance/finance.service';
import { Html2CanvasService } from '../../../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';
declare const $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'rate',
    templateUrl: './rate.component.html',
    styleUrls: ['./rate.component.scss'],
    standalone: false
})
export class RateComponent implements OnInit {
    approvalStatusForm!: FormGroup;
    agreementRateForm!: FormGroup;
    placement!: Placement;
    disClosure!: GapDetails;
    submitStatus!: RouteToSupervisor;
    agreementList: Agreement = new Agreement();
    id!: string;
    getAgreementStartDate: any;
    disableSendForApprovalBtn: any;
    getAgreementEndDate: any;
    daNumber!: string;
    roleId!: AppUser;
    currentUrl!: string;
    rateExceeded: boolean = true;
    uploadedFile: any = [];
    isSupervisor = false;
    isExistRecord = false;
    isApproved = false;
    agreement: GapAgreement = new GapAgreement();
    maxApprovalDate = new Date();
    deleteAttachmentIndex!: number;
    isEnableComments = false;
    gapAlertMessage!: string;
    showSSAApprovalDate = false;
    isShowAgreementForm = false;
    isShowRateForm = false;
    rateApprovalInfo: any;
    selectedRate!: Gapagreementrate;
    updateGapAgreementRateId: any;
    updateGapProviderId: any = null;
    newBtnDisabled!: boolean;
    agreementDetail: any;
    agreementRate: any;
    store: DynamicObject;
    token: any;
    placementAgreementRateId: any;
    showRateOverride!: boolean;
    showRateApprovalStatus!: boolean;
    courtStartdt: boolean = false;
    rateAction!: string;
    guardianOneID: any;
    guardainTwoId: any;
    guardianoneprovidername: any;
    guardiantwoprovidername: any;
    guardianOneDob: any;
    guardianTwoDob: any;
    selectedPersonID: any;
    childHasActivePlacement!: boolean;
    iscaseworker!: boolean;
    childdob!: Date;
    paginationInfo: PaginationInfo  = new PaginationInfo();
    pageInfo: PaginationInfo  = new PaginationInfo();
    changehistory = [];
    adjustment!: any[];
    approvalCode: any;
    overpayments!: any[];
    placmentDetails: any;
    providerDetails: any;
    reportedChild: any;
    isSubmitted!: boolean;
    gapAlternateID: any;
    annualReviewList: any;
    agreementenddate: any;
    agreementStartDate: any;
    isEnddateedited = 'no';
    isStartDateEdited = false;
    isedited!: boolean;
    agreementrateenddate: any;
    isRateEndDateEdited = 'no';
    isAgreementApproved = false;
    childInActiveSubsidy = false;
    maxOverrideAmount: any;
    mandatoryfieldcheck!: boolean;
    currEndDate!: Date;
    gapplacementpopupid = '#gap-placement';
    caseworkerpageurl = '/pages/case-worker/';

    private route: ActivatedRoute;
    private _dataStoreService: DataStoreService;
    private _formBuilder: FormBuilder;
    private _commonHttpService: CommonHttpService;
    private _alertService: AlertService;
    private _authService: AuthService;
    private _route: Router;
    private _session: SessionStorageService;
    private _placementService: PlacementGapService;
    private _uploadService: NgxfUploaderService;
    private _scPlacementService: ServiceCasePlacementsService;
    private _commonddservice: CommonDropdownsService;
    private _financeService: FinanceService;

    constructor(private injector : Injector,private html2canvas:Html2CanvasService){
        this.route = injector.get<ActivatedRoute>(ActivatedRoute);
        this._dataStoreService = injector.get<DataStoreService>(DataStoreService);
        this._formBuilder = injector.get<FormBuilder>(FormBuilder);
        this._commonHttpService = injector.get<CommonHttpService>(CommonHttpService);
        this._alertService = injector.get<AlertService>(AlertService);
        this._authService = injector.get<AuthService>(AuthService);
        this._route = injector.get<Router>(Router);
        this._session = injector.get<SessionStorageService>(SessionStorageService);
        this._placementService = injector.get<PlacementGapService>(PlacementGapService);
        this._uploadService = injector.get<NgxfUploaderService>(NgxfUploaderService);
        this._scPlacementService = injector.get<ServiceCasePlacementsService>(ServiceCasePlacementsService);
        this._commonddservice = injector.get<CommonDropdownsService>(CommonDropdownsService);
        this._financeService = injector.get<FinanceService>(FinanceService);
        this.store = this._dataStoreService.getCurrentStore();
    }

    ngOnInit() {
        this._placementService.checkDataAvailability();
        this.roleId = this._authService.getCurrentUser();
        this.iscaseworker = this._authService.selectedRoleIs('field');
        if (this.roleId.role.name === 'apcs') {
            this.isSupervisor = true;
            this.placementAgreementRateId = this._session.getItem('Placement-Agreement-Rate-Id');
            this.approvalCode = this._session.getItem(CASE_STORE_CONSTANTS.APPROVAL_EVENT_CODE);
            const ppid = this._session.getItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID);
            this._session.setItem('Placement-Agreement-Rate-Id', null);
            this._session.setItem(CASE_STORE_CONSTANTS.APPROVAL_EVENT_CODE, null);
            if (this.approvalCode === 'GAAR') {
                this.getPageforSupervisor();
            } else if (ppid) {
                this.getPage(ppid);
            }
        }
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.token = this._authService.getCurrentUser();
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        if (this.store['placement_child']) {
            this.placement = this.store['placement_child'];
            this.getPage(null);
        }
        this.agreementInitialform();
    }

    agreementInitialform() {
        this.agreementRateForm = this._formBuilder.group({
            providerid: [''],
            startdate: [''],
            enddate: [''],
            ratestartdate: [''],
            minratestartdate: [''],
            rateenddate: [''],
            oldenddate: [null],
            maxrateenddate: [''],
            rateapprovaldate: [null],
            updatedon: [null],
            ssaapprovaldate: [null],
            paymentamout: [''],
            negotiateddate: [null],
            isoverride: [null],
            notes: [''],
            status: [''],
            paymenttypekey: [{ value: 'Monthly Assistance', disabled: true }],
            gapagreementrateid: [null],
            gapagreementid: [null]
        });
        this.approvalStatusForm = this._formBuilder.group({
            routingstatus: [''],
            comments: ['']
        });
    }   

    getPageforSupervisor() {


        this._commonHttpService
        .getArrayList(
            {
                page: 1,
                limit: 10,
               where: {
                 objectid: this.placementAgreementRateId,
                 objecttype: 'agreement'
               },
               method: 'get'
            },
            'gapagreement/list?filter'
        )
        .subscribe(res => {
            if (res && (res instanceof Array)) {
                this.agreementDetail = res[0];
            }
        });

    }

    generatePDF_html() {
        const doc = new jsPDF('p', 'mm', 'a4');
        const agreementRateFormData: any = document.getElementById('agreement-Rate-Form');
        this.html2canvas.capture(agreementRateFormData).then(function(
            canvas
        ) {
            const imgData = canvas.toDataURL('image/png');
            const pageHeight = 300;
            const imgWidth = 205;
            const imgHeight = (canvas.height * imgWidth) / canvas.width;
            let heightLeft = imgHeight;
            let position = 0;
    
            doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
            heightLeft -= pageHeight;
    
            while (heightLeft >= 0) {
                position = heightLeft - imgHeight;
                doc.addPage();
                doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
                heightLeft -= pageHeight;
            }
    
            doc.save('GAP-rate.pdf');
        });
      }

      generatePDF() { 
        const req = {
            ...this.store  
        };
  
        const payload = {
            method: 'post',
            count: -1,
            page: 1,
            limit: 20,
            where: req,
            documntkey: [
                    'gapagreementrate'
                ]
          };
  
        this._commonHttpService.create(payload, 'gapapplication/getgappdftoprint').subscribe(
            response => {
                if (response) {
                    setTimeout(() => {
                        window.open(response.data.documentpath);
                    }, 2000);
                } else {
                    this._alertService.error('Error in processing, please try again later.');
                }
        });
   
    }

    private getAgreement(gapId: any) {
        const storedgapid = this._placementService.getGapId();
        this._commonHttpService
            .getArrayList(
                {
                    method: 'get',
                    page: 1,
                    limit: 10,
                    where: { gapid: (storedgapid) ? storedgapid : gapId }
                },
                'gapagreement/list?filter'
            )
            .subscribe(res => {
                if (res && (res instanceof Array)) {
                    this.agreementDetail = res[0];
                    this.agreementRate = this.agreementDetail.agreementrate;
                    this.getAgreementEndDate = this.agreementDetail.enddate;
                    this.getAgreementStartDate = this.agreementDetail.startdate;
                    if (!this.agreementDetail.startdate){
                        this.getCourtInformation();
                    }
                    this.agreementRateForm.patchValue({
                        gapagreementid: this.agreementDetail.gapagreementid,
                    });
                    this.patchAgreement(this.agreementDetail);
                    if (res[0].routingstatus !== 'Approved' && res[0].routingstatus !== 'Review'  ) {
                      this.gapAlertMessage = 'Please complete Gap Agreement';
                      ($(this.gapplacementpopupid)).modal('show');
                    }
                     else if (!res[0].iscomprehensivehomestudy || !res[0].iscgawardedcustody || !res[0].isplacementenddate) {
                        this.gapAlertMessage = 'Please complete Closing Checklist';
                        ($(this.gapplacementpopupid)).modal('show');
                    }
                } else {
                   this.isShowAgreementForm = true;
                    this.isShowRateForm = true;
                    const startdate = new Date();
                    const enddate = new Date();
                    enddate.setFullYear(enddate.getFullYear() + 1);
                    enddate.setDate(enddate.getDate() - 1);
                    this.agreementRateForm.patchValue({
                        ratestartdate: startdate,
                       minratestartdate: startdate,
                       rateenddate: enddate,
                       maxrateenddate: enddate
                    });
                    this.gapAlertMessage = 'Please complete Gap Agreement';
                    ($(this.gapplacementpopupid)).modal('show');
                }
            });
    }


    ratedatechange() {
      
/*Logic / Functional Requirement:
Not more than $887 for Children under the age of 11 and below
Not above $902 for children 12 and Older.

Prince George and Charles County have different Foster care Board Rate as below,

Not more than $927 for Children under the age of 11 and below
Not above $942 for children 12 and Older. 
*/
      // If negotiated date is not entered then calculating the age with current age
      const selectedDate = this.agreementRateForm.getRawValue().negotiateddate ? new Date(this.agreementRateForm.getRawValue().negotiateddate) : new Date();
       
       const dob = moment(this.agreementDetail.childdob);
       const ageAt11 = dob.add(11, 'years').toDate();
        if (this.agreementDetail.countydetails === 'c81be790-a79d-40ac-a38d-abd4dd5a81f6' || this.agreementDetail.countydetails === '58bac299-69ce-4cd2-8e9c-2773524050db') {
            if (selectedDate > ageAt11) {
                this.maxOverrideAmount = '942';
            } else {
                this.maxOverrideAmount = '927'
            }
        }
        else {
            if (selectedDate > ageAt11) {
                this.maxOverrideAmount = '902';
            } else {
                this.maxOverrideAmount = '887'
            }
        }
    }



    getPage(permanencplanid: any) {
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: {
                        intakeserviceid: this.id,
                        permanencyplanid: (() => {
                            if (permanencplanid) {
                                return permanencplanid;
                            }
                            return this.placement.permanencyplanid;
                          })()
                    },
                    method: 'get'
                }),
                'gapdisclosure/getguardianship' + '?filter'
            )
            .subscribe(res => {
                if (res?.data?.length>0) {
                    this.disClosure = res.data[0];
                    this.patchGuardians(res.data[0]?.guardianoneproviderid);
                    this.guardianOneID = res.data[0]?.guardianoneproviderid
                    this.guardainTwoId = res.data[0]?.guardiantwoproviderid;
                    this.guardianoneprovidername = res.data[0]?.guardianoneprovidername;
                    this.getReviews(res.data[0]?.gapid);
                    this.selectedPersonID = res.data[0]?.personid;
                    this.guardiantwoprovidername =  res.data[0]?.guardiantwoprovidername;
                    this.guardianOneDob = moment(res.data[0]?.one_dob_dt).format('MM/DD/YYYY');
                    this.guardianTwoDob = moment(res.data[0]?.two_dob_dt).format('MM/DD/YYYY');
                    if(res.data[0]?.gapapplication[0]?.routingstatus === 'Approved') {
                          this.getAgreement(res.data[0].gapapplication[0].gapid);
                          this._placementService.setGapId(res.data[0].gapapplication[0].gapid);
                    } else if (!res.data[0]?.gapdisclosure || res.data[0]?.gapdisclosure[0]?.routingstatus !== 'Approved') {
                        this.gapAlertMessage = 'Please complete Disclosure Checklist';
                        ($(this.gapplacementpopupid)).modal('show');
                    }
                    else {
                        this.gapAlertMessage = 'Please complete Gap Application';
                         ($(this.gapplacementpopupid)).modal('show');
                    }
                  
                  
                } else {
                   this.gapAlertMessage = 'Please complete disclosure checklist';
                   ($(this.gapplacementpopupid)).modal('show');
                }
            });
    }


    patchGuardians(provider_id: any) {
        this._commonHttpService.getArrayList(
          {
            where: { provider_id: provider_id },
            method: 'get'
          },
          'tb_provider/getproviderguardians?filter'
        ).subscribe(res => {
          if (res[0]) {
            const getproviderguardians = res[0].getadoptiveparents;
            if (getproviderguardians.length) {
               const guardiandetails = getproviderguardians[0];
               this.guardianOneDob = guardiandetails.adoptiveparent1dob ? guardiandetails.adoptiveparent1dob  : null ;
               this.guardianTwoDob = guardiandetails.adoptiveparent2dob ? guardiandetails.adoptiveparent2dob : null; 
               if(!this.guardainTwoId) {
                this.guardainTwoId = guardiandetails.provider2id;
               }                
            }
          }
        });
      }
  

    getReviews(gapid: any) {
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: {
                        gapid: gapid
                    },
                    method: 'get'
                }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Gap.AnnualReview + '?filter'
            ).subscribe((resp) => {
                this.annualReviewList = resp;
            });
    }

    getCourtInformation() {
        const persondetails =  this._dataStoreService.getData('placed_child');
          this._commonHttpService
              .getSingle(
                  {
                      where: {
                          objectid: this.id,
                          objecttype:'servicecase'
                      },
                      method: 'get'
                  },
                  CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.GetCourtOrderUrl + '?filter'
              ).subscribe(response => {
                if (response && response.length) {
                  const filterPerson = response.filter((element: { personid: any; }) => element.personid == persondetails.personid);
                  filterPerson.forEach((element: any) => {
                    if(element.hearingoutcome && element.hearingoutcome.length) {  
                       element.hearingoutcome.forEach((el: { hearingoutcometypekey: string; }) => {
                              if (el.hearingoutcometypekey === 'CUSGUA' && element.courtorderdate) {
                                this.getAgreementStartDate =  new Date(element.courtorderdate);
                                this.agreementDetail.startdate = element.courtorderdate;
                                this.courtStartdt = true;
                              } 
                           });
                        }
                    });
                }
            });
      }

    rateenddateedit() {
        this.conditionValidation();
        if (this.isEnddateedited === 'no' && this.rateAction === 'Update') {
            const enddate = this.agreementRateForm.getRawValue().rateenddate;
            const newenddate = new Date(enddate);
            const currEnddate = new Date(this.agreementRateForm.getRawValue().oldenddate);
            this.currEndDate = currEnddate;
            if (newenddate && currEnddate) {
                newenddate.setHours(0, 0, 0, 0);
                currEnddate.setHours(0, 0, 0, 0);
                this.isRateEndDateEdited = (newenddate.valueOf() === currEnddate.valueOf()) ? 'no' : 'yes';
            }
        } 
    }


    ratestartdatechange(force?: boolean) {
        let startdate = this.agreementRateForm.getRawValue().ratestartdate;
        const enddate = this.agreementRateForm.getRawValue().rateenddate;
        startdate = new Date(startdate);
        const agenddate = this.agreementDetail.enddate;
        if(new Date(startdate).setHours(0,0,0,0) > new Date(agenddate).setHours(0,0,0,0)) {
            this.isShowRateForm = false;
            this._alertService.error("Agreement Rate start date should not be greater than agreement end date.");
            return;
        }
        startdate.setFullYear(startdate.getFullYear() + 1);
        startdate.setDate(startdate.getDate() - 1);
        let upcomingReviewDate, upcomingReview, completedReview, completedReviewDate;
        if (this.annualReviewList && this.annualReviewList.length) {
          upcomingReview = this.annualReviewList.filter((review: { status: string; }) => review.status === 'Review');
          completedReview = this.annualReviewList.filter((review: { status: string; }) => review.status === 'Approved');
          upcomingReviewDate = upcomingReview[0]?.reviewdate;
          completedReviewDate = completedReview[completedReview?.length - 1]?.reviewdate;
        }
        if (!upcomingReviewDate && !completedReviewDate) {
          let agstartdate = this?.agreementDetail?.startdate;
          agstartdate = new Date(agstartdate);
          agstartdate.setFullYear(agstartdate.getFullYear() + 1);
          agstartdate.setDate(agstartdate.getDate() - 1);
        }
        const rateEndDate = startdate && new Date(startdate).setHours(0,0,0,0) < new Date(agenddate).setHours(0,0,0,0) ? startdate : agenddate;
        this.agreementRateForm.patchValue({
            rateenddate: (() => {
                if (force) {
                    return rateEndDate;
                }
                if (enddate) {
                    return enddate;
                }
                return rateEndDate;
              })(),
            maxrateenddate: rateEndDate,
        });
        this.rateenddateChange();
    }

    rateenddateChange() {
        const startdate = this.agreementRateForm.getRawValue().ratestartdate;
        const enddate = this.agreementRateForm.getRawValue().rateenddate;
        let upcomingReviewDate, upcomingReview, completedReview, completedReviewDate;
        if (this?.annualReviewList?.length>0) {
          upcomingReview = this.annualReviewList.filter((review: { status: string; }) => review.status === 'Review');
          completedReview = this.annualReviewList.filter((review: { status: string; }) => review.status === 'Approved');
          upcomingReviewDate = upcomingReview[0]?.reviewdate;
          completedReviewDate = completedReview[completedReview?.length - 1]?.reviewdate;
        }
        if (!upcomingReviewDate && !completedReviewDate) {
          let agstartdate = this?.agreementDetail?.startdate;
          agstartdate = new Date(agstartdate);
          agstartdate.setFullYear(agstartdate.getFullYear() + 1);
          agstartdate.setDate(agstartdate.getDate() - 1);
          upcomingReviewDate = agstartdate;
        } else if (!upcomingReviewDate && completedReviewDate) {
          let cmstartdate;
          cmstartdate = completedReviewDate;
          cmstartdate = new Date(cmstartdate);
          cmstartdate.setFullYear(cmstartdate.getFullYear() + 1);
          cmstartdate.setDate(cmstartdate.getDate() - 1);
          upcomingReviewDate = cmstartdate;
        }
        if ( new Date(startdate) < new Date(upcomingReviewDate)) {

          this.agreementRateForm.patchValue({
            rateenddate: enddate && new Date(enddate) < new Date(upcomingReviewDate) ? new Date(enddate) : upcomingReviewDate,
          });
        } else {
          this.agreementRateForm.patchValue({
            rateenddate: null,
          });
         setTimeout(() => {
           this.isShowRateForm = false;
          ($('#annual-review-validation')).modal('show'); } , 500 );
        }
    }



    conditionValidation(): any {
        if(!this.isAgreementApproved){
          if ( this.agreementRateForm.getRawValue().ratestartdate && this.agreementRateForm.value.rateenddate) {
            let date = this.agreementRateForm.getRawValue().ratestartdate;
            date = new Date(date);
            date.setFullYear(date.getFullYear() + 1);
            date.setDate(date.getDate() - 1);
            this.agreementRateForm.patchValue({
                maxrateenddate: date
            });
            if(new Date(this.agreementRateForm.value.ratestartdate).setHours(0,0,0,0) > new Date(this.getAgreementEndDate).setHours(0,0,0,0)){
                this._alertService.error('Rate Start date cannot be beyond Agreement End Date');
                return false;
            }
            if(new Date(this.agreementRateForm.value.rateenddate).setHours(0,0,0,0) > new Date(this.getAgreementEndDate).setHours(0,0,0,0)){
                this._alertService.error('Rate End date cannot be beyond Agreement End Date');
                return false;
            }
            if(new Date(this.agreementRateForm.value.rateenddate).setHours(0,0,0,0) > new Date(date).setHours(0,0,0,0)) {
                this._alertService.error('Rate end date cannot be greater than 364 days from rate begin date');
                this.agreementRateForm.patchValue({
                    rateenddate: new Date(date)
                });
                return false;
            }
            else if(new Date(this.agreementRateForm.value.rateenddate).setHours(0,0,0,0) == new Date( this.currEndDate).setHours(0,0,0,0)){
                this._alertService.error('Selected Date cannot be same as the last selected end date ')
                return false;
            }
        }
        return true;
      }
    }

    rejectComments(status: any) {
        if (status === 'Rejected') {
            this.isEnableComments = true;
        } else {
            this.isEnableComments = false;
            this.approvalStatusForm.patchValue({ comments: '' });
        }
    }

    navigateTo() {
        if (this.disClosure) {
            const gapdisclosure = this.disClosure.gapdisclosure;
            const gapagreement = this.agreementDetail;
            const gapannualreview = this.disClosure.gapannualreview;
            ($(this.gapplacementpopupid)).modal('hide');
            if (!gapdisclosure) {
                this.currentUrl = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/placement/placement-gap/disclosure-checklist';
            } else if (!gapagreement) {
                this.currentUrl = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/placement/placement-gap/agreement';
            } 
            else if (!gapagreement.iscomprehensivehomestudy || !gapagreement.iscgawardedcustody || !gapagreement.isplacementenddate) {
                this.currentUrl = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/placement/placement-gap/finalization-checklist';
            } 
            else if (!gapannualreview) {
                this.currentUrl = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/placement/placement-gap/annual-reviews';
            }
        } else {
            this.currentUrl = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/placement/placement-gap/disclosure-checklist';
        }
        this._route.navigate([this.currentUrl]);
    }


    rateLimit() {
        const rateInput = this.agreementRateForm.getRawValue();
        this. mandatoryfieldcheck = true;
        if(this.agreementRateForm.valid){
        if(rateInput.paymentamout > 2000 && this.rateExceeded) {
           ($('#rate-exceeded')).modal('show');
            return true;
        } else {
           this.ratedatechange();
           this.addAgreement();
        }    
    }
    else{
        this._alertService.warn("Please fill required fields")
    }
    }

    saveGapRate() {
        this.addAgreement();
    }

    _courtstartdt(courtStartdt?: any) {
        if (courtStartdt) {
            return true;
        }
    }

    _startdate(startdate?: any) {
        if (!startdate) {
            return this?.getAgreementStartDate;
        }
    }	

    _enddate(enddate?: any) {
        if (!enddate) {
            return this?.getAgreementEndDate;
        }
    }
    
    disableBtn()
    {
      this.disableSendForApprovalBtn = true;
    }	

    _isagreementedit(isStartDateEdited?: any) {
        if (isStartDateEdited) {
            return 'no';
        }
        return this?.isRateEndDateEdited;
    }

    addAgreement() {


        const agreeement = this.agreementRateForm.getRawValue();
// Max Override Amount is set to 950$ will be updated Once we get the correct amount from SSA
        if (agreeement?.paymentamout > this?.maxOverrideAmount) {
            this.showRateOverride = true;
            this.showSSAApprovalDate = true;
            if (!agreeement.isoverride) {
                this._alertService.error('The Negotiated Amount is above the Foster Care Board Rate. Please select Rate Override and proceed further.!');
                return false;
            } 
            if (!agreeement.ssaapprovaldate) {
                this._alertService.error('Enter SSA Approval Date');
                return false;
            }
        }
        if ((this.agreementRateForm.valid && this.agreementRateForm.enabled) || this.agreementRateForm.disabled) {
            const validation = this.conditionValidation();
            this.agreement = Object.assign(
                {
                    servicecaseid: this.id,
                },
                this.agreementDetail,agreeement
            );
            const ratedetails = this.agreementRateForm.getRawValue();
            const agrementRate = {
                providerid: (() => {
                    if (this?.updateGapProviderId) {
                        return this.updateGapProviderId;
                    }
                    return this?.disClosure?.guardianoneproviderid;
                  })(),
                editGapAgreementRate: this?.updateGapAgreementRateId,
                startdate: ratedetails?.ratestartdate,
                enddate: ratedetails?.rateenddate,
                rateapprovaldate: ratedetails?.rateapprovaldate,
                paymentamout: ratedetails?.paymentamout,
                isoverride: ratedetails?.isoverride,
                ssaapprovaldate: ratedetails?.ssaapprovaldate,
                paymenttypekey: this._setPaymentTypeKey(ratedetails?.paymenttypekey),
                notes: ratedetails?.notes,
                negotiateddate: ratedetails?.negotiateddate,
                status: 'Review'
            };
            this.agreement.attachment = this?.uploadedFile;
            this.agreement.gapagreementrate = (Array.isArray(this?.agreement?.gapagreementrate)) ? this?.agreement?.gapagreementrate : [];
            this?.agreement?.gapagreementrate?.push(agrementRate);
            const poppedRateData = this.agreement?.gapagreementrate?.pop();
            if (poppedRateData) {
                this.agreement.gapagreementrate = [poppedRateData];
            }
            this.agreement.status = 'Review';
            this.agreement.courtstartdt = this._courtstartdt(this?.courtStartdt);
            this.agreement.startdate = this._startdate(this?.agreement?.startdate);
            this.agreement.enddate = this._enddate(this?.agreement?.enddate);	
            this.agreement.isagreementedit = this._isagreementedit(this?.isStartDateEdited); 
            this.agreement['ratestartdate'] = moment(this.agreement['ratestartdate']).format("YYYY-MM-DD'T'HH:mm:ss");
            this.agreement['rateenddate'] = moment(this.agreement['rateenddate']).format("YYYY-MM-DD'T'HH:mm:ss");
            this.agreement['minratestartdate'] = moment(this.agreement['minratestartdate']).format("YYYY-MM-DD'T'HH:mm:ss");
            this.agreement['maxrateenddate'] = moment(this.agreement['maxrateenddate']).format("YYYY-MM-DD'T'HH:mm:ss");
            if (validation) {
                this.disableBtn();
                this.agreement.gapagreementrate = this.agreement.gapagreementrate?.map(item2 =>{
                    return {
                        ...item2,
                        startdate :  moment(item2.startdate).format("YYYY-MM-DD'T'HH:mm:ss"),
                        enddate: moment(item2.enddate).format("YYYY-MM-DD'T'HH:mm:ss")
                    }
                }) ?? [];
                this._commonHttpService.create(this.agreement, 'gapagreementrate/add').subscribe(
                    _res => {
                        this._alertService.success('Rate Submitted for Supervisor Approval');
                        this.getPage(null);
                        this.getAgreement(null);
                        this.isExistRecord = true;
                    },
                    _err => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            }
        }
    }

    _isExistRecord(modal?: any) {
        if (['Approved', 'Rejected'].includes(modal?.routingstatus)) {
            return false;
        }
        return true;
    }

    _isedited(modal?: any) {
        if ((modal.routingstatus === 'Review') && ((modal?.newenddate !== modal?.enddate)||(modal?.newstartdate !== modal?.startdate))) {
            return true;
        }
        return false;
    }

    patchAgreement(modal: any) {
        if (modal) {
            this.agreementList = modal;
            this.agreementenddate = modal?.enddate;
            this.agreementStartDate = modal?.startdate;
            this.newBtnDisabled = true;
            this.isExistRecord = this._isExistRecord(modal);
            this.agreementList.ischildreceivetca = String(this?.agreementList?.ischildreceivetca);
            this.isedited = this._isedited(modal);
            if (this.agreementList.agreementrate && this.agreementList.agreementrate.length > 0) {
                const latestgaprate: any =  this.agreementList && this.agreementList.agreementrate ? this.agreementList.agreementrate[this.agreementList.agreementrate.length - 1] : '';
                this.agreementrateenddate = latestgaprate?.rateenddate;
                const gapRate: any = this.agreementList && this.agreementList.agreementrate ? this.agreementList.agreementrate[0] : '';

                if(gapRate?.status == 'Review'){
                    this.agreementRateForm.disable();
                }
            }
            this.approvalStatusForm.patchValue({
                comments: this?.agreementList?.comments
            });
            if (['Approved', 'Rejected'].includes(this.agreementList?.routingstatus)) {
                const rateList = this?.agreementList['agreementrate'];
                const pending = rateList?.some(item => item?.status === 'Review');
                this.isApproved = (() => {
                    if (pending) { 
                        return false
                    }
                    return true;
                  })();	
                if(this.isApproved) {
                    this.approvalStatusForm.patchValue({
                        routingstatus: this?.agreementList?.routingstatus
                    });
                    this.isSubmitted = true;
                }
                this.rejectComments(this?.agreementList?.routingstatus);
            }
            this.agreementList = Object.assign({});
        }
    }

    routingUpdate() {
        this.isSubmitted = true;
        if(this?.isSupervisor){
            const reviewRateRec = this?.agreementRate?.filter((item: { status: string; }) => item?.status === 'Review');
            this.placementAgreementRateId = reviewRateRec[0]?.gapagreementrateid;
        }
        let comment = '';

        if (this?.approvalStatusForm?.value?.routingstatus === 'Rejected') {
          comment = 'Guardianship Rate Rejected ';
          if(!this?.approvalStatusForm?.value?.comments) {
            this._alertService.error('Enter Comments');
            return false;
          }
        } else if (this?.approvalStatusForm?.value?.routingstatus === 'Approved') {
          comment = 'Guardianship Rate Approved '
        }
        this.submitStatus = Object.assign({
            objectid: this?.placementAgreementRateId,
            eventcode: this?.approvalCode,
            status: this?.approvalStatusForm?.value?.routingstatus,
            comments: this?.approvalStatusForm?.value?.comments,
            notifymsg: comment,
            routeddescription: comment,
            servicecaseid: this.id
        });
        if (this.roleId.role.name === 'apcs' && this.approvalStatusForm.value.routingstatus === '') {
            this.isSubmitted = false;
            return this._alertService.error('Please select review status!');
        } else {
            this._commonHttpService.create(this.submitStatus, 'routing/routingupdate').subscribe(
                _res => {
                    this._alertService.success('Agreement Rate updated successfully!');
                    this.isApproved = true;
                    const ppid = this._session.getItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID);
                    this.getPage(ppid);
                    if (this.approvalStatusForm.value.routingstatus === 'Approved') {
                        this.approvalStatusForm.disable();
                    }
                },
                _err => {
                    this.isSubmitted = false;
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }

    _setagreementRateForm(_status?: any) {
        if (!['New', 'Rejected'].includes(_status)) {    //this restriction to be removed once SSA approves the code change
            this.agreementRateForm.disable();
            this.agreementRateForm.get('rateenddate')?.enable();
            this.agreementRateForm.get('notes')?.enable();
        } else {
            this.agreementRateForm.enable();
            this.agreementRateForm.get('ratestartdate')?.disable();
        }
    }

    _setshowSSAApprovalDate(gapRate?: any){
        if(gapRate?.isoverride) {
            this.showSSAApprovalDate = true;
        }
    }

    _setStartDate(validRates?: any) {
        if (validRates?.length > 1) {
            const lastrate = validRates[validRates.length - 2];
            const startdate = new Date(lastrate.rateenddate);
            startdate.setDate(startdate.getDate() + 1);
            this.agreementRateForm.patchValue({
                minratestartdate: startdate
            });
        } 
    }

    _alertAnnualReviewStatus(_agreementDetail?: any) {
        if (_agreementDetail?.agreementrate?.filter((item: { annualreviewstatus: string; status: string; }) => item?.annualreviewstatus === 'NO' && item?.status !== 'Rejected')?.length) {
            this.isShowRateForm = false;
            this._alertService.error('Annual Review Status Is Pending For Existing Rate');
        } 
    }

    _greementRateFormPatchValue(_agreementDetail?: any) {
        if (_agreementDetail?.agreementrate?.length>0) {
            const validRates = _agreementDetail?.agreementrate?.filter((item: { status: string; }) => item?.status !== 'Rejected');
            if (validRates?.length>0) {
                const length = validRates?.length;
                const lastrate = validRates[length - 1];
                const startdate = new Date(lastrate?.rateenddate);
                startdate.setDate(startdate?.getDate() + 1);
                const enddate = new Date(startdate);
                enddate.setFullYear(enddate?.getFullYear() + 1);
                enddate.setDate(enddate?.getDate() - 1);
                this.agreementRateForm.patchValue({
                    ratestartdate: startdate,
                    minratestartdate: startdate,
                    rateenddate: enddate,
                    maxrateenddate: enddate,
                    gapagreementid: _agreementDetail?.gapagreementid
                });
            }
            if (_agreementDetail?.gapagreementid) {
                this.agreementRateForm.patchValue({
                    gapagreementid: _agreementDetail?.gapagreementid
                });
            } 
        } else {

            const enddate = new Date(_agreementDetail?.startdate);
             enddate.setFullYear(enddate?.getFullYear() + 1);
             enddate.setDate(enddate?.getDate() - 1);
            this.agreementRateForm.patchValue({
                ratestartdate: _agreementDetail?.startdate,
                minratestartdate: _agreementDetail?.startdate,
                rateenddate: enddate,
                maxrateenddate: enddate,
                gapagreementid: _agreementDetail?.gapagreementid
            });
        }
    }

    _setPaymentTypeKey(_paymenttypekey?: any) {
        if(!_paymenttypekey) {
            return 'Monthly Assistance';
        }
        return _paymenttypekey;
    }

    _annualReviewCheck(formatreviewdate: any, formatratedate: any) {
        if (formatreviewdate >= formatratedate) {
            return true;
        }
    }

    _isValid1(approvedRecords: any, annualReviewList: any, annualReviewCheck: any) {
        if((approvedRecords?.length  > annualReviewList?.length) && !annualReviewCheck) {
            return true;
        }
        return false;
    }

    _isValid2(_length: any, _agreementDetail: any) {
        if (!_length) {
            const approvedRecords = _agreementDetail?.agreementrate?.filter((item: { status: string; }) => item?.status === 'Approved');
            if (approvedRecords?.length>0) {
                return true;
            }
        }
        return false;
    }

    selectRate(action: any, gapRate?: any) {
        this.isShowRateForm = true;
        this.rateApprovalInfo = gapRate;
        this._setshowSSAApprovalDate(gapRate);
        switch(action)
        {
            case 'Update':
                this.rateAction = 'Update';
                this.showRateApprovalStatus = true;
                this.showRateOverride = true;
                this.selectedRate = gapRate;
                this.updateGapAgreementRateId = gapRate.gapagreementrateid;
                this.updateGapProviderId = gapRate.provider_id;
                this.agreementRateForm.patchValue(gapRate);
                this.agreementRateForm.patchValue({
                    oldenddate: new Date(gapRate.rateenddate),
                    paymenttypekey: this._setPaymentTypeKey(gapRate?.paymenttypekey)
                });
                 this.ratestartdatechange();
                 this._setStartDate(this?.agreementDetail?.agreementrate?.filter((item: { status: string; }) => item?.status !== 'Rejected'));
                 this._setagreementRateForm(gapRate?.status);
                 break;
            case 'Add':
                this.rateAction = 'Add';
                this.showRateApprovalStatus = false;
                this.showRateOverride = true;
                let annualReviewCheck: any = false;
                if (this?.agreementDetail?.agreementrate?.filter((item: { status: string; }) => item?.status === 'Review')?.length) {
                    this._alertService.error('Approval Status Is Pending For Existing Rate');
                    this.isShowRateForm = false;
                    return;
                }

                const upcomingReview = this?.annualReviewList?.filter((review: { status: string; }) => review?.status === 'Review' );
                  if (upcomingReview?.length>0) {
                    this._alertService.error('Annual Review is Pending');
                    this.isShowRateForm = false;
                    return;
                  }

                const _valid2 = this._isValid2(this.annualReviewList.length, this?.agreementDetail);
                if (_valid2) {
                    this._alertService.error('Please Add Annual Review');
                    this.isShowRateForm = false;
                    return;
                }

                if (this?.annualReviewList?.length>0) {
                    const approvedRecords = this?.agreementDetail?.agreementrate?.filter((item: { status: string; }) => item?.status === 'Approved');
                    const reviewdate = this?.annualReviewList[this?.annualReviewList?.length - 1]?.reviewdate;
                    const ratedate  = approvedRecords[approvedRecords?.length - 1]?.rateenddate;
                    const  formatratedate = moment(ratedate).format('YYYY-MM-DD');
                    const formatreviewdate = moment(reviewdate).format('YYYY-MM-DD'); 
                    // CDM-34670 - To Check Annual Review is available for the selected Rate
                    const cmstartdate = new Date(formatreviewdate);
                    cmstartdate.setFullYear(cmstartdate?.getFullYear() + 1);
                    cmstartdate.setDate(cmstartdate?.getDate() - 1);

                    const agstartdate = new Date(formatratedate);

                    if (cmstartdate < agstartdate) {
                        setTimeout(() => {
                            this.isShowRateForm = false;
                        ($('#annual-review-validation')).modal('show'); } , 500 );
                    this.isShowRateForm = false;
                    return;
                    }
                    annualReviewCheck = this._annualReviewCheck(formatreviewdate, formatratedate);
                    const _valid1 = this._isValid1(approvedRecords, this.annualReviewList, annualReviewCheck);
                    if(_valid1) {
                        this._alertService.error('Please Add Annual Review');
                        this.isShowRateForm = false;
                        return;
                    }
                }
                this._alertAnnualReviewStatus(this?.agreementDetail);
                this.isShowRateForm = true;
                this.selectedRate = Object.assign({}, new Gapagreementrate());
                this.agreementRateForm.reset();
            
                this.agreementRateForm.enable();
                this.agreementRateForm.patchValue({
                    paymenttypekey: 'Monthly Assistance'
                });
                this.agreementRateForm.get('paymenttypekey')?.disable();

                this._greementRateFormPatchValue(this?.agreementDetail);
                this.agreementRateForm.valueChanges.subscribe((item) => {
                    // No content to add or call
                });
                break;
            case 'View':
                this.rateAction = 'View';
                this.showRateApprovalStatus = true;
                this.showRateOverride = true;
                this.selectedRate = gapRate;
                this.agreementRateForm.patchValue(gapRate);
                this.agreementRateForm.patchValue({
                    paymenttypekey: this._setPaymentTypeKey(gapRate?.paymenttypekey)
                });
                this.agreementRateForm.disable();
                break;
            default:
                this.isShowRateForm = false;
                break;
                
        }
    }

    addedittorate() {
        const rateInput = this.agreementRateForm.getRawValue();
        if (rateInput.gapagreementrateid) {
            this.agreementDetail.agreementrate.forEach((element: any) => {
                if (element?.gapagreementrateid === rateInput?.gapagreementrateid) {
                    if (rateInput.status === 'Rejected') {
                        element = rateInput;
                    } else {
                        element.rateenddate = new Date(rateInput.rateenddate);
                        element.oldenddate = rateInput.oldenddate;
                    }
                    element.status = 'Review';
                }
            });
        } else {
            rateInput.providerid = this?.disClosure?.guardianoneproviderid;
            rateInput.status = 'New';
            let exist = false;
            this.agreementDetail.agreementrate = this?.agreementDetail?.agreementrate?.map((item: { status: string; }) => {
                if (item.status === 'New') {
                    exist = true;
                    item = rateInput;
                }
                return item;
            });
            if (!exist) {
                this?.agreementDetail?.agreementrate?.push(rateInput);
            }
        }
        this.isShowRateForm = false;
    }


    fiscalAudit() {
        this._financeService.getChangeHistory(1, this.gapAlternateID, 'gaprate');
    }

}
