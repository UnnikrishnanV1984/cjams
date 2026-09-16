import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { IntakeAttachmentsGenerateComponent } from './intake-attachments-generate.component';

describe('IntakeAttachmentsGenerateComponent', () => {
  let component: IntakeAttachmentsGenerateComponent;
  let fixture: ComponentFixture<IntakeAttachmentsGenerateComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ IntakeAttachmentsGenerateComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IntakeAttachmentsGenerateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
