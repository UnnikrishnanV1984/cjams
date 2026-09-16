import { Component, Input, OnInit } from '@angular/core';
import { Subject } from 'rxjs';

import { EntitiesSearchEntity } from '../../_entities/find-entity.module';

declare let $: any;
@Component({
    selector: 'entities-view',
    templateUrl: './entities-view.component.html',
    styleUrls: ['./entities-view.component.scss'],
    standalone: false
})
export class EntitiesViewComponent implements OnInit {

  @Input() entity!: Subject<EntitiesSearchEntity>;
  entityData: EntitiesSearchEntity;

  constructor() {
    this.entityData = new EntitiesSearchEntity();
  }

  ngOnInit() {
    this.entity.subscribe(data => {
      this.entityData = data;
      this.showEntityViewModel();
    });
  }

  showEntityViewModel() {
    $('#modal-view-entities').modal('show');
  }

}
