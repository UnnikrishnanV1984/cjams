import { Component, OnInit } from '@angular/core';
import { ExitPlacementService } from '../exit-placements/exit-placement.service';
import { FormGroup } from '@angular/forms';
import { ServiceCasePlacementsService } from '../service-case-placements.service';

@Component({
    selector: 'void-placement-form',
    templateUrl: './void-placement-form.component.html',
    standalone: false
})
export class VoidPlacementFormComponent implements OnInit {

  voidPlacementReasonTypes: any[] = [];
  voidPlacementForm!: FormGroup;
  children: any[] = [];
  constructor(private _placementservice: ServiceCasePlacementsService,
    private _service: ExitPlacementService) { }

  ngOnInit() {
    this.children = this._placementservice.placementDetails;
    this.voidPlacementForm = this._service.getVoidPlacementFormInstance();

    if(this.children[0].placement.placementrevision != null){
      this.voidPlacementForm.patchValue({
        leastrestrictiveplacement:this.children[0].placement.placementrevision[0].leastrestrictiveplacement
      });
    }
    this._service.getVoidReasonTypes().subscribe(response => {
      if (response && response.length) {
        this.voidPlacementReasonTypes = response;
      }

    });
  }

  onChange(): void {
      let value: any = $('#voidremarks').val();
      if(value.length > 1000) {
        $('#voidremarks').val(value.substring(0, 1000));
      }
  }

}
