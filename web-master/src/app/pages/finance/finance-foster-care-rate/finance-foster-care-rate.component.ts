
import {pluck, map, share, mergeMap, startWith, debounceTime} from 'rxjs/operators';
import { Component, OnInit, Input } from '@angular/core';
import { Observable, merge, Subject } from 'rxjs';
import { PaginationInfo, PaginationRequest, DropdownModel, DynamicObject } from '../../../@core/entities/common.entities';
import { CommonHttpService, AlertService, AuthService } from '../../../@core/services';
import { FormBuilder, FormGroup, Validators} from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import _ from 'lodash';
import { FinanceUrlConfig } from '../finance.url.config';
import { FosterCareRate } from '../_entities/finance-entity.module';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'finance-foster-care-rate',
    templateUrl: './finance-foster-care-rate.component.html',
    styleUrls: ['./finance-foster-care-rate.component.scss'],
    standalone: false
})
export class FinanceFosterCareRateComponent implements OnInit {
  @Input() showTable!: boolean;
  @Input() pageNumberResult$!: Subject<number>;
  @Input() totalResulRecords$!: Observable<number>;

  paginationInfo: PaginationInfo = new PaginationInfo();
  private pageSubject$ = new Subject<number>();
  fosterCareForm!: FormGroup;
  updateFosterCare!: boolean;
  fosterCareRate$!: Observable<FosterCareRate[]>;
  fosterCareRateHist$!: Observable<FosterCareRate[]>;
  addFosterCareRate!: FosterCareRate;
  approveFosterCareRate!: FosterCareRate;
  rateType$!: Observable<DropdownModel[]>;
  serviceType$!: Observable<DropdownModel[]>;
  rateid: any;
  canDisplayPager$!: Observable<boolean>;
  pageStream$ = new Subject<number>();
  private searchTermStream$ = new Subject<DynamicObject>();
  validation_messages: any;
  selectedfosterCare: any;
  perDiemRate!: number;
  monthlyRate!: number;
  perDiemRateDiable!: boolean;

  isHist!: boolean;
  isSupervisor!: boolean;
  isRateApproved!: boolean;
  countyList$!: Observable<DropdownModel[]>;
  countyidlist: any[] = [];
  isMonthlyDiff!: boolean;
  isClothing!: boolean;
  isStipend!: boolean;
  invalidAgeRange!: boolean;
  isBedFee!: boolean;
  dirtyStatus!: number;
  rateStatus!: string;
  isFinance!: boolean;
  enteravalidamountmsg = 'Enter a valid amount';
  regexnopattern = '^[+-]?([0-9]*[.])?[0-9]+$';
  addfostercarepopupid = '#add-fostercare';

  constructor(private _httpService: CommonHttpService,
    private _formBuilder: FormBuilder,
    private _alertService: AlertService,
   // private _ativityService: GenericService<>,
    private route: ActivatedRoute,
    private _authService: AuthService) { }

