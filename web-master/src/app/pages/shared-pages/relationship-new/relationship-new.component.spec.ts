import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { RelationshipNewComponent } from './relationship-new.component';

describe('RelationshipNewComponent', () => {
  let component: RelationshipNewComponent;
  let fixture: ComponentFixture<RelationshipNewComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ RelationshipNewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RelationshipNewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
