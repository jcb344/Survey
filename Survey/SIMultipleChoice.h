//
//  SIMultipleChoice.h
//  Survey
//
//  Created by Jacob Balthazor on 3/3/13.
//  Copyright (c) 2013 Jacob Balthazor. All rights reserved.
//

#import "SurveyItem.h"

@interface SIMultipleChoice : SurveyItem <UIPickerViewDataSource,UIPickerViewDelegate>{
    IBOutlet UIPickerView *picker;
    NSArray *choiceArray;
}

-(void)setChoices:(NSArray*)a;

@end
