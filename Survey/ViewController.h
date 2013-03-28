//
//  ViewController.h
//  Survey
//
//  Created by Jacob Balthazor on 3/3/13.
//  Copyright (c) 2013 Jacob Balthazor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SurveyItem.h"
#import "SINumberQuestion.h"
#import "SIShortAnswer.h"
#import "SITime.h"
#import "SIMultipleChoice.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "GAZZCloud.h"

@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate>{
    IBOutlet UIView *setupView;
    IBOutlet UIScrollView *scroll;
    IBOutlet UIButton *sendButton;
    IBOutlet UITextView *DirectionsView;
    IBOutlet UIButton *keyboardUppButton;
    
    IBOutlet UIButton *unlockButton1;
    IBOutlet UIButton *unlockButton2;

    BOOL button1State;
    BOOL button2State;
    
    IBOutlet UITextField *studyField;
    IBOutlet UITextField *subjectField;
    NSString *surveyID;
    
    NSDictionary *surveyFile;
    NSMutableArray *questions;
    id upkeyboardSender;
    
    NSMutableArray *savedAnswers;
    
    GAZZCloud *cloud;
}

-(void)setPrompts;
-(void)keyboardUpp:(id)sender;

-(IBAction)done:(id)sender;
-(IBAction)submitAction:(id)sender;

-(IBAction)unlockButtonPressedDown:(id)sender;
-(IBAction)unlockButtonPressedUp:(id)sender;
-(IBAction)saveIDsPressed:(id)sender;

-(NSString*)dataFilePath;
-(void)loadFromFile;
-(void)saveFile;
-(IBAction)clearSavedData;

@end
