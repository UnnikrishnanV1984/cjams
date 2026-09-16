
import {of as observableOf,  Observable } from 'rxjs';

import {map, pluck, share} from 'rxjs/operators';
import { Component, OnInit, Injector } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import jsPDF from 'jspdf';
import { AppUser } from '../../../../../../@core/entities/authDataModel';
import { PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { DataStoreService, SessionStorageService } from '../../../../../../@core/services';
import { AlertService } from '../../../../../../@core/services/alert.service';
import { AuthService } from '../../../../../../@core/services/auth.service';
import { CommonHttpService } from '../../../../../../@core/services/common-http.service';
import { AnnualReview, GapAnnualReview, GapDetails, RouteToSupervisor, Placement } from '../../_entities/placement.model';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { PlacementGapService } from '../placement-gap.service';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { Html2CanvasService } from './../../../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'annual-reviews',
    templateUrl: './annual-reviews.component.html',
    styleUrls: ['./annual-reviews.component.scss'],
    standalone: false
})
export class AnnualReviewsComponent implements OnInit {
    annualReview: GapAnnualReview = new GapAnnualReview();
    id!: string;
    annualReviewGapForm!: FormGroup;
    approvalStatusForm!: FormGroup;
    GapAnnualReview!: GapAnnualReview;
    disClosure!: GapDetails;
    placement!: Placement;
    submitStatus!: RouteToSupervisor;
    isSupervisor = false;
    roleId!: AppUser;
    currentUrl!: string;
    daNumber!: string;
    annualReviewList: AnnualReview = new AnnualReview();
    annualReviewList$!: Observable<any>;
    gapAlertMessage!: string;
    isExistRecord = false;
    isApproved = false;
    isEnableComments = false;
    isInitialized = false;
    isFormDisplay = false;
    isEditReview = false;
    gapannualreviewid!: string;
    gapagreementid: any;
    placementAnnualReviewID: any;
    agreement: any;
    checkApprovedRate: any;
    maxdate: any;
    viewOnly: any;
    store: any;
    displayValidationMessages: boolean = false;
    gapplacementpopupid = '#gap-placement';
    caseworkerpageurl = '/pages/case-worker/';

    private _authService: AuthService;
    private _commonHttpService: CommonHttpService;
    private formBuilder: FormBuilder;
    private route: ActivatedRoute;
    private _dataStoreService: DataStoreService;
    private _alertService: AlertService;
    private _route: Router;
    private _placementService: PlacementGapService;
    private _session: SessionStorageService;

    constructor(private injector : Injector,private html2canvas:Html2CanvasService){
        this._authService = injector.get<AuthService>(AuthService);
        this._commonHttpService = injector.get<CommonHttpService>(CommonHttpService);
        this.formBuilder = injector.get<FormBuilder>(FormBuilder);
        this.route = injector.get<ActivatedRoute>(ActivatedRoute);
        this._dataStoreService = injector.get<DataStoreService>(DataStoreService);
        this._alertService = injector.get<AlertService>(AlertService);
        this._route = injector.get<Router>(Router);
        this._placementService = injector.get<PlacementGapService>(PlacementGapService);
        this._session = injector.get<SessionStorageService>(SessionStorageService);
        this.store = this._dataStoreService.getCurrentStore();
    }

