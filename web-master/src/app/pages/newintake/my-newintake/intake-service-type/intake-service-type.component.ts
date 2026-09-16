
import {map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import {
    FormBuilder,
    FormGroup,
    Validators
} from '@angular/forms';
import {
    DropdownModel,
    PaginationRequest
} from '../../../../@core/entities/common.entities';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { NewUrlConfig } from '../../newintake-url.config';
import {
    ComplaintTypeCase,
    ChoosenAllegation
} from '../_entities/newintakeSaveModel';
import { AuthService, DataStoreService } from '../../../../@core/services';
import { AppUser } from '../../../../@core/entities/authDataModel';
import {
    IntakePurpose,
    SubType,
    AllegationItem
} from '../_entities/newintakeModel';
import { REGEX } from '../../../../@core/entities/constants';
import { AlertService } from '../../../../@core/services/alert.service';
import * as reason from './_configurations/reason.json';
import { IntakeStoreConstants } from '../my-newintake.constants';
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'intake-service-type',
    templateUrl: './intake-service-type.component.html',
    styleUrls: ['./intake-service-type.component.scss'],
    standalone: false
})
export class IntakeServiceTypeComponent implements OnInit {

    // @Input() purposeInputSubject$ = new Subject<IntakePurpose>();
    // @Input() createdCaseInputSubject$ = new Subject<ComplaintTypeCase[]>();
    // @Input() createdCaseOuptputSubject$ = new Subject<ComplaintTypeCase[]>();
    // @Input() reviewstatus: string;

    reviewstatus!: string;
    serviceTypes$!: Observable<DropdownModel[]>;
    subServiceTypes$!: Observable<DropdownModel[]>;
    servicetype!: DropdownModel;
    createdCases: ComplaintTypeCase[] = [];
    createdCasesAdult: ComplaintTypeCase[] = [];
    caseCreationFormGroup!: FormGroup;
    caseEditFormGroup!: FormGroup;
    selectedPurpose!: IntakePurpose;
    purposeList: IntakePurpose[] = [];
    subServiceTypes: SubType[] = [];
    editCase!: ComplaintTypeCase;
    deleteCaseID!: string;
    roleId!: AppUser;
    token!: AppUser;
    reasonDropdown: DropdownModel[] = [];
    allegationDropDownItems: DropdownModel[] = [];
    allegationItems: AllegationItem[] = [];
    filteredAllegationItems: AllegationItem[] = [];
    choosenAllegation!: ChoosenAllegation;
    choosenAllegationNew$!: Observable<ChoosenAllegation[]>;
    choosenAllegationArray: any[] = [];


    // selectedDaTypeKeyforEdit: string;
    selectedcaseIndex!: number;
    caseIndex = 0;
    groupSetupForm!: FormGroup;
    groupDAReasonForm!: FormGroup;

    groupSelectedDAIds: string[] = [];
    ungroupSelectedGroupIds: string[] = [];
    store: any;
    constructor(
        private _commonHttpService: CommonHttpService,
        private formBuilder: FormBuilder,
        private _alertService: AlertService,
        private _authService: AuthService,
        private _dataStore: DataStoreService,
    ) {
        this.store = this._dataStore.getCurrentStore();
    }

    ngOnInit() {
        this.reviewstatus = this.store[IntakeStoreConstants.reviewstatus];
        this.buildFormGroup();
        if (this.store[IntakeStoreConstants.purposeSelected]) {
        this.loadAllegation(this.caseIndex, this.store[IntakeStoreConstants.purposeSelected].value);
        }
        this.roleId = this._authService.getCurrentUser();
        this.token = this._authService.getCurrentUser();
        this.reasonDropdown = <any>reason;

        // this.purposeInputSubject$.subscribe(purpose => {
        // this.selectedPurpose = purpose;
        // if (purpose.teamtype) {
        this.listServicetypes(this.store[IntakeStoreConstants.agency]);
        // }

        if (this.store[IntakeStoreConstants.purposeSelected] && this.store[IntakeStoreConstants.purposeSelected].value) {
            this.listServiceSubtype(this.store[IntakeStoreConstants.purposeSelected].value);

            this.caseCreationFormGroup.patchValue({
                serviceType: this.store[IntakeStoreConstants.purposeSelected].value
            });
        }
        // });
        // this.createdCaseOuptputSubject$.subscribe(createdCases =>
        {
            this.createdCases = this.store[IntakeStoreConstants.createdCases] ? this.store[IntakeStoreConstants.createdCases] : [];
        }// );

        const astData = this.store[IntakeStoreConstants.adultScreenTool];
        if (astData && astData.isComplete && !this.isApsInvestigationPresent()) {
            this.preCreateClassAndAllegation();
        }
        if (this._authService.isAS() && this.roleId.role.name === 'apcs') {
            this.caseCreationFormGroup.get('subServiceType')?.disable();
            this.caseCreationFormGroup.get('serviceType')?.disable();
        }
    }

