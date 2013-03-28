//
//  SITime.h
//  Survey
//
//  Created by Jacob Balthazor on 3/3/13.
//  Copyright (c) 2013 Jacob Balthazor. All rights reserved.
//

#import "SurveyItem.h"

@interface SITime : SurveyItem <UIPickerViewDataSource,UIPickerViewDelegate>{
    IBOutlet UIPickerView *picker;
}

@end