    ngOnInit() {
        this._placementService.checkDataAvailability();
        this.roleId = this._authService.getCurrentUser();
        if (this.roleId.role.name === 'apcs') {
            this.isSupervisor = true;
            this.placementAnnualReviewID = this._session.getItem('Placement-Review-Id');
            if (this.placementAnnualReviewID && this.placementAnnualReviewID !== "null") {
                this.getReviewsforSupervisor();
            }
        }
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        const ppid = this._session.getItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.annualReviewInitialform();
        this.isInitialized = true;
        this._dataStoreService.currentStore.subscribe((store) => {
            if (this.isInitialized && store['placement_child']) {
                this.placement = store['placement_child'];
                if (this.placement) {
                    this.getReviews();
                    this.isInitialized = false;
                    this.getPage(ppid);
                }
            }
        });
        this.getAgreement();
        this.getReviews();
    }


    
    generatePDF_html() {
        const doc = new jsPDF('p', 'mm', 'a4');
        const formIdDataFn: any = document.getElementById('annual-Review-Gap-Form');
        this.html2canvas.capture(formIdDataFn).then(function(
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
    
            doc.save('GAP-annual-reviews.pdf');
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
                    'gapagreementreview'
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

    getReviewsforSupervisor() {

            this._commonHttpService
            .getArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 10,
                    where: {
                        objectid: this.placementAnnualReviewID,
                        objecttype: 'annualreview' },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Gap.AnnualReview + '?filter'
            ).subscribe(
                (resp) => {
                    this.annualReviewList$ = observableOf(resp);
                }
            );

    }

    formAccess(reviewMode: any) {
        if (reviewMode === 0) {
            this.isFormDisplay = true;
            this.isEditReview = false;
            this.formClear();
            this.setReviewDate();
        } else {
            this.isFormDisplay = true;
            this.isEditReview = true;
            this.formClear();
        }
    }
    formClear() {
        this.annualReviewGapForm.reset();
    }
    editAnnualReview(reviewModal: any) {
        this.formAccess(1);
        this.viewOnly = false;
        this.annualReviewGapForm.patchValue(reviewModal);
        this.annualReviewGapForm.markAsPristine();
        this.gapannualreviewid = reviewModal.gapannualreviewid;
    }

    viewAnnualReview(reviewModal: any) {
        this.formAccess(1);
        this.viewOnly = true;
        if(reviewModal?.status === 'Review') {
            this.isApproved = false;
            this._placementAnnualReviewID(this.isSupervisor);
        } else {
            this.isApproved = true;
        }
        this.annualReviewGapForm.patchValue(reviewModal);
        this.gapannualreviewid = reviewModal.gapannualreviewid;
        this.annualReviewGapForm.disable();
    }

    annualReviewInitialform() {
        this.annualReviewGapForm = this.formBuilder.group({
            reviewdate: [null, Validators.required],
            isguardianresponsible: [null],
            isguardiansupportfinance: [null],
            ischildwithguardian: [null],
            ischildattendingschool: [null],
            isdocumentprovided: [null],
            ischildreacheighteen: [null],
            ischilddisability: [null],
            istrainingenrolled: [null],
            isunemployment: [null],
            isformcomplete: [null],
            cgprimarydate: [null, Validators.required],
            cgsecondarydate: [null],
            directorsigndate: [null, Validators.required]
        });

        this.approvalStatusForm = this.formBuilder.group({
            routingstatus: [''],
            comments: ['']
        });
    }
    getReviews() {
        const review = this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: {
                        gapid: this._placementService.getGapId()
                    },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Gap.AnnualReview + '?filter'
            ).pipe(map((resp) => {
                return {data: resp};
            }),share(),);
        this.annualReviewList$ = review.pipe(pluck('data'));
    }
    addEditAnnualReview(annualreview: any, editmode: any) {
        if (this.annualReviewGapForm.invalid) {
            this.displayValidationMessages =true;
            this.annualReviewGapForm.markAllAsTouched();
            return;
        }
        let modal;
        if(this._placementService.getGapId()){
            if (editmode === 0) {
                 modal = Object.assign(
                    {
                        gapid: this._placementService.getGapId(),
                        servicecaseid: this.id,
                        gapagreementid: this.gapagreementid
                    },
                    annualreview
                );
            } else {
                modal = Object.assign(
                    {
                        gapid: this._placementService.getGapId(),
                        servicecaseid: this.id,
                        gapannualreviewid: this.gapannualreviewid
                    },
                    annualreview
                );
            }
            if (this.annualReviewGapForm.valid) {
                this._commonHttpService.create(modal,
                    CaseWorkerUrlConfig.EndPoint.DSDSAction.Gap.AddEditReview).subscribe(
                    (_res) => {
                        this._alertService.success('Annual Review Submitted for supervisor approval');
                        this.getReviews();
                        this.formClear();
                        this.isFormDisplay = false;
                    }
                );
            }
        }
        else {
            this._alertService.error('Gap details are missing, please reopen gap application');
        }
    }

    getPage(permanencplanid: any) {
        const ppid = this.placement.permanencyplanid;
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: {
                        intakeserviceid: this.id,
                        // placementid: this.placement.placement_id,
                        permanencyplanid: (permanencplanid) ? permanencplanid : ppid
                    },
                    method: 'get'
                }),
                'gapdisclosure/getguardianship' + '?filter'
            )
            .subscribe(res => {
                if (res.data && res.data.length) {
                    this.disClosure = res.data[0];
                    if(res.data[0].gapapplication[0].routingstatus === 'Approved') {
                        this.getAgreement();
                          this._placementService.setGapId(res.data[0].gapapplication[0].gapid);
                    } else if (!res.data[0].gapdisclosure || res.data[0].gapdisclosure[0].routingstatus !== 'Approved') {
                        this.gapAlertMessage = 'Please complete Disclosure Checklist';
                        (<any>$(this.gapplacementpopupid)).modal('show');
                    }
                    else {
                        this.gapAlertMessage = 'Please complete Gap Application';
                         (<any>$(this.gapplacementpopupid)).modal('show');
                    }
                } else {
                   this.gapAlertMessage = 'Please complete disclosure checklist';
                   (<any>$(this.gapplacementpopupid)).modal('show');
                }
            });
    }

    rejectComments(status: any) {
        if (status === 'Rejected') {
            this.isEnableComments = true;
        } else {
            this.isEnableComments = false;
            this.approvalStatusForm.patchValue({ comments: '' });
        }
    }

    _placementAnnualReviewID(_isSupervisor?: any) {
        if(_isSupervisor){
            this.annualReviewList$.subscribe( ar => { 
                const reviewAnnualReviw =  ar?.filter( (re: { status: string; }) => { return  re?.status === 'Review';  });
                if(reviewAnnualReviw?.length > 0) {
                    this.placementAnnualReviewID = reviewAnnualReviw[0]?.gapannualreviewid;
                }
            });
        }
    }

    routingUpdate() {
        const comment = 'Annual Review Submitted for review';
        this._placementAnnualReviewID(this.isSupervisor);
        this.submitStatus = Object.assign({
            objectid: this.placementAnnualReviewID ? this.placementAnnualReviewID : '',
            eventcode: 'GAYR',
            status: this.approvalStatusForm.value.routingstatus,
            comments: this.approvalStatusForm.value.comments,
            notifymsg: comment,
            routeddescription: comment,
            servicecaseid: this.id
        });
        if (this.roleId.role.name === 'apcs' && this.approvalStatusForm.value.routingstatus === '') {
            return this._alertService.error('Please select review status!');
        } else {
            this._commonHttpService.create(this.submitStatus, 'routing/routingupdate').subscribe(
                (_res) => {
                    this._alertService.success('Annual Review ' + this.approvalStatusForm.value.routingstatus + ' Successfully!');
                    this.isApproved = true;
                    this.getReviews();
                },
                (_err) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }
    navigateTo() {
        if (this.disClosure) {
            const gapdisclosure = this.disClosure.gapdisclosure;
            const gapagreement = this.disClosure.gapagreement;
            const gapannualreview = this.disClosure.gapannualreview;
            (<any>$(this.gapplacementpopupid)).modal('hide');
            if (!gapdisclosure) {
                this.currentUrl = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/placement/placement-gap/disclosure-checklist';
            } else if (!this.checkApprovedRate){
                this.currentUrl = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/placement/placement-gap/rate';
            } else if (!gapagreement) {
                this.currentUrl = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/placement/placement-gap/agreement';
            } else if (!gapannualreview) {
                this.currentUrl = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/placement/placement-gap/annual-reviews';
            }
        } else {
            this.currentUrl = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/placement/placement-gap/disclosure-checklist';
        }
        this._route.navigate([this.currentUrl]);
    }

    private getAgreement() {
        this._commonHttpService.getArrayList(
            {
                method: 'get',
                page: 1,
                limit: 10,
                where: { gapid: this._placementService.getGapId() }
            },
            'gapagreement/list?filter'
        ).subscribe(res => {
            if (res && (res instanceof Array)) {
                const data = res[0];
                this.gapagreementid = data.gapagreementid;
                this.agreement = data;
                this.checkApprovedRate = false;
                this.handleAgreementrateFn(res);
                if (res[0].routingstatus !== 'Approved' && res[0].routingstatus !== 'Review') {
                    this.gapAlertMessage = 'Please complete Gap Agreement';
                    (<any>$(this.gapplacementpopupid)).modal('show');
                } else if (!res[0].iscomprehensivehomestudy || !res[0].iscgawardedcustody || !res[0].isplacementenddate) {
                    this.gapAlertMessage = 'Please complete Closing Checklist';
                    (<any>$(this.gapplacementpopupid)).modal('show');
                }
            }
        });
    }
    // Assosiated with getAgreement function
    private handleAgreementrateFn(res: any[]) {
        res.forEach(e => {
            if (e.agreementrate && e.agreementrate.length) {
                e.agreementrate.forEach((element: { status: string; }) => {
                    if (element.status == 'Approved') {
                        this.checkApprovedRate = true;
                    }
                });
            }
        });
    }

   setReviewDate() {
        let startdate = this.agreement && this.agreement.startdate ? this.agreement.startdate : null;
        let enddate = this.agreement && this.agreement.enddate ? this.agreement.enddate : null;
        if(startdate) {
        startdate = new Date(startdate);
        startdate.setDate(startdate.getDate() + 364);
        } 
        if(enddate) {
            enddate = new Date(enddate);
        }
        if(enddate < startdate) {
            this.returnToReviewList('Agreement must be active for atleast 364 days to continue adding a new Annual Review.');
            return;
        }
        this.annualReviewList$.subscribe( annualReviewList => { 
        const existingAnnualReviw =  annualReviewList && annualReviewList.length ? annualReviewList.filter((review: { status: string; }) => { return  review.status === 'Approved';  }) : [];
        
        if(this.handleIfAgreementrateFn(existingAnnualReviw, startdate, enddate)) {
            return;
        }
        
        });
    }
    // Assosiated with setagreementRate function
    private handleIfAgreementrateFn(existingAnnualReviw: any, startdate: any, enddate: any) {
        if(existingAnnualReviw && existingAnnualReviw.length) {
            startdate =  existingAnnualReviw[existingAnnualReviw.length-1].reviewdate;
            startdate = new Date(startdate);
            startdate.setDate(startdate.getDate() + 364);
        }
        this.annualReviewGapForm.patchValue({ reviewdate : startdate <= enddate ? startdate : enddate });
        // CDM-44645 - To Disable future date selection
        if (new Date() > new Date(enddate)){
            this.maxdate = enddate;
        } else {
            this.maxdate = new Date();
        }
        if (this.agreement && this.agreement.agreementrate.length) {
            const agreementRate = this.agreement.agreementrate.filter((item: { status: string; }) => item.status === 'Approved');
            if (agreementRate && agreementRate.length) {
                
                const agreementendDate = agreementRate[agreementRate.length - 1].rateenddate;
                const previousReviewDate = this.handleExistingAnnualReviwFn(existingAnnualReviw);

                if(!((previousReviewDate && new Date(agreementendDate) > new Date(previousReviewDate)) || existingAnnualReviw?.length === 0)) {
                    this.returnToReviewList('Rate Agreement must be completed to continue adding a new  Annual Review.');
                    return true;
                } 

            } else {
                this.returnToReviewList('Rate Agreement must be completed to continue adding a new  Annual Review.');
                return true;
            }
        }
        return false;
    }
    // Assosiated with setagreementRate function
    private handleExistingAnnualReviwFn(existingAnnualReviw: any) {
        let previousReviewDate;
        if (existingAnnualReviw && existingAnnualReviw.length) {
            previousReviewDate = existingAnnualReviw[existingAnnualReviw.length - 1].reviewdate;
        } else {
            previousReviewDate = this.annualReviewGapForm.getRawValue().reviewdate;
        }
        return previousReviewDate;
    }

    returnToReviewList(msg: any) {
        this._alertService.error(msg);
        this.isFormDisplay = false;
    }

    getErrorsMessage(ControlName: any, displayName: any){
        if(this.annualReviewGapForm.controls[ControlName].status =='INVALID' ){
        return 'Please enter valid ' + displayName
        }
    }
    
}
