import { Component, OnInit, Injector } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
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
import { SessionStorageService } from '../../../../../../@core/services';
import moment from 'moment';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { ServiceCasePlacementsService } from '../../../service-case-placements/service-case-placements.service';
import { FinanceService } from '../../../../../finance/finance.service';
import { Html2CanvasService } from '../../../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'finalization-checklist',
    templateUrl: './finalization-checklist.component.html',
    styleUrls: ['./finalization-checklist.component.scss'],
    standalone: false
})
export class FinalizationChecklistComponent implements OnInit {
    agreementGapForm!: FormGroup;
    placement!: Placement;
    disClosure!: GapDetails;
    submitStatus!: RouteToSupervisor;
    agreementList: Agreement = new Agreement();
    id!: string;
    daNumber!: string;
    roleId!: AppUser;
    isSupervisor = false;
    isExistRecord = false;
    child: any;
    isApproved = false;
    agreement: GapAgreement = new GapAgreement();
    maxDate = new Date();
    deleteAttachmentIndex!: number;
    isEnableComments = false;
    gapAlertMessage!: string;
    isShowAgreementForm = false;
    isShowRateForm = false;
    selectedRate!: Gapagreementrate;
    newBtnDisabled!: boolean;
    agreementDetail: any;
    agreementRate: any;
    store: DynamicObject;
    token: any;
    placementAgreementRateId: any;
    showRateOverride!: boolean;
    showRateApprovalStatus!: boolean;
    rateAction!: string;
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
    agreementenddate: any;
    agreementStartDate: any;
    isEnddateedited = 'no';
    isStartDateEdited = false;
    isedited!: boolean;
    agreementrateenddate: any;
    isRateEndDateEdited = 'no';
    isAgreementApproved = false;
    childInActiveSubsidy = false;
    approvalStatus!: string;
    disableChecklist: boolean = false;
    guardianOneID: any;
    guardainTwoId: any;
    guardianoneprovidername: any;
    guardiantwoprovidername: any;
    guardianOneDob: any;
    guardianTwoDob: any;
    gapplacementpopupid = '#gap-placement';
    private _dataStoreService: DataStoreService;
    private _formBuilder: FormBuilder;
    private _commonHttpService: CommonHttpService;
    private _alertService: AlertService;
    private _authService: AuthService;
    private _route: Router;
    private _session: SessionStorageService;
    private _placementService: PlacementGapService;
    private _scPlacementService: ServiceCasePlacementsService;
    private _financeService: FinanceService;
    mostRecentApprovedEndDate: any;
    agreementExcludeOverlapDate: any;
    courtorderdate: any;
    filterCase: any;
    openChildRemovalExists!: boolean;
    doesOpenPlacementExist: any;

    constructor(private injector : Injector,private html2canvas:Html2CanvasService){
        this._dataStoreService = injector.get<DataStoreService>(DataStoreService);
        this._formBuilder = injector.get<FormBuilder>(FormBuilder);
        this._commonHttpService = injector.get<CommonHttpService>(CommonHttpService);
        this._alertService = injector.get<AlertService>(AlertService);
        this._authService = injector.get<AuthService>(AuthService);
        this._route = injector.get<Router>(Router);
        this._session = injector.get<SessionStorageService>(SessionStorageService);
        this._placementService = injector.get<PlacementGapService>(PlacementGapService);
        this._scPlacementService = injector.get<ServiceCasePlacementsService>(ServiceCasePlacementsService);
        this._financeService = injector.get<FinanceService>(FinanceService);
        this.store = this._dataStoreService.getCurrentStore();
    }

