import { Component, OnInit } from '@angular/core';
import { CommonHttpService, DataStoreService, AuthService } from '../../../../@core/services';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { ActivatedRoute } from '@angular/router';
import { CaseWorkerUrlConfig } from 'src/app/pages/case-worker/case-worker-url.config';

@Component({
    selector: 'person-background-check',
    templateUrl: './person-background-check.component.html',
    styleUrls: ['./person-background-check.component.scss'],
    standalone: false
})
export class PersonBackgroundCheckComponent implements OnInit {
  id: string;
  objectID: string;
  persons = [];
  selectedPerson: any;
  selectedPersonId: any;
  constructor(private _commonHttpService: CommonHttpService,
    private route: ActivatedRoute,
    private _dataStoreService: DataStoreService,
    private _authService: AuthService) {
    this.objectID = this.route.parent.parent.snapshot.params['id'];
  }

  ngOnInit() {
    this.getHouseHolds(1, 20).subscribe(response => {
      if (response && response.data && response.data.length) {
        this.persons = response.data;
      }
    })
  }

  getHouseHolds(page: number, limit: number) {
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    
    let url = '';
    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }
    const inputRequest = {
      intakenumber: this.objectID,
      isExpungementSuperUser: isExpungementSuperUser,
      'iscaseexpunged': iscaseexpunged
    };
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: page,
          limit: limit,
          method: 'get',
          where: inputRequest
        }),
        url + '?filter'
      );


  }

  selectPerson(person) {
    this.selectedPerson = null;
    this._dataStoreService.setData('SELECTED_PERSON_ID', person.personid);
    this._dataStoreService.setData('OBJECT_ID', this.objectID);
    this._dataStoreService.setData('ROLE', person.rolename);
    setTimeout(() => {
      this.selectedPerson = person;
    }, 1000);
  }

  close() {
    this.selectedPerson = null;
    this.selectedPersonId = null;
  }
}
