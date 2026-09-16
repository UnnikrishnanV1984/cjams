import { Component, Input } from '@angular/core';

@Component({
    selector: 'placement-address-info',
    templateUrl: './placement-address-info.component.html',
    standalone: false
})
export class PlacementAddressInfoComponent {

  @Input() placement: any;
}
