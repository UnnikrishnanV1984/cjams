import { Injectable, NgZone } from '@angular/core';
import { Observable } from 'rxjs';
import _ from 'lodash';

interface IWindow extends Window {
    webkitSpeechRecognition: any;
    SpeechRecognition: any;
}

@Injectable({ providedIn: 'root' })
export class SpeechRecognitionService {
    speechRecognition: any;

    constructor(private zone: NgZone) {
    }

    record(): Observable<string> {

      return new Observable(observer => {
            try {
                const { webkitSpeechRecognition } = window as any;
            this.speechRecognition = new webkitSpeechRecognition();
            this.speechRecognition.continuous = true;
            this.speechRecognition.lang = 'en-us';
            this.speechRecognition.maxAlternatives = 1;

            this.speechRecognition.onresult = (speech: any) => {
                let term = '';
                if (speech.results) {
                    const result = speech.results[speech.resultIndex];
                    const transcript = result[0].transcript;
                    if (result.isFinal) {
                        if (result[0].confidence < 0.3) {
                            // No operation needed here
                        } else {
                            term = _.trim(transcript);
                        }
                    }
                }
                this.zone.run(() => {
                    observer.next(term);
                });
            };

            this.speechRecognition.onerror = (error: any) => {
                observer.error(error);
            };

            this.speechRecognition.onend = () => {
                observer.complete();
            };

            this.speechRecognition.start();
            } catch (error) {
            }
        });
    }

    destroySpeechObject() {
        if (this.speechRecognition) {
            this.speechRecognition.stop();
        }
    }

}