    ngOnInit() {
        this._placementService.checkDataAvailability();
        this.roleId = this._authService.getCurrentUser();
        this.iscaseworker = this._authService.selectedRoleIs('field');
        this.initializeChecklistForm();
        if (this.roleId.role.name === 'apcs') {
            this.isSupervisor = true;
        }
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.child = this._dataStoreService.getData('placed_child');
        const mostRecentEnddate = this.child.placements?.filter((e: { placementtypekey: string; enddate: any; routingstatus: string; }) => e.placementtypekey === 'PRPL' && e.enddate && e.routingstatus === 'Approved')  
                                    .sort((a: any, b: any) => new Date(b.enddate).getTime() - new Date(a.enddate).getTime())  
                                    .map((e: { enddate: any; }) => e.enddate)[0];
        this.mostRecentApprovedEndDate = mostRecentEnddate ?? 
                                    this.store['placement_child']?.placementrevision?.filter((revision: { status: string; }) => revision.status === 'Approved')
                                        .sort((a: any, b: any) => new Date(b.approveddate).getTime() - new Date(a.approveddate).getTime())
                                        .map((revision: { enddate: any; }) => revision.enddate)
                                        .find((enddate: any) => enddate !== null);
        this.token = this._authService.getCurrentUser();
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        if (this.store['placement_child']) {
            this.handleIfPlacementChildFn();
        }
        if (this.store['placed_child']) {
            this.handleIfPlacedChildFn();
        }
        if(this.child && this.child.cjamspid) {
          this.checkallservicelog(this.child.cjamspid);
        }
    
        this.loadInitialData();
        this.getCourtInformation();
        this.getExcludeOverlapDates();
    }
    
    async loadInitialData(): Promise<void> {
        await this.getOpenRemovalOrPlacement();
        this.calculateMostRecentApprovedEndDate();
    }
    
    async getOpenRemovalOrPlacement(): Promise<void> {
        await Promise.all([
            this.getPlacementHistoryByPerson(this.child.personid),
            this.getRemovalHistoryOfPerson(this.child.personid),
        ]);
    }
    
    calculateMostRecentApprovedEndDate(): void {
        let placementEndDate = this._dataStoreService.getData('placement_child')?.exitDate
        const mostRecentEnddate = this.child.placements?.filter((e: { placementtypekey: string; enddate: any; routingstatus: string; }) => e.placementtypekey === 'PRPL' && e.enddate && e.routingstatus === 'Approved')  
                                    .sort((a: any, b: any) => new Date(b.enddate).getTime() - new Date(a.enddate).getTime())  
                                    .map((e: { enddate: any; }) => e.enddate)[0] ?? placementEndDate;
        this.mostRecentApprovedEndDate = mostRecentEnddate ?? 
                                    this.store['placement_child'].placementrevision?.filter((revision: { status: string; }) => revision.status === 'Approved')
                                        .sort((a: any, b: any) => new Date(b.approveddate).getTime() - new Date(a.approveddate).getTime())
                                        .map((revision: { enddate: any; }) => revision.enddate)
                                        .find((enddate: any) => enddate !== null);
    }

    async getPlacementHistoryByPerson(person: string): Promise<void> {
        const result = await this._commonHttpService
            .getSingle(
                {
                    where: { personid: person },
                    method: 'get',
                },
                'placement/getplacementbyperson?filter'
            )
            .toPromise();
    
        if (!result) {
            this.doesOpenPlacementExist = false;
            return;
        }
    
        const targetPlacements = result.filter(
            (placement: { placementtypekey: string; isvoided: number; }) =>
                placement.placementtypekey === 'PRPL' && placement.isvoided === 0
        );
    
        this.child.placements = targetPlacements;
        this.doesOpenPlacementExist = targetPlacements.some(
            (e: { livingenddate: null; }) => e.livingenddate === null
        );
    }    
    
