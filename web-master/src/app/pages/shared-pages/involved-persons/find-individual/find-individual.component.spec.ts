import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FindIndividualComponent } from './find-individual.component';

describe('FindIndividualComponent', () => {
  let component: FindIndividualComponent;
  let fixture: ComponentFixture<FindIndividualComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FindIndividualComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FindIndividualComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
