   //
//  ViewController.m
//  Timer
//
//  Created by keyess on 7/18/13.
//  Copyright (c) 2013 keyess. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


// for the UIActivityViewController
@property (strong, nonatomic) UIPopoverController *activityPopover;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareItem;

@property (weak, nonatomic) IBOutlet UIButton *myShareButton;

@end

@implementation ViewController
{
    //An array of all events
    NSMutableArray *eventTimes;
    
    // set up variables
    NSInteger myHopCount;
    
    NSInteger hopCount;
    NSInteger earsCount;
    NSInteger kicksCount;
    NSInteger squeakCount;
    
    //other count variables for Mount, Intro and Ejac
    NSInteger mountCount;
    NSInteger introCount;
    NSInteger ejacCount;
    NSInteger inTimeCount;
    
    // true if the the last action button pressed was "In", false if last action button pressed was "Out"
    bool lastPressWasIn;
    
    NSInteger totalTime;
    
    
    // gets at the currently selected element in eventTimes Array
    NSInteger currentIndex;
    
    // gets the current size of the eventTimesArray
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initialize a few variables/properties, and set the text field delegate as self (the viewcontroller)
    _timeLabel.text = @"0:00";
    isRunning = false;
    eventTimes = [[NSMutableArray alloc] init];
    self.editTextField.delegate = self;
    startTime = [NSDate timeIntervalSinceReferenceDate];
    pausedTimeAt = [NSDate timeIntervalSinceReferenceDate];
    timePausedFor = 0;
    _expTitle.text = titleInfoFromPrevScene;
    
    
    hopCount = 0;
    earsCount = 0;
    kicksCount = 0;
    squeakCount = 0;
    
    // initialize mountCount, introCount and ejacCount to 0
    mountCount = 0;
    introCount = 0;
    ejacCount = 0;
    inTimeCount = 0;
    
    // lastPressWasIn is initialized to false
    lastPressWasIn = NO;
    
    totalTime = 0;
    
    
    // initialize currentIndex to -1 so that no element gets deleted if none is selected
    currentIndex = -1;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setTitleName:(NSString *)expName :(NSString *)yourName :(NSString *)femNumber :(NSString *)studNumber :(NSString *)notes{
    titleInfoFromPrevScene = [NSString stringWithFormat:@"%@%@%@%@%@",expName,yourName,femNumber,studNumber,notes];
    
}

- (IBAction)onStartButton:(UIButton *)sender {
    if (isRunning == false){
        //set a few settings so that the app can begin working with new data (set startTime, reinitialize eventTimes
        isRunning = true;
        [sender setTitle:@"Pause" forState:UIControlStateNormal];
        timePausedFor =timePausedFor + [NSDate timeIntervalSinceReferenceDate] - pausedTimeAt;
        [self updateTime];
    } else {
        //delete nothing, but stop the timer
        [sender setTitle:@"Start" forState:UIControlStateNormal];
        isRunning = false;
        pausedTimeAt = [NSDate timeIntervalSinceReferenceDate];
    }
}

- (IBAction)onActionButton:(UIButton *)sender {
    //If the timer isn't running, don't add anything
    if (isRunning == false) return;
    
    //NSLog(@"This is the action button");
    if ([sender.currentTitle isEqualToString:@"In"]) {
        lastPressWasIn = YES;
        //NSLog(@"We're In");
        
        inTime = [NSDate timeIntervalSinceReferenceDate];
    }
    
    
    
    
    if (([sender.currentTitle isEqualToString:@"Out"]) && lastPressWasIn) {
        //NSLog(@"We're Out");
        //NSLog(@"We were in and now we're out.");
        lastPressWasIn = NO;
        //inTimeCount++;
        
        outTime = [NSDate timeIntervalSinceReferenceDate];
        elapsedTime = outTime - inTime;
        NSInteger intElapsedTime = elapsedTime;
        totalTime = totalTime + intElapsedTime;
        NSString *stringTotalTime = [NSString stringWithFormat:@"In Time: %ld seconds", (long)totalTime];
        
        _inTimeLabel.text = stringTotalTime;
    }
    

    //Construct the string to be added
    NSString *nowEventText = [NSString stringWithFormat:@"%@,%@, %li", _timeLabel.text,sender.currentTitle, (long)mountCount];
    
    [eventTimes addObject:nowEventText];
    [_tableOfEventTimes reloadData];
}

- (IBAction)onIntroButton:(UIButton *)sender {
    if (isRunning == false) return;
    
    // increment introCount
    introCount++;
    NSLog(@"%li",(long) introCount);
    
    
    // update the introLabel label
    _introLabel.text = [NSString stringWithFormat:@"Intro: %li",(long) introCount];
    
    NSString *nowEventText = [NSString stringWithFormat:@"%@,Intro,%@, %li", _timeLabel.text,sender.currentTitle, (long)mountCount];
    
    [eventTimes addObject:nowEventText];
    [_tableOfEventTimes reloadData];
}

- (IBAction)onMountButton:(UIButton *)sender {
    if (isRunning == false) return;
    
    // increment mountCount
    mountCount++;
    NSLog(@"%li",(long) mountCount);
    
    // update the mountLabel label
    _mountLabel.text = [NSString stringWithFormat:@"Mount: %li",(long) mountCount];
    
    
    NSString *nowEventText = [NSString stringWithFormat:@"%@,Mount,%@,", _timeLabel.text,sender.currentTitle];
    [eventTimes addObject:nowEventText];
    [_tableOfEventTimes reloadData];
    
}

- (IBAction)onEvacButton:(UIButton *)sender {
    if (isRunning == false) return;
    
    // increment ejacCount
    ejacCount++;
    NSLog(@"%li",(long) ejacCount);
    
    // update the ejacLabel label
    _ejacLabel.text = [NSString stringWithFormat:@"Ejac: %li",(long) ejacCount];
    
    
    NSString *nowEventText = [NSString stringWithFormat:@"%@,Ejac,%@,", _timeLabel.text,sender.currentTitle];
    
    [eventTimes addObject:nowEventText];
    [_tableOfEventTimes reloadData];
}

- (IBAction)onClearButton:(id)sender {
    NSLog(@"Clear...BZZZT!");
    //clear data from previous trial
    _editTextField.text = @"";
    [eventTimes removeAllObjects];
    [_tableOfEventTimes reloadData];
    // Initialize a start time of 0:00
    startTime = [NSDate timeIntervalSinceReferenceDate];
    timePausedFor = 0;
    _timeLabel.text = @"0:00";
    
    // reset hop, ears, squeak and kicks to 0
    hopCount = 0;
    _hopLabel.text = [NSString stringWithFormat:@"Hop/Dart: %li",(long) hopCount];
    
    earsCount = 0;
    _earsLabel.text = [NSString stringWithFormat:@"Ears: %li",(long) earsCount];
    
    squeakCount = 0;
    
    kicksCount = 0;
    _kicksLabel.text = [NSString stringWithFormat:@"Kicks: %li",(long) kicksCount];
    
    // *inTimeLabel;
    
    mountCount = 0;
    _mountLabel.text = [NSString stringWithFormat:@"Mount: %li", (long) kicksCount];
    
    
    introCount = 0;
    _introLabel.text = [NSString stringWithFormat:@"Intro: %li", (long) introCount];
    
    ejacCount = 0;
    _ejacLabel.text = [NSString stringWithFormat:@"Ejac: %li", (long) ejacCount];
    
    inTimeCount = 0;
    _inTimeLabel.text = [NSString stringWithFormat:@"In Time %li", (long) inTimeCount];
    
    
}


// Marks the hop label with the most recent time
- (IBAction)onHopButton:(id)sender {
    NSLog(@"Hop!");
    
    // Add one to the hop count
    hopCount++;
    NSLog(@"%li",(long) hopCount);
    
    // Update the current display
    _hopLabel.text = [NSString stringWithFormat:@"Hop/Dart: %li",(long) hopCount];

    
    
}

- (IBAction)onEarsButton:(id)sender {
    NSLog(@"Ears!");
    
    // Add one to the ears count
    earsCount++;
    
    // Update the current display
    _earsLabel.text = [NSString stringWithFormat:@"Ears: %li",(long) earsCount];
    
}

- (IBAction)onSqueakButton:(id)sender {
    NSLog(@"Squeak");
    
    // Add one to the squeak count
    squeakCount++;
    
    // Update the current display
   // squeaksLabel.text = [NSString stringWithFormat:@"Ears: %li",(long) squeakCount];
}

- (IBAction)onKickButton:(id)sender {
    NSLog(@"Kick!");
    
    // Add one to the kick count
    kicksCount++;
    
    // Update the current display
    _kicksLabel.text = [NSString stringWithFormat:@"Kicks: %li",(long) kicksCount];
}

- (void)updateCurrentCellLabel{
    
}


// the array we need to access is eventTimes




 //when the delete button is pressed, delete that element from the array
- (IBAction)onDeleteButton:(id)sender {
        NSLog(@"Delete Button");
        NSLog(@"Current Index: %li", (long)currentIndex);
    
    
    
    
}

// when the comment button is pressed, show the keyboard and allow the user to input comments to the currently selected element in the tableView
- (IBAction)onCommentsButton:(id)sender {
     NSLog(@"Comments Button");
    
}


// when the flag putton is pressed, toggle a boolean flag on the currently selected element in the tableView

- (IBAction)onFlagButton:(id)sender {
     NSLog(@"Flag Button");
}









//Return back to the title card

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"MoveToTitleCard"]){
        NSLog(@"Returning to the TitleCardViewController");
        // Create a controller object and set its title property
        ViewController *myViewController = [segue destinationViewController];

        
    }
}









