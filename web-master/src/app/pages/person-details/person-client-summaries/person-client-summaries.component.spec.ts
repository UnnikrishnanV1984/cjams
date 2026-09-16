import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonClientSummariesComponent } from './person-client-summaries.component';

describe('PersonClientSummariesComponent', () => {
  let component: PersonClientSummariesComponent;
  let fixture: ComponentFixture<PersonClientSummariesComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonClientSummariesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonClientSummariesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
