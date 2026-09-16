
import {pluck, share, map} from 'rxjs/operators';
import { Component, OnInit, AfterViewInit } from '@angular/core';
import { CommonHttpService, DataStoreService, AuthService } from '../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { ActivatedRoute } from '@angular/router';
import { DropdownModel } from '../../../../@core/entities/common.entities';
import { Observable } from 'rxjs';
import { FormGroup, FormBuilder, ValidatorFn, ValidationErrors, Validators } from '@angular/forms';
import { LegalActionHistory } from '../../_entities/caseworker.data.model';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';

declare const $ : any;

@Component({
    selector: 'legal-action-history',
    templateUrl: './legal-action-history.component.html',
    styleUrls: ['./legal-action-history.component.scss'],
    standalone: false
})
export class LegalActionHistoryComponent implements OnInit, AfterViewInit {
  hearingTypes$!: Observable<DropdownModel[]>;
  courtActions$!: Observable<DropdownModel[]>;
  courtOrders$!: Observable<DropdownModel[]>;
  adjudicatedDecision$!: Observable<DropdownModel[]>;
  adjudicatedOffense$!: Observable<DropdownModel[]>;
  legalActionHistoryForm!: FormGroup;
  viewHistoryForm!: FormGroup;
  id!: string;
  courtActionDescription: string[] = [];
  courtOrderDescription: string[] = [];
  histories: LegalActionHistory[] = [];

  defaulthearingdate = '2018-09-27T00:00:00.000Z';

  constructor(private _commonHttpService: CommonHttpService, private _route: ActivatedRoute,
    private _formBuilder: FormBuilder, private _dataStoreService: DataStoreService, private _authService: AuthService) { }

  ngOnInit() {
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.loadDropdowns();
    this.initFormGroup();
    this.legalActionHistoryForm.valueChanges.subscribe(res => { 
      // No content to add or call
    });
  }
  ngAfterViewInit() {
      const intakeCaseStore = this._dataStoreService.getData('IntakeCaseStore');
      if (this._authService.isDJS() && intakeCaseStore && intakeCaseStore.action === 'view') {
          $(':button').prop('disabled', true);
          $('span').css({'pointer-events': 'none',
                      'cursor': 'default',
                      'opacity': '0.5',
                      'text-decoration': 'none'});
          $('i').css({'pointer-events': 'none',
                                  'cursor': 'default',
                                  'opacity': '0.5',
                                  'text-decoration': 'none'});
          $('th a').css({'pointer-events': 'none',
                                  'cursor': 'default',
                                  'opacity': '0.5',
                                  'text-decoration': 'none'});
      }
  }

  loadDropdowns() {
    const courtActionUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.CourtActionTypeUrl + '?filter={"nolimit":true,"where": {"intakeservicerequestid": "' + this.id + '"}}';
    const hearing = this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.legalActionHistory.hearingType).pipe(
      map(hearingType => {
        return {
          hearingTypes: hearingType.map(res =>
            new DropdownModel({
              text: res.description,
              value: res.hearingtypekey
            }))
        };
      }),share(),);

    const courtAction = this._commonHttpService.getArrayList({}, courtActionUrl).pipe(
      map(courtActions => {
        return {
          courtActions: courtActions.map(res => new DropdownModel({
            text: res.description,
            value: res.courtactiontypekey
          }))
        };
      }),share(),);

