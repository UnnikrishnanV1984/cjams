import { Component, OnInit, AfterViewChecked, ChangeDetectorRef, ViewRef, OnDestroy, Injector } from '@angular/core';
import { InvolvedPerson, PersonSearch, InvolvedPersonSearchResponse, PersonRelation } from '../../../../@core/common/models/involvedperson.data.model';
import { PaginationInfo } from '../../../../@core/entities/common.entities';

import { AlertService, GenericService, DataStoreService, CommonDropdownsService } from '../../../../@core/services';
import { Router, ActivatedRoute } from '@angular/router';
import { ObjectUtils } from '../../../../@core/common/initializer';
import { Observable } from 'rxjs';
import { RelationshipService } from '../relationship.service';
import { PersonDetailsService } from '../../person-details.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'search-relationship-result',
    templateUrl: './search-relationship-result.component.html',
    styleUrls: ['./search-relationship-result.component.scss'],
    standalone: false
})
export class SearchRelationshipResultComponent implements OnInit, AfterViewChecked, OnDestroy {
  personSearchForm!: InvolvedPerson;
  paginationInfo: PaginationInfo = new PaginationInfo();
  canDisplayPager$!: Observable<boolean>;
  totalRecords$!: Observable<number>;
  personSearchResult$!: Observable<PersonSearch[]>;
  showPersonDetail = -1;
  selectedPerson: PersonSearch | null =null ;
  relationShipDropdownItems: any[] = [];
  relationshipTypeKey!: string | null;
  personid: string;
  relationshipType!: string | null;
  inCustody!: boolean;
  livingWith!: boolean;
  relationshipTypeList: any[] = [
    { key: 'P', text: 'Primary' },
    { key: 'S', text: 'Secondary' },
    { key: 'O', text: 'Other' }
  ];
  involvedPersonSearchResponses: any[] = [];
  totalCount!: number;
  isAuthorized :any; //for fortify issues 

  private _alertService: AlertService;
  private router: Router;
  private _involvedPersonSeachService: GenericService<InvolvedPersonSearchResponse>;
  private _dataStoreService: DataStoreService;
  private route: ActivatedRoute;
  private dropdownService: CommonDropdownsService;
  private personService: PersonDetailsService;
  private relationshipService: RelationshipService;
  private _changeDetect: ChangeDetectorRef;

  constructor(private injector : Injector){
    this._alertService = this.injector.get<AlertService>(AlertService);
    this.router =  this.injector.get<Router>(Router);
    this._involvedPersonSeachService =  this.injector.get<GenericService<InvolvedPersonSearchResponse>>(GenericService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this.route =  this.injector.get<ActivatedRoute>(ActivatedRoute);
    this.dropdownService =  this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this.personService =  this.injector.get<PersonDetailsService>(PersonDetailsService);
    this.relationshipService =  this.injector.get<RelationshipService>(RelationshipService);
    this._changeDetect =  this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);

    this.personid = this.personService.person.personid;
  }

  ngOnInit() {
    this.isAuthorized= this._dataStoreService.isAuthorized(); //for fortify issues 
    this.selectedPerson = null;
    this.relationshipTypeKey = null;
    this.relationshipType = null;
    this.inCustody = false;
    this.livingWith = false;
    this.loadDropdowns();
    this.checkRelationship();
    this.personSearchForm = this._dataStoreService.getData('RELATION_PERSON_SEARCH_FORM');
    if (this.personSearchForm) {
      this.getPage(1);
    } else {
      this.router.navigate(['../search'], { relativeTo: this.route });
    }
    this._dataStoreService.setData('RELATION_PERSON_SEARCH_FORM', null);
  }
  ngOnDestroy(): void {
    //No operation needed here
  }

  ngAfterViewChecked() {
    // explicit change detection to avoid "expression-has-changed-after-it-was-checked-error"
    this._changeDetect.detectChanges();
  }

  private checkRelationship() {
    const relationships = this.relationshipService.relativePersons;
    if (relationships && relationships.length > 0) {
      const primary = relationships.find(data => (data.relationcategory === 'P'));
      if (primary) {
        this.relationshipTypeList = this.relationshipTypeList.filter(data => data.key !== primary.relationcategory);
      }
      const secondary = relationships.find(data => (data.relationcategory === 'S'));
      if (secondary) {
        this.relationshipTypeList = this.relationshipTypeList.filter(data => data.key !== secondary.relationcategory);
      }
    }
  }
 
  private loadDropdowns() {
    if (!this.dropdownService.personRelations) {
      this.dropdownService.getRelations().subscribe(relations => {
        this.dropdownService.personRelations = relations;
        this.relationShipDropdownItems = this.dropdownService.personRelations;
      });
    } else {
      this.relationShipDropdownItems = this.dropdownService.personRelations;
    }
  }

  private getPage(pageNumber: number) {
    ObjectUtils.removeEmptyProperties(this.personSearchForm);
    this._involvedPersonSeachService
      .getPagedArrayList(
        {
          limit: this.paginationInfo.pageSize,
          order: this.paginationInfo.sortBy,
          page: pageNumber,
          count: this.paginationInfo.total,
          where: this.personSearchForm,
          method: 'post'
        },
        'globalpersonsearches/getEnhancedPersonSearchData'
      )
      .subscribe((result) => {
        this.involvedPersonSearchResponses = result.data;
        this.totalCount = result.count;
        if (!(this._changeDetect as ViewRef).destroyed) {
          this._changeDetect.detectChanges();
        }
      });
  }

  pageChanged(event: any) {
    this.paginationInfo.pageNumber = event.page;
    this.getPage(this.paginationInfo.pageNumber);
  }
  searchPersonDetails(id: number) {
    if (this.showPersonDetail !== id) {
      this.showPersonDetail = id;
    } else {
      this.showPersonDetail = -1;
    }
  }

  openPersonInDetail(person: any) {
    this.router.navigate(['/pages/person-details/view/' + person.personid + '/basic']);

  }

  selectPerson(person: any) {
    this.selectedPerson = person;
    this.relationshipTypeKey = null;
    this.relationshipType = null;
    this.inCustody = false;
    this.livingWith = false;
  }

  addRealtedPerson() {
    if (this.relationshipTypeKey) {
      const relation: PersonRelation = new PersonRelation();
      relation.personid = this.personid;
      relation.personrelativeid = this.selectedPerson?.personid;
      relation.actorrelationshipkey = this.relationshipTypeKey;
      relation.relationcategory = this.relationshipType;
      relation.livingwith = this.livingWith;
      relation.incustody = this.inCustody;
      this.relationshipService.addRelation(relation)
        .subscribe(() => {
          this._alertService.success('Relationship added sucessfully', true);
          this.router.navigate(['../persons'], { relativeTo: this.route });
        }, (_error: any) => {
          this._alertService.error('Relationship not added');
        });
    }
  }
}
