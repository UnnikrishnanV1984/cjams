import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { EdlreviewresultConfig } from '../../_entities/reviewda.data.models';
import { GenericService } from '../../../../../@core/services';
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'add-edit-edl-review-results',
    templateUrl: './add-edit-edl-review-results.component.html',
    standalone: false
})
export class AddEditEdlReviewResultsComponent implements OnInit {
  id = '0';
  isEditMode = false;
  edlReviewResult: EdlreviewresultConfig = new EdlreviewresultConfig();


  constructor(private route: ActivatedRoute,
    private _service: GenericService<EdlreviewresultConfig>) { }

  ngOnInit() {
    this.edlReviewResult.deficiency = false;
  }

  save(modelData: EdlreviewresultConfig) {
    modelData.reviewtypekey = 'EDL';
    modelData.activeflag = 1;
    modelData.updatedby = 'admin';
    modelData.insertedby = 'admin';
    modelData.effectivedate = new Date();
    this._service.create(modelData).subscribe((response: any) => {
        if (response.reviewtypekey) {
      this._service.getArrayList({});
    }
});
}

  private showEditor() {
    (<any>$('#add-edit-edl-review-results')).modal('show'); // NOSONAR
  }

}
