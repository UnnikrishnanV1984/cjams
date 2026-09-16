import { Component, Input, OnInit } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';

import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { GenericService } from '../../../../@core/services/generic.service';
import { Person, PersonSearchEntity } from '../../_entities/find-entity.module';
import { FindUrlConfig } from '../../find.url.config';
import { DataStoreService } from '../../../../@core/services';

@Component({
    selector: 'app-person-search-result',
    templateUrl: './person-search-result.component.html',
    styleUrls: ['./person-search-result.component.scss'],
    standalone: false
})
export class PersonSearchResultComponent implements OnInit {

  @Input() showTable: boolean;
  @Input()
  pageNumberSubject$!: Subject<number>;
  @Input()
  personList$!: Observable<Person[]>;
  @Input()
  totalRecords$!: Observable<number>;
  isAuthorized :any; //for fortify issues 
  selectedPerson!: string;
  personSearchResult: any;
  personSearchResult$!: Observable<Person[]>;
  personSearchCriteria: PersonSearchEntity;

  paginationInfo: PaginationInfo = new PaginationInfo();
  private pageSubject$ = new Subject<number>();

  constructor(private _service: GenericService<Person>,private _datastoreService: DataStoreService) {
    this.showTable = false;
    this._service.endpointUrl = FindUrlConfig.EndPoint.PersonSearch.globalpersonsearches;
    this.personSearchCriteria = new PersonSearchEntity();
    this.personSearchCriteria.sortdir = 'asc';
    this.personSearchCriteria.sortcol = 'lastname';
    this.personSearchCriteria.personflag = 'T';
    this.personSearchCriteria.activeflag = '1';
  }

  ngOnInit() {
    this.isAuthorized= this._datastoreService.isAuthorized(); //for fortify issues 
    this.pageSubject$.subscribe(pageNumber => {
      this.paginationInfo.pageNumber = pageNumber;
    });

  }

  pageChanged(page: number) {
    this.pageNumberSubject$.next(page);
  }

  selectPerson(id: string) {
    this.selectedPerson = id;
  }

  

  public calculateAge(birthdate: any): number | undefined {
         if ( birthdate ) {
            const timeDiff = Math.abs(Date.now() - Date.parse(birthdate));
            return  Math.floor((timeDiff / (1000 * 3600 * 24)) / 365);
        }
    }

}