// Removes all empty strings and saves the data to the file results.csv
- (IBAction)exportData:(UIButton *)sender {
    // Create a string (in .csv format) to write to the .csv file
    NSString *toBeCSV = @"";
    for (NSString *contents in eventTimes){
        if (contents.length) {
            // Add contents to csv string
            toBeCSV = [NSString stringWithFormat:@"%@%@\n",toBeCSV,contents];
        }
    }
    
    // get the current date
    NSDate *date = [NSDate date];
    // format it
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"ddMMMyyy_HH:mm:ss"];
    NSString *timeAsString = [dateFormat stringFromDate:date];
    
    //Save to file
    // Find the place to save the file, create the file if it doesnt already exist, save the string there
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *results = [NSString stringWithFormat:@"%@/%@_AtTime_%@.csv",docPath,titleInfoFromPrevScene,timeAsString];
    if(![[NSFileManager defaultManager] fileExistsAtPath:results]){
        [[NSFileManager defaultManager] createFileAtPath:results contents:nil attributes:nil];
    }
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:results];
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:[toBeCSV dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandle closeFile];
    
    //Use to find the docPath for debugging
    //NSLog(docPath);
    
    
    // Clear the log of events
    
    // open a UIActivityViewController for saving to DropBox
    
    NSString *string1 = @"Hello";
    NSString *string2 = @"Goodbye";
    
    NSArray *myArray = @[string1, string2];
    
