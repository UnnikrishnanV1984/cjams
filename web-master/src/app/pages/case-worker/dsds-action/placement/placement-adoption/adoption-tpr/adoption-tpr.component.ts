
import {map} from 'rxjs/operators';
import { ChangeDetectionStrategy, ChangeDetectorRef, Component, Injector, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../../../../@core/services/common-http.service';
import { PaginationRequest, DynamicObject, DropdownModel } from '../../../../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { ActivatedRoute, Router } from '@angular/router';
import { DataStoreService, AuthService } from '../../../../../../@core/services';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { InvolvedPerson } from '../../../../_entities/caseworker.data.model';
import { Observable } from 'rxjs';
import { AlertService } from '../../../../../../@core/services/alert.service';
import { TprDetails } from '../_entities/adoption.model';
import { CourtOrderList } from '../../../court/_entities/court.data.model';
import { DSDS_STORE_CONSTANTS } from '../../../dsds-action.constants';
import { PlacementAdoptionService } from '../placement-adoption.service';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { NavigationUtils } from '../../../../../_utils/navigation-utils.service';
import _ from 'lodash';
import moment from 'moment';
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'adoption-tpr',
    templateUrl: './adoption-tpr.component.html',
    styleUrls: ['./adoption-tpr.component.scss'],
    changeDetection: ChangeDetectionStrategy.OnPush,
    standalone: false
})
export class AdoptionTprComponent implements OnInit {
    private id!: string;
    private childActorId!: string;
    private spclientid!: string;
    store: DynamicObject;
    tprDetailsForm!: FormGroup;
    isTermination!: boolean;
    involvedPersons: InvolvedPerson[] = [];
    appealDecisionDropdownItems$!: Observable<DropdownModel[]>;
    terminationtypDropdownItems$!: Observable<DropdownModel[]>;
    methodServiceDropdownItems$!: Observable<DropdownModel[]>;
    tprListDetails: TprDetails[] = [];
    addEditLabel!: string;
    updateButton!: boolean;
    hearingData: any[] = [];
    courtOrder: CourtOrderList[] = [];
    private daNumber!: string;
    alertMessage!: string;
    remainingPeople: InvolvedPerson[] = [];
    isAdoptionCreated!: boolean;
    alertText!: string;
    deletingTPR: any;
    selectedChildarray: any[] = [];
    everbeenadoptedflag: any;
    everadoptedsingleparentcheck: any;
    tprRecommendationList: any;
    isEditDisabled = false;
    isDeleteDisabled = false;
    checkrequired: boolean= false;
    tpralertpopupid = '#tpr-alert-dialog';
    gettypesurl = 'referencetype/gettypes';
    terminationofparentalpopupid = '#termination-ofparental';
    hearingtypeArray: any = {};
    adoptionTprTableList: any[] = [];
    adoptionCourtTprTableList: any[] = [];
    private route: ActivatedRoute;
    private _store: DataStoreService;
    private _commonHttp: CommonHttpService;
    private _formBuilder: FormBuilder;
    private _alertService: AlertService;
    private _router: Router;
    private _PlacementAdoptionService: PlacementAdoptionService;
    private cdr: ChangeDetectorRef;
    
    constructor(
        private readonly injector : Injector,
        private _dataStoreService: DataStoreService,
        private _navigationService: NavigationUtils,
        public _authService: AuthService
    ) {
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._store = this.injector.get<DataStoreService>(DataStoreService);
        this._commonHttp = this.injector.get<CommonHttpService>(CommonHttpService);
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._router = this.injector.get<Router>(Router);
        this._PlacementAdoptionService = this.injector.get<PlacementAdoptionService>(PlacementAdoptionService);
        this.cdr = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);

