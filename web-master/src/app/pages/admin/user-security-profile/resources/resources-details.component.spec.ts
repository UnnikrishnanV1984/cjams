import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ResourcesDetailsComponent } from './resources-details.component';

describe('ResourcesDetailsComponent', () => {
  let component: ResourcesDetailsComponent;
  let fixture: ComponentFixture<ResourcesDetailsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ResourcesDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ResourcesDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
