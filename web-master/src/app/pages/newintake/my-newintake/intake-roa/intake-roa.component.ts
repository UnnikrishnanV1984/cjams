
import {of as observableOf,  Observable } from 'rxjs';
import { Component, OnInit } from '@angular/core';
import { CommonHttpService, DataStoreService, CommonDropdownsService } from '../../../../@core/services';
import { NewUrlConfig } from '../../newintake-url.config';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { IntakeStoreConstants } from '../my-newintake.constants';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../../case-worker/case-worker-url.config';

@Component({
    selector: 'intake-roa',
    templateUrl: './intake-roa.component.html',
    styleUrls: ['./intake-roa.component.scss'],
    standalone: false
})
export class IntakeRoaComponent implements OnInit {
  states: any;
  jurisdictions: any;
  services: any;
  resources: any;
  roaForm!: FormGroup;
  searchResult: any;
  isAudtLogVisible: any;
  disableFind!: boolean;
  isLoadingSaveData!: boolean;
  intakenumber!: any;
  caseList$!: Observable<any[]>;
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalRecords!: number;
  caseNumber: any;
  radioSelected: any;
  constructor(
    private _commonHttpService: CommonHttpService,
    private _formBilder: FormBuilder,
    private _datastoreService: DataStoreService,
    private _commonDDService: CommonDropdownsService
  ) { }

  ngOnInit() {
    this.initFormGorup();
    this.loadDropdowns();
    this.patchSavedValues();
    this.roaForm.valueChanges.subscribe(data => {
      this._datastoreService.setData(IntakeStoreConstants.roacps, data);
    });
    this.intakenumber =   this._datastoreService.getData('intakenumber');
    this.roaForm.patchValue({
      intakenumber: this.intakenumber
    });
  }

  patchSavedValues() {
    const roacps = this._datastoreService.getData(IntakeStoreConstants.roacps);
    if (roacps) {
      this.isLoadingSaveData = true;
      this.roaForm.patchValue(roacps);
      this.changeStateType(this.roaForm.get('statetype')?.value);
      this.isLoadingSaveData = false;
    }
  }

  initFormGorup() {
    this.roaForm = this._formBilder.group({
      servicerequested: [null],
      resourcetypes: [null],
      statetype: [null],
      jurisdiction: [null],
      cpsid: [null],
      state: [null],
      otherresource: [null],
      roacpsstatetypekey: ['MD'],
      intakenumber: [null]

    });
  }



   isOtherResource() {
    const selectedResource = this.roaForm.getRawValue().resourcetypes;
    if (selectedResource) {
      return selectedResource.includes('TOROTH');
    } else {
      return false;
    }
   }
  loadDropdowns() {
    this.loadStates();

    this._commonHttpService.create(
      { where: { state: 'MD' }, order: 'countyname asc', nolimit: true},
      NewUrlConfig.EndPoint.Intake.MDCountryListUrl
    ).subscribe(res => {
      this.jurisdictions = res;
    });

    this._commonHttpService.getArrayList(
      {
        method: 'get',
        nolimit: true,
        where: { 'active_sw': 'Y', 'delete_sw': 'N', 'picklist_type_id': '241' }
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
    ).subscribe(res => {
      this.services = res;
    });

    this._commonHttpService.getArrayList({
      nolimit: true,
      where: { referencetypeid: 100 }, order: 'displayorder ASC', method: 'get'
    },
      'referencevalues?filter').subscribe(res => {
        this.resources = res;
      });
  }

  private loadStates() {
    this._commonHttpService.getArrayList({
      method: 'get',
      nolimit: true
    }, NewUrlConfig.EndPoint.Intake.StateListUrl + '?filter').subscribe(res => {
      this.states = res;
    });
  }

  changeStateType(state: string | null) {
    if (state === 'instate') {
      this.roaForm.get('state')?.setValue('MD');
      this.roaForm.get('state')?.disable();
      this.ifInStateFn();
      this.roaForm.get('jurisdiction')?.enable();
      this.roaForm.get('cpsid')?.setValidators(Validators.required);
      this.roaForm.get('cpsid')?.updateValueAndValidity();

    } else {
      this.ifNotInStateFn(state);
      
    }
  }

  private ifNotInStateFn(state: string | null) {
    if (!this.isLoadingSaveData) {
      this.roaForm.get('state')?.setValue(null);
    }
    this.roaForm.get('state')?.enable();
    this.roaForm.get('cpsid')?.clearValidators();
    this.roaForm.get('cpsid')?.updateValueAndValidity();
    if (this.states && Array.isArray(this.states)) {
      this.states.forEach(s => s.stateabbr !== 'MD');
    }
    if (!this.isLoadingSaveData) {
      this.roaForm.get('jurisdiction')?.setValue(null);

    }
    if (state !== null) {
      this.roaForm.get('jurisdiction')?.disable();
    }
  }

  private ifInStateFn() {
    let mdFound = true;

    if (this.states) {
      mdFound = this.states.find((s: { stateabbr: string; }) => s.stateabbr === 'MD');
    }

    if (!mdFound) {
      this.states.push({
        stateabbr: 'MD',
        statename: 'Maryland'
      });
    }
    if (!this.isLoadingSaveData) {
      this.roaForm.get('jurisdiction')?.setValue(null);
    }
  }

  searchCaseNumber(page: any) {
    if (this.roaForm.get('cpsid')) {
      const reqData = {
        // 'actiontype': null,
        'servicerequestnumber': this.roaForm.get('cpsid')?.value || ''
        //  'workername': null
      };
      this._commonHttpService
        .getSingle(
          {
            order: 'desc',
            where: reqData,
            method: 'get',
            pagenumber : page,
            pagesize:10
          },
          'Intakeservicerequests/getcpscase?filter'
        ).subscribe(data => {
          if (data && data.length) {
            this.totalRecords = +data[0].totalcount;
          }
          if (data && data.length) {
            this.searchResult = data;
            this.disableFind = false;
            this.caseList$ = observableOf(this.searchResult);
          }
        });
    }
  }

  selectedCase(casenumber: any) {
        this.caseNumber = casenumber;
   }

   selectedCasenumber() {
     this.roaForm.patchValue({
       cpsid: this.caseNumber || this.roaForm.get('cpsid')?.value
     });
   }

   openAuditLog(item: any) {
     // No data or function to call or add
   }
   routeToCase(item: any) {
    // No data or function to call or add
  }

}
