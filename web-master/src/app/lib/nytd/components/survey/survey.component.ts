import {Component, EventEmitter, Input, OnChanges, Output, SimpleChanges} from '@angular/core';

@Component({
    selector: 'nytd-survey',
    templateUrl: './survey.component.html',
    standalone: false
})
export class SurveyComponent implements OnChanges {

    @Input() data: any;

    @Output() didClickSave = new EventEmitter<any>();

    answers: {[key:string]:any}={}

    prefix = 'question_';

    survey: any;
    startDate?:Date;
    picker?: Date;

    onClickSave($event:any) {
        // Remove prefix
        const answers = Object.keys(this.answers).reduce((acc:any, key:any) => {
            acc[key.substring(this.prefix.length)] = this.answers[key];
            return acc;
        }, {});

        this.didClickSave.emit(answers);
    }

    ngOnChanges(changes: SimpleChanges) {
        if (this.data) {
            // morph for usage
            this.survey = this.transformToSurvey(this.data);
            // extract to set form
            this.answers = this.extractAnswers(this.data);
        }
    }

    extractAnswers(data:any) {
        return data.filter((q:any) => q.id > 33).reduce((acc:any, question:any) => {
            acc[this.prefix + question.id] = question.value;
            return acc;
        }, {});
    }

    transformToSurvey(data:any) {

        const survey = {
            validated: false,
            participation: {},
            questions: []
        };

        if (data) {
            survey.participation = data.find((e:any) => e.id == 34);
            survey.questions = data.filter((e:any) => e.id > 36);
        }

        return survey;
    }

    didChangeParticipation($event:any) {
        this.updateAnswer({
            id: 34,
            value: $event.value
        });
    }

    didChangeDate($event:any) {
        this.updateAnswer({
            id: 35,
            value: $event.value
        });
    }

    didChangeStatus($event:any) {
        this.updateAnswer({
            id: 36,
            value: $event.checked
        });
    }

    updateAnswer($event:any) {
        const value = $event.value;
        const element = this.prefix + $event.id;

        this.answers[element] = value; // NOSONAR
    }
}
