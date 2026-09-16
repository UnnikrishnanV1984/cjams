import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdoptionNarrativeComponent } from './adoption-narrative.component';

describe('AdoptionNarrativeComponent', () => {
  let component: AdoptionNarrativeComponent;
  let fixture: ComponentFixture<AdoptionNarrativeComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdoptionNarrativeComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdoptionNarrativeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
