//
//  TitleCardViewController.m
//  Timer
//
//  Created by Greg Fournier on 9/3/13.
//  Copyright (c) 2013 keyess. All rights reserved.
//

#import "TitleCardViewController.h"
#import "ViewController.h"

@interface TitleCardViewController ()

@end

@implementation TitleCardViewController
@synthesize expName, yourName, femNumber, studNumber, notes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Pass the title info to the the next scene
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"MoveToExperiment"]){
        NSLog(@"Passing Info");
        // Create a controller object and set its title property
        ViewController *myViewController = [segue destinationViewController];
        [myViewController setTitleName:expName.text :yourName.text :femNumber.text :studNumber.text :notes.text];
        
    }
}

- (BOOL)prefersStatusBarHidden {return YES;}

@end