//    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]
//                                                        initWithActivityItems: myArray
//                                                        applicationActivities:nil];
//    //[UINavigationController presentViewController:activityViewController animated:YES completion: nil];
//    [self presentViewController:activityViewController animated:TRUE completion:nil];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]
                                                        initWithActivityItems: myArray
                                                        applicationActivities:nil];
    
    //CGRect *actionSheetPopover = CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height/4, self.view.frame.size.width *.75, self.view.frame.size.height *.75);
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //iPhone, present activity view controller as is
        [self presentViewController:activityViewController animated:YES completion:nil];
    }
    else
    {
        //iPad, present the view controller inside a popover
        if (![self.activityPopover isPopoverVisible]) {
            self.activityPopover = [[UIPopoverController alloc] initWithContentViewController:activityViewController];
            [self.activityPopover presentPopoverFromRect: [self.view frame] inView: self.view  permittedArrowDirections: UIPopoverArrowDirectionAny animated:TRUE];
                                                        // :self.myShareButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        else
        {
            //Dismiss if the button is tapped while pop over is visible
            [self.activityPopover dismissPopoverAnimated:YES];
        }
    }
    
}



- (void)updateTime
{
    //If the app isn't running, don't allow any of this counting business to happen
    
    if (isRunning == false) return;
    
    //Calculate elapsed as the time difference between currentTime and the previously initialized startTime (in viewDidLoad)
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = currentTime - (startTime + timePausedFor);
    int minutes = (int) (elapsed/60);
    elapsed -= minutes*60;
    int seconds = (int) elapsed;
    _timeLabel.text = [NSString stringWithFormat:@"%u:%02u", minutes, seconds];
    
    //Update every second
    [self performSelector:@selector(updateTime) withObject:self afterDelay:1];
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //If the timer is running and the eventTimes array is not empty, allow the action of touching outside the keyboard to discount any edits made to editTextField and return the textField text as it was to mimic the unedited cell text
    if (isRunning == true && [eventTimes count] > 0) {
        [self.view endEditing:YES];
        [super touchesBegan:touches withEvent:event];
        _editTextField.text = [eventTimes objectAtIndex:[[_tableOfEventTimes indexPathForSelectedRow] row]];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //For when Return is touched on the keyboard
    if (isRunning == true && textField == _editTextField) {
        
        if ([_tableOfEventTimes indexPathForSelectedRow] == nil) {
            //if the array is empty, you can add a comment
            [eventTimes addObject:_editTextField.text];
            [textField resignFirstResponder];       //retract keyboard
            [_tableOfEventTimes reloadData];
        } else {
            //if the array isn't empty, set the textField text to the index of eventTimes that corresponds to the selected cell
            [textField resignFirstResponder];
            NSIndexPath *path = [_tableOfEventTimes indexPathForSelectedRow];
            //NSString *arrayItemOfSelectedCell = [eventTimes objectAtIndex:path.row];
            //[eventTimes objectAtIndex:path.row] = _editTextField.text;
            [eventTimes replaceObjectAtIndex:path.row withObject:_editTextField.text];
            [_tableOfEventTimes reloadData];
            return NO;
        }
    }
    return YES;
}


// let's see if we can use this function to delete stuff from the tableView
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [eventTimes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationFade];
    }
}












- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Load selected cell text into textField
    
    
    currentIndex = indexPath.row;
    
//    if (currentIndex == 4) {
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
//    }
    [tableView reloadData];
    
    
    _editTextField.text = [eventTimes objectAtIndex:indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Returns size of array
    return [eventTimes count];
}

- (UITableViewCell *)tableView:(UITableView *)sender cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Free up a new cell from the tableview, or make a new one
    UITableViewCell *cell = [sender dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    //currentIndex = indexPath.row;

    
    
    
    
    //set the cell text to whatever's assigned to its corresponding index in eventTimes
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor lightTextColor];
    cell.textLabel.text = [eventTimes objectAtIndex:indexPath.row];
    return cell;
}

- (BOOL)prefersStatusBarHidden {return YES;}

@end
