//
//  SIShortAnswer.m
//  Survey
//
//  Created by Jacob Balthazor on 3/3/13.
//  Copyright (c) 2013 Jacob Balthazor. All rights reserved.
//

#import "SIShortAnswer.h"

@implementation SIShortAnswer

- (id)initWithFrame:(CGRect)frame
{
    height = 215;
    frame.size.height = height;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSBundle mainBundle] loadNibNamed:@"SIShortAnswerView" owner:self options:nil];
        [self addSubview:view];
        
        /*
        CGRect f = [prompT frame];
        f.size.width = frame.size.width;
        [prompT setFrame:f];
        
        f = [textAnswer frame];
        f.size.width = frame.size.width-45*2;
        [textAnswer setFrame:f];
        */
        
        CGRect f = [view frame];
        f.size.width = frame.size.width;
        [view setFrame:f];
    }
    return self;
}

-(NSString *)GetResult{
    return [textAnswer text];
}

-(void)dissmissKeyboard{
    [textAnswer resignFirstResponder];
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
