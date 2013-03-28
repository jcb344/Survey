//
//  SurveyItem.m
//  Survey
//
//  Created by Jacob Balthazor on 3/3/13.
//  Copyright (c) 2013 Jacob Balthazor. All rights reserved.
//

#import "SurveyItem.h"

@implementation SurveyItem

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        //frame.size.height = 1;
        //[[NSBundle mainBundle] loadNibNamed:@"surveyView" owner:self options:nil];
        //[self addSubview:view];
        
        
    }
    return self;
}

-(void)setDeligate:(id)dg{
    deligate = dg;
}

-(void)setPrompt:(NSString*)text{
    [prompT setText:text];
}
-(NSString*)getPrompt{
    return [prompT text];
}

-(NSString*)GetResult{
    return @"";
}

-(int)getHeight{
    return height;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [deligate keyboardUpp:self];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [deligate keyboardUpp:self];
    return 1;
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