  ngOnInit() {
    this.getAccessRole();
    this.pageSubject$.subscribe((pageNumber :any)=> {
      this.paginationInfo.pageNumber = pageNumber;
    });
    this.paginationInfo.sortBy = null;
    this.paginationInfo.sortColumn = null;
    this.buildForm();
    this.getFosterCareRate(this.paginationInfo.pageNumber);
    this.getRateServiceType();
    this.getCounty();
    this.isSupervisor = false;
    this.isPending(false);
    this.isHistory(false);
    this.perDiemRateDiable = false;
    this.isMonthlyDiff = false;
    this.isClothing = false;
    this.isStipend = false;
    this.fosterCareForm.get('monthly_rate_no')?.disable();
    this.fosterCareForm.get('per_diem_rate_no')?.disable();
    this.fosterCareForm.get('max_clothing_no')?.disable();
    this.fosterCareForm.get('monthly_stipend_no')?.disable();
  }
  private getAccessRole(){
    const cache = Date.now();
    const userid = this._authService.getCurrentUser().userId;
    this._httpService
        .getAll(`Authorizes/getPageProfile?cache=${cache}&arg={"count":-1,"where":{"modulekey":"finance-module","userid":${userid}},"method":"get"}`)
        .subscribe((res:any) => {
            const data: any = res;
            this.isFinance = _.includes(_.map(data.resources, 'resourceid'), 'manage_fostercare_rates');
        });
  }
  private buildForm() {
    this.validation_messages = {
      'monthly_rate_no': [
          { type: 'pattern', message: this.enteravalidamountmsg }
      ],
      'max_clothing_no': [
          { type: 'pattern', message: this.enteravalidamountmsg }
      ],
      'per_diem_rate_no': [
        { type: 'pattern', message: this.enteravalidamountmsg }
      ],
      'monthly_stipend_no': [
        { type: 'pattern', message: this.enteravalidamountmsg }
      ],
      'monthly_differential_no': [
        { type: 'pattern', message: this.enteravalidamountmsg }
      ],
      'emergency_bed_fee': [
        { type: 'pattern', message: this.enteravalidamountmsg }
      ],
      'min_age_no': [
        { type: 'pattern', message: 'Minimum age range 0 - 20' }
      ],
      'max_age_no': [
        { type: 'pattern', message: 'Maximum age range 1 - 20' }
      ]
  };
    this.fosterCareForm = this._formBuilder.group({
      rate_type_cd: ['', Validators.required],
      service_id: [null, Validators.required],
      start_dt: [null, Validators.required],
      end_dt: [null],
      min_age_no: [null, Validators.compose([Validators.required, Validators.pattern('^([0-9]|1[0-9]|2[0])$')])], //@TM: allow only 0-20
      max_age_no: [null, Validators.compose([Validators.required, Validators.pattern('^([1-9]|1[0-9]|2[0])$')])], //@TM: allow only 1-20
      monthly_rate_no: [null, Validators.compose([Validators.pattern(this.regexnopattern)])],
      max_clothing_no: [null, Validators.compose([Validators.pattern(this.regexnopattern)])],
      per_diem_rate_no: [null, Validators.compose([Validators.pattern(this.regexnopattern)])],
      monthly_stipend_no: [null, Validators.compose([Validators.pattern(this.regexnopattern)])],
      monthly_differential_no: [null, Validators.compose([Validators.pattern(this.regexnopattern)])],
      emergency_bed_fee: [null, Validators.compose([Validators.pattern(this.regexnopattern)])],
      county_id: [null]
  });
  }

  validateAgeRange(maxAgeValue: any) {
    var max = maxAgeValue.target.value;
    var min = this.fosterCareForm.get('min_age_no')?.value;
    if (+max < +min) {
      this.invalidAgeRange = true;
    } else {
      this.invalidAgeRange = false;
    }
  }

  public clearItem() {
    this.fosterCareForm.reset();
    this.rateid = null;
    this.countyidlist = [];
    this.dirtyStatus = 1;
    this.rateStatus = 'pending';
  }

  private buildResponse(result: any) {
    if (result && result.data.length) {
      return { data: result.data, count: result.count, canDisplayPager: result.count > this.paginationInfo.pageSize };
    } else {
      return null;
    }
  }

  private getFosterCareRate(page: any): void {
  type SearchPageParam = { search: string | null; page: number };
  const pageSource: Observable<SearchPageParam> = this.pageStream$.pipe(
    map((pageNumber: number) => {
      this.paginationInfo.pageNumber = pageNumber;
      return { search: null, page: pageNumber };
    })
  );
  
    const searchSource: Observable<SearchPageParam> = this.searchTermStream$.pipe(
      map((searchTerm: any) => String(searchTerm || '')),
      debounceTime(1000),
      map((searchTerm: string) => {
      return { search: searchTerm, page: 1 };
      })
    );

    this.paginationInfo.pageNumber = page;

    const source: Observable<any> = merge(searchSource, pageSource).pipe(
      startWith<SearchPageParam>({
        search: null,
        page: this.paginationInfo.pageNumber,
    }),
    mergeMap((params: SearchPageParam) => {
      return this._httpService.getPagedArrayList(
      new PaginationRequest({
        where: {
          rateid: null,
          sortcolumn: this.paginationInfo.sortColumn,
          sortorder: this.paginationInfo.sortBy
        },
        limit: this.paginationInfo.pageSize,
        page: params.page,
      method: 'get'
    }),
    FinanceUrlConfig.EndPoint.fosterCareRate.listFosterCare + '?filter'
        ).pipe(
    map(result => this.buildResponse(result)));
      }),
      share()
    );
  
    this.fosterCareRate$ = source.pipe(pluck('data'));
    if (this.paginationInfo.pageNumber === 1) {
      this.totalResulRecords$ = source.pipe(pluck('count')) as Observable<number>;
      this.canDisplayPager$ = source.pipe(pluck('canDisplayPager')) as Observable<boolean>;
    }
  }

