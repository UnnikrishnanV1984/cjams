import {EventEmitter, Injectable, Input, OnChanges, Output, SimpleChanges} from '@angular/core';

@Injectable()
export abstract class QuestionComponent implements OnChanges {

    @Input() question?: any

    @Input() name: string='';

    @Input() value: string='';

    @Output() didChange = new EventEmitter<any>();

    choices: any[]=[];

    ngOnChanges(changes: SimpleChanges) {

        let choices :any[]= [];
        if (this.question && this.question?.choices) {
            choices = Object.keys(this.question?.choices)?.map(key => {
                return { key, label: this.question?.choices[key]}
            });
        }
        this.choices = choices;
    }

    onChange($event :any) {
        this.didChange.emit({
            id: this.question.id,
            value: $event.value
        });
    }
}

