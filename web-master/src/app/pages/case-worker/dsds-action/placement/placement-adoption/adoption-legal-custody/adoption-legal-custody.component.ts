
import {map} from 'rxjs/operators';
import { Component, Injector, OnInit, signal } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';

import { DropdownModel, DynamicObject } from '../../../../../../@core/entities/common.entities';
import { AlertService } from '../../../../../../@core/services/alert.service';
import { CommonHttpService } from '../../../../../../@core/services/common-http.service';
import { InvolvedPerson } from '../../../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { Getlegalcustody } from '../_entities/adoption.model';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import { DataStoreService } from '../../../../../../@core/services/data-store.service';
import { PlacementAdoptionService } from '../placement-adoption.service';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { AuthService } from '../../../../../../@core/services';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'adoption-legal-custody',
    templateUrl: './adoption-legal-custody.component.html',
    styleUrls: ['./adoption-legal-custody.component.scss'],
    standalone: false
})
export class AdoptionLegalCustodyComponent implements OnInit {
    caseid: string;
    involvedYouth!: string;
    addEditLabel!: string;
    updateButton!: boolean;
    involvedPersons: InvolvedPerson[] = [];
    intakeservicerequestpetitionactors = [];
    adoptionLegalForm!: FormGroup;
    adoptionListDetails = signal<Getlegalcustody[]>([]);
    legalCustodyDropdownItems$!: Observable<DropdownModel[]>;
    apAlertMessage!: 'Hearing Outcome does not match TPR Granted';
    permanencyPlanId: any;
    private id: string;
    private store: DynamicObject;
    private daNumber: string;
    childActorId!: string;
    minDate!: Date;
    isAdoptionCreated!: boolean;
    isEditDisabled = false;
    private _commonHttpService: CommonHttpService;
    private _formBuilder: FormBuilder;
    private _alertService: AlertService;
    private _store: DataStoreService;
    private _router: Router;
    private _PlacementAdoptionService: PlacementAdoptionService;
    private _dataStoreService: DataStoreService;
    public _authService: AuthService;
    constructor(private injector: Injector) {
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._store = this.injector.get<DataStoreService>(DataStoreService);
        this._router = this.injector.get<Router>(Router);
        this._PlacementAdoptionService = this.injector.get<PlacementAdoptionService>(PlacementAdoptionService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.caseid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.store = this._store.getCurrentStore();
    }

    ngOnInit() {
        this.isEditDisabled = this._authService.isDisabled('adoptionplanning','adoptionplanning.legalcustody.edit');
        this.addEditLabel = 'Add';
        this.adoptionLegalForm = this._formBuilder.group({
            intakeservicerequestactorid: [''],
            fromdate: ['', [Validators.required]],
            todate: [''],
            relationship: [''],
            Address: [''],
            phonenumber: [''],
            workphone: [''],
            code: [''],
            reason: [''],
            legalcustodytypekey: ['', [Validators.required]],
            legalcustodyid: [null],
            permanencyplanid: [null]
        });

        this._PlacementAdoptionService.storeDataPatched$.subscribe(data => {
            if (data === 'TPRRecommend') {
        this.ValidateStoreValues();
          }
        });
        

        this.getBreaklink();


        // if (
        //     !this.store['TPRRecommendationList'] ||
        //     !this.store['TPRRecommendationList'].tprrecommendationid ||
        //     !this.store['TPRRecommendationList'].courtorder ||
        //     this.store['TPRRecommendationList'].courtorder.length
        // ) {
        //     if (this.store['TPRRecommendationList'] && this.store['TPRRecommendationList'].courtorder && this.store['TPRRecommendationList'].courtorder.length) {
        //         const validTpr = this.store['TPRRecommendationList'].courtorder.filter(itm =>  itm.petitiontypekey === 'GAPTPR' && itm.hearingoutcometypekey === 'TPRG');
        //         if (validTpr.length) {
        //             this.getInvolvedPerson();
        //             this.getLegalCustody();
        //             this.getLegalCustodyDropdown();
        //             this.disableFieldOnInit();
        //         } else {
        //             (<any>$('#ap-custody')).modal('show');
        //         }
        //     }
        //     // this._alertService.error('Hearing Outcome does not match TPR Granted');
        // } else {
        //     this.getInvolvedPerson();
        //     this.getLegalCustody();
        //     this.getLegalCustodyDropdown();
        //     this.disableFieldOnInit();
        // }
    }

    beginDateChange(form: any) {
        this.minDate = new Date(form.value.fromdate);
        form.get('todate').reset();
      }

    ValidateStoreValues() {
        if (this.store['placement_child']) {
            this.permanencyPlanId = this.store['placement_child'].permanencyplanid;
            this.adoptionLegalForm.patchValue({permanencyplanid: this.permanencyPlanId});
            this.childActorId = this.store['placement_child'].intakeservicerequestactorid;
        }
        if (
            this.store['TPRRecommendationId'] || this.store['TPR_RECOMMENDATION_ID']
        ) {
            this.getInvolvedPerson();
            this.getLegalCustody();
            this.getLegalCustodyDropdown();
            this.disableFieldOnInit();
        } else {
            (<any>$('#ap-custody')).modal('show');
        }
    }
    private getLegalCustodyDropdown() {
        this.legalCustodyDropdownItems$ = this._commonHttpService
            .getArrayList(
                {
                    where: {
                        referencetypeid: '28',
                        teamtypekey: null
                    },
                    method: 'get',
                    nolimit: true
                },
                'referencetype/gettypes' + '?filter'
            ).pipe(
            map(result => {
                return result.map(
                    res =>
                        new DropdownModel({
                            text: res.description,
                            value: res.ref_key
                        })
                );
            }));
    }
    private getInvolvedPerson() {
        this._commonHttpService
            .getArrayList(
                {
                    page: 1,
                    method: 'get',
                    where: {objectid: this.id , objecttypekey : 'servicecase'}
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
            )
            .subscribe((res: any) => {
                if (!res['data'] || res['data'].length === 0) {
                    return;
                }
                res['data'].map((item: any) => {
                    this.handleIfNoRolenameFn(item);
                    if (
                        item.rolename !== 'AV' &&
                        item.rolename !== 'AM' &&
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
                            if ( item.roles &&  item.roles.length &&  item.roles[0].intakeservicerequestactorid) {
                            item.intakeservicerequestactorid  = item.roles[0].intakeservicerequestactorid; }
                        }
                        this.involvedPersons.push(item);
                    }
                    // });
                });
                this.involvedPersons.sort((a,b)=>a.fullname.localeCompare(b.fullname));
            });
    }

    private handleIfNoRolenameFn(item: any) {
        if (!item.rolename || item.rolename === '') {

            if (item.roles && item.roles.length && item.roles[0].intakeservicerequestpersontypekey) {
                item.rolename = item.roles[0].intakeservicerequestpersontypekey;
            }
        }
    }

    manageAdoption(type: any, item?: any) {
        if (type === 'add') {
            this.addEditLabel = 'Add';
            this.adoptionLegalForm.patchValue({ legalcustodyid: null });
            this.adoptionLegalForm.enable();
            this.disableFieldOnInit();
            this.adoptionLegalForm.reset();
        } else {
            this.adoptionLegalForm.patchValue(item);
            this.changePerson(item.intakeservicerequestactorid);
            if (type === 'view') {
                this.addEditLabel = 'View';
                this.updateButton = true;
                this.adoptionLegalForm.disable();
            } else if (type === 'edit') {
                this.addEditLabel = 'Update';
                this.updateButton = true;
                this.adoptionLegalForm.enable();
                this.disableFieldOnInit();
            }
        }
        (<any>$('#addlegalcustody')).modal('show');
    }
    cancelAdoption() {
        this.adoptionLegalForm.reset();
        this.updateButton = false;
        this.addEditLabel = 'Add';
    }
    private getLegalCustody() {

        this._PlacementAdoptionService.getLegalCustody(this.childActorId)
            .subscribe(res => {
                if (res && res.length && res[0].getlegalcustody) {
                    this.adoptionListDetails.set(res?.[0]?.getlegalcustody ?? []);
                    this._store.setData('LegalCustodyDetails', this.adoptionListDetails());
                }
            });
    }

    saveLegalCustody(model: any) {
        const legalCustoduInput = model;
        legalCustoduInput.servicecaseid = this.id;
        legalCustoduInput.permanencyplanid = this.permanencyPlanId;
        if (!legalCustoduInput.intakeservicerequestactorid) {
            legalCustoduInput.intakeservicerequestactorid = this.childActorId;
        }
        const personId =  (this.store['placement_child'] && this.store['placement_child'].personid ) ? this.store['placement_child'].personid  : null;
        legalCustoduInput.personid = personId;
        this._commonHttpService.create(legalCustoduInput, CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.LegalCustodyAddUpdate).subscribe(
            res => {
                    this.updateButton = true;
                    this._alertService.success('adoption legal custody saved successfully');
                    (<any>$('#addlegalcustody')).modal('hide');
                    this.adoptionLegalForm.reset();
                    this.getLegalCustody();
            },
            err => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    changePerson(id: any) {
        let AddressText;
        const personRelation = this.returnPersonRelationFn(id);
        if (personRelation && personRelation.length) {
            AddressText = personRelation[0].address ? personRelation[0].address : '';
            AddressText += personRelation[0].address2 ? ', ' + personRelation[0].address2 : '';
            AddressText += personRelation[0].state ? ', ' + personRelation[0].state : '';
            AddressText += personRelation[0].city ? ', ' + personRelation[0].city : '';
            AddressText += personRelation[0].county ? ', ' + personRelation[0].county : '';
            AddressText += personRelation[0].zipcode ? ' - ' + personRelation[0].zipcode : '';
        }
        this.patchAdoptionLegalFormAddressDataFn(personRelation, AddressText);
    }
    // Assosiated with changePerson method
    private patchAdoptionLegalFormAddressDataFn(personRelation: InvolvedPerson[], AddressText: any) {
        const relationshipText = personRelation && personRelation.length ? personRelation[0].relationship : '';
        const Phoneno = personRelation && personRelation.length ? personRelation[0].phonenumber : '';
        this.adoptionLegalForm.patchValue({
            relationship: relationshipText,
            Address: AddressText,
            phonenumber: Phoneno
        });
    }
    // Assosiated with changePerson method
    private returnPersonRelationFn(id: any) {
        return this.involvedPersons && this.involvedPersons.length ? this.involvedPersons.filter(item => item.intakeservicerequestactorid === id) : [];
    }

    clearLeagalCustody() {
        this.adoptionLegalForm.reset();
        this.disableFieldOnInit();
    }
    private disableFieldOnInit() {
        this.adoptionLegalForm.get('relationship')?.disable();
        this.adoptionLegalForm.get('Address')?.disable();
        this.adoptionLegalForm.get('phonenumber')?.disable();
        this.adoptionLegalForm.get('workphone')?.disable();
        this.adoptionLegalForm.get('code')?.disable();
    }
    navigateTo() {
    this._PlacementAdoptionService.broadStoreDataPatched('TPRRecommend');
    const redirectUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/sc-permanency-plan/placement/adoption/tpr-recom';
    this._router.navigate([redirectUrl]);
        }

        private getBreaklink() {
            this._commonHttpService
              .getArrayList({
                method: 'get', where: {
                  adoptionplanningid: this._PlacementAdoptionService.getAdoptionPlanning().adoptionplanningid
                }
              }, 'adoptionbreakthelink/getadoptionbreakthelink?filter')
              .subscribe(res => {
                if (res && res.length) {
                  res.forEach((item) => {
                      if(item && item.getadoptionbreakthelink) {
                        item.getadoptionbreakthelink.forEach((breaklink: { adoptioncasenumber: any; }) => {
                            this.isAdoptionCreated = !!breaklink.adoptioncasenumber;
                          })
                      }
                  });
                }
              });
          }
}
