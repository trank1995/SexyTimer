//
//  ViewController.h
//  Timer
//
//  Created by keyess on 7/18/13.
//  Copyright (c) 2013 keyess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
{
    bool isRunning;
    NSTimeInterval startTime;
}

- (IBAction)onStartButton:(UIButton *)sender;
- (IBAction)onActionButton:(UIButton *)sender;
- (IBAction)onIntroButton:(UIButton *)sender;
- (IBAction)onMountButton:(UIButton *)sender;
- (IBAction)onEvacButton:(UIButton *)sender;

- (IBAction)exportData:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableOfEventTimes;
@property (strong, nonatomic) IBOutlet UITextField *editTextField;





@end