    preCreateClassAndAllegation() {
        const astData = this.store[IntakeStoreConstants.adultScreenTool];
        this.selectedcaseIndex = 0;
        this.choosenAllegation = new ChoosenAllegation();
        this.choosenAllegationArray = [];
        if (astData.phyAbuseSelect === 1) {
            this.choosenAllegationArray.push('Physical Abuse');
        }
        if (astData.selfNeglectSelect === 1) {
            this.choosenAllegationArray.push('Self-Neglect');
        }
        if (astData.neglectedByOthersSelect === 1) {
            this.choosenAllegationArray.push('Neglect by Others');
        }
        if (astData.exploitationSelect === 1) {
            this.choosenAllegationArray.push('Exploitation');
        }
        if (astData.sexExploitationSelect === 1) {
            this.choosenAllegationArray.push('Sexual Exploitation');
        }
        if (astData.physicalEnvironmentSelect === 1) {
            this.choosenAllegationArray.push('Physical Environment');
        }
        const purposeID = this._dataStore.getData(IntakeStoreConstants.purposeSelected).value;
        if (this.choosenAllegationArray.length > 0 && purposeID) {
            this._commonHttpService
                .getArrayList({}, NewUrlConfig.EndPoint.Intake.NextnumbersUrl)
                .subscribe((result: any) => {
                    const complaintTypeCase: ComplaintTypeCase = new ComplaintTypeCase();
                    complaintTypeCase.caseID = result['nextNumber'];
                    const selectedPurpose = this.store[IntakeStoreConstants.purposeSelected].text;
                    const apsInvestigation = 'APS Investigation';
                    complaintTypeCase.serviceTypeID = purposeID;
                    complaintTypeCase.serviceTypeValue = selectedPurpose;
                    complaintTypeCase.apsInvestigation = apsInvestigation;
                    this.choosenAllegationResponseFn(astData, complaintTypeCase);
                });
        }

    }

    private choosenAllegationResponseFn(astData: any, complaintTypeCase: ComplaintTypeCase) {
        if (astData['subTypeId']) {
            complaintTypeCase.subServiceTypeID = astData['subTypeId'];
        } else {
            complaintTypeCase.subSeriviceTypeValue = '';
        }
        this.createdCases.push(complaintTypeCase);
        this.updateCreatedCases();
        for (let i = 0; i < this.choosenAllegationArray.length; i++) {
            this.choosenAllegation = new ChoosenAllegation();
            this.allegationDropDownItemsLoopFn(i);
        }
    }

    private allegationDropDownItemsLoopFn(i: number) {
        for (const element of this.allegationDropDownItems) {
            if (element.text === this.choosenAllegationArray[i]) {
                this.choosenAllegation.allegationID = element.value;
                this.choosenAllegation.allegationValue = element.text;
                this.createdCases[this.selectedcaseIndex].choosenAllegation.push(
                    this.choosenAllegation
                );
                this.saveAllegations();
            }
        }
    }

    isApsInvestigationPresent() {
        const acase = this.createdCases.find(element => element.apsInvestigation === 'APS Investigation');
        if (acase) {
            return true;
        } else {
            return false;
        }
    }

    buildFormGroup() {
        this.caseCreationFormGroup = this.formBuilder.group({
            serviceType: ['', Validators.required],
            subServiceType: ['', Validators.required],
            allegationId: ['']
        });
        this.caseEditFormGroup = this.formBuilder.group({
            serviceType: ['', Validators.required],
            subServiceType: ['', Validators.required]
        });
        this.groupSetupForm = this.formBuilder.group({
            DAItems: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            selectedDAItemsGroupNo: ['']
        });
        this.groupDAReasonForm = this.formBuilder.group({
            reasonType: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            reasonComments: ['']
        });
    }

    listServicetypes(teamtypekey: any) {
        const checkInput = {
            nolimit: true,
            where: { teamtypekey: teamtypekey },
            method: 'get',
            order: 'description'
        };

        this.serviceTypes$ = this._commonHttpService
            .getArrayList(
                new PaginationRequest(checkInput),
                NewUrlConfig.EndPoint.Intake.IntakePurposes + '/list?filter'
            ).pipe(
            map(result => {
                this.purposeList = result;
                return result.map(
                    res =>
                        new DropdownModel({
                            text: res.description,
                            value: res.intakeservreqtypeid
                        })
                );
            }));
    }

    getSelectedPurpose(purposeID: any): IntakePurpose | undefined {
        return this.purposeList.find((puroposeItem: any) => puroposeItem.intakeservreqtypeid === purposeID);
    }

