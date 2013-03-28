//
//  SINumberQuestion.m
//  Survey
//
//  Created by Jacob Balthazor on 3/3/13.
//  Copyright (c) 2013 Jacob Balthazor. All rights reserved.
//

#import "SINumberQuestion.h"

@implementation SINumberQuestion

- (id)initWithFrame:(CGRect)frame
{
    height = 145;
    frame.size.height = height;
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSBundle mainBundle] loadNibNamed:@"SINumberQuestionView" owner:self options:nil];
        [self addSubview:view];
        /*
        CGRect f = [prompT frame];
        f.size.width = frame.size.width;
        [prompT setFrame:f];
        
        f = [numberField frame];
        f.size.width = frame.size.width-45*2;
        [numberField setFrame:f];
        */
        CGRect f = [view frame];
        f.size.width = frame.size.width;
        [view setFrame:f];
    }
    return self;
}

-(NSNumber *)GetResult{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *n = [f numberFromString:[numberField text]];
    if (n == nil) {
        n = [NSNumber numberWithInt:0];
    }
    return n ;
    
}

-(void)dissmissKeyboard{
    [numberField resignFirstResponder];
}

@end
