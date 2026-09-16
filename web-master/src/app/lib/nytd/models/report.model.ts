import {Person} from './person.model';

export interface Report {
    period: string;
    people?: Person[];
}
