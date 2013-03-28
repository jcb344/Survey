//
//  ViewController.m
//  Survey
//
//  Created by Jacob Balthazor on 3/3/13.
//  Copyright (c) 2013 Jacob Balthazor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(IBAction)saveIDsPressed:(id)sender{
    [setupView setHidden:YES];
    [subjectField resignFirstResponder];
    [studyField resignFirstResponder];
    [self saveFile];
}

-(IBAction)unlockButtonPressedDown:(id)sender{
    if (sender == unlockButton1) {
        button1State = YES;
    }
    if (sender == unlockButton2) {
        button2State = YES;
    }
    if (button2State == YES && button1State == YES) {
        [setupView setHidden:NO];
        [self loadFromFile];
    }
}

-(IBAction)unlockButtonPressedUp:(id)sender{
    if (sender == unlockButton1) {
        button1State = NO;
    }
    if (sender == unlockButton2) {
        button2State = NO;
    }
}

-(IBAction)submitAction:(id)sender{
    [self loadFromFile];
    if (cloud == Nil) {
        cloud = [[GAZZCloud alloc] init];
    }
    NSMutableArray *data = [NSMutableArray array];
    NSDate *date = [[NSDate alloc] init];
    double t = [date timeIntervalSince1970];
    [date release];
    int tt = t;
    NSNumber *timeStamp = [NSNumber numberWithDouble:t];
    for (int i = 0; i<[questions count]; i++) {
        NSDictionary *record = [NSDictionary dictionaryWithObjectsAndKeys:[[questions objectAtIndex:i] getPrompt],@"prompt",[[questions objectAtIndex:i] GetResult],@"answer",timeStamp,@"timeStamp",surveyID,@"surveyID", nil];
        [data addObject:record];
        NSLog(@"%f %f",t,[[record objectForKey:@"timeStamp"] floatValue]);
    }
    [timeStamp release];
    timeStamp = nil;
    if (savedAnswers == nil) {
        savedAnswers = data;
    }
    else{
        [savedAnswers addObjectsFromArray:data];
    }
    [self saveFile];
    
    [cloud setStudyID:[studyField text] ];
    [cloud setSubjectID:[subjectField text]];
    [cloud postJSONOf:savedAnswers toAdress:@"http://cerebrum.ucsf.edu/datapost"];

    
    /* old email way
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"Survey Data"];
        if (toAdress != Nil) {
            [mailViewController setToRecipients:[NSArray arrayWithObject:toAdress]];
        }
        
        
        NSString *messageString = @"\n\n\n";
        for (int i = 0; i<[questions count]; i++) {
            messageString = [messageString stringByAppendingFormat:@"%d,%@,%@\n",i,[[questions objectAtIndex:i] getPrompt],[[questions objectAtIndex:i] GetResult]];
        }
        [mailViewController setMessageBody:messageString  isHTML:NO];
        [self presentModalViewController:mailViewController animated:YES];
        [mailViewController release];
    }
     */
    
}

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    
    [self dismissModalViewControllerAnimated:YES];
    if (result == MFMailComposeResultSent) {
        //[checkThree setHidden:NO];
        exit(0);
    }
    
}

-(void)keyboardUpp:(id)sender;{
    upkeyboardSender = sender;
    [keyboardUppButton setHidden:NO];    
}

