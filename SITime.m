//
//  SITime.m
//  Survey
//
//  Created by Jacob Balthazor on 3/3/13.
//  Copyright (c) 2013 Jacob Balthazor. All rights reserved.
//

#import "SITime.h"

@implementation SITime

- (id)initWithFrame:(CGRect)frame
{
    height = 325;
    frame.size.height = height;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSBundle mainBundle] loadNibNamed:@"SITimeView" owner:self options:nil];
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




-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *out;
    if (row < 10) {
        out = [NSString stringWithFormat:@"0%d",row];
    }
    else{
        out = [NSString stringWithFormat:@"%d",row];
    }
    return out;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    int out;
    switch (component) {
        case 0:
            out = 24;
            break;
        case 1:
            out = 60;
            break;
            
        default:
            break;
    }
    return out;
}

-(NSString *)GetResult{
    
    return [NSString stringWithFormat:@"%d:%d",[picker selectedRowInComponent:0],[picker selectedRowInComponent:1]];
    
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