    const courtOrder = this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.CourtOrderTypeUrl + '?filter={"nolimit":true}').pipe(
      map(courtOrders => {
        return {
          courtOrders: courtOrders.map(res => new DropdownModel({
            text: res.description,
            value: res.courtordertypekey
          }))
        };
      }),share(),);

    const adjudicatedDecision = this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.AdjudicatedDecisionTypeUrl + '?filter={"nolimit":true}').pipe(
      map(decision => {
        return {
          decision: decision.map(res => new DropdownModel({
            text: res.description,
            value: res.adjudicateddecisiontypekey
          }))
        };
      }),share(),);

    const adjudicatedOffense = this._commonHttpService.getArrayList({}, CaseWorkerUrlConfig.EndPoint.DSDSAction.Allegation.AllegationURL + '?filter={"nolimit":true,"order":"name asc"}').pipe(
      map((offense: any) => {
        return {
          offense: offense['data'].map((res: { name: any; allegationid: any; }) => new DropdownModel({
            text: res.name,
            value: res.allegationid
          }))
        };
      }),share(),);

    this.hearingTypes$ = hearing.pipe(pluck('hearingTypes'));
    this.courtActions$ = courtAction.pipe(pluck('courtActions'));
    this.courtOrders$ = courtOrder.pipe(pluck('courtOrders'));
    this.adjudicatedDecision$ = adjudicatedDecision.pipe(pluck('decision'));
    this.adjudicatedOffense$ = adjudicatedOffense.pipe(pluck('offense'));
  }

  initFormGroup() {
    this.legalActionHistoryForm = this._formBuilder.group({
      petitionID: '',
      complaintID: '',
      hearingType: '',
      worker: '',
      hearingDate: '',
      courtActions: '',
      courtOrder: '',
      courtDate: '',
      terminationDate: '',
      adjudicationDate: '',
      adjudicationDecision: '',
      adjudicatedOffense: ''
    }, { validators: this.atLeastOne(Validators.required) });

    this.viewHistoryForm = this._formBuilder.group({
      petitionID: '',
      complaintID: '',
      hearingType: '',
      worker: '',
      hearingDate: '',
      courtActions: '',
      courtOrder: '',
      courtDate: '',
      terminationDate: '',
      adjudicationDate: '',
      adjudicationDecision: '',
      adjudicatedOffense: ''
    });
  }

  selectCourtActionType(event: any) {
    if (event) {
      event.map((res: any) => {
        return { courtactiontypekey: res };
      });
      this.courtActions$.subscribe(items => {
        if (items) {
          const getActiontems = items.filter(item => {
            if (event.includes(item.value)) {
              return item;
            }
          });
          this.courtActionDescription = getActiontems.map(res => res.text);
        }
      });
    }
  }

  selectCourtOrderType(event: any) {
    if (event) {
     event.map((res: any) => {
        return { courtordertypekey: res };
      });
      this.courtOrders$.subscribe(items => {
        if (items) {
          const getOrdertems = items.filter(item => { // NOSONAR  // This function has less than 3 lines of identical code. Hence, marking it as no sonar.
            if (event.includes(item.value)) {
              return item;
            }
          });
          this.courtOrderDescription = getOrdertems.map(res => res.text);
        }
      });
    }
  }

  atLeastOne = (validator: ValidatorFn) => (
    group: FormGroup,
  ): ValidationErrors | null => {
    const hasAtLeastOne = group && group.controls && Object.keys(group.controls)
      .some(k => !validator(group.controls[k]));

    return hasAtLeastOne ? null : {
      atLeastOne: true,
    };
  }

  filterHistory(): void {
    this.histories = [];
    this.histories.push({
      petitionID: 'QA1234',
      complaintID: 'AQ4321',
      hearingType: 'Arrangement',
      worker: 'John Doe',
      hearingDate: '9/7/2018',
      courtActions: ['Dismissed'],
      courtOrder: ['Nolle Pros'],
      courtDate: '9/7/2018',
      terminationDate: '9/7/2018',
      adjudicationDate: '9/7/2018',
      adjudicationDecision: 'Sustained',
      adjudicatedOffense: 'Burglary 4th Degree'
    });
  }

  resetForm() {
    this.histories = [];
    this.legalActionHistoryForm.reset();
  }

  view(history: LegalActionHistory) {
    const historyValue : LegalActionHistory = {
      petitionID: 'QA1234',
      complaintID: 'AQ4321',
      hearingType: 'Arraign',
      worker: 'John Doe',
      hearingDate: this.defaulthearingdate,
      courtActions: ['AdjudiDismiss'],
      courtOrder: ['NP'],
      courtDate: this.defaulthearingdate,
      terminationDate: this.defaulthearingdate,
      adjudicationDate: this.defaulthearingdate,
      adjudicationDecision: 'S',
      adjudicatedOffense: '4d520133-cc4c-400e-81bc-5ecc50973418'
    };
    this.courtActionDescription = ['Dismissed'];
    this.courtOrderDescription = ['Dismissed'];
    this.viewHistoryForm.patchValue(historyValue);
    this.viewHistoryForm.disable();
    $('#view-history').modal('show');
  }
}