-(IBAction)done:(id)sender{
    [upkeyboardSender dissmissKeyboard];
    [keyboardUppButton setHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadFromFile];
    
    [unlockButton2 setFrame:CGRectMake(self.view.frame.size.width-unlockButton2.frame.size.width, 0, unlockButton2.frame.size.width, unlockButton2.frame.size.height)];
    [setupView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [keyboardUppButton setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [sendButton setFrame:CGRectMake(self.view.frame.size.width/2 -sendButton.frame.size.width/2, 0, sendButton.frame.size.width, sendButton.frame.size.height)];
	
    [scroll setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    questions = [[NSMutableArray alloc] init];
    surveyFile = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SurveyQuestions" ofType:@"plist"]];
    
    [DirectionsView setText:[surveyFile objectForKey:@"DirectionsPromt"]];
    
    surveyID = [surveyFile objectForKey:@"surveyID"];
    
    int spacing = 20;
    int offset = DirectionsView.frame.size.height + spacing;
    
    for ( int i = 0; i<[[surveyFile objectForKey:@"Questions"] count]; i++) {
        
        UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(10, offset, self.view.frame.size.width-10, spacing)];
        [num setText:[NSString stringWithFormat:@"%d.",i+1]];
        [scroll addSubview:num];
        offset += spacing;
        
        if ([ [[[surveyFile objectForKey:@"Questions"] objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"time"] ) {
            SITime *sit = [[SITime alloc] initWithFrame:CGRectMake(0, offset, self.view.frame.size.width, 0)];
            [scroll addSubview:sit];
            [sit setPrompt:[[[surveyFile objectForKey:@"Questions"] objectAtIndex:i] objectForKey:@"prompt"]];
            [questions addObject:sit];
            offset += [sit getHeight];
            [sit setDeligate:self];
        }
        else if ([ [[[surveyFile objectForKey:@"Questions"] objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"shortAnswer"] ) {
            SIShortAnswer *sisa = [[SIShortAnswer alloc] initWithFrame:CGRectMake(0, offset, self.view.frame.size.width, 0)];
            [sisa setPrompt:[[[surveyFile objectForKey:@"Questions"] objectAtIndex:i] objectForKey:@"prompt"]];
            [scroll addSubview:sisa];
            [questions addObject:sisa];
            offset += [sisa getHeight];
            [sisa setDeligate:self];
        }
        else if ([ [[[surveyFile objectForKey:@"Questions"] objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"numberAnswer"] ) {
            SINumberQuestion *sin = [[SINumberQuestion alloc] initWithFrame:CGRectMake(0, offset, self.view.frame.size.width, 0)];
            [sin setPrompt:[[[surveyFile objectForKey:@"Questions"] objectAtIndex:i] objectForKey:@"prompt"]];
            [scroll addSubview:sin];
            [questions addObject:sin];
            offset += [sin getHeight];
            [sin setDeligate:self];
        }
        else if ([ [[[surveyFile objectForKey:@"Questions"] objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"multipleAnswer"] ) {
            SIMultipleChoice *simc = [[SIMultipleChoice alloc] initWithFrame:CGRectMake(0, offset, self.view.frame.size.width, 0)];
            [simc setPrompt:[[[surveyFile objectForKey:@"Questions"] objectAtIndex:i] objectForKey:@"prompt"]];
            [simc setChoices:[[[surveyFile objectForKey:@"Questions"] objectAtIndex:i] objectForKey:@"choices"]];
            [scroll addSubview:simc];
            [questions addObject:simc];
            offset += [simc getHeight];
            [simc setDeligate:self];
        }
        
    }
    
    offset += 20;
    [sendButton setFrame:CGRectMake(sendButton.frame.origin.x, offset, 75, 45)];
    offset += 75+20;
    
    /*
    SIMultipleChoice *si = [[SIMultipleChoice alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    [si setChoices:[NSArray arrayWithObjects:@"first",@"Second",@"third", nil]];
    [scroll addSubview:si];
    
    */
    [scroll setContentSize:CGSizeMake(self.view.frame.size.width, offset)];
}

-(void)clearSavedData{
    [savedAnswers removeAllObjects];
    [self saveFile];
}

-(void)saveFile{
    NSLog(@"Saving");
    NSMutableDictionary *file = [[NSMutableDictionary alloc] init];
    
    [file setObject:[subjectField text] forKey:@"subjectID"];
    [file setObject:[studyField text] forKey:@"studyID"];
    [file setObject:savedAnswers forKey:@"data"];
    
    
    [file writeToFile:[self dataFilePath] atomically:NO];
    [file release];
}

-(void)loadFromFile{
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSLog(@"Loading saved file");
        NSMutableDictionary *file = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        [subjectField setText:[file objectForKey:@"subjectID"]];
        [studyField setText:[file objectForKey:@"studyID"]];
        savedAnswers = [file objectForKey:@"data"];
        [savedAnswers retain];
        [file release];
    }
}

-(NSString*)dataFilePath
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    NSString *pathFin = [documentDirectory stringByAppendingPathComponent:@"board"];
    return pathFin;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
