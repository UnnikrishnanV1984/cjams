
import {share, pluck, map} from 'rxjs/operators';
import { AppConstants } from './../../../../../@core/common/constants';

import { ChangeDetectionStrategy, ChangeDetectorRef, Component, Injector, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormControl, FormArray, AbstractControl, ValidatorFn, ValidationErrors} from '@angular/forms';
import moment from 'moment';
import { Observable ,  forkJoin ,  Subject } from 'rxjs';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import {  PaginationRequest } from '../../../../../@core/entities/common.entities';
import { CommonHttpService, AlertService, DataStoreService, SessionStorageService, AuthService, CommonDropdownsService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { PetitionDetails, PetitionList } from '../_entities/court.data.model';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { AppConfig } from '../../../../../app.config';
import { HttpClient } from '@angular/common/http';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { SpeechRecognitionService } from '../../../../../@core/services/speech-recognition.service';
import { CourtResolverService } from '../court-resolver-service';
import { YouthTransitionPlanService } from '../../service-plan/youth-transition-plan-new/youth-transition-plan.service';
declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'petition-detail',
    templateUrl: './petition-detail.component.html',
    styleUrls: ['./petition-detail.component.scss'],
    changeDetection: ChangeDetectionStrategy.OnPush,
    standalone: false
})

