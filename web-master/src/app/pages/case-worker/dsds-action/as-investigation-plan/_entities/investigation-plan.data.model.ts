import { initializeObject } from "../../../../../@core/common/initializer";

export class AllegationItem {
    allegationname: string;
    allegationid: string;
    indicators: Indicator[];
    constructor(initializer?: AllegationItem) {
        initializeObject(this, initializer);
    }
}
export class Indicator {
    indicatorid: string;
    indicatorname: string;
    selected?: boolean;
}
export class ChoosenAllegation {
    allegationID: string;
    allegationValue: string;
    indicators: Indicator[];
}