    getSelectedSubtype(subTypeID: any): SubType | undefined {
        return this.subServiceTypes.find((subServiceType: any) => subServiceType.servicerequestsubtypeid === subTypeID);
    }

    listServiceSubtype(intakeservreqtypeid: any) {
        const checkInput = {
            include: 'servicerequestsubtype',
            nolimit: true,
            where: { intakeservreqtypeid: intakeservreqtypeid },
            method: 'get'
        };
        this.subServiceTypes$ = this._commonHttpService
            .getArrayList(
                new PaginationRequest(checkInput),
                NewUrlConfig.EndPoint.Intake.DATypeUrl + '/?filter'
            ).pipe(
            map(result => {
                this.subServiceTypes = result[0].servicerequestsubtype;
                return result[0].servicerequestsubtype.map(
                    (res: any) =>
                        new DropdownModel({
                            text: res.description,
                            value: res.servicerequestsubtypeid
                        })
                );
            }));
    }

    loadSubServiceTypes(serviceType: any) {
        this.listServiceSubtype(serviceType.value);
    }
    isSubTypeExists(servicerequestsubtypeid: string) {
        if (this.createdCases) {
            return this.createdCases.find(
                createdCase =>
                    createdCase.subServiceTypeID === servicerequestsubtypeid
            );
        }
        return false;
    }

    addCase() {
        if (this.caseCreationFormGroup.valid) {
            if (
                this.isSubTypeExists(
                    this.caseCreationFormGroup.value.subServiceType
                )
            ) {
                this._alertService.error(
                    'Already Case created for this sub type '
                );
                return false;
            }
            this._commonHttpService
                .getArrayList({}, NewUrlConfig.EndPoint.Intake.NextnumbersUrl)
                .subscribe((result: any) => {
                    const complaintTypeCase: ComplaintTypeCase = new ComplaintTypeCase();
                    complaintTypeCase.caseID = result['nextNumber'];
                    const selectedPurpose: any = this.getSelectedPurpose(
                        this.caseCreationFormGroup.value.serviceType
                    );
                    const selectedSubtype: any = this.getSelectedSubtype(
                        this.caseCreationFormGroup.value.subServiceType
                    );
                    complaintTypeCase.serviceTypeID = this.caseCreationFormGroup.value.serviceType;
                    complaintTypeCase.serviceTypeValue =
                        selectedPurpose.description;
                    complaintTypeCase.subServiceTypeID =
                        selectedSubtype.servicerequestsubtypeid;
                        this._dataStore.setData('purposesubtype', selectedSubtype.servicerequestsubtypeid);
                    complaintTypeCase.subSeriviceTypeValue =
                        selectedSubtype.description;
                    this.createdCases.push(complaintTypeCase);
                    this.updateCreatedCases();
                });
        }
    }

    deleteCase(intakeCase: ComplaintTypeCase) {
        this.deleteCaseID = intakeCase.caseID;
    }

    onEditCase(intakeCase: ComplaintTypeCase) {
        this.caseEditFormGroup.patchValue({
            serviceType: intakeCase.serviceTypeID,
            subServiceType: intakeCase.subServiceTypeID
        });
        this.editCase = intakeCase;
    }

    updateCreatedCases() {
        this._dataStore.setData(IntakeStoreConstants.createdCases, this.createdCases);
    }
    isUpdateDisabled() {
        if (this.editCase) {
            return (
                this.caseEditFormGroup.value.subServiceType ===
                this.editCase.subServiceTypeID
            );
        }
        return false;
    }
    updateSubTypes() {
        if (this.caseEditFormGroup.valid) {
            if (
                this.isSubTypeExists(
                    this.caseEditFormGroup.value.subServiceType
                )
            ) {
                this._alertService.error(
                    'Already Case created for this sub type '
                );
            } else {
                this.createdCases.forEach(complaintTypeCase => {
                    if (complaintTypeCase.caseID === this.editCase.caseID) {
                        const selectedPurpose: any = this.getSelectedPurpose(
                            this.caseEditFormGroup.value.serviceType
                        );
                        const selectedSubtype: any = this.getSelectedSubtype(
                            this.caseEditFormGroup.value.subServiceType
                        );
                        complaintTypeCase.serviceTypeID = this.caseEditFormGroup.value.serviceType;
                        complaintTypeCase.serviceTypeValue =
                            selectedPurpose.description;
                        complaintTypeCase.subServiceTypeID =
                            selectedSubtype.servicerequestsubtypeid;
                        complaintTypeCase.subSeriviceTypeValue =
                            selectedSubtype.description;
                        $('#editClose').click();
                    }
                });
            }
        }
    }

    deleteCaseConfirm() {
        this.createdCases = this.createdCases.filter(
            createdCase => createdCase.caseID !== this.deleteCaseID
        );
        this.updateCreatedCases();
        (<any>$('#delete-asd-asd')).modal('hide'); // NOSONAR
    }