export class PetitionDetailComponent implements OnInit {
    id: string;
    involvedYouth!: string;
    hearingType$!: Observable<any[]>;
    petitionType$!: Observable<any[]>;
    countyList$!: Observable<any[]>;
    countyList: any;
    notification!: string | null;
    petitionTypeList: any;
    speechRecogninitionOn!: boolean;
    speechData!: string;
    recognizing = false;
    recordDropDown: any;
    placementDropDown: any;
    petitionDetailsForm!: FormGroup;
    isViewMode: boolean = false;
    hearingDetailsForm!: FormGroup;
    personid!: string;
    witnessForm!: FormGroup;
    viewMode!: boolean;
    cinaForm!: FormGroup;
    cinasubpoenadForm!: FormGroup;
    cinaSiblingForm!: FormGroup;
    petitionDetails!: PetitionDetails;
    involvedPersons$!: Observable<any[]>;
    involvedPersons: any[] = [];
    clientActor: any[] = [];
    attorneyList: any[] = [];
    selectedPetition: any;
    times: string[] = [];
    petitonListDetails: PetitionList[] = [];
    updateButton!: boolean;
    petitionfocusid: any; // changing to single select
    clientactorsid : any;
    intakeservicerequestpetitionactors: any[] = [];
    clientActors: any[] = [];
    isTPRvalidate!: boolean;
    showWaiverReason!: boolean;
    aggravatedCircumstancesList: any[] = [];
    petitionwitness: any[] = [];
    showDownloadButton!: boolean;
    baseUrl: string;
    cinaPeitition: any;
    userInfo!: AppUser;
    supervisorsList: any[] = [];
    cinasubpoenad: any[] = [];
    cinaSibling: any[] = [];
    selectedIndex!: number;
    typeOfRecord: any[] = [];
    intakeReceivedDate!: Date;
    isClosed = false;
    collateralAttorney: any[] = [];
    quillToolbar = AppConstants.NARRATIVE.TOOLBAR_CONFIG;
    isDeleteDisabled = false;
    isEditDisabled = false;
    deleteItem: any;
    selectPersonNameList: string[] = [];
    selectOtherPersonNameList: string[] = [];
    isReadonly!: boolean;
    cinaadd!: boolean;
    displayValidationMessages = false;
    displayValidationMessagesForParent = false;
    generatedocurl = 'evaluationdocument/generateintakedocument';
    deletepopupid = '#delete-popup';
    personwithlegalcustodyuuid = '0073467a-242b-4276-9f48-7904e494acb2';
    errmsg = 'Please enter valid ';
    isSsnHiddenP1 = true;
    ssnEyeP1 = 'fa-eye';
    showSsnMaskP1 = true;
    isSsnHiddenP2 = true;
    ssnEyeP2 = 'fa-eye';
    showSsnMaskP2 = true;
    apgtFormArray!: FormArray;
    openApgtPanelsByActorId: Record<string, boolean> = {}
    removaldate: any;
    twelvehour: boolean = true;
    timeInterval: number = 5;
    iscaseexpunged: any = 0;
    parents: any[] = [];
    parentActors: any[] = [];
    displayParents : boolean = false;
    readonly UNKNOWN_PARENT_VALUE = 'UNKNOWN';
    private readonly _commonHttpService: CommonHttpService;
    private readonly _formBuilder: FormBuilder;
    private readonly _datastore: DataStoreService;
    private readonly _session: SessionStorageService;
    private readonly _alertService: AlertService;
    private _ytpService: YouthTransitionPlanService;
      private _commonDropDownService: CommonDropdownsService;
    public _authService: AuthService;
    public cdr: ChangeDetectorRef;
    childrenPayload: any;
    interestedPersons!: any[];
    courtTabUrl!: string;
    danumber: any;
    financeByChildId: Record< string, {
                                personid?: string;
                                incomes: any[];
                                assets: any[];
                                loaded?: boolean;
                                loading?: boolean;
                                error?: string;
                            }
                            > = {};
    public placementDetails: any[] = [];
    selectedPersonDetails: any;
    childList: any[] = [];
    private allCollateralDetails:any = [];
    constructor(private injector: Injector,
        private readonly http: HttpClient,
        private readonly _speechRecognitionService: SpeechRecognitionService,
        private readonly _courtResolverService: CourtResolverService) {
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._datastore = this.injector.get<DataStoreService>(DataStoreService);
        this._session = this.injector.get<SessionStorageService>(SessionStorageService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._ytpService= this.injector.get<YouthTransitionPlanService>(YouthTransitionPlanService);
        this.baseUrl = AppConfig.baseUrl;
        this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.danumber = this._datastore.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.cdr = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
            this._commonDropDownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    }
    @Input()
    petitionDetailsInputSubject$ = new Subject<PetitionDetails>();
    @Input()
    trackByValue = (_: number, item: any) => item?.intakeservicerequestactorid;
    ngOnInit() {
        this.iscaseexpunged = this._datastore.getData('iscaseexpunged');
        this.isDeleteDisabled = this._authService.isDisabled('court','court.petitiondetails.delete');
        this.isEditDisabled = this._authService.isDisabled('court','court.petitiondetails.edit');
        this.loadDroddowns();
        this.getAggravatedCircumstancesList();
        this.getInvolvedPerson();
        this.getCollateralPerson();
        this.initiateFormGroup();
         this.initApgtFormArray();
        this.getPetitionDetailsList();
        this.getSupervisorsList();
        this.loadRecordDropDown();
        this.loadPlacementDropDown();
        this.isTPRvalidate = false;
        this.typeOfRecord = [];
        this.selectedIndex = -1;
        this.notification = null;

        this.petitionDetailsForm.get('parent1Unknown')?.valueChanges.subscribe(value => {
            if (value) {
                this.petitionDetailsForm.patchValue({
                    parent1: this.UNKNOWN_PARENT_VALUE
                }, { emitEvent: false });
            } else if (this.petitionDetailsForm.get('parent1')?.value === this.UNKNOWN_PARENT_VALUE) {
                this.petitionDetailsForm.patchValue({
                    parent1: null
                }, { emitEvent: false });
            }

            this.petitionDetailsForm.updateValueAndValidity({ emitEvent: false });
            this.cdr.markForCheck();
        });

        this.petitionDetailsForm.get('parent2Unknown')?.valueChanges.subscribe(value => {
            if (value) {
                this.petitionDetailsForm.patchValue({
                    parent2: this.UNKNOWN_PARENT_VALUE
                }, { emitEvent: false });
            } else if (this.petitionDetailsForm.get('parent2')?.value === this.UNKNOWN_PARENT_VALUE) {
                this.petitionDetailsForm.patchValue({
                    parent2: null
                }, { emitEvent: false });
            }

            this.petitionDetailsForm.updateValueAndValidity({ emitEvent: false });
            this.cdr.markForCheck();
        });

        this.petitionDetailsForm.get('parent1')?.valueChanges.subscribe(value => {
            this.petitionDetailsForm.patchValue({
                parent1Unknown: value === this.UNKNOWN_PARENT_VALUE
            }, { emitEvent: false });

            this.petitionDetailsForm.updateValueAndValidity({ emitEvent: false });
            this.cdr.markForCheck();
        });

        this.petitionDetailsForm.get('parent2')?.valueChanges.subscribe(value => {
            this.petitionDetailsForm.patchValue({
                parent2Unknown: value === this.UNKNOWN_PARENT_VALUE
            }, { emitEvent: false });

            this.petitionDetailsForm.updateValueAndValidity({ emitEvent: false });
            this.cdr.markForCheck();
        });
        this.petitionDetailsForm.valueChanges.subscribe((_val) => {
            this.petitionDetailsInputSubject$.next(this.petitionDetailsForm.getRawValue());
        });
        this.times = this._courtResolverService.generateTimeList(false);
        this.courtTabUrl = `/pages/case-worker/${this.id}/${this.danumber}/dsds-action/service-plan/youth-transition-plan-new`;
        const dsdsActionsSummary = this._datastore.getData('object');
        if (dsdsActionsSummary && dsdsActionsSummary.da_receiveddate) {
            this.intakeReceivedDate = new Date(dsdsActionsSummary.da_receiveddate);
        }
        this.isClosed = this._authService.iscaseclosed('courtpetition');
        const activeModuleRole = this._session.getItem('activeModuleRole');
        if (activeModuleRole === 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole === 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole === 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
          this.isReadonly = false;
        } else {
        this.isReadonly =  this._authService.readonlyButton('read_only_access','caseworker-petition-edit');}
                this.petitionDetailsForm.get('petitiontypekey')?.valueChanges.subscribe((typeKey: string) => {
            if (typeKey === 'APGT') {
                this.syncApgtFromCurrentSelection();
                this.enforceApgtAgeRuleOnSelection();
            } else {
              this.clearApgtGroups();
            }
          });
        
        // When selected children change
        this.petitionDetailsForm.get('focusname')?.valueChanges.subscribe((actorIds: string[]) => {
        if (this.petitionDetailsForm.get('petitiontypekey')?.value === 'APGT') {
            this.syncApgtFromCurrentSelection();  
            this.enforceApgtAgeRuleOnSelection();
        }
        
        });
        this.getPlacementRecordList();
    }
    initApgtFormArray() {
        this.apgtFormArray = this._formBuilder.array([]);
      }

      buildApgtChildGroup(childActorId: string): FormGroup {
        const group = this._formBuilder.group({
          childActorId,
          youthName: [{ value: '', disabled: true }],
          youthAge: [{ value: '', disabled: true }],
          youthDob: [{ value: null, disabled: true }],
          youthAddress: [{ value: '', disabled: true }],
          firstCertificationDate: [null],  // TODO: auto-populate from Checklist #2 enrollment date
      
          disabilityNarrative: [''],
      
          vaBenefits: [null],
          vaBenefitsComment: [''],
      
          interestedPersons: this._formBuilder.array([]),
          financialSummary: [''],
      
          secondCertificationBy: [null],         
          secondCertificationAppointment: [null], 
        });
       
      
        return group;
      }

    private loadFirstCertFromYTP(childActorId: string) {
        if (!childActorId) return;
    
        const cached = this.financeByChildId?.[childActorId];
        const personid = cached?.personid || this.findPersonByActorId(childActorId)?.personid;
        if (!personid) return;
    
        this._ytpService.getYTPPlanList(personid).subscribe({
        next: (plans: any[]) => {
            const eligible = (Array.isArray(plans) ? plans : [])
            .filter(p =>
                p?.approvalstatuskey === 'Approved' &&
                p?.newfcgschecklistjson?.enrollmentDate
            )
            .sort((a, b) => {
                const ad = new Date(a.approvaldate || a.updatedon || a.insertedon).getTime();
                const bd = new Date(b.approvaldate || b.updatedon || b.insertedon).getTime();
                return bd - ad; // latest first
            });
    
            const picked = eligible[0];
            if (!picked) return;
    
            const dt = this.parseDate(picked.newfcgschecklistjson.enrollmentDate);
            if (!dt) return;
    
            const idx = this.findApgtGroupIndexByActorId(childActorId);
            if (idx >= 0) {
            const fg = this.apgtFormArray.at(idx) as FormGroup;
    
            if (!fg.get('firstCertificationDate')?.value) {
                fg.patchValue({ firstCertificationDate: dt }, { emitEvent: false });
            }
            }
        },
        error: () => { 
            this._alertService?.warn('Unable to auto-populate First certification date from YTP.')
         }
        });
    }
  

        /** Ensure there's exactly one APGT group per selected child */
    syncApgtFormsWithSelectedChildren(selectedActorIds: string[]) {
        if (!Array.isArray(selectedActorIds)) selectedActorIds = [];
    
        for (let i = this.apgtFormArray.length - 1; i >= 0; i--) {
        const g = this.apgtFormArray.at(i) as FormGroup;
        const actorId = g.get('childActorId')?.value;
        if (!selectedActorIds.includes(actorId)) {
            this.apgtFormArray.removeAt(i);
            delete this.openApgtPanelsByActorId[actorId];
        }
        }
    
        selectedActorIds.forEach(actorId => {
        const exists = (this.apgtFormArray.value || []).some((v: any) => v.childActorId === actorId);
        if (!exists) {
            this.apgtFormArray.push(this.buildApgtChildGroup(actorId));
            this.preloadFinanceForChild(actorId);
            this.loadFirstCertFromYTP(actorId);
            this.openApgtPanelsByActorId[actorId] = false; // default is closed
        }
        });
    }

    private findPersonByActorId(actorId: string) {
        return (this.involvedPersons || []).find(
          p => p.intakeservicerequestactorid === actorId
        );
      }
      
      private getIncomeDetails(personid: string) {
        return this._commonHttpService.getPagedArrayList(
          new PaginationRequest({
            method: 'get',
            where: { personid }
          }),
          `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.getFinanceIncomeList}?filter`
        );
      }
      
      private getAssetDetails(personid: string) {
        return this._commonHttpService.getPagedArrayList(
          new PaginationRequest({
            method: 'post',
            where: { personid }
          }),
          `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.getFinanceAsset}?filter` 
        );
      }
      
      /** Preload income + assets for a child. */
    public preloadFinanceForChild(childActorId: string) {
        if (!childActorId) return;
        const entry = (this.financeByChildId[childActorId] ||= {
            incomes: [],
            assets: []
        });

        if (entry.loaded || entry.loading) return;

        const person = this.findPersonByActorId(childActorId);
        const personid = person?.personid;
        if (!personid) {
            entry.error = 'Missing person id';
            this.cdr.markForCheck();
            return;
        }

        entry.personid = personid;
        entry.loading = true;
        this.cdr.markForCheck();

        const income$ = this.getIncomeDetails(personid);
        const asset$ = this.getAssetDetails(personid);

        forkJoin([income$, asset$]).subscribe({
            next: ([incomeRes, assetRes]) => {
                const incomes =
                    Array.isArray((incomeRes as any)?.data)
                        ? (incomeRes as any).data
                        : (incomeRes as any)?.getfinanceincome || [];

                const assets =
                    Array.isArray((assetRes as any)?.data)
                        ? (assetRes as any).data
                        : (assetRes as any)?.[0]?.getfinanceassets
                        || (assetRes as any)?.getfinanceassets
                        || [];

                entry.incomes = incomes;
                entry.assets = assets;
                entry.loaded = true;
                entry.loading = false;
                entry.error = '';
                this.cdr.markForCheck();
            },
            error: _e => {
                entry.error = 'Unable to load finances.';
                entry.loaded = true;
                entry.loading = false;
                this.cdr.markForCheck();
            }
        });
    }    
    
    onVaBenefitsChange(index: number) {
        const g = this.apgtFormArray.at(index) as FormGroup;
        const va = g.get('vaBenefits')?.value;
        const commentCtrl = g.get('vaBenefitsComment');
        if (va === true) {
        commentCtrl?.setValidators([Validators.required]);
        } else {
        commentCtrl?.clearValidators();
        commentCtrl?.setValue('');
        }
        commentCtrl?.updateValueAndValidity();
    }
    
    get apgtGroups(): FormGroup[] {
        return (this.apgtFormArray?.controls ?? []) as FormGroup[];
    }
    
    trackByActorId = (_: number, ctrl: AbstractControl) =>
        (ctrl as FormGroup).get('childActorId')?.value;
    
    getChildNameByActorId(actorId: string): string {
        const p = this.involvedPersons?.find(x => x.intakeservicerequestactorid === actorId);
        this.personid = p?.personid;
        return p?.fullname ?? 'Selected Child';
    }

    /** Find APGT group index by actor id */
private findApgtGroupIndexByActorId(actorId: string): number {
    if (!this.apgtFormArray) return -1;
    return this.apgtFormArray.controls.findIndex(
      g => (g as FormGroup).get('childActorId')?.value === actorId
    );
  }
  
  public composeAddress(p: any): string {
    const parts = [
      p?.address, p?.address2, p?.city, p?.state, p?.zipcode, p?.county
    ].filter(Boolean);
    return parts.join(', ');
  }
  
  /** Patch a single APGT child group from a selected person record */
  private patchApgtFromPerson(person: any): void {
    const actorId = person?.intakeservicerequestactorid || person?.actorid;
    if (!actorId) { return; }
  
    // make sure group exists
    const idx = this.findApgtGroupIndexByActorId(actorId);
    if (idx === -1) { return; } // group is created by syncApgtFormsWithSelectedChildren
  
    const group = this.apgtFormArray.at(idx) as FormGroup;
  
    const youthName =
      person?.fullname ||
      [person?.firstname, person?.middlename, person?.lastname].filter(Boolean).join(' ').trim() ||
      '';
  
    const youthAge = person?.age || '';
  
    const youthDob = this.parseDate(person?.dob);  
    const youthAddress = this.composeAddress(person);
  
    group.patchValue({
      youthName: youthName,
      youthAge: youthAge,
      youthDob: youthDob,
      youthAddress: youthAddress
    }, { emitEvent: false });
  }
  

  /** Rebuild groups to match current 'focusname' and populate fields */
syncApgtFromCurrentSelection() {
    const selectedIds: string[] = this.petitionDetailsForm.get('focusname')?.value || [];
    if (!Array.isArray(selectedIds)) return;
      this.syncApgtFormsWithSelectedChildren(selectedIds);
  
    const selectedPeople = (this.involvedPersons || []).filter(p =>
      selectedIds.includes(p.intakeservicerequestactorid)
    );
  
    selectedPeople.forEach(person => this.patchApgtFromPerson(person));
  }
  
  clearApgtGroups() {
    if (!this.apgtFormArray) return;
    while (this.apgtFormArray.length > 0) this.apgtFormArray.removeAt(0);
    this.openApgtPanelsByActorId = {};
  }

    private getAgeYears(p: any): number | null {
        const dobStr = p?.dob;
        if (dobStr) {
            const dob = new Date(dobStr);
            if (!isNaN(dob.getTime())) {
                const today = new Date();
                let age = today.getFullYear() - dob.getFullYear();
                const m = today.getMonth() - dob.getMonth();
                if (m < 0 || (m === 0 && today.getDate() < dob.getDate())) age--;
                return age;
            }
        }
        return null;
    }

    private toYyyyMmDd(value: any): string | null {
        if (!value) return null;
        const d = value instanceof Date ? value : new Date(value);
        if (isNaN(d.getTime())) return null;
        const mm = `${d.getMonth() + 1}`.padStart(2, '0');
        const dd = `${d.getDate()}`.padStart(2, '0');
        return `${d.getFullYear()}-${mm}-${dd}`;
    }
    
    private parseDate(value: any): Date | null {
        if (!value) return null;
        const d = new Date(value);
        return isNaN(d.getTime()) ? null : d;
    }
  
  
  private isEligibleApgtPerson(p: any): boolean {
    const age = this.getAgeYears(p);
    // If age unknown, we are currently allowing (or flip to false if age needs to be entered mandatorily)
    return age === null ? false : age >= 14;
  }
  
  /** Enforce APGT 14+ rule on current selection and warn */
  private enforceApgtAgeRuleOnSelection(): void {
    const type = this.petitionDetailsForm.get('petitiontypekey')?.value;
    if (type !== 'APGT') return;
  
    const selectedIds: string[] = this.petitionDetailsForm.get('focusname')?.value || [];
    if (!Array.isArray(selectedIds) || !selectedIds.length) return;
  
    const invalidIds = selectedIds.filter(id => {
      const p = (this.involvedPersons || []).find(x => x.intakeservicerequestactorid === id);
      return p ? !this.isEligibleApgtPerson(p) : false;
    });
  
    if (invalidIds.length) {
      const newSelection = selectedIds.filter(id => !invalidIds.includes(id));
      this.petitionDetailsForm.get('focusname')?.setValue(newSelection, { emitEvent: false });
  
      invalidIds.forEach(id => delete this.openApgtPanelsByActorId[id]);
  
      this.syncApgtFromCurrentSelection();
  
      this._alertService.warn('Client should be minimum 14 years selection.');
    }
  }
  
  
    
    private handleReqObjFn(isServiceCase: any) {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();

        let reqObj = {};
        if (isServiceCase) {
            reqObj = {
                objectid: this.id,
                objecttypekey: 'servicecase',
                servicecaseid: this.id,
                isExpungementSuperUser:isExpungementSuperUser,
                iscaseexpunged: this.iscaseexpunged
            };
        } else {
            reqObj = {
                intakeserviceid: this.id,
                isExpungementSuperUser:isExpungementSuperUser,
                iscaseexpunged: this.iscaseexpunged
            };
        }
        return reqObj;
    }
    getInvolvedPerson() {
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        let url = '';

        if(isExpungementSuperUser=== 1) {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
        } else {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
        }
        const isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        this.userInfo = this._authService.getCurrentUser();

        const reqObj = this.handleReqObjFn(isServiceCase);
        this.involvedPersons$ = this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 100,
                    nolimit: true,
                    method: 'get',
                    where: reqObj
                }),
                `${url}?filter`
            ).pipe(
            share(),
            pluck('data'),);
        this.involvedPersons$.subscribe((items) => {
            if (!items) {
                return;
            }
            const person = this.setPerson(items);
            this.interestedPersons = this.setInterestedPersons(items);
            this.setRoles(items);
            const client = this.setClient(items);
            this.involvedPersons = person.map((res: any) => res);
            const existingCollateral = this.clientActor?.filter((item: any) => item?.collateralid) || [];
            this.clientActor = [...client.map((res: any) => res), ...existingCollateral];
            this.parents = client.filter(person => person.isParent);
            this.childList = JSON.parse(JSON.stringify(client));
            this.childList = this.childList.filter((child: any) =>
                child?.intakeservicerequestactorid
                && !child?.collateralid
                && !child?.placementid
                && child?.age
                && +child.age.split(" ")[0] >= 17
            );

            this.prepareRelatioships();
            this.syncApgtFromCurrentSelection();
            this.interestedPersons = this.interestedPersons.filter((ele) => ['PARENT', "ADOPTIVEPARENT", "FOPA", "LG", "CHILD"].includes(ele.rolename))
        });
    }

    private setRoles(items: any[]) {
        return items.forEach((item) => {
            const roles = item.roles;
            const clientAttorney = ['ADV', 'AT', 'CHADCA', 'CLAT','CASAWRKER'];
            if (roles && roles.length && Array.isArray(roles)) {

                const rolePresent = roles.some(r => clientAttorney.includes(r.intakeservicerequestpersontypekey));
                if (rolePresent) {
                    this.attorneyList.push(item);
                }
            } else {
                if (item.rolename) {
                    const roleExist = clientAttorney.includes(item.rolename);
                    if (roleExist) {
                        this.attorneyList.push(item);
                    }
                }
            }
        });
    }
        private setInterestedPersons(items: any[]) {
        return items.filter((item) => {
        const hasRolesArray = item.roles && Array.isArray(item.roles) && item.roles.length > 0;
        if (!hasRolesArray || item.dateofdeath !== null) {
            return false;
        }
    
        const hasInterestedPersonRole = item.roles.some((role:any) =>
            role.intakeservicerequestpersontypekey === 'FOPA' ||
            role.intakeservicerequestpersontypekey === 'CHILD' ||
            role.intakeservicerequestpersontypekey === 'ADOPTIVEPARENT' ||
            role.intakeservicerequestpersontypekey === 'PARENT'||
            role.intakeservicerequestpersontypekey === 'LG'
        );
    
        if (!hasInterestedPersonRole) {
            return false;
        }
    
        if (!item.intakeservicerequestactorid &&
            item.roles &&
            item.roles.length &&
            item.roles[0].intakeservicerequestactorid) {
            item.intakeservicerequestactorid = item.roles[0].intakeservicerequestactorid;
        }
    
        return true;
        });
    }

    private setPerson(items: any[]){
        return items.filter((item) => {
            if (item.roles && item.roles.length && Array.isArray(item.roles)) {
                const selectedItem = item.roles.filter((itm: { intakeservicerequestpersontypekey: string; }) =>
                        itm.intakeservicerequestpersontypekey === 'RC'
                        || itm.intakeservicerequestpersontypekey === 'AV' || itm.intakeservicerequestpersontypekey === 'CHILD' );

                if (selectedItem && selectedItem.length >= 1 && item.dateofdeath === null) {
                    this.involvedYouth = `${item.firstname} ${item.lastname}`;
                    if (!item.intakeservicerequestactorid && item.roles && item.roles.length && item.roles[0].intakeservicerequestactorid) {
                            item.intakeservicerequestactorid = item.roles[0].intakeservicerequestactorid;
                        }
                    return true;
                    }
                }
            return false;
        });
    }
    private setClient(items: any[]) {
        return items.filter((item) => {
            const validRoles = ["PARENT", "ADOPTIVEPARENT", "FOPA", "LG","CHILD"];
            const roleMatch = item.roles && item.roles.some((role:any) => validRoles.includes(role.intakeservicerequestpersontypekey));

            if (roleMatch) {
                item.isParent = item.roles?.some(
                    (role: any) =>
                        role.intakeservicerequestpersontypekey === 'PARENT'
                );
                
                if (!item.rolename || item.rolename === '') {
                    const role = item.roles.find((role:any) => validRoles.includes(role.intakeservicerequestpersontypekey));
                    item.rolename = role ? role.intakeservicerequestpersontypekey : '';
                }

                if (item.rolename !== 'RC' && item.rolename !== 'AV') {
                    this.involvedYouth = `${item.firstname} ${item.lastname}`;
                    if (!item.intakeservicerequestactorid && item.roles && item.roles.length) {
                        item.intakeservicerequestactorid = item.roles[0].intakeservicerequestactorid;
                    }
                    return true;  
                }
            }
            return false;  
        });
    }

    checkPersons(items: any[]) {
        const person = this.getPerson(items);
        const clientAttorney = ['ADV', 'AT', 'CHADCA', 'CLAT', 'CASAWRKER'];
    
        items.forEach(item => {
            if (this.hasRole(item, clientAttorney)) {
                this.attorneyList.push(item);
            }
        });
    
        const client = this.getClient(items);
        this.involvedPersons = person;
        this.clientActor = client;
        this.childList = JSON.parse(JSON.stringify(client));
        this.childList = this.childList.filter((child: any) =>
            child?.intakeservicerequestactorid
            && !child?.collateralid
            && !child?.placementid
            && child?.age
            && +child.age.split(" ")[0] >= 17
        );
        this.prepareRelatioships();
    }
    
    hasRole(item: { roles: any; rolename: any; }, rolesArray: any) {
        const roles = item.roles;
        if (roles && roles.length && Array.isArray(roles)) {
            return roles.some(r => rolesArray.includes(r.intakeservicerequestpersontypekey));
        } else if (item.rolename) {
            return rolesArray.includes(item.rolename);
        }
        return false;
    }    

    getPerson(items: any[]) {
        return items.filter(item => {
            if (item.roles && item.roles.length && Array.isArray(item.roles)) {
                const selectedItem = item.roles.filter((itm: { intakeservicerequestpersontypekey: string; }) =>
                    itm.intakeservicerequestpersontypekey === 'RC'
                    || itm.intakeservicerequestpersontypekey === 'AV' 
                    || itm.intakeservicerequestpersontypekey === 'CHILD');
    
                if (selectedItem.length >= 1 && item.dateofdeath === null) {
                    this.involvedYouth = `${item.firstname} ${item.lastname}`;
                    
                    if (!item.intakeservicerequestactorid && item.roles.length && item.roles[0].intakeservicerequestactorid) {
                        item.intakeservicerequestactorid = item.roles[0].intakeservicerequestactorid;
                    }
    
                    return true;
                }
            }
            return false;
        });
    }
    

    getClient(items: any[]) {
        return items.filter(client => {
            if (!client.rolename || client.rolename === '') {
                if (client.roles && client.roles.length && client.roles[0].intakeservicerequestpersontypekey) {
                    client.rolename = client.roles[0].intakeservicerequestpersontypekey;
                }
            }
            if (client.rolename !== 'RC' && client.rolename !== 'CHILD' && client.rolename !== 'AV') {
                this.involvedYouth = `${client.firstname} ${client.lastname}`;
                if (!client.intakeservicerequestactorid && client.roles && client.roles.length && client.roles[0].intakeservicerequestactorid) {
                    client.intakeservicerequestactorid = client.roles[0].intakeservicerequestactorid;
                }
                return true;
            }
            return false;
        });
    }
    

    getCollateralPerson(){
        const request = {
            objectid: this.id,
            objecttype: 'case'
        };
        this._commonHttpService.getArrayList(
            {
                where: request,
                method: 'get',
                nolimit: true
            },
            'collateral/list?filter'
        ).subscribe(res => {
            if (res && res.length && res[0].getcollateraldetails && res[0].getcollateraldetails.length) {
                const collateralDetails = res[0].getcollateraldetails;
                this.allCollateralDetails = JSON.parse(JSON.stringify(collateralDetails));
                if(collateralDetails && collateralDetails.length>0){ 
                    this.checkCollateralDetails(collateralDetails);
                }
            }
        });

      }
    checkCollateralDetails(collateralDetails: any[], edit:boolean = false) {
        const secondCertificationRoles = ['FOPA', 'CACA'];
        const childAttorneyRoles = ['ADV', 'AT', 'CHADCA', 'CLAT', 'CASAWRKER'];

        collateralDetails.forEach((item) => {
            const roles = item.collateralroleconfig;

            if (roles && roles.length) {

                const isSecondCertificationRole = roles.some((r: any) =>
                    secondCertificationRoles.includes(r.actortypekey)
                );

                if (isSecondCertificationRole && item.collateralid) {
                    item.intakeservicerequestactorid = item.collateralid;
                    this.clientActor.push(item);
                }
                  if (edit) {
                    childAttorneyRoles.push(roles[0].actortypekey);
                  }
                const attorneyRoleList = roles
                    .filter((r: any) => childAttorneyRoles.includes(r.actortypekey))
                    .map((role: any) => {
                        return {
                            typedescription: role.description,
                            actortypekey: role.actortypekey
                        };
                    });

                if (attorneyRoleList.length > 0) {
                    const attorney = {
                        intakeservicerequestactorid: item.collateralid,
                        firstname: item.firstname,
                        lastname: item.lastname,
                        fullname: item.fullname,
                        roles: attorneyRoleList
                    };

                    this.attorneyList.push(attorney);
                    this.collateralAttorney.push(attorney);
                    if (edit) {
                        const index = childAttorneyRoles.indexOf(roles[0].actortypekey);
                        if (index !== -1) {

                            childAttorneyRoles.splice(index, 1);
                        }
                  }
                }
            }
        });
    }

    
    prepareRelatioships() {

        const relationship$ = this.clientActor.map(person => {
            const ob$ = this._commonHttpService
                .getPagedArrayList(
                    new PaginationRequest({
                        page: 1,
                        limit: 100,
                        method: 'get',
                        where: this.getRequestParam(person.personid)
                    }),
                    'People/getallpersonrelationbyprovidedpersonid?filter'
                );
            return { personid: person.personid, relation$: ob$ };
        });
        relationship$.forEach(obj => {
            obj.relation$.subscribe(data => {
                const person = this.clientActor.find(item => item.personid === obj.personid);
                if (person) {
                    person.relationshipList = data;
                }
            });
        });
    }

    getRequestParam(personid: string) {
        let inputRequest: any;
        const caseID = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
        const isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        if (isServiceCase) {
          inputRequest = {
            objectid: caseID,
            objecttypekey: 'servicecase',
          };
        } else {
          inputRequest = {
            intakeserviceid: caseID
          };
        }
        if (personid) {
            inputRequest.personid = personid;
        }

        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        inputRequest.isExpungementSuperUser= isExpungementSuperUser;
        return inputRequest;
      }
       getPersonIdByActorId = (actorId: any): string | null => 
    (this.involvedPersons || []).find(p => p.intakeservicerequestactorid === actorId.childActorId)?.personid ?? null;

    private getPetitionDetailsList() {
        const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        const isExpungementSuperUser= this._authService.isExpungementSuperUser();
        let courtReqObj = {};
        if (isServiceCase) {
            courtReqObj = {
                objectid: this.id,
                objecttype: 'servicecase'
            };
        } else {
            courtReqObj = { intakeservicerequestid: this.id,isExpungementSuperUser: isExpungementSuperUser, iscaseexpunged: this.iscaseexpunged};
        }
        this._commonHttpService
            .getArrayList(
                {
                    method: 'get',
                    where: courtReqObj
                },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.PetitionListUrl}?filter`
            )
            .subscribe((item) => {
                if (item && item.length) {
                    this.setPetitonListDetails(item);
                }
            });
    }

    setPetitonListDetails(item: any[]) {
        this.petitonListDetails = item.map((actor) => {
            let hasHearingDetails = false;
            
            if (Array.isArray(actor.intakeservicerequestcourthearing) && actor.intakeservicerequestcourthearing.length) {
                const activeHearings = actor.intakeservicerequestcourthearing.filter((el: { activeflag: number; }) => el.activeflag === 1);
                hasHearingDetails = activeHearings.length > 0;
            }
            
            return {
                intakeservicerequestpetitionid: actor.intakeservicerequestpetitionid,
                associatedattorneys: actor.associatedattorneys,
                petitionid: actor.petitionid,
                petitiontypekey: actor.petitiontypekey,
                actordetails: actor.petitionactors,
                clientActordetails: actor.clientactorsid,
                clientActorsdetails: actor.clientactors,
                courtcasenumber: actor.courtcasenumber,
                petitiondate: actor.petitiondate,
                witness1: actor.witness1,
                hasHearingDetails: hasHearingDetails,
                parentActorsdetails: actor.intakeservicerequestpetitionactor.filter((act:any)=>{return act.petitionactortype == 'PARENT1' || act.petitionactortype == 'PARENT2' })
    ,
   
            };
        });
        this.cdr.markForCheck();
    }
    

    getPetitionTypeDesc(pKey: string) {
        if (this.petitionTypeList && pKey) {
            return  this.petitionTypeList.filter((k: { value: string; }) => k.value === pKey)[0].text;
        } else {
            return '';
        }
    }

    getAggravatedCircumstancesList() {
        this._commonHttpService
            .getArrayList(
                {
                    method: 'get',
                    where: { 'referencetypeid': 41, 'teamtypekey': null }
                },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.AggravatedcircumstancesUrl}?filter`
            )
            .subscribe((item) => {
                this.aggravatedCircumstancesList = item && item.length ? item : [];
            });
    }

    loadRecordDropDown() {

        this._commonHttpService
            .getArrayList(
                {
                    where: { referencetypeid: 136, teamtypekey: 'CW' },
                    method: 'get'
                },
                'referencetype/gettypes' + '?filter'
            ).subscribe ( (data) => {
                this.recordDropDown = data;
                    if (this.recordDropDown && this.recordDropDown.length) {
                    this.recordDropDown.forEach((element: { ref_key: any; value_text: any; }) => {
                        this.typeOfRecord[element.ref_key] =   element.value_text;
                    });
                }
            });
    }

    loadPlacementDropDown() {
        this._commonHttpService
        .getArrayList(
            {
                where: { referencetypeid: 77 , teamtypekey: 'CW' },
                method: 'get'
            },
            'referencetype/gettypes' + '?filter'
        ).subscribe ( (data) => {
            this.placementDropDown = data;
        });
    }


    viewPetiton(item: any) {
        this.editPetiton(item, 'view');
        this.petitionDetailsForm.disable();
        this.cinaForm.disable();
        this.isViewMode = true;
    }
    cancelViewPetiton() {
        this.isViewMode = false;
        this.petitionDetailsForm.enable();
        this.cinaForm.enable();
        this.apgtFormArray?.enable({ emitEvent: false });
    }

    downloadPetiton(item: any) {
        const modal = {
            method: 'post',
            where: { 
                documenttemplatekey: ['qrtpdocument'],
                item
            },
            limit: 10,
            order: 'desc',
            page: 1,
            count: -1
        };
        this._commonHttpService.download(this.generatedocurl, modal)
            .subscribe(res => {
                const blob = new Blob([new Uint8Array(res)]);
                const link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = `QRTP Motion Petition.pdf`;
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            });
    }

    deletePetition() {
        const data = this.deleteItem;
        this._commonHttpService.patch(
          data.intakeservicerequestpetitionid,
          { intakeservicerequestpetitionid: data.intakeservicerequestpetitionid, activeflag: 0 },
            'intakeservicerequestpetition'
            ).subscribe(
          () => {
                this._commonHttpService.create(
                    { intakeservicerequestpetitionid: data.intakeservicerequestpetitionid },
                    CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.PetitionApgtDelete
                  ).subscribe(
              () => {
            this.getPetitionDetailsList();
            this._alertService.success('Petition deleted successfully');
            $(this.deletepopupid).modal('hide');
            this.deleteItem = null;
              },
              _ => { /* ignore APGT absence */ }
            );
          },
          _ => this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE)
        );
      }
      

    editPetiton(item: any, action: string) {
     if (action === 'edit') {
            this.cancelViewPetiton();
        }
        document.body.scrollTop = 0;
        document.documentElement.scrollTop = 0;
        this.updateButton = action === 'edit';
        let clientactors ;
        this.intakeservicerequestpetitionactors = [];
        this.petitionDetailsForm.patchValue(item);
        if ( item?.actordetails?.length) {
            this.petitionfocusid = item.actordetails.map((res: { intakeservicerequestactorid: any; }) => {
                return res.intakeservicerequestactorid;
            });
        this.missingPetitionForChild(item);
        }
        if (item.actordetails) {
            this.intakeservicerequestpetitionactors = item.actordetails;
        }
        if ( item?.clientActordetails?.length && Array.isArray(item.clientActordetails)) {
            this.clientactorsid = item.clientActordetails.map((res: { intakeservicerequestactorid: any; }) => {
                return res.intakeservicerequestactorid;
            });
        } else {
            if (item.clientActordetails) {
                this.clientactorsid = item.clientActordetails;
            }

        }
        this.missingChildAttorney(item);
        if (item?.clientActorsdetails?.length && Array.isArray(item.clientActorsdetails)) {
            clientactors = item.clientActorsdetails.map((res: { intakeservicerequestactorid: any; }) => {
                return res.intakeservicerequestactorid;
            });
        }
        this.missingClientActor(clientactors, item);
        this.cinaForm.get('parentsubstance')?.clearValidators();
        this.cinaForm.get('parentadmitted')?.clearValidators();
        if (item.petitiontypekey === 'CINA') {
            this.patchCinaForm(item.intakeservicerequestpetitionid, false);
            this.petitionDetailsForm.get('petitiontypekey')?.clearValidators();
            this.petitionDetailsForm.get('associatedattorneys')?.clearValidators();
            this.petitionDetailsForm.get('focusname')?.clearValidators();
            this.petitionDetailsForm.get('petitiondate')?.clearValidators();
            this.showDownloadButton = true;
        } 
             if (item.petitiontypekey === 'APGT') {
            this.patchApgtForPetition(item.intakeservicerequestpetitionid);
        
            this.isViewMode = action !== 'edit';
            if (this.isViewMode) {
              this.apgtFormArray.disable({ emitEvent: false });
            } else {
              this.apgtFormArray.enable({ emitEvent: false });
            }
        } 
        const iskinhome = ( item.iskinhome && item.iskinhome === 1 ) ? true : false;
        this.cinaForm.controls['iskinhome'].patchValue(iskinhome);
        this.petitionDetailsForm.controls['focusname'].patchValue(this.petitionfocusid);
        this.petitionDetailsForm.controls['clientactorsid'].patchValue(this.clientactorsid);
        this.petitionDetailsForm.controls['clientactors'].patchValue(clientactors);

        const parent1 = item.parentActorsdetails?.find(
            (x: any) => x.petitionactortype === 'PARENT1'
            );

        const parent2 = item.parentActorsdetails?.find(
            (x: any) => x.petitionactortype === 'PARENT2'
            );

        this.missingParentActor(item.parentActorsdetails, item);    
        if(this.petitionDetailsForm.controls['petitiontypekey'].value === "GAPTPR"){
          this.displayParents = true;
        }else{
            this.displayParents = false;
        }
        if (action === 'edit') {
            this.petitionDetailsForm.enable({ emitEvent: false });
        } else {
            this.petitionDetailsForm.disable({ emitEvent: false });
        }

        const UNKNOWN = this.UNKNOWN_PARENT_VALUE;

        const parent1IsUnknown =
            !!parent1 && !parent1?.intakeservicerequestactorid;

        const parent2IsUnknown =
            !!parent2 && !parent2?.intakeservicerequestactorid;

        this.petitionDetailsForm.patchValue({
            parent1: parent1IsUnknown
                ? UNKNOWN
                : parent1?.intakeservicerequestactorid || null,

            parent2: parent2IsUnknown
                ? UNKNOWN
                : parent2?.intakeservicerequestactorid || null,

            parent1Unknown: parent1IsUnknown,
            parent2Unknown: parent2IsUnknown
        }, { emitEvent: false });

        this.getPersonNameList(this.petitionDetailsForm.getRawValue().focusname, this.involvedPersons);
        this.getOtherPersonNameList(this.petitionDetailsForm.getRawValue().clientactors, this.clientActor)
    }

    missingChildAttorney(item: any) {

        // allCollateralDetails
        const attorneyExists = this.attorneyList.some(
            (attorney: any) =>
                attorney?.intakeservicerequestactorid === this.clientactorsid
        );
        if (!attorneyExists) {
            const getAttorney = this.allCollateralDetails.filter(
                (collateral: any) => collateral.collateralid === this.clientactorsid
            ) || [];

            if (getAttorney.length) {
                this.checkCollateralDetails(getAttorney, true)
            }
        }

    }

    missingParentActor(parentActors: any, item: any) {

        if (parentActors?.length) {

            for (const parent of parentActors) {

                if (!parent?.intakeservicerequestactorid) {
                    continue;
                }

                const findActor = this.parents.find(
                    e => e.intakeservicerequestactorid === parent.intakeservicerequestactorid
                );

                if (!findActor) {

                    this.parents.push({
                        intakeservicerequestactorid:
                            parent.intakeservicerequestactorid,

                        fullname:
                            parent.intakeservicerequestactor?.person?.firstname +
                            ' ' +
                            parent.intakeservicerequestactor?.person?.middlename +
                            ' ' +
                            parent.intakeservicerequestactor?.person?.lastname,

                        dob:
                            parent.intakeservicerequestactor?.person?.dob,

                        cjamspid:
                            parent.intakeservicerequestactor?.person?.cjamspid
                    });
                }
            }
        }
    }
      private currentApgtHeaderId: string | null = null;

    private patchApgtForPetition(intakeservicerequestpetitionid: string) {
    this._commonHttpService.getSingle(
        {
        method: 'get',
        where: { intakeservicerequestpetitionid },
        limit: 1, page: 1, count: -1
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.PetitionApgtDetailList
    ).subscribe((res) => {
        const header = res?.data?.[0];
        const children = res?.children || [];
        this.currentApgtHeaderId = header?.apgtpetitionid || null;
        this.interestedPersons = [];

        (children || []).forEach((ch: any) => {
            (ch?.interestedpersons || []).forEach((ele: any) => {
                this.interestedPersons.push({
                    ...ele,
                    fullname: ele.fullname || ele.full_name || null,
                    phonenumber: ele.phonenumber || ele.phone || null,
                    isSelected: true,
                    parentChildActorId: ch.intakeservicerequestactorid,
                    deletedForChildActorIds: []
                });
            });
        });

        this.apgtFormArray.clear();

        children.forEach((ch: any) => {
           ch.secondcertificationbyactorid = ch.secondcertificationbyactorid ||  ch.placementid;
           const fg = this.buildApgtChildGroup(ch.intakeservicerequestactorid);
            fg.patchValue({
              youthName: ch.youthname,
              youthAge: ch.youthage,
              youthDob: this.parseDate(ch.youthdob),
              youthAddress: ch.youthaddress,
              firstCertificationDate: ch.firstcertificationdate,
              disabilityNarrative: ch.disabilitynarrative,
              vaBenefits: ch.vabenefits,
              vaBenefitsComment: ch.vabenefitscomment,
              financialSummary: ch.financialsummary,
              secondCertificationBy: ch.placementid ||ch.secondcertificationbyactorid,
              secondCertificationAppointment: ch.secondcertificationappointment,
              interestedPersons: (ch.interestedPersons || []).map((ip: any) => ({
                name: ip.full_name,
                address: ip.address,
                phone: ip.phone
              }))
            });

            if (this.isViewMode) {
                fg.get('secondCertificationBy')?.disable({ emitEvent: false });
            }

            this.apgtFormArray.push(fg);
        });
          this.syncApgtFromCurrentSelection();
        this.apgtGroups.forEach((g, index) => {
            g.get("secondCertificationBy")?.setValue(children[index]?.secondcertificationbyactorid || children[index]?.placementid, { emitEvent: true });

            if (this.isViewMode) {
                g.get('secondCertificationBy')?.disable({ emitEvent: false });
            }
        })            
    });
    }

    missingPetitionForChild(item: { actordetails: any[]; }){
        for(const petitionPerson of this.petitionfocusid){
            const findInvolvedPerson = this.involvedPersons.find((e) => e.intakeservicerequestactorid === petitionPerson );
            if(!findInvolvedPerson){
                const missingPetitionChild = item?.actordetails.find(e1 => e1.intakeservicerequestactorid === petitionPerson);
                if(missingPetitionChild){
                 this.involvedPersons?.push({
                    intakeservicerequestactorid : missingPetitionChild?.intakeservicerequestactorid,
                    fullname : missingPetitionChild?.intakeservicerequestactor?.person?.firstname + " "  + missingPetitionChild.intakeservicerequestactor.person.middlename +  " "+ missingPetitionChild.intakeservicerequestactor.person.lastname,
                    cjamspid : missingPetitionChild.intakeservicerequestactor.person.cjamspid
                 });
                }
            }
            }
    }

   missingClientActor(clientactors: any, item: { clientActorsdetails: any[]; }){
    if(clientactors?.length){
    for(const clientAct of clientactors){
        const findActorPerson = this.clientActor.find(e => e.intakeservicerequestactorid === clientAct)
         if(!findActorPerson){
            const missingactorPerson = item?.clientActorsdetails?.find(e => e?.intakeservicerequestactorid === clientAct)
            if(missingactorPerson){
                this.clientActor?.push({
                  intakeservicerequestactorid : missingactorPerson.intakeservicerequestactorid,
                  fullname : missingactorPerson?.intakeservicerequestactor?.person?.firstname + " "  + missingactorPerson.intakeservicerequestactor.person.middlename +  " " + missingactorPerson.intakeservicerequestactor.person.lastname,
                  cjamspid : missingactorPerson.intakeservicerequestactor.person.cjamspid
                })
            }
        }  
      }
   }
}
    changePerson(item: any[]) {
        this.intakeservicerequestpetitionactors = item.map((res) => {
            return {
                intakeservicerequestactorid: res,
                petitionactortype: 'PA'
            };
        });
        this.setCinaChild(item);
        this.getPersonNameList(item, this.involvedPersons);
             if (this.petitionDetailsForm.getRawValue().petitiontypekey === 'APGT') {
            this.syncApgtFormsWithSelectedChildren(item);
        }
    }
    changeClientActor(item: any[]) {
        this.clientActors = item.map((res) => {
            return {
                intakeservicerequestactorid: res,
                petitionactortype: 'CA'
            };
        });
        this.getOtherPersonNameList(item, this.clientActor);
    }

    initiateFormGroup() {
        this.initPetitionDetailsForm();
        this.initWitnessForm();
        this.initCinaSubpoenadForm();
        this.initCinaSiblingForm();
        this.initCinaForm();
        this.cinaForm.patchValue({ daterequestcompleted: new Date() });
    }
    
    initPetitionDetailsForm() {
        this.petitionDetailsForm = this._formBuilder.group({
            servicecaseid: [null],
            intakenumber: '',
            petitiontypekey: ['', Validators.required],
            petitionfocusname: [null],
            petitionid: [null],
            associatedattorneys: new FormControl('', Validators.compose([
                Validators.pattern('^[a-zA-Z-\' ]*$')
            ])),
            complaintid: '',
            transferpetitionid: '',
            petitionfiled: [''],
            focusname: ['', Validators.required],
            clientactorsid: null,
            courtcasenumber: [''],
            petitiondate: [null, Validators.required],
            intakeservicerequestpetitionid: [null],
            aggravations: [[]],
            witness1: '',
            clientactors: [null],
            parent1:[],
            parent2:[],
            parent1Unknown: [false],
            parent2Unknown: [false],
        }, {
  validators: this.atLeastOneParentSelected()
});
    }
    
    initWitnessForm() {
        this.witnessForm = this._formBuilder.group({
            witnessName: [null, Validators.required],
            petitionwitnessaddress: [null]
        });
    }
    
    initCinaSubpoenadForm() {
        this.cinasubpoenadForm = this._formBuilder.group({
            intakeservicerequestpetitionid: [null],
            cinapetitionid: [null],
            insertedby: [null],
            insertedon: [null],
            updatedby: [null],
            updatedon: [null],
            activeflag: [null],
            institution: [null, Validators.required],
            custodianname: [null],
            typeofrecord: [null],
            address: [null],
            zipcode: [null],
            personto: [null],
            isreleasenecessary: [null],
            isitinfile: [null],
            filedetails: [null]
        });
    }
    
    initCinaSiblingForm() {
        this.cinaSiblingForm = this._formBuilder.group({
            cinasiblingid: [null],
            intakeservicerequestpetitionid: [null],
            cinapetitionid: [null],
            insertedby: [null],
            insertedon: [null],
            updatedby: [null],
            updatedon: [null],
            activeflag: [null],
            siblingname: [null],
            issibinginchildcare: [null],
            whysiblinginchildcare: [null],
            isabuseneglect: [null],
            isother: [null],
            otherreason: [null],
            siblingcps: [null],
            siblingchildwelfareservices: [null],
            sibingcina: [null],
            siblingrelationshipstatus: [null],
            narrative: [null]
        });
    }
    
    initCinaForm() {
        this.cinaForm = this._formBuilder.group({
            cinapetitionid: [null],
            intakeservicerequestpetitionid: [null],
            insertedby: [null],
            insertedon: [null],
            updatedby: [null],
            updatedon: [null],
            activeflag: [null],
            isnew: [null, Validators.required],
            isemergency: [null, Validators.required],
            policecomplaintnumber: [null],
            color: [null],
            legalservicefilenumber: [null],
            childname: [null],
            isfosterhome: [null],
            isgrouphome: [null],
            iskinhome: [1],
            fosterhomename: [null],
            grouphomename: [null],
            kinhomename: [null],
            kinaddress: [null],
            kinrelation: [null],
            personwithlegalcustody: [null],
            personphysicalcustody: [null],
            legalcustodianrelationship: [null],
            parent1name: [null],
            parent1address: [null],
            isparent1notifiedbyacdss: [null],
            isparent1notified: [null],
            reasonforparent1notnotified: [null],
            parent2name: [null],
            parent2address: [null],
            isparent2notifiedbyacdss: [null],
            isparent2notified: [null],
            reasonforparent2notnotified: [null],
            caseworker: this.userInfo && this.userInfo.role['name'] === 'field' ? this.userInfo.user.userprofile.displayname : null,
            supervisorname: [null],
            daterequestcompleted: [null],
            childinsheltercareon: [null],
            dateofemergencysheltercare: [null],
            ispreviousjuvenilecourt: [null],
            ischildorsibling: [null],
            physicalabusenature: [null],
            physicalabusemedicalexam: [null],
            physicalabusedocumentation: [null],
            physicalabusefailedtoprotect: [null],
            physicalabusedisclosedto: [null],
            sexualabusenature: [null],
            sexualabusemedicalexam: [null],
            sexualabusedocumentation: [null],
            sexualabusefailedtoprotect: [null],
            sexualabusedisclosedto: [null],
            neglectabusenature: [null],
            neglectabusemedicalexam: [null],
            neglectabusedocumentation: [null],
            neglectabusefailedtoprotect: [null],
            neglectabusedisclosedto: [null],
            within12months: [null],
            severechronicdisability: [null],
            mentalhealthdisorder: [null],
            physicalissues: [null],
            bornsubstanceexposed: [null],
            cinachildmedical: [null],
            psychological: [null],
            disability: [null],
            currentlocation: [null],
            medical: [null],
            childrelationshipwithparentsreason: [null],
            legalstatusreason: [null],
            homeconditiondescription: [null],
            inadequatehousing: [null],
            parentcannotidentified: [null],
            parentcannotidentifiedreason: [null],
            parentlocationunknown: [null],
            parentlocationunknownreason: [null],
            departmentattempttolocateparents: [null],
            parentphysicalmentalissues: [null],
            isparentincarcerated: [null],
            parentincarcerated: [null],
            isparenteconomicstatus: [null],
            parenteconomicstatus: [null],
            isparentnotcareforchild: [null],
            parentnotcareforchild: [null],
            isparentsubstance: [null],
            parentsubstance: [null],
            isparentadmitted: [null],
            parentadmitted: [null],
            isparentrefused: [null],
            parentrefused: [null],
            isparentnotcompletetreatment: [null],
            parentnotcompletetreatment: [null],
            isparentuncooperative: [null],
            parentuncooperative: [null],
            isparentsafetyplan: [null],
            parentsafetyplan: [null],
            parentcps: [null],
            parentchildwelfareservices: [null],
            parentcriminal: [null],
            parentcina: [null],
            siblingname: [null],
            siblingcps: [null],
            siblingchildwelfareservices: [null],
            sibingcina: [null],
            issiblingrelationship: [null],
            activechildwelfare: [null],
            effortsforpreventremoval: [null],
            ismonitoredchildsafety: [null],
            monitoredchildsafety: [null],
            isofferedchildwelfareservices: [null],
            offeredchildwelfareservices: [null],
            ismedicalservices: [null],
            medicalservices: [null],
            isparentingclasses: [null],
            parentingclasses: [null],
            isdisorderscreening: [null],
            disorderscreening: [null],
            ismentalhealth: [null],
            mentalhealth: [null],
            isexploredrelative: [null],
            exploredrelative: [null],
            isotherreasons: [null],
            otherreasons: [null],
            werereasonableeffortsmade: [null],
            reasonableeffortsmade: [null],
            wasfamilymeetingheld: [null],
            familymeetingdate: [null],
            familymeetingparticipants: [null],
            familymeetingoutcome: [null],
            dateofremoval: [null],
            timeofremoval: [null],
            typeofplacement: [null],
            otherinformation: [null],
            photoinformationexists: [null],
            whohasevidence: [null],
            cinasubpoenad: [null],
            cinasibling: [null],
            petitionwitness: [null],
            isdepartmentattempttolocateparents: [null],
            isparentphysicalmentalissues: [null],
            caseworkerphonenumber: [null],
            supervisorphonenumber: [null],
            personwithlegalcustodyname: [null],
            personphysicalcustodyname: [null],
            nameofthechild: [null],
            childdob: [null],
            childrace: [null],
            childgender: [null]
        });
    }    
    
    activateSpeechToText(type: any): void {
        this.recognizing = type;
        this.speechRecogninitionOn = !this.speechRecogninitionOn;
        if (this.speechRecogninitionOn) {
          this._speechRecognitionService.record().subscribe(
            // listener
            (_value) => {

                  const narrative = this.cinaSiblingForm.getRawValue().narrative;
                  this.cinaSiblingForm.patchValue({ narrative: `${narrative} ${this.speechData}` });

            },
            // errror
            (err) => {
              this.recognizing = false;
              if (err.error === 'no-speech') {
                this.notification = `No speech has been detected. Please try again.`;
                this._alertService.warn(this.notification);
                this.activateSpeechToText(type);
              } else if (err.error === 'not-allowed') {
                this.notification = `Your browser is not authorized to access your microphone. Verify that your browser has access to your microphone and try again.`;
                this._alertService.warn(this.notification);
              } else if (err.error === 'not-microphone') {
                this.notification = `Microphone is not available. Please verify the connection of your microphone and try again.`;
                this._alertService.warn(this.notification);
              }
            },
            () => {
              this.speechRecogninitionOn = true;
              this.activateSpeechToText(type);
            }
          );
        } else {
          this.recognizing = false;
          this.deActivateSpeechRecognition();
        }
      }

      deActivateSpeechRecognition() {
        this.speechRecogninitionOn = false;
        this._speechRecognitionService.destroySpeechObject();
      }

      ngOnDestroy(): void {
        this._speechRecognitionService.destroySpeechObject();
      }

    addCinaSubpoenad() {
        this.cinasubpoenadForm.get('institution')?.setValidators([Validators.required]);
        this.cinasubpoenadForm.get('institution')?.updateValueAndValidity();
        if (this.cinasubpoenadForm && this.cinasubpoenadForm.invalid) {
            this.cinasubpoenadForm.markAllAsTouched();
            this.displayValidationMessages =true;
            return;
        }
      const cinaSubpoenadObj = this.cinasubpoenadForm.getRawValue();
      if (this.cinasubpoenad && this.cinasubpoenad.length) {
          this.cinasubpoenad.push(cinaSubpoenadObj);
      } else {
        this.cinasubpoenad = [];
        this.cinasubpoenad.push(cinaSubpoenadObj);
      }
      this.cinasubpoenadForm.reset();
      this.reset();
    }

    addCinaSibling() {
        const cinaSiblingObj = this.cinaSiblingForm.getRawValue();
        if (this.cinaSibling && this.cinaSibling.length) {
            this.cinaSibling.push(cinaSiblingObj);
        } else {
          this.cinaSibling = [];
          this.cinaSibling.push(cinaSiblingObj);
        }
        this.cinaSiblingForm.reset();
        this.reset();
      }

    getSupervisorsList() {
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: 'INTR' },
                    method: 'post'
                }),
                'Intakedastagings/getroutingusers'
            )
            .subscribe((result) => {
                this.supervisorsList = result.data;
            });
     }

    onChangeLegalCustody(persionIdArray: any[]) {
        if (persionIdArray && persionIdArray.length && Array.isArray(persionIdArray)) {
            let legalcustodianrelationship = '';
            persionIdArray.forEach(persionId => {
                legalcustodianrelationship = legalcustodianrelationship + (legalcustodianrelationship ? ',' : '') + this.getRelationShip(persionId);
                if (legalcustodianrelationship) {
                    this.cinaForm.patchValue({ legalcustodianrelationship: legalcustodianrelationship });
                }
            });
        }
    }
    getRelationShip(id: any) {
        const selectedChilds = this.petitionDetailsForm.getRawValue().focusname;
        const childid = (Array.isArray(selectedChilds) && selectedChilds.length >= 1) ? selectedChilds[0] : null;
        const child = this.involvedPersons.find(item => item.intakeservicerequestactorid === childid);
        if (child) {
            const SelectedPerson = this.clientActor.find(person => person.intakeservicerequestactorid === id);
            if (SelectedPerson) {
                const relationshipList = (Array.isArray(SelectedPerson.relationshipList)) ? SelectedPerson.relationshipList : [];
                const relationitem = relationshipList.find((item: { personid: any; }) =>
                    item.personid === child.personid
                );
                return (relationitem) ? relationitem.relation : '';
            }
        }
        return '';
    }
    addWitness() {
        const witnessId = this.witnessForm.getRawValue().witnessName;
        const witnessAddress = this.witnessForm.getRawValue().petitionwitnessaddress;
        const witnessObj = { 'personid': witnessId, 'petitionwitnessaddress': witnessAddress };
        if (this.petitionwitness && this.petitionwitness.length) {
            this.petitionwitness.push(witnessObj);
        } else {
            this.petitionwitness = [];
            this.petitionwitness.push(witnessObj);
        }
        this.witnessForm.reset();
    }

    private loadDroddowns() {
        const source = forkJoin([
            this._commonHttpService.getArrayList(
                {
                    where: { activeflag: 1 },
                    method: 'get',
                    nolimit: true,
                    order: 'description'
                },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.PetitionTypeUrl}?filter`
            ),
            this._commonHttpService.create(
                {
                    nolimit: true,
                    order: 'countyname'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Sdmcaseworker.SdmCountyListUrl
            ),
        ]).pipe(
            map(([petitionType, countyList]) => {
                return {
                    petitionType: this._courtResolverService.mapToDropdownModel(petitionType, 'description', 'petitiontypekey'),
                    countyList: this._courtResolverService.mapToDropdownModel(countyList, 'countyname', 'countyid')
                };
            }),
            share(),);

        this.petitionType$ = source.pipe(pluck('petitionType'));
        this.countyList$ = source.pipe(pluck('countyList'));
        this.petitionType$.subscribe(pt => {
                      this.petitionTypeList  = pt;
         });
        this.countyList$.subscribe(res => {
            this.countyList = res;
        });
    }

    patchValuseData() {
        this._commonHttpService
            .getArrayList(
                {
                    where: {
                        intakeservicerequestid: null,
                        objectid: this.id,
                        objecttype: 'servicecase'
                    },
                    method: 'get'
                },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.PetitionDetailslist}?filter`
            ).subscribe();
    }

    setCinaChild(item: any) {
        let  removalTime = null;
        const firstName = this.getPersonPropertybyId(item, 'firstname');
        const lastName = this.getPersonPropertybyId(item, 'lastname');
        const childdob = this.getPersonPropertybyId(item, 'dob');
        const childrace = this.getPersonPropertybyId(item, 'racetypekey');
        const childgender = this.getPersonPropertybyId(item, 'gender');
        const removalDate = this.getPersonPropertybyId(item, 'removaldate');
        removalTime = removalDate ? moment(removalDate).format('hh:mm A') : null;
        this.cinaForm.patchValue({ nameofthechild: `${firstName} ${lastName}` });
        this.cinaForm.patchValue({childdob: childdob});
        this.cinaForm.patchValue({childrace: childrace});
        this.cinaForm.patchValue({childgender: childgender});
        this.cinaForm.patchValue({dateofremoval: removalDate});
        this.cinaForm.patchValue({timeofremoval: removalTime});

    }
    petitionCinaSave(petition: any, add: any) {
        this.cinaForm.patchValue({
            insertedby: this.cinaForm.value.securityuserid,
            updatedby: this.cinaForm.value.securityuserid
        });
        let petitionId: any;
         if(add){
            if(petition && petition.Intakeservicerequestpetition.intakeservicerequestpetitionid) {
                petitionId = petition.Intakeservicerequestpetition.intakeservicerequestpetitionid;
                  } else {
                petitionId = this.cinaForm.getRawValue().intakeservicerequestpetitionid;
               
            }
            
         }
         
        else if (petition && petition[0].intakeservicerequestpetitionid) {
            petitionId = petition[0].intakeservicerequestpetitionid;
           
        } else {
            petitionId = this.cinaForm.getRawValue().intakeservicerequestpetitionid;
            
        }
        if (this.petitionwitness && this.petitionwitness.length) {
            this.petitionwitness.forEach(element => {
                element.petitionid = petitionId;
                element.clientmergeid = petitionId;
            });
        }
        if (this.cinasubpoenad && this.cinasubpoenad.length ) {
            this.cinasubpoenad.forEach(element => {
                element.activeflag = 1;
                element.intakeservicerequestpetitionid = petitionId;
                element.cinapetitionid = petitionId;
            });
        }
        if (this.cinaSibling && this.cinaSibling.length ) {
            this.cinaSibling.forEach(element => {
                element.intakeservicerequestpetitionid = petitionId;
                element.cinapetitionid = petitionId;
            });
        }
        const personphysicalcustody = this.cinaForm.getRawValue().personphysicalcustody;
        const personwithlegalcustody = this.cinaForm.getRawValue().personwithlegalcustody;
        const personwithlegalcustodyname  = this.getPersonFullName(personphysicalcustody);
        const personphysicalcustodyname  = this.getPersonFullName(personwithlegalcustody);
        this.cinaForm.patchValue({personwithlegalcustodyname: personwithlegalcustodyname});
        this.cinaForm.patchValue({personphysicalcustodyname: personphysicalcustodyname});
        this.cinaForm.patchValue({cinasubpoenad: this.cinasubpoenad});
        this.cinaForm.patchValue({ petitionwitness: this.petitionwitness });
        this.cinaForm.patchValue({ cinasibling: this.cinaSibling });
        this.cinaForm.patchValue({ intakeservicerequestpetitionid: petitionId ? petitionId : null });
        const cinaForm = this.cinaForm.getRawValue();
        this._commonHttpService.create(cinaForm, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.PetitionCinaDetailsSave).subscribe(
            (_res) => {
                this.resetForm();
            },
            (_error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    ParentCircumstanceChange(isSelected: any, formControlName: string | number) {
        if (isSelected.value) {
            this.cinaForm.controls[formControlName].setValidators([Validators.required]);
            this.cinaForm.controls[formControlName].updateValueAndValidity();
        } else {
            this.cinaForm.controls[formControlName].clearValidators();
            this.cinaForm.controls[formControlName].updateValueAndValidity();
        }
    }

    getPersonPropertybyId(personid: any, propertyName: any) {
        return this.getChildPropertyValue(personid, propertyName);
    }

    getChildPropertyValue(id: any, propertyName: string | number) {
        const SelectedPerson = this.involvedPersons.filter(person => id.includes(person.intakeservicerequestactorid));
        if (SelectedPerson && SelectedPerson.length) {
            return SelectedPerson[0][propertyName];
        }
        return null;
    }

    getPropertyValue(id: any, propertyName: string) {

        if (!id) {
            return null;
        }

        var SelectedPerson = this.attorneyList.filter(person => person.intakeservicerequestactorid === id);

        if (SelectedPerson && SelectedPerson.length) {
            return SelectedPerson[0][propertyName];
        }

        if ((propertyName === 'fullname') && !(SelectedPerson && SelectedPerson.length > 0)) {
             
            const addedAttorney = this.collateralAttorney.filter(person => person.intakeservicerequestactorid === id);
            const showAttorney = this.allCollateralDetails.filter((person:any) => person.collateralid === id);
            SelectedPerson = addedAttorney.length ? addedAttorney : showAttorney || [];
            if (SelectedPerson && SelectedPerson.length) {
                return SelectedPerson[0][propertyName];
            } else {
                return null;
            }
        }

        return null;
    }

petitionDetailsSave() {
    console.log('Details to be saved ', this.petitionDetailsForm);

    this.displayValidationMessages = false;
    this.displayValidationMessagesForParent = false;

    ['focusname', 'petitiontypekey', 'petitiondate'].forEach((ctrlName) => {
        const ctrl = this.petitionDetailsForm.get(ctrlName);
        ctrl?.setValidators([Validators.required]);
        ctrl?.updateValueAndValidity({ emitEvent: false });
    });

    this.petitionDetailsForm.updateValueAndValidity({ emitEvent: false });

    const petitionType = this.petitionDetailsForm.getRawValue().petitiontypekey;

    if (petitionType === 'CINA') {
        ['isnew', 'isemergency'].forEach((ctrlName) => {
            const ctrl = this.cinaForm.get(ctrlName);
            ctrl?.setValidators([Validators.required]);
            ctrl?.updateValueAndValidity({ emitEvent: false });
        });

        this.cinaForm.updateValueAndValidity({ emitEvent: false });

        if (this.cinaForm.invalid) {
            this.displayValidationMessages = true;
            this.cinaForm.markAllAsTouched();
            this.cdr.markForCheck();
            return;
        }
    } else {
        ['isnew', 'isemergency'].forEach((ctrlName) => {
            const ctrl = this.cinaForm.get(ctrlName);
            ctrl?.clearValidators();
            ctrl?.updateValueAndValidity({ emitEvent: false });
        });
    }

    if (petitionType === 'APGT') {
        if (this.petitionDetailsForm.invalid) {
            this.displayValidationMessages = true;
            this.petitionDetailsForm.markAllAsTouched();
            this.cdr.markForCheck();
            return;
        }
    }

    if (petitionType === 'GAPTPR') {
        const formValue = this.petitionDetailsForm.getRawValue();
        const UNKNOWN = this.UNKNOWN_PARENT_VALUE || 'UNKNOWN';

        const parent1Valid =
            (formValue.parent1 && formValue.parent1 !== UNKNOWN) ||
            formValue.parent1Unknown === true ||
            formValue.parent1 === UNKNOWN;

        const parent2Valid =
            (formValue.parent2 && formValue.parent2 !== UNKNOWN) ||
            formValue.parent2Unknown === true ||
            formValue.parent2 === UNKNOWN;

        if (!parent1Valid && !parent2Valid) {
            this.displayValidationMessagesForParent = true;
            this.petitionDetailsForm.markAllAsTouched();
            this.cdr.markForCheck();
            return;
        }
    }

    if (this.petitionDetailsForm.invalid) {
        this.displayValidationMessages = true;
        this.petitionDetailsForm.markAllAsTouched();
        this.cdr.markForCheck();
        return;
    }

    const petitionID = this.petitionDetailsForm.getRawValue().petitionid;

    if (!petitionID) {
        this.petitionDetailsForm.patchValue({
            petitionid: 'To be confirmed'
        }, { emitEvent: false });
    }

    this.petitionDetailsForm.patchValue({
        servicecaseid: this.id
    }, { emitEvent: false });

    this.prepareParentActors();

    this.petitionDetails = Object.assign(
        {
            petitionactors: this.intakeservicerequestpetitionactors,
            clientactors: this.clientActors,
            parentactors: this.parentActors
        },
        this.petitionDetailsForm.getRawValue()
    );

    this.petitionDetails['clientactors'] = this.clientActors;
    this.petitionDetails['parentactors'] = this.parentActors;

    const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);

    if (isServiceCase) {
        this.petitionDetails['servicecaseid'] = this.id;
        this.petitionDetails['intakeservicerequestid'] = 'deda9fed-a731-4151-ab8b-5f6cef7b60c4';
    } else {
        delete this.petitionDetails.servicecaseid;
        this.petitionDetails['intakeservicerequestid'] = this.id;
    }

    delete this.petitionDetails.focusname;

    this.prepareChildrenPayload(this.apgtFormArray);

    this.savePetition();
    this.displayParents = false;
}

        private prepareChildrenPayload(apgtFormArray: FormArray) {
    if (!apgtFormArray || apgtFormArray.length === 0) {
        this.syncApgtFromCurrentSelection();
            }
            this.childrenPayload = (apgtFormArray.controls as FormGroup[]).map((g) => {
                const actorId = g.get('childActorId')?.value;
                const p = (this.involvedPersons || []).find(x => x.intakeservicerequestactorid === actorId);
                const personid = p?.personid || null;
                let associatePerson
                const personsList = this.getClientActorsByPersonId(g?.get('childActorId')?.value);
                if (personsList && personsList.length > 0) {
                    associatePerson = personsList.find(person => person.placementid === g.get('secondCertificationBy')?.value);
                }
                return {
                    intakeservicerequestactorid: actorId,
                    placementid: associatePerson?.placementid || null,
                    personid,
                    firstcertificationdate: this.toYyyyMmDd(g.get('firstCertificationDate')?.value),
                    disabilitynarrative: g.get('disabilityNarrative')?.value || null,
                    vabenefits: g.get('vaBenefits')?.value,
                    vabenefitscomment: g.get('vaBenefitsComment')?.value || null,
                    financialsummary: g.get('financialSummary')?.value || null,
                    secondcertificationbyactorid: associatePerson?.placementid ? null : g.get('secondCertificationBy')?.value || null,
                    secondcertificationappointment: this.toYyyyMmDd(g.get('secondCertificationAppointment')?.value),
                    interestedpersons: (this.interestedPersons || [])
                        .filter((ip: any) =>
                            ip?.intakeservicerequestactorid !== actorId
                            && (ip?.parentChildActorId === actorId || !ip?.parentChildActorId)
                            && !(ip?.deletedForChildActorIds?.includes(actorId))
                            && (
                                ["PARENT", "ADOPTIVEPARENT", "FOPA", "LG", "CHILD"].includes(ip?.rolename)
                                || ip?.isSelected
                                || ip?.personid
                            )
                        )
                        .map((ip: any) => ({
                            fullname: ip.fullname,
                            personid: ip.personid,
                            address: ip.address,
                            address2: ip.address2,
                            city: ip.city,
                            state: ip.state,
                            zipcode: ip.zipcode,
                            county: ip.county,
                            phonenumber: ip.phonenumber
                        }))
                };
            });
        }

    private saveApgt(petitionSaveResponse: any) {
        const isrPetitionId =
            petitionSaveResponse?.Intakeservicerequestpetition?.intakeservicerequestpetitionid
            || petitionSaveResponse?.intakeservicerequestpetitionid;
      
        const payload: any = {
          intakeservicerequestpetitionid: isrPetitionId,
          children: this.childrenPayload
        };
        if (this.currentApgtHeaderId) payload.apgtpetitionid = this.currentApgtHeaderId;
      
        this._commonHttpService.create(
          payload,
          CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.PetitionApgtDetailsSave
        ).subscribe(
          (resp: any) => {
            this.currentApgtHeaderId = resp?.apgtpetitionid || this.currentApgtHeaderId;
            this._alertService.success('APGT details saved');
            this.syncApgtFromCurrentSelection();
          },
          _ => this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE)
        );
      }


      refreshFinanceForChild(childActorId: string) {
        if (!childActorId) return;
        const entry = (this.financeByChildId[childActorId] ||= { incomes: [], assets: [] });
        // clear previous state
        entry.loaded = false;
        entry.loading = false;
        entry.error = '';
        entry.incomes = [];
        entry.assets = [];
        this.cdr.markForCheck();
        // re-fetch
        this.preloadFinanceForChild(childActorId);
    }  
    savePetition() {
        this._commonHttpService.create(this.petitionDetails, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.PetitionDetailsSave).subscribe(
            (res: PetitionDetails) => {
                this.petitionDetailsForm.reset();
                ['focusname', 'petitiontypekey', 'petitiondate'].forEach((item) => {
                    this?.petitionDetailsForm?.get(item)?.clearValidators();
                    this?.petitionDetailsForm?.get(item)?.updateValueAndValidity();
                });
    
                this.cinaadd = !this.updateButton;
                this.updateButton = false;
    
                this.getPetitionDetailsList();
    
                if (this.petitionDetails.petitiontypekey === 'CINA') {
                    this.petitionCinaSave(res, this.cinaadd);
                }
                    if (this.petitionDetails.petitiontypekey === 'APGT') {
                    this.saveApgt(res);
                  }
    
                const message = this.petitionDetails.intakeservicerequestpetitionid === null
                    ? 'Petition details saved successfully!'
                    : 'Petition details updated successfully!';
                this._alertService.success(message);
            },
            (_error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    
    validateForTPR($event: { value: string; }) {
        ['isnew', 'isemergency'].forEach((item) => {
            this?.cinaForm?.get(item)?.clearValidators();
            this?.cinaForm?.get(item)?.updateValueAndValidity();
        });
    
        this.isTPRvalidate = $event.value === 'TPR';
        this.showWaiverReason = $event.value === 'Waiver';
        this.displayParents = $event.value === 'GAPTPR';
        if ($event?.value === 'APGT') {
            const selected = this.petitionDetailsForm.get('focusname')?.value || [];
            this.syncApgtFormsWithSelectedChildren(selected);
          }
    }

    
    updateFormOptions(key: string, options: string[], form: FormGroup = this.cinaForm) {
        options.forEach(element => {
            if (element !== key) {
                const formObj: any = {};
                formObj[element] = null;
                form.patchValue(formObj);
            }
        });
    }
    

    onChangeParent2Det(key: any) {
        const parent2DetKey = ['parentsmarriedatchildbirth', 'parentaffidavit', 'paternityproceeding', 'paternitydone', 'parentdeterminedby'];
        this.updateFormOptions(key, parent2DetKey);
    }

    onChangeSiblingDD(key: any) {
        const siblingKey = ['isabuseneglect', 'isother'];
        this.updateFormOptions(key, siblingKey, this.cinaSiblingForm);
    }
    
    
    onChangePlacementOpt(key: any) {
        const placementOpt = ['placedinfosterfamily', 'isplacedinother'];
        this.updateFormOptions(key, placementOpt);
    }
    
    onChangeParent1Notify(key: any) {
        const parent1NotifyOpt = ['isparent1notifiedbyacdss', 'isparent1notified'];
        this.updateFormOptions(key, parent1NotifyOpt);
    }
    
    onChangeHome(key: any) {
        const FormOpt = ['iskinhome', 'isfosterhome', 'isgrouphome'];
        this.updateFormOptions(key, FormOpt);
    }
    
    onChangeParent2Notify(key: any) {
        const parent2NotifyOpt = ['isparent2notifiedbyacdss', 'isparent2notified'];
        this.updateFormOptions(key, parent2NotifyOpt);
    }
    

    getPersonAddress(personid: any) {
        const selectedPerson = this.clientActor.find(person => person.intakeservicerequestactorid === personid);
        if (!selectedPerson) {
            return null;
        }
    
        const { address, address2, city, state, county, country } = selectedPerson;
        const addressParts = [];
    
        if (address) {
            addressParts.push(address);
        }
        if (address2) {
            addressParts.push(address2);
        }
        if (city) {
            addressParts.push(city);
        }
        if (state) {
            addressParts.push(state);
        }
        if (county) {
            addressParts.push(county);
        }
        if (country) {
            addressParts.push(country);
        }
    
        return addressParts.join(', ');
    }
    

    patchPersonAddress(persionId: any, FieldName: string | number) {
        const personAddress = this.getPersonAddress(persionId);
        const obj: any = {};
        obj[FieldName] = personAddress;
        this.cinaForm.patchValue(obj);
    }

    resetForm() {
        this.cinaForm.reset();
        this.petitionwitness = [];
        this.petitionDetailsForm.reset();
    }

    toggleSsnParent1 = () => {
        this.isSsnHiddenP1 = !this.isSsnHiddenP1;
        if (this.isSsnHiddenP1) {
          this.ssnEyeP1 = 'fa-eye';
          this.showSsnMaskP1 = true;
        } else {
          this.ssnEyeP1 = 'fa-eye-slash';
          this.showSsnMaskP1 = false;
        }
    }

    toggleSsnParent2 = () => {
        this.isSsnHiddenP2 = !this.isSsnHiddenP2;
        if (this.isSsnHiddenP2) {
          this.ssnEyeP2 = 'fa-eye';
          this.showSsnMaskP2 = true;
        } else {
          this.ssnEyeP2 = 'fa-eye-slash';
          this.showSsnMaskP2 = false;
        }
    }

    patchCinaForm(petitionid: any, isDownload: any) {
        this._commonHttpService
            .getSingle(
                {
                    where: {
                        intakeservicerequestpetitionid: petitionid
                    },
                    limit: 10,
                    page: 1,
                    count: -1,
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.PetitionCinaDetailList
            )
            .subscribe((cinaRes) => {
                        this.petitionwitness = [];
                        this.cinaSibling = [];
                        this.cinasubpoenad = [];

                        if (cinaRes && cinaRes.data && cinaRes.data.length) {
                        this.petitionwitness = cinaRes.petitionwitness;
                        this.cinaSibling = cinaRes.cinasibling;
                        this.cinasubpoenad = cinaRes.cinasubpoenad;
                        this.cinaPeitition = cinaRes.data[0];
                        this.cinaPeitition.personphysicalcustody  =  (this.cinaPeitition.personphysicalcustody && this.cinaPeitition.personphysicalcustody !== 'null') ?
                                                                    this.cinaPeitition.personphysicalcustody.split(',') : null;
                        this.cinaPeitition.personwithlegalcustody =  (this.cinaPeitition.personwithlegalcustody && this.cinaPeitition.personwithlegalcustody !== 'null') ?
                                                                    this.cinaPeitition.personwithlegalcustody.split(',') : null;

                        if (isDownload) {
                            this.downloadCINAForm(this.cinaPeitition, this.petitionwitness);
                        } else {
                            this.cinaForm.patchValue(this.cinaPeitition);
                            if(this.cinaPeitition && this.cinaPeitition.removaltime) {
                            const removalTime =  moment(this.cinaPeitition.removaltime).format('hh:mm A');
                             this.petitionDetailsForm.controls['removaltime'].patchValue(removalTime);
                            }
                        }
                      }

            });
    }

    getPersonFullName(personId: any) {
        const selectedPerson = this.clientActor.find(person => person.intakeservicerequestactorid === personId);
    
        if (selectedPerson) {
            return `${selectedPerson.firstname || ''} ${selectedPerson.lastname || ''}`.trim();
        }
        return null;
    }
    

    getCINAForm(petition: any) {
        this.selectedPetition = petition;
        this.patchCinaForm(petition.intakeservicerequestpetitionid, true);
    }

    downloadCINAForm(petition: any, witness: any) {
        this.petitionfocusid = this.selectedPetition.actordetails.map((res: any) => {
            return res.intakeservicerequestactorid;
        })[0];
        petition.cjamspid = this.getPersonPropertybyId(this.petitionfocusid, 'cjamspid');
        petition.name = `${this.getPersonPropertybyId(this.petitionfocusid, 'firstname')} ${this.getPersonPropertybyId(this.petitionfocusid, 'lastname')}`;
        petition.associatedattorneys = this.selectedPetition.associatedattorneys;

        petition.parent1namevalue = this.getPersonFullName(petition.parent1name);
        petition.parent2namevalue = this.getPersonFullName(petition.parent2name);
        petition.personwithlegalcustodyvalue = this.getPersonFullName(petition.personwithlegalcustody);
        petition.personphysicalcustodyvalue = this.getPersonFullName(petition.personphysicalcustody);
        petition.countyname = this.countyList.find((county: { value: any; }) => county.value === petition.countyname).text;
        if (witness && witness.length) {
            witness.forEach((element: any) => {
                element.personidvalue = this.getPersonFullName(element.personid);
                element.address = this.getPersonAddress(element.personid);
            });
        }
        const json = {
            cina: this.cinaPeitition,
            witness: this.petitionwitness
        };
        const condition = {
            'count': -1,
            'where': {
                'documenttemplatekey': [
                    'cinaForm'
                ],
                'isheaderrequired': false,
                'json': json
            },
            'method': 'post',
            'limit': 10, 'page': 1
        };
            this.http.post(`${this.baseUrl}/${this.generatedocurl}`, condition, { responseType: 'arraybuffer' })
        .subscribe(res => {
                const blob = new Blob([new Uint8Array(res)]);
                const link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = 'CINA_FORM.pdf';

                document.body.appendChild(link);

                link.click();

                document.body.removeChild(link);
            });
    }

    patchTestData(isResetForm: any) {
// tslint:disable-next-line: max-line-length
        const testData = {'cinapetitionid': null, 
        'intakeservicerequestpetitionid': '76dbfe04-f70a-4330-b39e-a85f2db26229', 
        'insertedby': null, 'insertedon': null, 'updatedby': null, 'updatedon': null, 
        'activeflag': null, 'isnew': false, 'isemergency': false, 
        'policecomplaintnumber': 'asdasd', 'color': 'asdas', 'legalservicefilenumber': 'asdaas', 
        'childname': null, 'isfosterhome': true, 'fosterhomename': 'asas', 'kinhomename': 'asdas', 
        'kinaddress': 'dasd', 'kinrelation': 'asdsad', 'personwithlegalcustody': this.personwithlegalcustodyuuid, 
        'personphysicalcustody': this.personwithlegalcustodyuuid, 'legalcustodianrelationship': this.personwithlegalcustodyuuid,
         'parent1name': this.personwithlegalcustodyuuid, 'parent1address': null, 'isparent1notifiedbyacdss': true, 
         'isparent1notified': null, 'reasonforparent1notnotified': null, 'parent2name': this.personwithlegalcustodyuuid, 
         'parent2address': null, 'isparent2notifiedbyacdss': true, 'isparent2notified': null,
          'reasonforparent2notnotified': null, 'caseworker': 'dasda', 'supervisorname': 'sadasdad', 
          'daterequestcompleted': null, 'childinsheltercareon': '2019-03-27T18:30:00.000Z', 
          'dateofemergencysheltercare': '2019-03-20T18:30:00.000Z', 'ispreviousjuvenilecourt': 'no', 
          'ischildorsibling': null, 'physicalabusenature': 'adas', 'physicalabusemedicalexam': 'asd', 'physicalabusedocumentation': 'asd',
           'physicalabusefailedtoprotect': 'asd', 'physicalabusedisclosedto': 'asd', 'sexualabusenature': 'asd',
           'sexualabusemedicalexam': 'asd', 'sexualabusedocumentation': 'asa', 
           'sexualabusefailedtoprotect': 'asdasd', 'sexualabusedisclosedto': 'asd', 
           'neglectabusenature': 'asdasd', 'neglectabusemedicalexam': 'dsfdsfdf', 'neglectabusedocumentation': 'sdfsdfssdf', 
           'neglectabusefailedtoprotect': 'sdfsdsd', 'neglectabusedisclosedto': 'sdfsdf', 'within12months': 0, 'severechronicdisability': 0, 
           'mentalhealthdisorder': 0, 'physicalissues': 'sfdsfsd', 'bornsubstanceexposed': 1, 'cinachildmedical': true, 'psychological': true,
            'disability': true, 'currentlocation': 'sdfsd', 'medical': null, 'childrelationshipwithparentsreason': 'sdfsd', 
            'legalstatusreason': 'sfsdsdf', 'homeconditiondescription': 'sdfsdfsd', 'inadequatehousing': 1, 
            'parentcannotidentified': 1, 'parentcannotidentifiedreason': 'sdfsdf', 'parentlocationunknown': 'sdfsdfsd', 
            'parentlocationunknownreason': 'ssdfsdfsf', 'departmentattempttolocateparents': null, 'parentphysicalmentalissues': null, 
            'isparentincarcerated': 0, 'parentincarcerated': 'sfdfsdfsd', 'isparenteconomicstatus': null, 'parenteconomicstatus': 'sdfsdf', 
            'isparentnotcareforchild': null, 'parentnotcareforchild': 'fsdfsdsd', 'isparentsubstance': null, 'parentsubstance': 'sdsdfs',
             'isparentadmitted': null, 'parentadmitted': 'sfsdfs', 'isparentrefused': null, 'parentrefused': 'sdfsdfs', 
             'isparentnotcompletetreatment': null, 'parentnotcompletetreatment': 'sdfdfsdf', 'isparentuncooperative': null, 
             'parentuncooperative': 'sdfsd', 'isparentsafetyplan': null, 'parentsafetyplan': 'sdfsdfsdf', 'parentcps': 'sdfsdf', 
             'parentchildwelfareservices': 'sdfsd', 'parentcriminal': 'sdfsd', 'parentcina': 'sdfsd', 'siblingcps': 'sdfsd', 
             'siblingchildwelfareservices': 'sdfsd', 'sibingcina': 'dfsfsd', 'issiblingrelationship': 'sdfsd', 'activechildwelfare': 0, 
             'effortsforpreventremoval': 'll that apply', 'ismonitoredchildsafety': true, 'monitoredchildsafety': 'In-Home Services', 
             'isofferedchildwelfareservices': true, 'offeredchildwelfareservices': 'Welfare Services', 'ismedicalservices': true, 
             'medicalservices': 'necessary monitoring', 'isparentingclasses': true, 'parentingclasses': ' necessary monitoring', 
             'isdisorderscreening': true, 'disorderscreening': 'provided ', 'ismentalhealth': true, 'mentalhealth': ' monitoring', 
             'isexploredrelative': true, 'exploredrelative': 'sdfsdfsfs', 'isotherreasons': true, 'otherreasons': 'sdfsdf', 
             'werereasonableeffortsmade': null, 'reasonableeffortsmade': 'Efoorts', 'wasfamilymeetingheld': true, 
             'familymeetingdate': '2019-03-13T18:30:00.000Z', 'familymeetingparticipants': 'as', 'familymeetingoutcome': 'asd', 
             'dateofremoval': '2019-03-28T18:30:00.000Z', 'timeofremoval': '00:00', 'otherinformation': 'asdas',
              'photoinformationexists': true, 'whohasevidence': 'asdas', 'typeofrecord': null};
        if (!isResetForm) {
        this.cinaForm.patchValue(testData);
        }  else {
            this.cinaForm.reset();
        }
    }

    reset() {
        this.cinasubpoenadForm.get('institution')?.clearValidators();
        this.cinasubpoenadForm.get('institution')?.updateValueAndValidity();
        this.cinaSiblingForm.enable();
        this.cinaSiblingForm.reset();
        this.selectedIndex = -1;
        this.cinasubpoenadForm.enable();
        this.cinasubpoenadForm.reset();
        this.viewMode = false;
        $('#add-sibling').modal('hide');
        $('#add-sub').modal('hide');
    }

    viewSibling(item: any, isView: boolean) {
      this.viewMode = isView;
      this.cinaSiblingForm.patchValue(item);
      this.cinaSiblingForm.disable();
    }

    editSibling(item: any, index: number) {
      this.cinaSiblingForm.enable();
      this.selectedIndex = index;
      this.cinaSiblingForm.patchValue(item);
    }

    updateSibling() {
        const cinaSiblingData = this.cinaSiblingForm.getRawValue();
        if (this.cinaSibling && this.cinaSibling.length) {
            this.cinaSibling[this.selectedIndex] = cinaSiblingData;
        }
    }


    viewSub(item: any, isView: boolean) {
        this.viewMode = isView;
        this.cinasubpoenadForm.patchValue(item);
        this.cinasubpoenadForm.disable();
      }

    editSub(item: any, index: number) {
        this.cinasubpoenadForm.get('institution')?.clearValidators();
        this.cinasubpoenadForm.get('institution')?.updateValueAndValidity();
        this.selectedIndex = index;
        this.cinasubpoenadForm.enable();
        this.selectedIndex = index;
        this.cinasubpoenadForm.patchValue(item);
      }

    updateSub() {
        this.cinasubpoenadForm.get('institution')?.setValidators([Validators.required]);
        this.cinasubpoenadForm.get('institution')?.updateValueAndValidity();
        if (this.cinasubpoenadForm && this.cinasubpoenadForm.invalid) {
            this.cinasubpoenadForm.markAllAsTouched();
            this.displayValidationMessages =true;
            return;
        }
          const cinaSub = this.cinasubpoenadForm.getRawValue();
          if (this.cinasubpoenad && this.cinasubpoenad.length) {
              this.cinasubpoenad[this.selectedIndex] = cinaSub;
          }
      this.cinasubpoenadForm.reset();
      this.reset();
      }

      documentGenerate(petitionId: any) {
        const modal = {
          count: -1,
          where: {
            documenttemplatekey: ['cinaForm'],
            intakeservicerequestpetitionid: petitionId,
            isheaderrequired: false,
            format: 'pdf'
          },
          method: 'post'
        };
          this._commonHttpService.download(this.generatedocurl, modal)
            .subscribe(res => {
              const blob = new Blob([new Uint8Array(res)]);
              const link = document.createElement('a');
              link.href = window.URL.createObjectURL(blob);
              link.download = 'CinaForm.pdf';
              document.body.appendChild(link);
              link.click();
              document.body.removeChild(link);
            });
      }

      getClientAttorney(clientAttorney: any) {
        if (clientAttorney && Array.isArray(clientAttorney)) {
            return clientAttorney.join();
        }
        return '';
      }

      declineDelete() {
        $(this.deletepopupid).modal('hide');
      }
      confirmDelete(modal: any){
        this.selectedPetition = modal;
        if(this.selectedPetition.hasHearingDetails === true){ 
            $('#delete-alert-popup').modal('show');
        } else {
            $(this.deletepopupid).modal('show');
            this.deleteItem = modal;
        }
      }

    getPersonNameList(id: any, list: any) {
        const selectPersonList = list.filter((f: { intakeservicerequestactorid: any; }) => id?.includes(f.intakeservicerequestactorid));
        this.selectPersonNameList = selectPersonList.map((item: { fullname: any; }) => item.fullname);
        this.selectedPersonDetails = selectPersonList;
        
    if (this.petitionDetailsForm.getRawValue()?.petitiontypekey === 'APGT') {
        const selectedActorIds = selectPersonList.map((p: any) => p.intakeservicerequestactorid);

        this.syncApgtFormsWithSelectedChildren(selectedActorIds);

        selectPersonList.forEach((p: any) => this.patchApgtFromPerson(p));
        }
        this.getClientFrmPlacements();
    }

    getOtherPersonNameList(id: any, list: any) {
        if (id) {
            const selectPersonList = list.filter((f: { intakeservicerequestactorid: any; }) => id.includes(f.intakeservicerequestactorid));
            this.selectOtherPersonNameList = selectPersonList.map((item: { fullname: any; }) => item.fullname);
        }
    }

    getErrorsMessage(ControlName: any, displayName: any) {
        const control = this.petitionDetailsForm.controls[ControlName];
        return control.status === 'INVALID' ? `${this.errmsg} ${displayName}` : null;
    }
    

    cinasubpoenadFormMsg(ControlName: any, displayName: any){
        const control = this.cinasubpoenadForm.controls[ControlName];
        return control.status === 'INVALID' ? `${this.errmsg }${displayName}` : null;
    }

    cinaFormMsg(ControlName: any, displayName: any){
        const control = this.cinaForm.controls[ControlName];
        return control.status === 'INVALID' ? `${this.errmsg} ${displayName}` : null;
    }

    getControlByIndexFn(index: string): FormControl {
        return this.cinaSiblingForm.controls[index] as FormControl;
    }
    getPlacementRecordList() {
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 10,
                    method: 'get',
                    where: { servicecaseid: this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID) },
                }),
                'placement/getplacementbyservicecase?filter'
            ).subscribe(data => {
                this.placementDetails = data.data;
            });
    }
    addInterestedPersons(childActorId: any) {
        this.interestedPersons = this.interestedPersons.concat({
            parentChildActorId: childActorId,
            intakeservicerequestactorid: null,
            personid: null,
            fullname: null,
            address: '',
            address2: '',
            city: '',
            state: '',
            zipcode: '',
            county: '',
            phonenumber: '',
            age: null,
            rolename: null,
            isSelected: false,
            deletedForChildActorIds: []
        });
    }

    addEmptyPersonInfo(ip: any, item: any) {
        const selectedItem = this.childList.find((child: any) => child.fullname === item);
        if (selectedItem) {
            ip.personid = selectedItem.personid;
            ip.intakeservicerequestactorid = selectedItem.intakeservicerequestactorid || null;
            ip.fullname = selectedItem.fullname;
            ip.address = selectedItem.address;
            ip.address2 = selectedItem.address2;
            ip.city = selectedItem.city;
            ip.state = selectedItem.state;
            ip.zipcode = selectedItem.zipcode;
            ip.county = selectedItem.county;
            ip.phonenumber = selectedItem.phonenumber;
            ip.age = selectedItem.age || null;
            ip.rolename = selectedItem.rolename || null;
            ip.isSelected = true;
            ip.deletedForChildActorIds = [];
        }

        this.interestedPersons = [...this.interestedPersons];
    }

    
     getClientFrmPlacements() {
        const selectedFocusNames = this.selectedPersonDetails;
        let freshPrimaryCaregivers: any = [];

        if (selectedFocusNames && selectedFocusNames.length > 0) {

            const isExist = this.placementDetails.filter((item: any) => (
                selectedFocusNames.some((name: any) => name.personid === item.personid)
            ));

            if (isExist && isExist.length > 0) {
                isExist.forEach((item: any) => {
                    (item.placements || []).forEach((p: any) => {
                        const isActivePlacement = (p.enddate === null || p.enddate === "");
                        if ((p.placementtypekey === "PRPL" && isActivePlacement)
                            || (p.livingarrangementtypekey === 'RFKH' && (p.placementtypekey == "LA" && isActivePlacement))) {
                            if (p && p.primarycaregiver) {
                                freshPrimaryCaregivers.push({
                                    fullname: p?.primarycaregiver,
                                    placementid: p.placementid,
                                    intakeservicerequestactorid: null,
                                    personid_: item?.personid,
                                    _src: p.livingarrangementtypekey,
                                    placementtypekey: p.placementtypekey
                                });
                            }
                        }
                    })
                });
            }
        }

        // remove old PRPL rows, add fresh PRPL rows
        this.clientActor = (this.clientActor || []).filter((x: any) => x?._src !== 'PRPL' && x?.rolename !== 'CHILD');

        const newOnes = freshPrimaryCaregivers.filter((pc: any) =>
            !this.clientActor.some((ca: any) =>
                (ca.placementid && pc.placementid && ca.placementid === pc.placementid) ||
                (ca.fullname === pc.fullname && ca.personid_ === pc.personid_)
            )
        );

        this.clientActor.push(...newOnes);
    }

    getClientActorsByPersonId(id: any) {
        const isExist = this.involvedPersons.filter(p => p.intakeservicerequestactorid === id)
        const personid = isExist[0].personid//this.getPersonIdByActorId(id);
        if (!personid) {
            return this.clientActor;
        }

        return (this.clientActor || []).filter((p: any) => {
            return (!p?.personid_ || p.personid_ === personid);
        });
    }
      formatPhoneNumber(phoneNumber: string = "") {
    return this._commonDropDownService.formatPhoneNumber(phoneNumber);
    }
    isPersonInChildList(fullname: string): boolean {
        return this.childList?.some(item => item.fullname?.trim() === fullname?.trim());
    }
    getInterestedPersonsByPersonId(childActorId: any) {
        const isExist = this.involvedPersons.filter(p => p.intakeservicerequestactorid === childActorId)
        const personid = isExist[0].personid//this.getPersonIdByActorId(id);
        if (!personid) {
            return this.interestedPersons;
        }
        const data = (this.interestedPersons || []).filter((ip: any) => ip.personid !== personid || (ip.parentChildActorId === childActorId && ip.intakeservicerequestactorid === null));
        return data;
    }
    removeInterestedPerson(ip: any, childActorId: any) {
        if (ip?.parentChildActorId) {
            this.interestedPersons = this.interestedPersons.filter((x: any) => x !== ip);
            return;
        }

        if (!ip.deletedForChildActorIds) {
            ip.deletedForChildActorIds = [];
        }

        if (!ip.deletedForChildActorIds.includes(childActorId)) {
            ip.deletedForChildActorIds.push(childActorId);
        }

        this.interestedPersons = [...this.interestedPersons];
    }
    getAvailableInterestedPersonChildList(childActorId: any, currentIp: any) {
        const selectedNames = (this.interestedPersons || [])
            .filter((ip: any) =>
                (ip?.parentChildActorId === childActorId || !ip?.parentChildActorId)
                && !(ip?.deletedForChildActorIds?.includes(childActorId))
                && ip?.fullname
                && ip !== currentIp
            )
            .map((ip: any) => ip.fullname?.trim());

        return (this.childList || []).filter((item: any) =>
            item?.intakeservicerequestactorid
            && !item?.collateralid
            && !item?.placementid
            && item.intakeservicerequestactorid !== childActorId
            && (
                item.fullname?.trim() === currentIp?.fullname?.trim()
                || !selectedNames.includes(item.fullname?.trim())
            )
        );
    }


    getClientActorRoleText(p: any): string {
        if (p?.roles?.length) {
            return p.roles
                .map((role: any) => role?.typedescription)
                .filter((desc: string) => desc)
                .join(', ');
        }

        if (p?.collateralroleconfig?.length) {
            return p.collateralroleconfig
                .map((role: any) => role?.description)
                .filter((desc: string) => desc)
                .join(', ');
        }

        if (p?.placementtypekey === 'PRPL') {
            return 'Provider Placement';
        }

        if (p?.placementtypekey === 'LA') {
            return 'Living Arrangement';
        }

        return '';
    }

    getClientActorDisplayName(p: any): string {
        return (p?.fullname || '').replace(/\s+/g, ' ').trim();
    }

    getSelectedClientActorName(selectedValue: any, childActorId: any): string {
        const selectedPerson = this.getClientActorsByPersonId(childActorId)?.find((p: any) =>
            (p.intakeservicerequestactorid || p.placementid) === selectedValue
        );

        return this.getClientActorDisplayName(selectedPerson);
    }
    getOtherClientsNamedOnPetitionList() {
        return (this.clientActor || []).filter((item: any) =>
            !item?.collateralid && !item?.placementid
        );
    }
    getPersonId(childActorId: any) {
        const person = this.involvedPersons.filter(p => p.intakeservicerequestactorid === childActorId);
        return person.length ? person[0].personid : null;
    }  

    showParents():boolean{
      return this.displayParents;
    }

    getParent1List() {
        const parent2 = this.petitionDetailsForm.get('parent2')?.value;

        return this.parents.filter(person => person.intakeservicerequestactorid !== parent2);
    }

    getParent2List() {
        const parent1 = this.petitionDetailsForm.get('parent1')?.value;

        return this.parents.filter(person => person.intakeservicerequestactorid !== parent1);
    }

    onParent1Change(value: any) {
        const parent2 = this.petitionDetailsForm.get('parent2')?.value;

        if (value === parent2) {
            this.petitionDetailsForm.get('parent2')?.setValue(null);
        }
    }

    onParent2Change(value: any) {
        const parent1 = this.petitionDetailsForm.get('parent1')?.value;

        if (value === parent1) {
            this.petitionDetailsForm.get('parent1')?.setValue(null);
        }
    }

 atLeastOneParentSelected(): ValidatorFn {
    return (form: AbstractControl): ValidationErrors | null => {
       const petitionType = form.get('petitiontypekey')?.value;

            if (petitionType !== 'GAPTPR') {
                return null;
            }
        const UNKNOWN = this.UNKNOWN_PARENT_VALUE || 'UNKNOWN';

        const parent1 = form.get('parent1')?.value;
        const parent2 = form.get('parent2')?.value;
        const parent1Unknown = form.get('parent1Unknown')?.value === true;
        const parent2Unknown = form.get('parent2Unknown')?.value === true;

        const parent1Valid =
            (parent1 && parent1 !== UNKNOWN) ||
            parent1Unknown ||
            parent1 === UNKNOWN;

        const parent2Valid =
            (parent2 && parent2 !== UNKNOWN) ||
            parent2Unknown ||
            parent2 === UNKNOWN;

        return parent1Valid || parent2Valid
            ? null
            : { parentRequired: true };
    };
}

    prepareParentActors(): void {
        const formValue = this.petitionDetailsForm.getRawValue();

        this.parentActors = [];

        if (formValue.parent1 || formValue.parent1Unknown) {
            const isParent1Unknown =
                formValue.parent1Unknown || formValue.parent1 === this.UNKNOWN_PARENT_VALUE;

            const parent1Obj = this.parents.find(
                person => person.intakeservicerequestactorid === formValue.parent1
            );

            this.parentActors.push({
                intakeservicerequestactorid: isParent1Unknown ? null : formValue.parent1,
                personid: isParent1Unknown ? null : parent1Obj?.personid || null,
                petitionactortype: 'PARENT1'
            });
        }

        if (formValue.parent2 || formValue.parent2Unknown) {
            const isParent2Unknown =
                formValue.parent2Unknown || formValue.parent2 === this.UNKNOWN_PARENT_VALUE;

            const parent2Obj = this.parents.find(
                person => person.intakeservicerequestactorid === formValue.parent2
            );

            this.parentActors.push({
                intakeservicerequestactorid: isParent2Unknown ? null : formValue.parent2,
                personid: isParent2Unknown ? null : parent2Obj?.personid || null,
                petitionactortype: 'PARENT2'
            });
        }
    }

    getParentName(actorId: any): string {
        if (actorId === this.UNKNOWN_PARENT_VALUE) {
            return 'Unknown';
        }

        const person = this.parents?.find(
            p => p.intakeservicerequestactorid === actorId
        );

        return person?.fullname || '';
    }

    isParent1Valid(): boolean {
        const formValue = this.petitionDetailsForm.getRawValue();
        const UNKNOWN = this.UNKNOWN_PARENT_VALUE || 'UNKNOWN';

        return !!(
            (formValue.parent1 && formValue.parent1 !== UNKNOWN) ||
            formValue.parent1Unknown === true ||
            formValue.parent1 === UNKNOWN
        );
    }

    isParent2Valid(): boolean {
        const formValue = this.petitionDetailsForm.getRawValue();
        const UNKNOWN = this.UNKNOWN_PARENT_VALUE || 'UNKNOWN';

        return !!(
            (formValue.parent2 && formValue.parent2 !== UNKNOWN) ||
            formValue.parent2Unknown === true ||
            formValue.parent2 === UNKNOWN
        );
    }
}