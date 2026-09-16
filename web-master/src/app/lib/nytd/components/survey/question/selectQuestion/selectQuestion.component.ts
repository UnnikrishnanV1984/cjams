import {Component, Input, OnChanges, SimpleChanges} from '@angular/core';
import {QuestionComponent} from '../question.component';

@Component({
    selector: 'select-question',
    templateUrl: './selectQuestion.component.html',
    standalone: false
})
export class SelectQuestionComponent extends QuestionComponent implements OnChanges {
	
    @Input() value:string='';
	@Input() name:string='';
	@Input() declare question:any;

	ngOnChanges(changes: SimpleChanges) {
		super.ngOnChanges(changes);
	}
}