    isPeaceOrder(complaintCase: ComplaintTypeCase): boolean {
        return complaintCase.subSeriviceTypeValue === 'Peace Order';
    }

    loadAllegation(caseIndex: number, daTypeKey: string) {
        this.selectedcaseIndex = caseIndex;
        this.choosenAllegation = new ChoosenAllegation();

        this.allegationItems = [];
        this.allegationDropDownItems = [];
        this.filteredAllegationItems = [];
        this.caseCreationFormGroup.patchValue({
            allegationId: ''
        });
        const url =
            NewUrlConfig.EndPoint.Intake.AllegationsIndicaorUrl + '?filter';
        this._commonHttpService
            .getArrayList(
                {
                    where: { intakeservreqtypeid: daTypeKey },
                    method: 'get'
                },
                url
            )
            .subscribe(result => {
                this.allegationItems = result.map(
                    item => new AllegationItem(item)
                );
                this.allegationDropDownItems = this.allegationItems.map(
                    item =>
                        new DropdownModel({
                            text: item.allegationname,
                            value: item.allegationid
                        })
                );
            });
    }

    allegationOnChange(option: any) {
        this.loadSelectedAllegation(option.value);
        this.choosenAllegation.allegationID = option.value;
        this.choosenAllegation.allegationValue = option.label;
    }

    loadSelectedAllegation(selectedAllegation: string) {
        this.filteredAllegationItems = this.allegationItems.filter(item => {
            return item.allegationid === selectedAllegation;
        });
    }

    indicatorsChecked(model: string, control: any) {
        if (control.target.checked) {
            this.choosenAllegation.indicators.push(model);
        } else {
            const index = this.choosenAllegation.indicators.indexOf(model);
            this.choosenAllegation.indicators.splice(index, 1);
        }
    }

    saveAllegations() {
        let ispresent = false;
        this.createdCases[this.selectedcaseIndex].choosenAllegation.forEach(
            element => {
                if (
                    this.choosenAllegation.allegationID === element.allegationID
                ) {
                    element.indicators = this.choosenAllegation.indicators;
                    ispresent = true;
                }
            }
        );
        if (!ispresent) {
            this.createdCases[this.selectedcaseIndex].choosenAllegation.push(
                this.choosenAllegation
            );
        }
    }

    deleteAllegation(caseIndex: number, aligationIndex: number) {
        this.createdCases[caseIndex].choosenAllegation.splice(
            aligationIndex,
            1
        );
    }

    openGroupSetup() {
        if (
            this.groupSetupForm.value.DAItems &&
            this.groupSetupForm.value.DAItems.length >= 2 &&
            this.createdCases.filter(item => !item.GroupNumber).length >= 2
        ) {
            (<any>$('#serviceGroupReason')).modal('show'); // NOSONAR
        } else {
            this._alertService.error('Please select at least 2 Case');
        }
    }

    cancelGroupSetup() {
        this.groupDAReasonForm.reset();
        this.groupSetupForm.reset();
        (<any>$('#serviceGroupReason')).modal('hide'); // NOSONAR
    }

    saveGroupSetup() {
        if (
            this.groupSetupForm.value.DAItems &&
            (this.groupDAReasonForm.valid && this.groupDAReasonForm.dirty)
        ) {
            this.groupSelectedDAIds = this.groupSetupForm.value.DAItems;
            this._commonHttpService
                .getArrayList(
                    {},
                    'Nextnumbers/getNextNumber?apptype=GroupAuthorizationNumber'
                )
                .subscribe((result: any) => {
                    this.createdCases = this.createdCases.map(item => {
                        this.groupSelectedDAIds.forEach(da => {
                            if (item.caseID === da) {
                                item.GroupNumber = result['nextNumber'];
                                item.GroupReasonType = this.groupDAReasonForm.value.reasonType;
                                item.GroupComment = this.groupDAReasonForm.value.reasonComments;
                            }
                        });
                        return item;
                    });
                    this.cancelGroupSetup();
                    return { nextNumber: result };
                });
        } else {
            this._alertService.error('Please select Grouping reason type');
        }
    }

    unGroupDAItems() {
        if (this.groupSetupForm.value.selectedDAItemsGroupNo) {
            this.ungroupSelectedGroupIds = this.groupSetupForm.value.selectedDAItemsGroupNo;
            this.createdCases = this.createdCases.map(item => {
                this.ungroupSelectedGroupIds.forEach(da => {
                    if (item.GroupNumber === da) {
                        item.GroupNumber = '';
                        item.GroupReasonType = '';
                        item.GroupComment = '';
                    }
                });
                return item;
            });
            this._dataStore.setData(IntakeStoreConstants.createdCases, this.createdCases);
        }
    }

}
