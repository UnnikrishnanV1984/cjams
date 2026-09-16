import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { MobilitySpeechCwComponent } from './mobility-speech-cw.component';

describe('MobilitySpeechCwComponent', () => {
  let component: MobilitySpeechCwComponent;
  let fixture: ComponentFixture<MobilitySpeechCwComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ MobilitySpeechCwComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(MobilitySpeechCwComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
