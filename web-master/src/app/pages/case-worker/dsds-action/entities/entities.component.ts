
import {pluck, share, map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { DropdownModel, PaginationInfo } from '../../../../@core/entities/common.entities';
import { forkJoin,  Observable } from 'rxjs';
import { EntitesSave, InvolvedEntitySearchResponse, InvolvedEntitySearch } from '../../_entities/caseworker.data.model';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { GenericService, CommonHttpService, AlertService } from '../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { ObjectUtils } from '../../../../@core/common/initializer';

@Component({
    selector: 'entities',
    templateUrl: './entities.component.html',
    styleUrls: ['./entities.component.scss'],
    standalone: false
})
export class EntitiesComponent implements OnInit {
  involvedEntitiesForm: FormGroup;
  entityDetailsForm: FormGroup;
  entityId: number;
  canShowSSBG = false;
  involvedEntityData: boolean = false;
  entitesSearchTabActive = false;
  entitesserachResultTabActive = false;
  entiteSearchTabActive = false;
  previousButtonDisabel = true;
  entityDetailsSave: EntitesSave = new EntitesSave();
  entitySubjectArray: EntitesSave[] = [];
  addedEntities: InvolvedEntitySearchResponse[] = [];
  listEntities: EntitesSave[] = [];
  editEntityData: EntitesSave;
  editEntityIndex: number;
  selectEntite: InvolvedEntitySearchResponse;
  paginationInfo: PaginationInfo = new PaginationInfo();
  countyDropDownItems$: Observable<DropdownModel>;
  stateDropDownItems$: Observable<DropdownModel>;
  regionDropDownItems$: Observable<DropdownModel>;
  categoryDropDownItems$: Observable<DropdownModel>;
  roleDropdownItems$: Observable<DropdownModel[]>;
  roleTypeDropdownItems$: Observable<DropdownModel[]>;
  involvedEntitySearchResponses$: Observable<InvolvedEntitySearchResponse[]>;
  totalRecords$: Observable<number>;
  canDisplayPager$: Observable<boolean>;
  private involvedEntitySearch: InvolvedEntitySearch;
  entitysearchpopupid = '#entities-search';
  constructor(
    private formBuilder: FormBuilder,
    private _involvedEntitySeachService: GenericService<InvolvedEntitySearchResponse>,
    private _commonHttpService: CommonHttpService,
    private _alertService: AlertService
  ) { }

  ngOnInit() {
    this.initilizeForm();
    this.loadDropdownItems();
  }
  initilizeForm() {
    this.involvedEntitiesForm = this.formBuilder.group({
      description: [''],
      agencycategorykey: [''],
      facid: [''],
      ssbg: [''],
      address1: [''],
      address2: [''],
      zipcode: [''],
      city: [''],
      region: [''],
      state: [''],
      county: [''],
      phonenumber: [''],
      isSatelliteOffice: [''],
      satelliteOffice: false
    });
    this.entityDetailsForm = this.formBuilder.group({
      agencyroletypekey: ['', [Validators.required]],
      agencytypekey: ['', [Validators.required]]
    });
  }
  searchResult() {
    (<any>$('#search-result-click')).click();
    this.paginationInfo.pageNumber = 1;
  }
  searchInvolvedEntities(model: InvolvedEntitySearch) {
    this.entitesSearchTabActive = true;
    this.involvedEntitySearch = model;
    this.involvedEntitiesForm.reset();
    this.getPage(1);
  }
  selectInvolvedEntity(model: InvolvedEntitySearchResponse, control: any) {
    this.selectEntite = model;
    const tempCount = this.listEntities.filter((item) => item.agencyid === model.agencyid);
    if (tempCount.length >= 1) {
      this._alertService.error('Entity Already Exists');
      control.target.checked = false;
    } else {
      if (this.addedEntities.length >= 1) {
        this.addedEntities.forEach((data) => {
          this.addedEntities.splice(0, 1);
          this.addedEntities.push(model);
        });
      } else {
        this.addedEntities.push(model);
      }
    }
  }
  saveEntity(event) {
    if (this.involvedEntitiesForm.valid) {
      if (this.entityDetailsForm.valid) {
        this.entitesSearchTabActive = false;
        this.entitesserachResultTabActive = false;
        this.entiteSearchTabActive = false;
        if (this.editEntityIndex !== undefined) {
          this.listEntities[this.editEntityIndex].agencyroletypekey = event.agencyroletypekey;
          this.listEntities[this.editEntityIndex].agencytypekey = event.agencytypekey;
          this.involvedEntitiesForm.reset();
          this.entityDetailsForm.reset();
          (<any>$(this.entitysearchpopupid)).modal('hide');
          this.editEntityIndex = undefined;
        } else {
          const entitySaveItem = this.addedEntities[0];
          this.entityDetailsSave = <EntitesSave>{
            agencyid: entitySaveItem.agencyid,
            description: entitySaveItem.agencyname,
            agencysubtype: entitySaveItem.agencysubtype,
            agencytypedesc: entitySaveItem.agencytypedesc,
            phonenumber: entitySaveItem.phonenumber,
            state: entitySaveItem.state,
            zipcode: entitySaveItem.zipcode,
            agencyroletypekey: event.agencyroletypekey,
            agencytypekey: event.agencytypekey
          };
          this.listEntities.push(this.entityDetailsSave);
          this.closePopup();
          this.editEntityIndex = undefined;
        }
      } else {
        this._alertService.warn('Please fill mandatory fields');
      }
    } else {
      this._alertService.warn('Select Entity Role');
    }
  }
  clearSearch() {
    this.involvedEntitiesForm.reset();
  }
  closePopup() {
    (<any>$(this.entitysearchpopupid)).modal('hide');
    this.involvedEntitiesForm.reset();
    this.entityDetailsForm.reset();
    this.editEntityIndex = undefined;
    this.entitesSearchTabActive = false;
    this.entitesserachResultTabActive = false;
    this.entiteSearchTabActive = false;
  }
  editEntity(model, index) {
    (<any>$(this.entitysearchpopupid)).modal('show');
    (<any>$('#entiterole')).click();
    this.entitesSearchTabActive = true;
    this.entitesserachResultTabActive = true;
    this.previousButtonDisabel = false;
    this.editEntityData = model;
    this.editEntityIndex = index;
    this.loadEntityDropdowns();
    this.entityDetailsForm.patchValue({
      agencyroletypekey: model.agencyroletypekey,
      agencytypekey: model.agencytypekey
    });
  }
  tabNavigation(id) {
    if (id === 'entiteinfo') {
      (<any>$('#' + id)).click();
      this.entitesserachResultTabActive = true;
      this.selectEntite = Object.assign({});
      this.paginationInfo.pageNumber = 1;
    }
    if (id === 'entiterole') {
      if (this.selectEntite.agencyid) {
        (<any>$('#' + id)).click();
        this.loadEntityDropdowns();
        this.entitesserachResultTabActive = true;
      } else {
        this._alertService.warn('Please select an entity.');
      }
    }
    (<any>$(this.entitysearchpopupid)).modal('show');
    if (id === 'search-result-click') {
      (<any>$('#' + id)).click();
      this.entiteSearchTabActive = true;
    }
  }
  searchPopup(id) {
    this.selectEntite = Object.assign({});
    (<any>$(this.entitysearchpopupid)).modal('show');
    (<any>$('#' + id)).click();
  }
  confirmDelete(model: EntitesSave) {
    this.entityId = this.listEntities.indexOf(model);
    (<any>$('#delete-entity-popup')).modal('show');
  }

  deleteInvolvedEntity() {
    this.listEntities.splice(this.entityId, 1);
    this.entitySubjectArray.splice(this.entityId, 1);
    (<any>$('#delete-entity-popup')).modal('hide');
    this.entityId = null;
  }
  pageChanged(event: any) {
    this.paginationInfo.pageNumber = event.page;
    this.paginationInfo.pageSize = event.itemsPerPage;
    this.getPage(this.paginationInfo.pageNumber);
  }
  private loadDropdownItems() {
    const source = forkJoin([
      this._commonHttpService.create(
        {
          nolimit: true
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.CountyList
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.StateListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          where: { activeflag: '1' },
          method: 'get',
          nolimit: true
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.entities.RegionListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.entities.AgencyCategoryUrl + '?filter'
      )
    ]).pipe(
      map((result) => {
        return {
          counties: result[0].map(
            (res) =>
              new DropdownModel({
                text: res.countyname,
                value: res.countyname
              })
          ),
          stateList: result[1].map(
            (res) =>
              new DropdownModel({
                text: res.statename,
                value: res.stateabbr
              })
          ),
          regions: result[2]['data'].map(
            (res) =>
              new DropdownModel({
                text: res.regionname,
                value: res.regionid
              })
          ),
          categories: result[3].map(
            (res) =>
              new DropdownModel({
                text: res.description,
                value: res.agencycategorykey
              })
          )
        };
      }),
      share(),);
    this.countyDropDownItems$ = source.pluck('counties');
    this.stateDropDownItems$ = source.pluck('stateList');
    this.regionDropDownItems$ = source.pluck('regions');
    this.categoryDropDownItems$ = source.pluck('categories');
  }
  private getPage(pageNumber: number) {
    ObjectUtils.removeEmptyProperties(this.involvedEntitySearch);
    const source = this._involvedEntitySeachService
      .getAllFilter(
        {
          limit: this.paginationInfo.pageSize,
          order: '',
          page: pageNumber,
          count: this.paginationInfo.total,
          where: this.involvedEntitySearch
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.entities.InvolvedEnititesSearchUrl
      ).pipe(
      map((result) => {
        this.canShowSSBG = result.data.filter((item) => item.ssbg).length !== 0;
        return {
          data: result.data,
          count: result.count,
          canDisplayPager: result.count > this.paginationInfo.pageSize
        };
      }),
      share(),);
    this.involvedEntitySearchResponses$ = source.pipe(pluck('data'));
    if (pageNumber === 1) {
      this.totalRecords$ = source.pipe(pluck('count'));
      this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
    }
  }
  private loadEntityDropdowns() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.entities.EntityRoletypeUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          where: { agencycategorykey: 'Agency' },
          order: 'displayorder ASC',
          method: 'get',
          nolimit: true
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetSentTo + '?filter'
      )
    ]).pipe(
      map((result) => {
        return {
          entityRoleType: result[0].map(
            (data) =>
              new DropdownModel({
                text: data.typedescription,
                value: data.agencyroletypekey
              })
          ),
          entitySubRoleType: result[1].map(
            (data) =>
              new DropdownModel({
                text: data.typedescription,
                value: data.agencytypekey
              })
          )
        };
      }),
      share(),);
    this.roleDropdownItems$ = source.pipe(pluck('entityRoleType'));
    this.roleTypeDropdownItems$ = source.pipe(pluck('entitySubRoleType'));
  }

}
