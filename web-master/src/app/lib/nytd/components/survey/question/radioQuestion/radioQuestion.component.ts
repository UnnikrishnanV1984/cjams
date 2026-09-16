import {Component, Input, OnChanges, SimpleChanges} from '@angular/core';
import {QuestionComponent} from '../question.component';

@Component({
    selector: 'radio-question',
    templateUrl: './radioQuestion.component.html',
    standalone: false
})
export class RadioQuestionComponent extends QuestionComponent implements OnChanges {

	@Input() declare value: string;
	
	ngOnChanges(changes: SimpleChanges) {
		super.ngOnChanges(changes);
	}
}