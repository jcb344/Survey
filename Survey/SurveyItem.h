//
//  SurveyItem.h
//  Survey
//
//  Created by Jacob Balthazor on 3/3/13.
//  Copyright (c) 2013 Jacob Balthazor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SurveyItem : UIView <UITextFieldDelegate,UITextViewDelegate>{
    IBOutlet UIView *view;
    IBOutlet UITextView *prompT;
    int height;
    id deligate;
}

-(NSString*)GetResult;
-(void)setPrompt:(NSString*)text;
-(NSString*)getPrompt;
-(int)getHeight;
-(void)setDeligate:(id)dg;
-(void)dissmissKeyboard;

@end
