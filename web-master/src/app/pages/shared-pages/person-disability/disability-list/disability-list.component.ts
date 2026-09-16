import { Component, OnInit } from '@angular/core';
import { PersonDisabilityService } from '../person-disability.service';
import { Router, ActivatedRoute } from '@angular/router';

@Component({
    selector: 'disability-list',
    templateUrl: './disability-list.component.html',
    styleUrls: ['./disability-list.component.scss'],
    standalone: false
})
export class DisabilityListComponent implements OnInit {

  person: any;
  personDisabilities: any[] = [];
  constructor(
    private _service: PersonDisabilityService,
    private _router: Router,
    private route: ActivatedRoute,
  ) { }

  ngOnInit() {
    (<any>$('#disability-list')).modal('show');
    this.person = this._service.person;
    this.loadDisabilityList();
  }

  loadDisabilityList() {
    this._service.getDisabilityList(this._service.person.personid).subscribe(response => {
      if (response && Array.isArray(response)) {
        this.personDisabilities = response;
      }
    });
  }

  close() {
    (<any>$('#disability-list')).modal('hide');
    this._router.navigate(['../../../'], { relativeTo: this.route });
  }

}
