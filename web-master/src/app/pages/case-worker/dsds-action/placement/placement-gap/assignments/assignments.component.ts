import { Component, OnInit, Injector } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import jsPDF from 'jspdf';
import { AppUser } from '../../../../../../@core/entities/authDataModel';
import { PaginationInfo, PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { DataStoreService, SessionStorageService } from '../../../../../../@core/services';
import { AlertService } from '../../../../../../@core/services/alert.service';
import { AuthService } from '../../../../../../@core/services/auth.service';
import { CommonHttpService } from '../../../../../../@core/services/common-http.service';
import { GapAssignment, GapDetails, GapSuspension, RouteToSupervisor, SuspensionReasonType, Suspesion } from '../../_entities/placement.model';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { PlacementGapService } from '../placement-gap.service';
import { FinanceUrlConfig } from '../../../../../finance/finance.url.config';
import { FinanceService } from '../../../../../finance/finance.service';
import moment from 'moment';
import _ from 'lodash';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { PersonInfoService } from '../../../../../shared-pages/person-info/person-info.service';
import { Html2CanvasService } from '../../../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';
declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'assignments',
    templateUrl: './assignments.component.html',
    styleUrls: ['./assignments.component.scss'],
    standalone: false
})
export class AssignmentsComponent implements OnInit {
    id!: string;
    daNumber!: string;
    currentUrl!: string;
    placement: any;
    paginationInfo: PaginationInfo = new PaginationInfo();
    assignmentForm!: FormGroup;
    approvalStatusForm!: FormGroup;
    assignment: GapAssignment = new GapAssignment();
    disClosure!: GapDetails;
    suspesionReason!: GapSuspension[];
    suspensionReasonType: SuspensionReasonType[] = [];
    isSubmitForReview = false;
    roleId!: AppUser;
    isSupervisor = false;
    submitStatus!: RouteToSupervisor;
    isExistRecord = false;
    suspensionReason: Suspesion = new Suspesion();
    gapAlertMessage!: string;
    isApproved = false;
    isEnableComments = false;
    placementSuspensionId!: string | undefined;
    isInitialized = false;
    toShowDOD!: boolean;
    currentdate!: Date;
    maxenddate: any;
    changehistory = [];
    adjustment!: any[];
    showSuspensionDetail!: boolean;
    reportedChild: any;
    overpayments!: any[];
    placmentDetails: any;
    providerDetails: any;
    gapAlternateID!: string | null;
    agrementStartDate!: Date;
    agrementEndDate!: Date;
    suspensionNotes: any;
    store: any;
    displayValidationMessages: boolean = false;
    gapplacementpopupid = '#gap-placement';
    gapalertmsg = 'Please complete disclosure checklist';
    caseworkerpageurl = '/pages/case-worker/';
    dtformat = 'YYYY-MM-DD';
    filteredSuspensionReasonType: SuspensionReasonType[] = [];

    private _alertService: AlertService;
    private route: ActivatedRoute;
    private _formBuilder: FormBuilder;
    private _httpService: CommonHttpService;
    private _dataStoreService: DataStoreService;
    private _authService: AuthService;
    private _route: Router;
    private _session: SessionStorageService;
    private _gapService: PlacementGapService;
    private _financeService: FinanceService;
    private _personInfoService: PersonInfoService;
    filterCase!: string;
    doesOpenPlacementExist!: boolean;
    openChildRemovalExists!: boolean;
    child: any = {
        removalList: [],
        placements: []
      };
    personid: any;

