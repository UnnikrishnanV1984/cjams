import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { InvolvedPersonsComponent } from './involved-persons.component';

describe('InvolvedPersonsComponent', () => {
  let component: InvolvedPersonsComponent;
  let fixture: ComponentFixture<InvolvedPersonsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ InvolvedPersonsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(InvolvedPersonsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
