//
//  SIMultipleChoice.m
//  Survey
//
//  Created by Jacob Balthazor on 3/3/13.
//  Copyright (c) 2013 Jacob Balthazor. All rights reserved.
//

#import "SIMultipleChoice.h"

@implementation SIMultipleChoice

- (id)initWithFrame:(CGRect)frame
{
    height = 325;
    frame.size.height = height;
    NSLog(@"width = %f",frame.size.width);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSBundle mainBundle] loadNibNamed:@"SIMultipleChioceView" owner:self options:nil];
        [self addSubview:view];
        
        /*
        CGRect f = [prompT frame];
        f.size.width = frame.size.width;
        [prompT setFrame:f];
        
         f = [picker frame];
        f.size.width = frame.size.width;
        [picker setFrame:f];
         */
        
        CGRect f = [view frame];
        f.size.width = frame.size.width;
        [view setFrame:f];
    }
    return self;
}



-(void)setChoices:(NSArray*)a{
    choiceArray = a;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [choiceArray objectAtIndex:row];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [choiceArray count];
}

-(NSString *)GetResult{
    
    return [choiceArray objectAtIndex:[picker selectedRowInComponent:0]];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