    constructor(private injector : Injector,private html2canvas:Html2CanvasService){
        this._alertService = injector.get<AlertService>(AlertService);
        this.route = injector.get<ActivatedRoute>(ActivatedRoute);
        this._formBuilder = injector.get<FormBuilder>(FormBuilder);
        this._httpService = injector.get<CommonHttpService>(CommonHttpService);
        this._dataStoreService = injector.get<DataStoreService>(DataStoreService);
        this._authService = injector.get<AuthService>(AuthService);
        this._route = injector.get<Router>(Router);
        this._session = injector.get<SessionStorageService>(SessionStorageService);
        this._gapService = injector.get<PlacementGapService>(PlacementGapService);
        this._personInfoService = injector.get<PersonInfoService>(PersonInfoService);
        this._financeService = injector.get<FinanceService>(FinanceService);
        this.store = this._dataStoreService.getCurrentStore();
    }

    ngOnInit() {
        this._gapService.checkDataAvailability();
        this.roleId = this._authService.getCurrentUser();
        if (this.roleId.role.name === 'apcs') {
            this.isSupervisor = true;
            this.showSuspensionDetail = false;
            this.placementSuspensionId = this._session.getItem('Placement-Suspension-Id');
            this._session.setItem('Placement-Suspension-Id', null);
            this.getPageForSupervisor();
            this.getSuspensionReason();

        } else {
            this.showSuspensionDetail = true;
        }
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.assignmentFormInitilize();
        this.assignmentForm.patchValue({ servicecaseid: this.id });
        this.isInitialized = true;
        this._dataStoreService.currentStore.subscribe((store) => {
            if (this.isInitialized && store['placement_child']) {
                this.placement = store['placement_child'];
                if (this.placement) {
                    this.getPage();
                    this.getAgreement();
                    this.getSuspensionReason();
                    this.isInitialized = false;
                }
            }
        });
        this.childPlacementList();
    }
    assignmentFormInitilize() {
        this.assignmentForm = this._formBuilder.group({
            suspensionreasontypekey: ['', Validators.required],
            startdate: [null, Validators.required],
            enddate: [null],
            notes: [''],
            isdraft: ['123'],
            suspensiondesc: [''],
            gapid: [null],
            doddate: [null],
            servicecaseid: [null],
            otherreason: [''],
            guardiansubsidyid: [null],
            activeflag: [1],
            gapsuspensionid: null
        });
        this.approvalStatusForm = this._formBuilder.group({
            routingstatus: [''],
            comments: ['']
        });


    }
    generatePDF_html() {
        const doc = new jsPDF('p', 'mm', 'a4');
        const foridDataFn: any = document.getElementById('assignment-Form');
        this.html2canvas.capture(foridDataFn).then(function(canvas) {
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

            doc.save('GAP-assessments.pdf');
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
                    'gapagreementsuspend'
                ]
          };

        this._httpService.create(payload, 'gapapplication/getgappdftoprint').subscribe(
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

    getPageForSupervisor() {
        this._httpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 10,
                    where: {
                        objectid: this.placementSuspensionId,
                        objecttype: 'suspension'
                    },
                    method: 'get'
                }),
                'gapdisclosure/getguardianship' + '?filter'
            )
            .subscribe(
                (checkList) => {
                    if (checkList.data && checkList.data.length) {
                        this.personid = checkList.data[0].personid;
                        $(this.gapplacementpopupid).modal('hide');
                        this.disClosure = checkList.data[0];
                        this.assignmentForm.patchValue({ gapid: this.disClosure.gapid });
                        this.suspesionReason = _.orderBy(this.disClosure.gapsuspension, ['startdate'], ['desc']);
                        if (!this.isApproved) {
                            this.patchAssignment(this.disClosure);
                        }
                    } else {
                        return;
                    }
                },
                (error) => {
                    // No data or function to add or call
                }
            );
    }

    getPage() {
        this._httpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: {
                        permanencyplanid: (this.placement && this.placement.permanencyplanid) ? this.placement.permanencyplanid : null
                    },
                    method: 'get'
                }),
                'gapdisclosure/getguardianship' + '?filter'
            )
            .subscribe(
                (checkList) => {
                    if (checkList.data.length) {
                        this.personid = checkList.data[0].personid;
                        $(this.gapplacementpopupid).modal('hide');
                        this.disClosure = checkList.data[0];
                        this.assignmentForm.patchValue({ gapid: this.disClosure.gapid });
                        this.gapAlternateID = this.disClosure.alternateid || null;
                        this.suspesionReason = _.orderBy(this.disClosure.gapsuspension, ['startdate'], ['desc']);
                        if (!this.isApproved) {
                            this.patchAssignment(this.disClosure);
                        }
                        if (this.suspesionReason && this.suspesionReason.length > 0) {
                            this.suspesionreasoncheck();

                        } else {
                            this.currentdate = new Date();
                        }
                    } else {
                        this.gapAlertMessage = this.gapalertmsg;
                        $(this.gapplacementpopupid).modal('show');
                    }
                },
                (error) => {
                    // No data or function to add or call
                }
            );
    }

    suspesionreasoncheck(){
        const incompletedSuspension = this.suspesionReason.filter(item => item.routingstatus === 'Review'  || (!item.enddate && item.routingstatus !== 'Rejected')) ;
        if (incompletedSuspension.length === 0) {
            this.showSuspensionDetail = this.isSupervisor ? false : true;
        } else {
            this.showSuspensionDetail = false;
            !this.placementSuspensionId || this.placementSuspensionId == 'null' ? this.placementSuspensionId = incompletedSuspension[0].gapsuspensionid : true; // NOSONAR
        }
    }

    getSuspensionReason() {
        this._httpService.getSingle({}, 'suspensionreasontype/').subscribe((data) => {
             this.suspensionReasonType = data;
             this.filteredSuspensionReasonType = this.suspensionReasonType.filter(dropDownItems => dropDownItems.suspensionreasontypekey !== 'COHP');
        });
    }

    conditionValidation(): boolean {
        if (!this.assignmentForm.value.startdate) {
            this._alertService.error('Discolsure end date should be greater than start date');
            return false;
        }

        if (this.assignmentForm.value.startdate !== null
            && (this.assignmentForm.value.enddate !== null)
            && this.assignmentForm.value.enddate < this.assignmentForm.value.startdate) {
            this._alertService.error('Discolsure end date should be greater than start date');
            return false;
        }
        return true;
    }
    patchAssignment(modal: any) {
        if (!modal.gapdisclosure) {
            this.gapAlertMessage = this.gapalertmsg;
            $(this.gapplacementpopupid).modal('show');
        } else if (modal.gapsuspension && modal.gapsuspension.length > 0) {
            const gapSuspension = modal.gapsuspension.filter((data: { activeflag: number; }) => (data.activeflag === 1 || data.activeflag));
            if (gapSuspension && gapSuspension.length) {
                this.gapSuspensioncheck(gapSuspension);
            }
        } else {
            this.isExistRecord = false;
        }
    }
    
    gapSuspensioncheck(gapSuspension: any){
        this.isExistRecord = true;

        //To Check for any record with status as review and patch it to the approval status form
        this.suspensionReason = gapSuspension.find((gapSuspensionData: any) => gapSuspensionData.routingstatus === 'Review')

        // Patch the record with latest gap suspension start date incase there is no review record
        if(this.suspensionReason?.routingstatus !== 'Review'){
            this.suspensionReason = _.orderBy(gapSuspension, ['startdate'], ['desc'])[0];
            this.isApproved = true;
        }
        this.approvalStatusForm.patchValue({
            routingstatus: this.suspensionReason.routingstatus ? this.suspensionReason.routingstatus : '',
            comments: this.suspensionReason.comments ? this.suspensionReason.comments : ''
        });
    }

    resetSuspension() {
        this.assignmentForm.enable();
        this.assignmentForm.reset();
        if (this.suspesionReason && this.suspesionReason.length > 0) {
            const lastSuspension = this.suspesionReason[0];
            if (lastSuspension && lastSuspension.enddate) {
                this.showSuspensionDetail = true;
            } else {
                this.showSuspensionDetail = false;
            }
        }
    }
    patchSuspension(suspension: any, _index: any) {
        this.filteredSuspensionReasonType = this.suspensionReasonType;
        //  Hiding system generated suspension type for manual suspension entry
        if(suspension.suspensionreasontypekey !== 'COHP'){
            this.filteredSuspensionReasonType = this.suspensionReasonType.filter(dropDownItems => dropDownItems.suspensionreasontypekey !== 'COHP');
        }
        this.showSuspensionDetail = true;
        this.suspensionReason = suspension;
        this.assignmentForm.patchValue(this.suspensionReason);
        this.approvalStatusForm.patchValue({
            routingstatus: this.suspensionReason.routingstatus ? this.suspensionReason.routingstatus : '',
            comments: this.suspensionReason.comments ? this.suspensionReason.comments : ''
        });
        if (this.approvalStatusForm.value.routingstatus === 'Approved' || this.approvalStatusForm.value.routingstatus === 'Rejected') {
            this.isApproved = true;
        }
        this.suspensionStartDateChanged();
    }

    rejectComments(status: any) {
        if (status === 'Rejected') {
            this.isEnableComments = true;
        } else {
            this.isEnableComments = false;
            this.approvalStatusForm.patchValue({ comments: '' });
        }
    }

    isSuspensionValid(suspensionEndDate: any, child: any) {
        const parseDate = (dateStr: any) => dateStr ? new Date(dateStr) : null;

        const mostRecentPlacementEndDate = child.placements
          .filter((p: any) =>p.placementtypekey === 'PRPL' && p.enddate)
          .map((p: any) => parseDate(p.enddate))
          .reduce((latest: any, current: any) => current > latest ? current : latest, new Date(0));

        const mostRecentRemovalEndDate = child.removalList
          .map((r: any) => parseDate(r.enddate))
          .filter((date: any) => date !== null)
          .reduce((latest: any, current: any) => current > latest ? current : latest, new Date(0));

        const mostRecentDate: any = (mostRecentPlacementEndDate && mostRecentPlacementEndDate > mostRecentRemovalEndDate)
          ? mostRecentPlacementEndDate
          : mostRecentRemovalEndDate;

        const suspensionEnd: any = parseDate(suspensionEndDate);
        const recentDateData: any = this.toMidnight(mostRecentDate);

        if (suspensionEnd && recentDateData && suspensionEnd >= recentDateData) {
          return true;
        } else {
          return false;
        }
      }

    confirmUpdate() {
        $('#maintenance-payment-check-dialog-g').modal('show');
    }

    async getPlacementHistoryByPerson(person: any){
        this._httpService
        .getSingle(
          {
            where: { personid: person},
            method: 'get'
          },

          'placement/getplacementbyperson?filter'
        ).subscribe(result => {

          if (!result) {
            this.doesOpenPlacementExist = false;
            return;
          }
          const targetPlacements = result?.filter((placement: any) =>
              placement.placementtypekey === 'PRPL'
              && placement.isvoided === 0
            );
          this.child.placements = targetPlacements;

          this.doesOpenPlacementExist =  targetPlacements.some((e: any) => e.livingenddate === null);
        });
      }

      async getRemovalHistoryOfPerson(personid: any){
        this._httpService
        .getSingle(
          {
            where: { objectid: personid, 'objecttypekey': 'personid'},
            method: 'get'
          },
          `${CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetChildRemovalList}?filter`
        ).subscribe(data => {
            if (!data) {
              this.openChildRemovalExists = false
              return;
            }
            this.child.removalList = data;
            this.openChildRemovalExists=data.some((e: { exitdate: null; }) => e.exitdate === null);
        });
      }
    
      
    async saveAssignment(modal: any) {
        this.child = this._dataStoreService.getData('placed_child');

        if(!this.child) {
            await this.getPlacementHistoryByPerson(this.personid);
            await this.getRemovalHistoryOfPerson(this.personid);
        }

        const isThereAnOpenPlacementOrRemoval = this.child.removalList.filter((e: any) => e.approvalstatus === "Approved").some((e: any) => e.exitdate === null) || this.child.placements.filter((e: any) => e.routingstatus === "Approved"  && e.placementtypekey === 'PRPL').some((e: any) => e.enddate === null && e.isvoided === 0);

        if (modal.enddate) {
            if(isThereAnOpenPlacementOrRemoval) {
                this.filterCase = 'There is an Open/Active Provider Placement & Child Removal entered for the GAP client that is beyond the GAP Suspension Period and it can lead on the duplicate payments.';
                this.confirmUpdate();
                return;
            }
            const suspensionDateValidity = !this.isSuspensionValid(modal.enddate, this.child);
            if (suspensionDateValidity) {
                this.filterCase = 'There is an Open/Active Provider Placement & Child Removal entered for the GAP client that is beyond the GAP Suspension Period and it can lead on the duplicate payments.';
                this.confirmUpdate();
                return;
            }
        }


        if (this.assignmentForm.invalid) {
            this.displayValidationMessages =true;
            this.assignmentForm.markAllAsTouched();
            return;
        }
        const validation = this.conditionValidation();
        this.assignment = Object.assign({}, modal);
        this.assignment.gapid = this.disClosure.gapid;
        if (validation) {
            this._httpService.create(this.assignment, 'gapsuspension/add').subscribe(
                (_res) => {
                    this._alertService.success('Suspension Details  Submitted for Supervisor Approval');
                    this.resetSuspension();
                    this.getPage();
                }
            );
        }
    }
    routingUpdate() {
        const comment = 'Guardianship Suspension Submitted for review';
        this.submitStatus = Object.assign({
            objectid: this.placementSuspensionId,
            eventcode: 'GASR',
            status: this.approvalStatusForm.value.routingstatus,
            comments: this.approvalStatusForm.value.comments,
            notifymsg: comment,
            routeddescription: comment,
            servicecaseid: this.id
        });

        if (this.roleId.role.name === 'apcs' && this.approvalStatusForm.value.routingstatus === '') {
            this._alertService.error('Please select review status!');
        } else {
            this._httpService.create(this.submitStatus, 'routing/routingupdate').subscribe(
                (_res) => {
                    this._alertService.success('Suspension Details ' + this.approvalStatusForm.value.routingstatus + ' Successfully!');
                    this.isApproved = true;
                    this.getPageForSupervisor();
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
            $(this.gapplacementpopupid).modal('hide');
            if (!gapdisclosure) {
                this.currentUrl = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/placement/placement-gap/disclosure-checklist';
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

    reasonSelected(event: any) {
        if (event.value === 'DC') {
            this.toShowDOD = true;
        } else {
            this.toShowDOD = false;
        }
    }

    getAgreement() {
        this._httpService
            .getArrayList(
                {
                    method: 'get',
                    page: 1,
                    limit: 10,
                    where: { gapid: this._gapService.getGapId() }
                },
                'gapagreement/list?filter'
            )
            .subscribe(res => {
                if (res && (res instanceof Array)) {
                    const agreementDetail = res[0];
                    this.maxenddate = agreementDetail.enddate;
                    this.agrementEndDate = agreementDetail.enddate;
                    this.agrementStartDate = new Date(agreementDetail.startdate);
                } else {
                    this.maxenddate = null;
                }
            });
    }

    childPlacementList() {
        this._httpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 10,
                    method: 'get',
                    where: { servicecaseid: this.id },
                }),
                'placement/getplacementbyservicecase?filter'
                // CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.InvolvedPersonList + '?filter'
            ).subscribe(result => {
                if (result && result.data) {
                    if (this._dataStoreService.getData('placed_child') && this._dataStoreService.getData('placed_child').cjamspid) {
                        this.placmentDetails = result.data.find(item => item.cjamspid === this._dataStoreService.getData('placed_child').cjamspid);
                        this.providerDetails = (this.placmentDetails && this.placmentDetails.placements && this.placmentDetails.placements.length && this.placmentDetails.placements[0].providerdetails) ?
                            this.placmentDetails.placements[0].providerdetails : null;
                        if (this.providerDetails) {
                            this.getOverPaymentList(this.providerDetails.provider_id, this._dataStoreService.getData('placed_child').cjamspid);
                        }
                    }
                }
            });
    }
    getOverPaymentList(providerID: any, clientid: any) {
        this._httpService.getPagedArrayList({
            where: {
                providerid: providerID,
                client_id: clientid
            },
            page: 1,
            limit: null,
            nolimt: true,
            method: 'get'
        }, FinanceUrlConfig.EndPoint.accountsReceivable.overpayments.list).subscribe((res: any) => {
            if (res && res.data && res.data.length) {
                this.overpayments = res.data;
            }
        });
    }

    fiscalAudit() {
        this._financeService.getChangeHistory(1, this.gapAlternateID, 'gapsuspension');
    }

    filterGaps = (d: any): boolean => {
        // Prevent dates in ranges from being selected.
        if (this.suspesionReason && this.suspesionReason.length) {
            const validSuspensions = this.suspesionReason.filter(item => item.routingstatus !== 'Rejected');
            return !validSuspensions.some(item => {
                 const startDate =item.startdate ? moment(item.startdate).format(this.dtformat) : null;
                 const endDate = item.enddate ? moment(item.startdate).format(this.dtformat) : null;
                 const calanderDate = moment(d).format(this.dtformat);
                 if (endDate && startDate) {
                    return calanderDate >= startDate && calanderDate <= endDate;
                 } else {
                    return false;
                 }
            });
        } else {
            return true;
        }
    }

    suspensionStartDateChanged() {
        const suspensionStartDate = new Date(this.assignmentForm.getRawValue().startdate);
        this.assignmentForm.patchValue({enddate: null});

        let validSuspensions = this.suspesionReason.filter(item => item.routingstatus !== 'Rejected');
        if (this.suspensionReason) {
            validSuspensions = validSuspensions.filter(item => item.gapsuspensionid !== this.suspensionReason.gapsuspensionid);
        }
        const orderedSupensions = _.orderBy(validSuspensions, ['startdate'], ['asc']);

        const firstMaxItem = orderedSupensions.find((item: any) => new Date(item.startdate) >= new Date(suspensionStartDate));
        if (firstMaxItem) {
            this.maxenddate =  moment(firstMaxItem.startdate).add(-1, 'days').toDate();
        } else {
            this.maxenddate = this.agrementEndDate;
        }


    }

    openSuspensionNotes(suspensionInfo: any) {
        if (suspensionInfo && suspensionInfo.notes) {
            this.suspensionNotes = this.fixNarrativeHistoryClearanceText(suspensionInfo.notes);
        } else {
            this.suspensionNotes = '';
        }
        $('#narrative-dialog').modal('show');
    }

    fixNarrativeHistoryClearanceText(narr: string) {
        let n: string = narr;
        if (n) {
            n = n.replace(/(\\n)/g, '<br>');
            n = n.replace(/(\\r)/g, '');
            n = n.replace(/&nbsp;/g, ' ')
            n = n.replace(/''/g, `'`);
        }
        return n;
    }

    getErrorsMessage(ControlName: any, displayName: any){
        if(this.assignmentForm.controls[ControlName].status =='INVALID' ){
        return 'Please enter valid ' + displayName
        }
    }

    toMidnight(date: any) {
        if (!date) return null;
        const d = new Date(date);
        d.setHours(0, 0, 0, 0);
        return d;
      }

}