        this.store = this._store.getCurrentStore();
    }

    ngOnInit() {
        this.isEditDisabled = this._authService.isDisabled('adoptionplanning','adoptionplanning.tpr.edit');
        this.isDeleteDisabled = this._authService.isDisabled('adoptionplanning','adoptionplanning.tpr.delete');
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.getCourtOrderDetails();
        this.addEditLabel = 'Add';

        this.getBreaklink();
        this.tprDetailsForm = this._formBuilder.group({
            intakeservicerequestactorid: ['', [Validators.required]],
            serveddate: [null],
            servicetypekey: [''],
            terminationtypekey: [''],
            isappealed: [null],
            isdssappealed: [null],
            appealdate: [null],
            appealdecisiontypekey: [''],
            decisiondate: [null],
            reason: [''],
            parentname: [''],
            tprdetailsid: [null],
            tprdecisiondate: [null],
            tprpetitiondate: [null],
            relationshiptypekey: [null],
            isdenied: [null],
            isgranted: [null],
            iscontested: [null],
            singleparent: [null],
            isdisabled: [false]
        });

        this.getrecommendationlist();
        this.getInvolvedPerson();
        this.getsingleparentcheckinfo();
        this.getAppealDecisionDropdown();
        this.getTerminationTypeDropdown();
        this.getMethodServiceDropdown();
        this.gethearingDetails();
        this.tprDetailsForm.controls['parentname'].disable();
        this._PlacementAdoptionService.storeDataPatched$.subscribe(data => {
            if (data === 'LegalCustody') {
                this.ValidateStoreValues();
            }
        });
        this.getHearingTypeDropdown();
    }

    singleParentChecked($event: any){
        if($event.checked){
            if(this.tprListDetails && this.tprListDetails.length && this.tprListDetails.length>1){
                this.alertText = `Cannot select "Single Parent" checkbox, as there are more than one parents added with TPR.  
                Please remove one parent TPR to identify 'Single Parent'.
                `;
                $(this.tpralertpopupid).modal('show');
                this.tprDetailsForm.patchValue({
                    singleparent: false
                });
                return;
            }
        }
        if(this.tprListDetails && this.tprListDetails.length){
            this._commonHttp.patch(this.tprListDetails[0]['tprdetailsid'], {singleparent : $event.checked}, 'tprdetails').subscribe(data => {
                if(data && data.tprdetailsid && data.singleparent==$event.checked){
                    this._alertService.info("Successful");
                }else{
                    this._alertService.error("Server error occurred");
                }
                this.getTPRList();
            });
        }
    }


    private getBreaklink() {
        this._commonHttp
          .getArrayList({
            method: 'get', where: {
              adoptionplanningid: this._PlacementAdoptionService.getAdoptionPlanning().adoptionplanningid
            }
          }, 'adoptionbreakthelink/getadoptionbreakthelink?filter')
          .subscribe(res => {
            if (res && res.length) {
              res.forEach((item) => {
                  if(item && item.getadoptionbreakthelink) {
                    this.returnBreaklinkFn(item);
                  }
              });
            }
          });
      }
      // Assosiated with getBreaklink method
    private returnBreaklinkFn(item: any) {
        return item.getadoptionbreakthelink.map((breaklink: { adoptioncasenumber: any; }) => {
            this.isAdoptionCreated = (breaklink.adoptioncasenumber) ? true : false;
            return breaklink;
        });
    }

    ValidateStoreValues() {
        if (this.store['CASEUID']) {
        this.id = this.store['CASEUID'];
        }
        if (
            !this.store['LegalCustodyDetails'] ||
            !this.store['LegalCustodyDetails'].length
        ) {
        $('#ap-tpr').modal('show');
        } else {
            if (!this.store['LegalCustodyDetails'].filter((custody: { legalcustodytypekey: string; }) => custody.legalcustodytypekey === 'GUARDDSS').length) {
                $('#ap-tpr').modal('show');
                this.alertMessage = 'Please complete the Legal Custody with Guardianship to DSS';
            } 
        }
    }
    getsingleparentcheckinfo() {
        this.spclientid = this.store['placement_child'] ? this.store['placement_child'].personid : this.returnSpclientidFn();

        return this._commonHttp
        .getArrayList(
            new PaginationRequest({
                where: {
                    spclientid: this.spclientid ? this.spclientid : null
                },
                method: 'get'
            }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.SingleParentCheckInfo + '?filter'
        ).subscribe(res => {
                if(res && res.length) {
                    this.everadoptedsingleparentcheck = res[0].singleparent;
                }
            }
        )
    }
    // Assosiated with getsingleparentcheckinfo method
    private returnSpclientidFn(): string | null {
        return (this.store['spclientid'] ? this.store['spclientid'] : null);
    }

    gethearingDetails() {
        if (this.id) {
            this._commonHttp
                .getArrayList(
                    {
                        method: 'get',
                        where: {
                            intakeserviceid: this.id
                        }
                    },
                    CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.GetCourtOrderUrl + '?filter'
                )
                .subscribe(result => {
                    if (result[0]) {
                        this.courtOrder = result;
                    }
                });
        }
    }


    getCourtOrderDetails() {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');

        const isServiceCase = this._dataStoreService.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        let hearingReqObj = {};
        if (isServiceCase) {
            hearingReqObj = {
                objectid: this.id,
                objecttype: 'servicecase',
                isExpungementSuperUser: isExpungementSuperUser,
                'iscaseexpunged': iscaseexpunged
            };
        } else {

            hearingReqObj = { intakeservicerequestid: this.id ,isExpungementSuperUser:isExpungementSuperUser,'iscaseexpunged':iscaseexpunged};
        }
        if (this.id) {
            this._commonHttp
                .getArrayList(
                    {
                        method: 'get',
                        where: hearingReqObj
                    },
                    CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.getHearingUrl + '?filter'
                )
                .subscribe(result => {
                    if (result[0]) {
                        this.hearingData = result.filter(item =>( (item.hearingtype.includes('TGU') || item.hearingtype.includes('TGC') )&& item.hearingstatustypekey === 'CONCULD'));                   
                        this.buildAdoptionCourtTprTableList();
                        this.cdr.markForCheck();
                    }
                });
        }
    }

    isSetValidator(item: any) {
        if (item) {
            this.tprDetailsForm.controls['isdssappealed'].setValidators([Validators.required]);
            this.tprDetailsForm.controls['appealdate'].setValidators([Validators.required]);
            this.tprDetailsForm.controls['appealdate'].updateValueAndValidity();
            this.tprDetailsForm.controls['isdssappealed'].updateValueAndValidity();
        } else {
            this.tprDetailsForm.controls['isdssappealed'].clearValidators();
            this.tprDetailsForm.controls['appealdate'].clearValidators();
            this.tprDetailsForm.controls['appealdate'].updateValueAndValidity();
            this.tprDetailsForm.controls['isdssappealed'].updateValueAndValidity();
        }
    }

    cancelTRPDetails() {
        this.isSetValidator(false);
        this.tprDetailsForm.reset();
        this.updateButton = false;
        this.addEditLabel = 'Add';
        this.checkrequired =false;
    }
    clearTPRDetails() {
        this.tprDetailsForm.reset();
    }

    private getAppealDecisionDropdown() {
        this.appealDecisionDropdownItems$ = this.returnDecisionDropdownFn('29');
    }

    private getMethodServiceDropdown() {
        this.methodServiceDropdownItems$ = this.returnDecisionDropdownFn('35');
    }
    // Assosiated with getAppealDecisionDropdown and getMethodServiceDropdown methods
    private returnDecisionDropdownFn(id: string): Observable<DropdownModel[]> {
        return this._commonHttp
            .getArrayList(
                {
                    where: {
                        referencetypeid: id,
                        teamtypekey: null
                    },
                    method: 'get',
                    nolimit: true
                },
                this.gettypesurl + '?filter'
            ).pipe(
                map(result => {
                    return result.map(
                        res => new DropdownModel({
                            text: res.description,
                            value: res.ref_key
                        })
                    );
                }));
    }

    filterRemainingPersons() {
        this.remainingPeople = this.involvedPersons.filter(item => {
            let isExist = false;
            if (this.tprListDetails) {
                isExist = this.tprListDetails.some((ele: any) =>
                    ele.intakeservicerequestactorid === (item.intakeservicerequestactorid)
                );
            }
            return !isExist;
        });

        let needtocreateperson = false;

        //court case has both parents
        needtocreateperson = (this.involvedPersons && this.involvedPersons.length == 2);

        //court case has one parent.
        if(!needtocreateperson && this.involvedPersons.length == 1) {
            
            if(this.tprListDetails.length == 0 || (this.tprListDetails.length== 1 && !this.tprListDetails[0].parentname.includes('1'))){
                this.remainingPeople.push(this.createUnknownParent(1));
            }
            needtocreateperson = true;
        }
        //court case has no parent

        if(!needtocreateperson && this.tprListDetails.length == 0){
            this.remainingPeople.push(this.createUnknownParent(1));
            this.remainingPeople.push(this.createUnknownParent(2));
            needtocreateperson = true;
        }
        if(!needtocreateperson && this.tprListDetails.length == 1 && this.tprListDetails[0].parentname.includes('1')){
            this.remainingPeople.push(this.createUnknownParent(2));
            needtocreateperson = true;
        }
        if(!needtocreateperson){
            this.remainingPeople.push(this.createUnknownParent(1));
        }
        this.remainingPeople.sort((a, b) => a.fullname.localeCompare(b.fullname));
    }

    manageTPR(type: any, item?: any) {
        this.removeUnwantedPersons();
        if (type === 'add') {
            const form = this.tprDetailsForm.getRawValue();
            if (
                form.singleparent &&
                this.tprListDetails &&
                this.tprListDetails.length &&
                this.tprListDetails.length === 1
            ) {
                this.alertText = `Cannot record TPR for another parent as "Single Parent" Checkbox is selected.  
                Please uncheck "Single Parent" Checkbox to add TPR for both parents.
                `;
                $(this.tpralertpopupid).modal('show');
                return;
            }
            this.filterRemainingPersons();
            this.addEditLabel = 'Add';
            this.updateButton = false;
            this.checkrequired = false;
            this.tprDetailsForm.reset({}, { emitEvent: false });
            this.tprDetailsForm.enable({ emitEvent: false });
            this.tprDetailsForm.patchValue({
                tprdetailsid: null,
                singleparent: this.everadoptedsingleparentcheck
            }, { emitEvent: false });

            $(this.terminationofparentalpopupid).modal('show');
            return;
        }
        if (type === 'delete') {
            this.deletingTPR = item;
            this.alertText = 'Are you sure you want to remove this parent from TPR';
            $(this.tpralertpopupid).modal('show');
            return;
        }
        this.checkrequired = false;
        this.tprDetailsForm.reset({}, { emitEvent: false });
        this.tprDetailsForm.enable({ emitEvent: false });

        this.remainingPeople = this.involvedPersons.filter(
            e => e.roles.some(r => r.intakeservicerequestactorid === item.intakeservicerequestactorid)
        );

        this.handleMultiRoleParentPatching(item);
        this.handleRemainingPeopleLoopFn(item);

        if (this.remainingPeople && this.remainingPeople.length === 0) {
            const unknownParent = this.tprListDetails.filter(
                e => e.intakeservicerequestactorid === item.intakeservicerequestactorid
            )[0];
            this.remainingPeople.push(this.createUnknownParent(unknownParent));
        }

        item.isdssappealed =
            item.isdssappealed !== null && item.isdssappealed !== undefined
                ? `${item.isdssappealed}`
                : null;
        this.tprDetailsForm.patchValue(item, { emitEvent: false });
        this.isSetValidator(item.isappealed);
        if (type === 'view') {
            this.addEditLabel = 'View';
            this.updateButton = true;
            this.setTprViewMode();
        } else if (type === 'edit') {
            this.addEditLabel = 'Edit';
            this.updateButton = true;
            this.setTprEditMode();
        }

        $(this.terminationofparentalpopupid).modal('show');
        setTimeout(() => {
            if (type === 'view') {
                this.setTprViewMode();
            }
            if (type === 'edit') {
                this.setTprEditMode();
            }
            this.cdr.detectChanges();
        });
    }
    // Assosiated to manageTPR method
    private handleRemainingPeopleLoopFn(item: any) {
        if (this.remainingPeople && this.remainingPeople.length) {
            this.remainingPeople.forEach((i) => {
                if (i.roles && i.roles.length) {
                    const role = i.roles.filter(r => r.intakeservicerequestpersontypekey === 'PARENT');
                    if (role === null || role.length === 0) { //CIDM-10003 - Resolving multiple role display issues
                        item.intakeservicerequestactorid = i.roles[0].intakeservicerequestactorid;
                    }

                }
            });

        }
    }

    deleteConfirm(){
        this._commonHttp.patch(this.deletingTPR.tprdetailsid, {activeflag : 0}, 'tprdetails').subscribe(data => {
            if(data && data.tprdetailsid && data.activeflag==0){
                this._alertService.info("Successfully removed parent.");
            }else{
                this._alertService.error("Error removing parent.");
            }
            this.deletingTPR = null;
            this.getTPRList();
        });
    }
    private getTerminationTypeDropdown() {
        this.terminationtypDropdownItems$ = this.returnDecisionDropdownFn('30');
    }

    getrecommendationlist(){    
        if(this.store['placement_child']){
            const permanencyPlanId = this.store['placement_child'].permanencyplanid;
            const childpersonid =  
                this.store?.['placement_child']?.personid ?? 
                this.returnSpclientidFn() ??
                this.store?.['placed_child']?.personid;
            this._store.setData('spclientid', this.spclientid);
            this._PlacementAdoptionService.getRecommendedListByPerson(this.id, permanencyPlanId, childpersonid)
            .subscribe(res => {
                this.tprRecommendationList = res;
                this.getTPRList();
            })
        }        
    }
    

     private getTPRList() {
        this.tprListDetails = [];
        const listOfTPRRecommendationId: any[] = [];

        if (this.tprRecommendationList?.tprlist?.length) {
            this.tprRecommendationList.tprlist.forEach((tpr: any) => {
                listOfTPRRecommendationId.push(tpr.tprrecommendationid);
            });
        }

        this.spclientid =
            this.store?.['placement_child']?.personid ??
            this.returnSpclientidFn() ??
            this.store?.['placed_child']?.personid ??
            null;

        this._store.setData('spclientid', this.spclientid);

        this._PlacementAdoptionService
            .getTPRListForUnknownParent(this.id, this.spclientid)
            .subscribe(res => {
                this.handleGetTPRListForUnknownParentRespFn(res, listOfTPRRecommendationId);
            });
    } 
    // Assosiated to getTPRList method
    private handleGetTPRListForUnknownParentRespFn(res: any[], listOfTPRRecommendationId: any[]) {
        if (res && res.length) {
            const trplistinfo: any[] = [];
            const result = res;
            res = this.filterResFn(res, trplistinfo, listOfTPRRecommendationId);

            this.trplistinfocheck(trplistinfo, result);
            this.buildAdoptionCourtTprTableList();

            this._store.setData(DSDS_STORE_CONSTANTS.TPR_LIST, res);
            if (this.tprListDetails && this.tprListDetails.length) {
                this.tprDetailsForm.patchValue({
                    singleparent: this.tprListDetails[0].singleparent
                });
            } else {
                this.tprDetailsForm.patchValue({
                    singleparent: this.everadoptedsingleparentcheck
                });
            }
            this.checkTPRPlacement();
        }
    }
    // Assosiated to getTPRList method
    private filterResFn(res: any[], trplistinfo: any[], listOfTPRRecommendationId: any[]) {
        res = res.filter(item => {
            if (item.old_id) {
                return true;
            } else if (item.intakeservreqcourtorderid) {
                this.handleHearingDataLoopFn(item, trplistinfo);
            } else if (!item.intakeservreqcourtorderid && item.personid == this.spclientid) {
                trplistinfo.push(item);
                return true;

            } else {
                return listOfTPRRecommendationId.includes(item.tprrecommendationid);
            }
        });
        this.cdr.markForCheck();
        return res;
    }
    // Assosiated to getTPRList method
    private handleHearingDataLoopFn(item: any, trplistinfo: any[]) {
        if (this.hearingData && this.hearingData.length) {
            this.hearingData.forEach((h) => {
                if (h.intakeservicerequestpetition && h.intakeservicerequestpetition.intakeservicerequestpetitionid == item.intakeservreqcourtorderid) {
                    h.hearingclientdetails.forEach((p: { personid: string; }) => {
                        if (p.personid == this.spclientid) {
                            trplistinfo.push(item);
                            return true;
                        }
                        return false;
                    });
                    return true;
                }
                return false;
            });
        }
    }

    tprlistdetailscheckelse(){
        if(this.tprListDetails && this.tprListDetails.length){
            this.tprDetailsForm.patchValue({
                singleparent: this.tprListDetails[0].singleparent
            });
        }else {
                this.tprDetailsForm.patchValue({
                    singleparent: this.everadoptedsingleparentcheck
                });
            }
    }
    trplistinfocheck(trplistinfo: any,result: any){
        if(trplistinfo && trplistinfo.length) {
            const tprsortlistinfo =  trplistinfo.filter((list: { personid: string; }) => (list.personid == this.spclientid));
            const sorting = _.sortBy(tprsortlistinfo ,'tprdecisiondate').reverse();
            sorting.sort((a: any, b: any) =>
                (b.intakeservreqcourtorderid ? 1 : 0) -
                (a.intakeservreqcourtorderid ? 1 : 0)
            );
            const filterUnique = _.uniqBy(
                sorting,
                (item: any) =>
                    `${item.intakeservreqcourtorderid}_${item.intakeservicerequestactorid}_${(item.parentname || '').trim().toLowerCase()}`
            );
            this.tprListDetails = filterUnique;
        } else {
            const sorttrplistinfo = result.filter((list: { personid: string; }) => (list.personid == this.spclientid));
            const sorting = _.sortBy(sorttrplistinfo, 'tprdecisiondate').reverse();
            const filterUnique = _.uniqBy(
                sorting,
                (item: any) =>
                    `${item.intakeservreqcourtorderid}_${item.intakeservicerequestactorid}_${(item.parentname || '').trim().toLowerCase()}`
            );
            this.tprListDetails = filterUnique;
        }
        
    }

    checkTPRPlacement() {
        //If TPR completed and missing pre-adoptive placement
        if(this.tprListDetails && this.tprListDetails.length){
            //if 2 parents or 1 parent & sigle parent checked
            if(
                this.tprListDetails.length === 2 ||
                (this.tprListDetails.length === 1 && this.tprListDetails[0].singleparent)
            ) {
            $('#tpr-completion-placement').modal('show');
            }
        }
        this.cdr.markForCheck();
    }

    private createUnknownParent(unknownparent: any){
        const otherperson: InvolvedPerson = new InvolvedPerson();

        if(unknownparent && unknownparent.intakeservicerequestactorid){
            const nameParts = unknownparent.parentname.trim().split(/\s+/);
            otherperson.firstname = nameParts.shift();
            otherperson.lastname = nameParts.join(' ');
            otherperson.intakeservicerequestactorid = unknownparent.intakeservicerequestactorid;
            otherperson.fullname = unknownparent.parentname;
            otherperson.roles = [
                {"typedescription": "unknown"}
            ];
        }else{
            otherperson.firstname = 'Parent';
            otherperson.lastname = unknownparent;
            otherperson.intakeservicerequestactorid = unknownparent;
            otherperson.relationshipdescription = "";
            otherperson.fullname = 'Parent '+ unknownparent;
            otherperson.roles = [
                {"typedescription": "unknown"}
            ];
        }
        return otherperson; 
    }

    navigateToPlacement() {
        const redirectUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/sc-placements/list';
        this._navigationService.dsdsActionTabSwitch$.next('placementTab');
        this._router.navigate([redirectUrl]);
    }
 
    private getInvolvedPerson() {
        this._commonHttp
            .getArrayList(
                {
                    page: 1,
                    method: 'get',
                    where: {objectid: this.id , objecttypekey : 'servicecase'}
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
            )
            .subscribe((res: any) => {
                if (res['data'] && res['data'].length) {
                    this.selectedChildarray = [];
                    const cjamspid = this._dataStoreService.getData('childforGAP');
                    this.handleResMapFn(res, cjamspid);
            
                    if(this.selectedChildarray && this.selectedChildarray.length) {
                        this.everbeenadoptedflag = this.selectedChildarray[0].everbeenadoptedflag;
                    }

                    this.handleInvolvedPersonsFn(res);
                    //  Filter Relative Type Only
                    // .filter(item => {
                    //     if ( !item.rolename || item.rolename === '') {

                    //         if ( item.roles &&  item.roles.length &&  item.roles[0].intakeservicerequestpersontypekey) {
                    //             item.rolename  = item.roles[0].intakeservicerequestpersontypekey; }
                    //     }
                    //     // tslint:disable-next-line:max-line-length
                    //     if (item.rolename === 'RELATIVE') {
                    //         console.log(item);
                    //         return item;
                    //     }
                    // });
                }
            });
    }
    // Assosiated to getInvolvedPerson method
    private handleResMapFn(res: any, cjamspid: any) {
        res['data'].map((item: { rolename: string; roles: string | any[]; cjamspid: any; }) => {
            if (!item.rolename || item.rolename === '') {
                if (item.roles && item.roles.length && item.roles[0].intakeservicerequestpersontypekey) {
                    item.rolename = item.roles[0].intakeservicerequestpersontypekey;
                }
            }
            const rolename = item.rolename ? item.rolename : '';
            const child = ['CHILD', 'AV', 'OTHERCHILD', 'RC'].includes(rolename);
            if (child && item.cjamspid === cjamspid) {
                this.selectedChildarray.push(item);
            }
        });
    }

    // Assosiated to getInvolvedPerson method
    private handleInvolvedPersonsFn(res: any) {
        this.involvedPersons = res['data'].filter((item: { rolename: string; roles: string | any[]; intakeservicerequestactorid: any; }) => {
            if (!item.rolename || item.rolename === '') {

                if (item.roles && item.roles.length && item.roles[0].intakeservicerequestpersontypekey) {
                    item.rolename = item.roles[0].intakeservicerequestpersontypekey;
                }
            }
            if (item.rolename &&
                item.rolename !== 'AV' &&
                //  item.rolename !== 'AM' &&
                item.rolename !== 'CHILD' &&
                item.rolename !== 'RC' &&
                item.rolename !== 'BIOCHILD' &&
                item.rolename !== 'NVC' &&
                item.rolename !== 'OTHERCHILD' &&
                item.rolename !== 'PAC'
                // (item.roles.length &&
                //     item.roles.filter(
                //         itm =>
                //             itm.rolename !== 'AV' &&
                //             itm.rolename !== 'AM' &&
                //             itm.rolename !== 'CHILD' &&
                //             itm.rolename !== 'RC' &&
                //             itm.rolename !== 'BIOCHILD' &&
                //             itm.rolename !== 'NVC' &&
                //             itm.rolename !== 'OTHERCHILD' &&
                //             itm.rolename !== 'PAC'
                //     ))
            ) {
                if (!item.intakeservicerequestactorid) {
                    if (item.roles && item.roles.length && item.roles[0].intakeservicerequestactorid) {
                        item.intakeservicerequestactorid = item.roles[0].intakeservicerequestactorid;
                    }
                }
                return item;
            }
        });
    }

    private removeUnwantedPersons(){
        const requiredPersons: InvolvedPerson[] = this.involvedPersons.filter(itemData => 
            (this.tprRecommendationList.courtorder && this.tprRecommendationList.courtorder[0].hearingclientdetails.map((item: { personid: any; })=> item.personid).includes(itemData.personid)));

        this.involvedPersons = requiredPersons;
    }

    changePerson(id: any) {
        
        const personRelation = this.involvedPersons && this.involvedPersons.length ? this.involvedPersons.filter(item => item.intakeservicerequestactorid === id) : [];
        let personnameText;
        if(personRelation && personRelation.length==0){
            const unknownparent: TprDetails[] = this.tprListDetails && this.tprListDetails.length ? this.tprListDetails.filter(item => item.intakeservicerequestactorid === id) : [];
            personnameText = (unknownparent && unknownparent[0]) ? unknownparent[0].parentname: "Person 1";
        }else{
            const unknownParent = this.remainingPeople.filter(item => item.intakeservicerequestactorid === id);
            personnameText = personRelation && personRelation.length ? personRelation[0].firstname + ' ' + personRelation[0].lastname : unknownParent[0].firstname + ' ' + unknownParent[0].lastname;
        }
        this.tprDetailsForm.patchValue({
            parentname: personnameText
        });
        this.updateTPRForm();
    }

    private updateTPRForm(){    
        if(this.tprRecommendationList && this.tprRecommendationList.courtorder && this.tprRecommendationList.courtorder[0].hearingstatustypekey === 'CONCULD'){

                const istrpcontested = this.tprRecommendationList.courtorder[0].hearingtype[0] === 'TGC';
                const istrpgranted = this.tprRecommendationList.courtorder[0].hearingoutcometypekey === 'TPRGRA';
                const tprdecisionon = this.tprRecommendationList.courtorder[0].courtorderdate;
                const tprpetitionon = this.tprRecommendationList.courtorder[0].petitiondate;

                this.tprDetailsForm.patchValue({
                    isgranted: istrpgranted,
                    iscontested: istrpcontested,
                    tprdecisiondate: tprdecisionon,
                    tprpetitiondate: tprpetitionon,
                    isdisabled: true
                });
        }        
    }
    saveTprDetail(model: any) {
        this.checkrequired =true;
        if(this.tprDetailsForm.valid){
        const TprDetailInput = model;
        TprDetailInput.isdssappealed = Number(model.isdssappealed);
        TprDetailInput.isappealed = model.isappealed ? 1 : 0;
        if (model.tprdetailsid) {
            TprDetailInput.tprdetailsid = model.tprdetailsid;
            this._commonHttp.patch(TprDetailInput.tprdetailsid, TprDetailInput, 'tprdetails').subscribe(
                res => {
                    this.checkPlacementChildCondIfTprFn();
                }
            );
        } else {
            TprDetailInput.intakeserviceid = null;
            TprDetailInput.servicecaseid = this.id;
            TprDetailInput.tprrecommendationid = this.store['TPRRecommendationId'];
            this._commonHttp.create(TprDetailInput, 'tprdetails/addtprdetail').subscribe(
                res => {
                    this.checkPlacementChildCondIfTprFn();
                }
            );
        }
    }
    else{
        this._alertService.error("Please fill all the required fields");
    }
    }
    // Assosiated to saveTprDetail method
    private checkPlacementChildCondIfTprFn() {
        if (this.store['placement_child']) {
            const permanencyPlanId = this.store['placement_child'].permanencyplanid;
            const childpersonid = this.store['placement_child'] ? this.store['placement_child'].personid : this.returnSpclientidFn();

            if (permanencyPlanId) {
                this._PlacementAdoptionService.getRecommendedListByPerson(this.id, permanencyPlanId, childpersonid)
                    .subscribe(res => {
                        this.tprRecommendationList = res;
                        this.getTPRList();
                    });
            } else {
                this.getTPRList();
            }
        }
        else {
            this.getTPRList();
        }
        this.updateButton = true;
        this._alertService.success('TPR Details saved successfully');
        $(this.terminationofparentalpopupid).modal('hide');
        this.tprDetailsForm.reset();
    }

    navigateTo(fromTPRAlert?: any) {
        const isAPPlanning = $('#ap-tpr').data('bs.modal')?.isShown;
        if(!fromTPRAlert || (fromTPRAlert && !isAPPlanning)){
        const redirectUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/sc-permanency-plan/placement/adoption/tpr-recom';
        this._PlacementAdoptionService.broadStoreDataPatched('TPRRecommend');
        this._router.navigate([redirectUrl]);
        }
    }

    // CIDM-9827 TPR Patching issue associated with manageTPR function
    handleMultiRoleParentPatching(item:any) {
        this.involvedPersons.forEach(person => {
            const needsUpdate = person.roles.some(role => 
                role.intakeservicerequestactorid === item.intakeservicerequestactorid &&
                person.intakeservicerequestactorid !== item.intakeservicerequestactorid
            );
            
            if (needsUpdate) {
                person.intakeservicerequestactorid = item.intakeservicerequestactorid;
            }
        });
    }

    getCourtPetitionId(tpr: any): string {
        return (
            tpr?.petitionid ||
            tpr?.courtpetitionid ||
            tpr?.intakeservicerequestpetition?.petitionid ||
            ''
        );
    }

    getHearingTypes(tpr: any): any[] {
        if (Array.isArray(tpr?.hearingtype)) {
            return tpr.hearingtype;
        }

        if (tpr?.hearingtype) {
            return [tpr.hearingtype];
        }

        return [];
    }

    getHearingDateTime(tpr: any): any {
        return (
            tpr?.hearingdatetime ||
            tpr?.hearingdate ||
            tpr?.tprdecisiondate ||
            null
        );
    }

    getTprDecision(tpr: any): string {
        if (tpr?.isgranted) {
            return 'TPR Granted';
        }

        if (tpr?.isdenied) {
            return 'TPR Denied';
        }

        if (tpr?.hearingoutcome && Array.isArray(tpr.hearingoutcome)) {
            return tpr.hearingoutcome
                .filter((x: any) =>
                    x?.hearingoutcomedesc === 'TPR Granted' ||
                    x?.hearingoutcomedesc === 'TPR Denied'
                )
                .map((x: any) => x.hearingoutcomedesc)
                .join(', ');
        }

        return '';
    }

    getDateTimeFormatted(date: any): string {
        if (date && moment(date).isValid()) {
            return moment(date).format('MM/DD/YYYY, h:mm A');
        }

        return '';
    }

    private getHearingTypeDropdown() {
        this._commonHttp
            .getArrayList(
                {},
                'hearingtype?filter={"nolimit":true,"order":"description"}'
            )
            .subscribe((res: any[]) => {
                if (res && res.length) {
                    res.forEach(type => {
                        this.hearingtypeArray[type.hearingtypekey] = type.description;
                    });
                }
            });
    }


 private buildAdoptionCourtTprTableList() {
    this.adoptionCourtTprTableList = [];

    if (!this.hearingData?.length || !this.tprListDetails?.length) {
        return;
    }


    const tprCourtOrderList = this.tprListDetails.filter((tpr: any) =>
        tpr.intakeservreqcourtorderid
    );

    this.hearingData.forEach((hearing: any) => {
        const petitionId =
            hearing?.intakeservicerequestpetition?.intakeservicerequestpetitionid ||
            hearing?.intakeservicerequestpetitionid;

       

        const matchedTprDetails = tprCourtOrderList.filter((tpr: any) =>
            (
                String(tpr.intakeservreqcourtorderid || '').trim() === String(petitionId || '').trim() ||
                String(tpr.intakeservicerequestpetitionid || '').trim() === String(petitionId || '').trim()
            )
        );

        matchedTprDetails.forEach((tpr: any) => {
            this.adoptionCourtTprTableList.push({
                ...tpr,

                courtpetitionid: hearing?.intakeservicerequestpetition?.petitionid || hearing?.petitionid,

                parentname: tpr?.parentname || tpr?.clientname,

                hearingtype: Array.isArray(hearing?.hearingtype)
                    ? hearing.hearingtype
                    : hearing?.hearingtype
                        ? [hearing.hearingtype]
                        : [],

                hearingdatetime: hearing?.hearingdatetime,

                tprdecision: tpr?.isgranted
                    ? 'TPR Granted'
                    : tpr?.isdenied
                        ? 'TPR Denied'
                        : '',

                originalTpr: tpr
            });
        });
    });

    this.cdr.markForCheck();
}

    private setTprEditMode(): void {
        this.tprDetailsForm.disable({ emitEvent: false });

        [
            'serveddate',
            'servicetypekey',
            'relationshiptypekey',
            'terminationtypekey',
            'isappealed',
            'reason'
        ].forEach(controlName => {
            this.tprDetailsForm.get(controlName)?.enable({ emitEvent: false });
        });

        this.tprDetailsForm.get('isdisabled')?.enable({ emitEvent: false });
        this.tprDetailsForm.patchValue({
            isdisabled: false
        }, { emitEvent: false });
    }

    private setTprViewMode(): void {
        this.tprDetailsForm.disable({ emitEvent: false });

        this.tprDetailsForm.get('isdisabled')?.enable({ emitEvent: false });
        this.tprDetailsForm.patchValue({
            isdisabled: true
        }, { emitEvent: false });
    }

    private resetTprModalState(): void {
        this.tprDetailsForm.reset({}, { emitEvent: false });
        this.tprDetailsForm.enable({ emitEvent: false });
        this.checkrequired = false;
    }

    getSelectedParentName(): string {
        const actorId = this.tprDetailsForm?.get('intakeservicerequestactorid')?.value;

        const selectedParent = this.remainingPeople?.find(
            (person: any) => person?.intakeservicerequestactorid === actorId
        );

        if (!selectedParent) {
            return '';
        }

        return `${selectedParent.firstname || ''} ${selectedParent.lastname || ''}`.trim();
    }

}
