import { Component, OnDestroy } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FindIndividualService } from './find-individual.service';

@Component({
    selector: 'find-individual',
    templateUrl: './find-individual.component.html',
    styleUrls: ['./find-individual.component.scss'],
    standalone: false
})
export class FindIndividualComponent implements OnDestroy {
  

  constructor(private _router: Router, private route: ActivatedRoute,
    private _service: FindIndividualService) { }
  goBack() {
    this._router.navigate(['../'], { relativeTo: this.route });
    this._service.resetSearchCriteria();
  }

  ngOnDestroy(): void {
    this._service.searchCriteria = null;
  }

}
