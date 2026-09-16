import { Component, OnInit } from '@angular/core';
import { ServiceCasePlacementsService } from '../service-case-placements.service';

@Component({
    selector: 'selected-child-list',
    templateUrl: './selected-child-list.component.html',
    standalone: false
})
export class SelectedChildListComponent implements OnInit {

  selectedChildren: any[] = [];
  constructor(private _service: ServiceCasePlacementsService) { }

  ngOnInit() {
    this.selectedChildren = this._service.selectedChildren;
  }

}
