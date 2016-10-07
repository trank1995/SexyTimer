//
//  ViewController.m
//  Timer
//
//  Created by keyess on 7/18/13.
//  Copyright (c) 2013 keyess. All rights reserved.
// 

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    //An array of all events
    NSMutableArray *eventTimes;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initialize a few variables/properties, and set the text field delegate as self (the viewcontroller)
    _timeLabel.text = @"0:00";
    isRunning = false;
    eventTimes = [[NSMutableArray alloc] init];
    self.editTextField.delegate = self; 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (IBAction)onStartButton:(UIButton *)sender {
    if (isRunning == false){
        //clear data from previous trial
        _editTextField.text = @"";
        [eventTimes removeAllObjects];
        [_tableOfEventTimes reloadData];
        
        //set a few settings so that the app can begin working with new data (set startTime, reinitialize eventTimes
        isRunning = true;
        startTime = [NSDate timeIntervalSinceReferenceDate];
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
        [self updateTime];
        eventTimes = [[NSMutableArray alloc] init];
    } else {
        //delete nothing, but stop the timer
        [sender setTitle:@"Start" forState:UIControlStateNormal];
        isRunning = false;
    }
}

- (IBAction)onActionButton:(UIButton *)sender {
    //If the timer isn't running, don't add anything
    if (isRunning == false) return;
    
    //Construct the string to be added
    NSString *nowEventText = [NSString stringWithFormat:@"%@,%@,", _timeLabel.text,sender.currentTitle];
    
    [eventTimes addObject:nowEventText];
    [_tableOfEventTimes reloadData];
}

- (IBAction)onIntroButton:(UIButton *)sender {
    if (isRunning == false) return;
    NSString *nowEventText = [NSString stringWithFormat:@"%@,Intro,%@,", _timeLabel.text,sender.currentTitle];
    
    [eventTimes addObject:nowEventText];
    [_tableOfEventTimes reloadData];
}

- (IBAction)onMountButton:(UIButton *)sender {
    if (isRunning == false) return;
    NSString *nowEventText = [NSString stringWithFormat:@"%@,Mount,%@,", _timeLabel.text,sender.currentTitle];
    
    [eventTimes addObject:nowEventText];
    [_tableOfEventTimes reloadData];
}

- (IBAction)onEvacButton:(UIButton *)sender {
    if (isRunning == false) return;
    NSString *nowEventText = [NSString stringWithFormat:@"%@,Ejac,%@,", _timeLabel.text,sender.currentTitle];
    
    [eventTimes addObject:nowEventText];
    [_tableOfEventTimes reloadData];
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
    NSString *results = [NSString stringWithFormat:@"%@/resultsFrom_%@.csv",docPath,timeAsString];
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
    
    
}



- (void)updateTime
{
    //If the app isn't running, don't allow any of this counting business to happen
    if (isRunning == false) return;
    
    //Calculate elapsed as the time difference between currentTime and the previously initialized startTime (in viewDidLoad)
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = currentTime - startTime;
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Load selected cell text into textField
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
    
    //set the cell text to whatever's assigned to its corresponding index in eventTimes
    cell.textLabel.textColor = [UIColor lightTextColor];
    cell.textLabel.text = [eventTimes objectAtIndex:indexPath.row];
    return cell;
}

@end