    async getRemovalHistoryOfPerson(personid: string): Promise<void> {
        const data = await this._commonHttpService
            .getSingle(
                {
                    where: { objectid: personid, objecttypekey: 'personid' },
                    method: 'get',
                },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetChildRemovalList}?filter`
            )
            .toPromise();
    
        if (!data) {
            this.openChildRemovalExists = false;
            return;
        }
    
        this.child.removalList = data;
        this.openChildRemovalExists = data.some((e: { exitdate: null; }) => e.exitdate === null);
    }
    
    
    // Assosiated with ngOnInit function
    private handleIfPlacedChildFn() {
        const removalInfo = this.store['placed_child'].removalList;
        const placements = this.store['placed_child'].placements;
        const endRemovalInfo = removalInfo ? removalInfo.filter((item: { exitdate: any; }) => item.exitdate) : null;
        const endPRPLPlacments = placements ? placements.filter((item: { placementtypekey: string; isvoided: number; }) => item.placementtypekey == 'PRPL' && item.isvoided !== 1) : null;
        const endPlacments = endPRPLPlacments ? endPRPLPlacments.filter((item: { enddate: any; }) => item.enddate) : null;
        const laPlacements = placements ? placements.filter((item: { placementtypekey: string; }) => item.placementtypekey == 'LA') : null;
        const endDateLAPlacements = laPlacements ? laPlacements.filter((item: { enddate: any; }) => item.enddate) : null;
        if (placements && placements.length) {
            this.childHasActivePlacement = this._scPlacementService.checkForChildHasActivePlacements(placements);
        } else {
            this.childHasActivePlacement = false;
        }
        if (removalInfo && placements && endRemovalInfo && endPlacments
            && removalInfo.length === endRemovalInfo.length
            && endPRPLPlacments.length === endPlacments.length) {
            this.agreementGapForm.patchValue({ isplacementenddate: true });
        }
        if (laPlacements && endDateLAPlacements && laPlacements.length == endDateLAPlacements.length) {
            this.agreementGapForm.patchValue({ islaendate: true });
        }
    }
    // Assosiated with ngOnInit function
    private handleIfPlacementChildFn() {
        this.placement = this.store['placement_child'];
        this.getPage();
        const child = this._dataStoreService.getData('placed_child');
        const req = Object.assign(
            { cjamspid: child.cjamspid }
        );
        this._commonHttpService.create(req, 'gapagreement/checkForActiveSubsidy').subscribe(res => {
            this.childInActiveSubsidy = res > 0 ? true : false;
        },
            err => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
        this.childdob = new Date(child.dob);
    }

    initializeChecklistForm() {
        this.agreementGapForm = this._formBuilder.group({
            iscomprehensivehomestudy: [null, Validators.requiredTrue],
            iscgawardedcustody: [null, Validators.requiredTrue],
            isplacementenddate: [null, Validators.requiredTrue],
            islaendate: [null, Validators.requiredTrue],
            isservicelogsendate: [null, Validators.requiredTrue],
            startdate :[null]
        });
    }

    getExcludeOverlapDates() {
        this._commonHttpService.getSettings(['agreement_overlap_date']).subscribe((result)=> {
            this.agreementExcludeOverlapDate = result.settings[0].settingvalue
        })
    }


    generatePDF_html() {
        const doc = new jsPDF('p', 'mm', 'a4');
        const formDataFn: any = document.getElementById('closing-Checklist-Form');
        this.html2canvas.capture(formDataFn).then(function(
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
    
            doc.save('GAP-Finalization-checklist.pdf');
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
                    'gapagreementcc'
                ],
                isservicelogsendate:this.agreementGapForm.value.isservicelogsendate,
                islaendate: this.agreementGapForm.value.islaendate,
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

    getPage() {
        let getpermanencyplanid: any = '';
        getpermanencyplanid = this._session.getItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID);
        getpermanencyplanid = (getpermanencyplanid) ? getpermanencyplanid : null;
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: {
                        permanencyplanid: (this.placement && this.placement.permanencyplanid) ? this.placement.permanencyplanid : getpermanencyplanid
                    },
                    method: 'get'
                }),
                'gapdisclosure/getguardianship' + '?filter'
            )
            .subscribe((res) => {
                    if (res.data && res.data.length) {
                        this.handleIfGuardianshipApiResponseFn(res);
                    } else {
                        this.gapAlertMessage = 'Please complete disclosure checklist';
                        ($(this.gapplacementpopupid)).modal('show');
                    }
                }
            );
    }
    // Assosiated with getPage method
    private handleIfGuardianshipApiResponseFn(res: any) {
        this.disClosure = res.data[0];
        if (res.data[0].guardianoneproviderid) {
            this.patchGuardians(res.data[0].guardianoneproviderid);
        }
        this.guardianOneID = res.data[0].guardianoneproviderid;
        this.guardainTwoId = res.data[0].guardiantwoproviderid;
        this.guardianoneprovidername = res.data[0].guardianoneprovidername;
        this.guardiantwoprovidername = res.data[0].guardiantwoprovidername;
        this.guardianOneDob = res.data[0].one_dob_dt ? moment(res.data[0].one_dob_dt).format('MM/DD/YYYY') : null;
        this.guardianTwoDob = res.data[0].two_dob_dt ? moment(res.data[0].two_dob_dt).format('MM/DD/YYYY') : null;
        if (res.data[0].gapapplication[0].routingstatus === 'Approved') {
            if ((!res.data[0].gapdisclosure) || (res.data[0].gapdisclosure[0].routingstatus !== 'Approved')) {
                this.gapAlertMessage = 'Please complete Disclosure checklist';
                ($(this.gapplacementpopupid)).modal('show');
            }
            this.getAgreement(res.data[0].gapid);
        } else {
            this.gapAlertMessage = 'Please complete Gap Application';
            ($(this.gapplacementpopupid)).modal('show');
        }

        this.gapAlternateID = res.data[0].alternateid ? res.data[0].alternateid : null;
    }

    private handleDisclosureData(res: any) {
        this.disClosure = res.data[0];
        if(res.data[0].guardianoneproviderid) { 
            this.patchGuardians(res.data[0].guardianoneproviderid);
        }
        this.guardianOneID = res.data[0].guardianoneproviderid
        this.guardainTwoId = res.data[0].guardiantwoproviderid;
        this.guardianoneprovidername = res.data[0].guardianoneprovidername;
        this.guardiantwoprovidername =  res.data[0].guardiantwoprovidername;
        this.guardianOneDob = res.data[0].one_dob_dt ? moment(res.data[0].one_dob_dt).format('MM/DD/YYYY') : null ;
        this.guardianTwoDob = res.data[0].two_dob_dt ? moment(res.data[0].two_dob_dt).format('MM/DD/YYYY') : null;    
        if(res.data[0].gapapplication[0].routingstatus === 'Approved') {
            if((!res.data[0].gapdisclosure) || (res.data[0].gapdisclosure[0].routingstatus !== 'Approved')) {
                this.gapAlertMessage = 'Please complete Disclosure checklist';
                ($(this.gapplacementpopupid)).modal('show');
            } 
            this.getAgreement(res.data[0].gapid);
        } else {
            this.gapAlertMessage = 'Please complete Gap Application';
            ($(this.gapplacementpopupid)).modal('show');
        }

        this.gapAlternateID = res.data[0].alternateid ? res.data[0].alternateid : null;
    }

    onChange($event: any) {
        if($event.checked){
            ($('#check-box-selected')).modal('show');
        } else {
            ($('#check-box-selected')).modal('hide');
        }
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
                if (response?.length > 0) {
                    const filterPerson = response.filter((element: { personid: any; }) => element.personid === persondetails?.personid);
                
                    filterPerson.sort((a: any, b: any) => 
                        new Date(moment(b.courtorderdate).format("YYYY-MM-DD")).getTime() - 
                        new Date(moment(a.courtorderdate).format("YYYY-MM-DD")).getTime()
                    );
                
                    const latestHearing = filterPerson.find((element: any) => 
                        element.hearingoutcome &&
                        element.hearingoutcome.length > 0 &&
                        element.courtorderdate &&
                        element.hearingoutcome.some((e: { hearingoutcometypekey: string; }) => e.hearingoutcometypekey === 'CUSGUA') &&
                        !this.courtorderdate
                    );
                
                    if (latestHearing) {
                        this.courtorderdate = latestHearing.courtorderdate;
                    } else {
                        this.courtorderdate = filterPerson[0]?.courtorderdate || null;
                    }
                
                    response.forEach((element: { personid: any; }) => {
                        if(element.personid === persondetails?.personid) {
                            this.checkHearingOutcome(element);
                          }
                      });
                } else {
                    this.courtorderdate = null; 
                  }
              });
    }
    // Assosiated with getCourtInformation method
    private checkHearingOutcome(element: { personid?: any; hearingoutcome?: any; courtorderdate?: any; }) {
        if (element.hearingoutcome && element.hearingoutcome.length) { 
            element.hearingoutcome.forEach((el: { hearingoutcometypekey: string; }) => {
                if (el.hearingoutcometypekey === 'CUSGUA' && element.courtorderdate) {
                    this.agreementGapForm.patchValue({ iscgawardedcustody: true });
                    this.agreementGapForm.patchValue({startdate: element.courtorderdate}) // CIDM-10639 Logic to patch agreement start date from finalization screen from the existing latest court order date.
                } 
            });
        }
    }

    getServiceLogList(cids: any) {
        return this._commonHttpService.getArrayList(
          {
            where: { daNumber: this.daNumber, client_id: cids },
            method: 'get',
            nolimit: true
          },
          CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.servicelogmultipelist + '?filter'
        );
    }

    getVendorList(personlist: any) {

        return this._commonHttpService.getArrayList(
            {
                where: { daNumber: this.daNumber, clientid: personlist, nolimit: true },
                method: 'get'
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.vendorServiceLog + '?filter'
        );
    }

    checkallservicelog(personlistforservicelog: any) {
        let vendorlist: any[] = [];
        let agencylist: any = [];
        const slsource = this.getServiceLogList(personlistforservicelog);
        const vssource = this.getVendorList(personlistforservicelog);
        vssource.subscribe((data: any) => {
          vendorlist = data['servicelogData'];
                          });
        slsource.subscribe((data: any) => {
          const list = Array.isArray(data['servicelogData']) ? data['servicelogData'] : [];
          agencylist = list;
                           });
        setTimeout(()=>{ 
        if (vendorlist.length == 0 && agencylist.length == 0) {
            this.agreementGapForm.patchValue({isservicelogsendate: true});
        } else if (vendorlist && vendorlist.length) {
            let servicelogEndDate = true;
            vendorlist.forEach(el => {
                if (el.actual_end_date == null || el.actual_end_date == undefined ) {
                   servicelogEndDate = false
                } 
             });
            this.agreementGapForm.patchValue({isservicelogsendate: servicelogEndDate});
        }
    }, 3000);
    }


    confirmUpdate(filtercase: any) {
        this.filterCase = filtercase;
        $('#maintenance-payment-check-dialog-b').modal('show');
    }

    updateChecklist() {   
        const agreementData = this.agreementGapForm.getRawValue();
        agreementData.gapagreementid = this.agreementDetail.gapagreementid;

        let courtorderdate: any = this.courtorderdate ? new Date(this.courtorderdate) : null;

        if ((!courtorderdate || isNaN(courtorderdate.getTime())) && this.agreementDetail && this.agreementDetail.startdate) {
            courtorderdate = new Date(this.agreementDetail.startdate);
        }
        const exitDate = new Date(this.mostRecentApprovedEndDate);

        if (courtorderdate < exitDate && exitDate >= new Date(this.agreementExcludeOverlapDate)) {
            let filtercase = 'Placement Exit Date is Overlapping  with the GAP Agreement Start Date. Please Check and correct the Placement Exit Date accordingly to proceed with the Guardianship Subsidy Rate';
            this.confirmUpdate(filtercase);
            return;
        }
        
        this._commonHttpService.create(agreementData, 'gapagreement/updatechecklist').subscribe(
            res => { 
                this.disableChecklist = true;
                this._alertService.success('Agreement Closing checklist updated successfully!');
                this.getAgreement(this.disClosure.gapid);
            },
            err => { this._alertService.error('Error updating the Checklist!'); }
        );
    }

    navigateTo() {
        if (this.disClosure) {
            const gapdisclosure = this.disClosure.gapdisclosure;
            ($(this.gapplacementpopupid)).modal('hide');
            if (!gapdisclosure || (gapdisclosure[0] && gapdisclosure[0].routingstatus !== 'Approved')) {
                const currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/placement/placement-gap/disclosure-checklist';
                this._route.navigate([currentUrl]);
            }
        } else {
            const currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/placement/placement-gap/disclosure-checklist';
            this._route.navigate([currentUrl]);
        }
    }

    getAgreement(gapId: any) {
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
                    this.disableChecklist = (this?.agreementRate?.length > 0) ?  true : false;
                    this.approvalStatus = this.agreementDetail.routingstatus;
                    this.agreementGapForm.patchValue({iscomprehensivehomestudy: res[0].iscomprehensivehomestudy});
                } else {
                    this.gapAlertMessage = 'Please complete Gap Agreement';
                    ($(this.gapplacementpopupid)).modal('show');
                }
            });
    }

    fiscalAudit() {
        this._financeService.getChangeHistory(1, this.gapAlternateID, 'gaprate');
    }
} 