  private getFosterCareRateHist(rateid: number, page: number) {
    const pageSource = this.pageStream$.pipe(map((pageNumber:any) => {
      this.paginationInfo.pageNumber = pageNumber;
      return { search: null, page: pageNumber };
    }));
    const searchSource = this.searchTermStream$.pipe(debounceTime(1000),map((searchTerm:any) => {
      return { search: searchTerm, page: 1 };
      }),);
    this.paginationInfo.pageNumber = page;
    const source = merge(searchSource,pageSource).pipe(
      startWith({
        search: null,
        page: this.paginationInfo.pageNumber
    }),
    mergeMap((params: { search: null; page: number }) => {
      return this._httpService.getPagedArrayList(
      new PaginationRequest({
        where: {
          mainrateid: rateid,
          sortcolumn: this.paginationInfo.sortColumn,
          sortorder: this.paginationInfo.sortBy
        },
        limit: this.paginationInfo.pageSize,
        page: this.paginationInfo.pageNumber,
      method: 'get'
    }),
    FinanceUrlConfig.EndPoint.fosterCareRate.fosterCareRateHist + '?filter'
    ).pipe(
    map(result => this.buildResponse(result)));
  }),share(),);
    this.fosterCareRateHist$ = source.pipe(pluck('data')) as Observable<FosterCareRate[]>;
    if (this.paginationInfo.pageNumber === 1) {
      this.totalResulRecords$ = source.pipe(pluck('count')) as Observable<number>;
      this.canDisplayPager$ = source.pipe(pluck('canDisplayPager')) as Observable<boolean>;
    }
  }

  onSorted($event: ColumnSortedEvent) {
    this.paginationInfo.sortBy = $event.sortDirection;
    this.paginationInfo.sortColumn = $event.sortColumn;
    this.getFosterCareRate(this.paginationInfo.pageNumber);
  }

   pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.paginationInfo.pageSize = pageInfo.itemsPerPage;
    this.pageStream$.next(this.paginationInfo.pageNumber);
  }

  checkPlacementType(serviceId: string) { //@TM: Disable Monthly Rates for Emgcy Plcmt Structs
    if (serviceId == '13') { //@TM: Enable Per Diem only for Emgcy Foster Home Care
      this.fosterCareForm.get('monthly_rate_no')?.disable();
      this.fosterCareForm.get('per_diem_rate_no')?.enable();
      this.fosterCareForm.get('monthly_stipend_no')?.disable();
    } else if (serviceId == '71' || serviceId == '15') {
      this.fosterCareForm.get('monthly_rate_no')?.disable();
      this.fosterCareForm.get('per_diem_rate_no')?.disable();
      this.fosterCareForm.get('monthly_stipend_no')?.enable();
    } else {
      this.fosterCareForm.get('monthly_rate_no')?.enable();
      this.fosterCareForm.get('per_diem_rate_no')?.disable();
      this.fosterCareForm.get('monthly_stipend_no')?.enable();
    }
  }

  checkRateType(rateCd: string) { //@TM: Enable Clothing only for clothing rate type
    if (rateCd == '5669' || rateCd == '1233' || rateCd == '5671' || rateCd == '5670') { 
      this.fosterCareForm.get('max_clothing_no')?.enable();
      this.isClothing = true;
    } else {
      this.fosterCareForm.get('max_clothing_no')?.disable();
      this.isClothing = false;
    }

    if (rateCd == '1234') {
      this.fosterCareForm.get('monthly_stipend_no')?.enable();
      this.isStipend = true;
    } else {
      this.fosterCareForm.get('monthly_stipend_no')?.disable();
      this.isStipend = false;
    }

    if (rateCd == '5629') {
      this.fosterCareForm.get('emergency_bed_fee')?.enable();
      this.isBedFee = true;
    } else {
      this.fosterCareForm.get('emergency_bed_fee')?.disable();
      this.isBedFee = false;
    }
  }

  initJurisdiction(event: any) { //@TM: Jurisdiction is mandatory when Monthly Differential Rate is entered
    const monthlyDiff :any =event.target.value
    if (monthlyDiff && monthlyDiff > 0) {
      this.isMonthlyDiff = true;
      this.fosterCareForm.get('county_id')?.setValidators(Validators.required);
      this.fosterCareForm.get('county_id')?.updateValueAndValidity();
    } else {
      this.isMonthlyDiff = false;
      this.fosterCareForm.get('county_id')?.clearValidators();
      this.fosterCareForm.get('county_id')?.updateValueAndValidity();
    }
  }

  public saveFosterCare() {
    this.updateFosterCare = false;
    this.isPending(true);
    (<any>$(this.addfostercarepopupid)).modal('show');
  }
  calculatePerDiem(monthlyRate: any) {
    this.monthlyRate = +monthlyRate.target.value;
   this.perDiemRate = this.monthlyRate / 30 ;
   this.perDiemRate = +this.perDiemRate.toFixed(2);
    this.fosterCareForm.patchValue({
      per_diem_rate_no: this.perDiemRate ? this.perDiemRate : 0.00
    });
  }

  isHistory(flag: any){
    if(flag) {
      this.isHist = true;
    } else {
      this.isHist = false;
    }
  }

  isPending(flag: any){
    if(flag) {
      this.isRateApproved = false;
      this.dirtyStatus = 1;
      this.rateStatus = 'pending';
    }
  }

  isApproved(flag: any){
    if(flag) {
      this.isRateApproved = true;
      this.dirtyStatus = 0;
      this.rateStatus = 'approved';
    } else {
      this.isRateApproved = false;
      this.dirtyStatus = 1;
      this.rateStatus = 'rejected';
    }
  }

  saveFosterCareRate(fosterCareRate: FosterCareRate) {
    fosterCareRate.rate_id = this.rateid;
    if (fosterCareRate.rate_id) {
      this.updateFosterCare = true;
    } else {
      this.updateFosterCare = false;
    }
    if (this.fosterCareForm.valid) {
      if (fosterCareRate) {
        this.addFosterCareRate = Object.assign(fosterCareRate);
        this.addFosterCareRate.per_diem_rate_no = this.perDiemRate;


        var countyids = this.fosterCareForm.get('county_id')?.value;

        this.countryIdsFilterFn(countyids);
        
        this.addFosterCareRate = Object.assign({
            countyidlist: this.countyidlist,
            dirty_status: this.dirtyStatus,
            rate_status: this.rateStatus
          },
          fosterCareRate
      );

        this._httpService.create(this.addFosterCareRate,
          FinanceUrlConfig.EndPoint.fosterCareRate.addUpdateFosterCare)
        .subscribe((res:any) => {
          (<any>$(this.addfostercarepopupid)).modal('hide');
          this.addUpdateFosterCareApiStatusResponseFn();
          this.clearItem();
          this.paginationInfo.sortBy = null;
          this.paginationInfo.sortColumn = null;
          this.getFosterCareRate(1);
        },
        (error:any) => {
          this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
        );
      }
    }
    (<any>$('#fosterCareRateHist')).modal('hide');
    (<any>$('#viewFosterCare')).modal('hide');    
  }
  
  private countryIdsFilterFn(countyids: any) {
    if (countyids) {
      for (const id of countyids) {
        this.countyidlist.push({
          "county_id": id
        });
      }
    }
  }

  // Associated with saveFosterCareRate function
  private addUpdateFosterCareApiStatusResponseFn() {
    if (this.updateFosterCare) {
      this._alertService.success('Foster Care Rate Updated successfully!');
    } else {
      this._alertService.success('Foster Care Rate Added successfully!');
    }
  }

  public editFosterCare(fosterCareRate: any) {
    this.updateFosterCare = true;
    this.rateid = fosterCareRate.rate_id;
    (<any>$(this.addfostercarepopupid)).modal('show');
    this.checkPlacementType(fosterCareRate.service_id);
    this.checkRateType(fosterCareRate.rate_type_cd);
    this.initJurisdiction(fosterCareRate.monthly_differential_no);
    this.fosterCareForm.patchValue({
      rate_type_cd: fosterCareRate.rate_type_cd,
      service_id: fosterCareRate.service_id,
      min_age_no: fosterCareRate.min_age_no,
      max_age_no: fosterCareRate.max_age_no,
      start_dt: fosterCareRate.start_dt,
      end_dt: fosterCareRate.end_dt,
      monthly_rate_no: fosterCareRate.monthly_rate_no ? fosterCareRate.monthly_rate_no : '0.00',
      max_clothing_no: fosterCareRate.max_clothing_no ? fosterCareRate.max_clothing_no : '0.00',
      monthly_stipend_no: fosterCareRate.monthly_stipend_no ? fosterCareRate.monthly_stipend_no : '0.00',
      per_diem_rate_no: fosterCareRate.per_diem_rate_no ? fosterCareRate.per_diem_rate_no : '0.00',
      monthly_differential_no: fosterCareRate.monthly_differential_no ? fosterCareRate.monthly_differential_no : '0.00',
      county_id: fosterCareRate.county_id ? fosterCareRate.county_id : null
    });
    if(fosterCareRate.status == 'approved'){
      this.isApproved(true);
    } else {
      this.isApproved(false);
    }
  }

  private getRateServiceType() {
    this.rateType$ = this._httpService.getArrayList({
      count: -1,
      where: {picklist_type_id: '82'},
      nolimit: true,
      method: 'get'
    },
    FinanceUrlConfig.EndPoint.fosterCareRate.rateType + '?filter'
    ).pipe(
    map((result:any) => {
      return result?.map(
          (res:any) =>
              new DropdownModel({
                  text: res.description_tx,
                  value: res.picklist_value_cd
              })
      );
  }));
  this.serviceType$ = this._httpService.getArrayList({
    count: -1,
    where: {structure_service_cd: 'P', provider_id: null},
    nolimit: true,
    method: 'get'
  },
  FinanceUrlConfig.EndPoint.fosterCareRate.serviceType + '?filter'
  ).pipe(
  map((result:any) => {
    return result.map(
        (res:any) =>
            new DropdownModel({
                text: res.service_nm,
                value: res.service_id
            })
    );
  }));
  }

  private getCounty() {
    const source = this._httpService.create(
      {
        where: {
            activeflag: '1',
            state: 'MD'
        },
        order: 'countyname asc',
        nolimit: true
      },
      FinanceUrlConfig.EndPoint.fosterCareRate.countyList
    ).pipe(map((res: any[]) => {
      return {
        countyList: res.map(
          item =>
            new DropdownModel({
              text: item.countyname,
              value: item.countyid
            })
        )
      }
    }));
    this.countyList$ = source.pipe(pluck('countyList'));
  }

  confirmDelete(rateid: any) {
    this.rateid = rateid;
    (<any>$('#delete-fostercare-popup')).modal('show');
  }

  public viewFosterCare(fosterCareInfo: any) {
    this.selectedfosterCare = fosterCareInfo;

    if(this.isHist && fosterCareInfo) {
      this.rateid = fosterCareInfo.main_rate_id;
      this.fosterCareForm.patchValue({
        rate_type_cd: fosterCareInfo.rate_type_cd,
        service_id: fosterCareInfo.service_id,
        min_age_no: fosterCareInfo.min_age_no,
        max_age_no: fosterCareInfo.max_age_no,
        start_dt: fosterCareInfo.start_dt,
        end_dt: fosterCareInfo.end_dt,
        monthly_rate_no: fosterCareInfo.monthly_rate_no ? fosterCareInfo.monthly_rate_no : '0.00',
        max_clothing_no: fosterCareInfo.max_clothing_no ? fosterCareInfo.max_clothing_no : '0.00',
        monthly_stipend_no: fosterCareInfo.monthly_stipend_no ? fosterCareInfo.monthly_stipend_no : '0.00',
        per_diem_rate_no: fosterCareInfo.per_diem_rate_no ? fosterCareInfo.per_diem_rate_no : '0.00',
        monthly_differential_no: fosterCareInfo.monthly_differential_no ? fosterCareInfo.monthly_differential_no : '0.00',
        county_id: fosterCareInfo.county_id ? fosterCareInfo.county_id : null
      });
    }
  }

  public deleteFosterCare() {
    this._httpService.endpointUrl = FinanceUrlConfig.EndPoint.fosterCareRate.deleteFosterCare;
    this._httpService.create({
        rate_id: this.rateid,
        // method: 'post'
    })
        .subscribe(
            (response :any) => {
                if (response) {
                    this._alertService.success(
                        'Foster Care Rate deleted successfully'
                    );
                    (<any>$('#delete-fostercare-popup')).modal('hide');
                    this.getFosterCareRate(1);
                }
            },
           (error:any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    this.clearItem();
  }

}
