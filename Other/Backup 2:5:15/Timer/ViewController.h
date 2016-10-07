//
//  ViewController.h
//  Timer
//
//  Created by keyess on 7/18/13.
//  Copyright (c) 2013 keyess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleInfo.h"

@interface ViewController : UIViewController <UITextFieldDelegate>
{
    bool isRunning;
    NSTimeInterval startTime;
    NSTimeInterval pausedTimeAt;
    NSTimeInterval timePausedFor;
    NSString *titleInfoFromPrevScene;
}

- (IBAction)onStartButton:(UIButton *)sender;
- (IBAction)onActionButton:(UIButton *)sender;
- (IBAction)onIntroButton:(UIButton *)sender;
- (IBAction)onMountButton:(UIButton *)sender;
- (IBAction)onEvacButton:(UIButton *)sender;
- (IBAction)exportData:(UIButton *)sender;

-(void)setTitleName:(NSString*)expName :(NSString*)yourName :(NSString*)femNumber :(NSString*)studNumber :(NSString*)notes;


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableOfEventTimes;
@property (strong, nonatomic) IBOutlet UITextField *editTextField;
@property (weak, nonatomic) IBOutlet UILabel *expTitle;


// Setting up individual lists 
@property (weak, nonatomic) IBOutlet UILabel *inTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mountLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *ejacLabel;
@property (weak, nonatomic) IBOutlet UILabel *hopLabel;
@property (weak, nonatomic) IBOutlet UILabel *earsLabel;
@property (weak, nonatomic) IBOutlet UILabel *kicksLabel;




@end
