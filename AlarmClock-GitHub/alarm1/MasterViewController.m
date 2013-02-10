//
//  MasterViewController.m
//  alarm1
//
//  Created by Philip Montalvo on 2012-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "Singleton.h"
@implementation MasterViewController
@synthesize timeDisplay;
@synthesize ampmDisplay;
@synthesize secondsDisplay;
@synthesize dayDisplay;
@synthesize dateDisplay;
@synthesize background;
@synthesize alarmIndicator;


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"PushminView"])
	{
		UINavigationController *navigationController = segue.destinationViewController;
		minTableViewController *minnTableViewController = [[navigationController viewControllers] objectAtIndex:0];
		minnTableViewController.delegate = self;
        
	}
}

- (void)minTableViewControllerDidDone:(AddAlarmViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)settingsButton:(id)sender {
}

-(void)showClock //Beskriver vad som händer då man kallar "showClock"
{
    
    
    NSDate *dateShow= [NSDate dateWithTimeIntervalSinceNow:0];
    
    dateFormat = [[NSDateFormatter alloc] init];
    
    if ([[[Singleton sharedSingleton]sharedSettings] integerForKey:@"24HourClockSetting"] == 0) {
        [dateFormat setDateFormat:@"hh:mm"];
    } else {
        [dateFormat setDateFormat:@"HH:mm"];
    }
    
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"a"];
    
    NSDateFormatter *secondFormatter = [[NSDateFormatter alloc] init];
    [secondFormatter setDateFormat:@"ss"];
    
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat:@"EEE"];
    
    NSDateFormatter *fullDateFormatter = [[NSDateFormatter alloc] init];
    [fullDateFormatter setDateFormat:@"yyyy-MM-dd"];
    
   
    //[dateFormat setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateString = [dateFormat stringFromDate:dateShow];
    NSString *ampmString = [outputFormatter stringFromDate:dateShow];
    NSString *secondsString = [secondFormatter stringFromDate:dateShow];
    NSString *dayString = [dayFormatter stringFromDate:dateShow];
    NSString *fullDateString = [fullDateFormatter stringFromDate:dateShow];
    
    ampmDisplay.text = ampmString;
    timeDisplay.text = dateString;
    secondsDisplay.text = secondsString;
    dayDisplay.text = dayString;
    dateDisplay.text = fullDateString;
}


- (void)awakeFromNib
{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    
    //Kolla veckodag
    NSDateFormatter* theDateFormatter = [[NSDateFormatter alloc] init];
    [theDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [theDateFormatter setDateFormat:@"EEEE"];
    NSString *weekDay =  [theDateFormatter stringFromDate:[NSDate date]];
    
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
    NSInteger day = [weekdayComponents day];
    NSInteger weekday = [weekdayComponents weekday];
    
     [[self navigationController] setNavigationBarHidden:YES animated:NO];   
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(showClock) userInfo:nil repeats:YES]; //Kallar showClock med intervallet 0,5 sekunder.
    
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    dateFormat = nil;
    
    [super viewDidUnload];
        
}

- (void)viewWillAppear:(BOOL)animated {
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *array = [app scheduledLocalNotifications];
    if ([array count] > 0) {
        alarmIndicator.hidden = NO;
    } else {
        alarmIndicator.hidden = YES;
    }
    
    [self showClock];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [super viewWillAppear:animated];
    
    //UIImage *simplyBG = [UIImage imageNamed:@"SimplyBG.png"];
    UIImage *simplyBG = [UIImage imageNamed:@"SimplyBG.png"];
    UIImage *standardBG = [UIImage imageNamed:@"BlackBoard4.png"];
    UIImage *whiteBG = [UIImage imageNamed:@"WhiteDesign.png"];
    UIImage *testing = [UIImage imageNamed:@"clock4 copy.png"];
    UIImage *testing2 = [UIImage imageNamed:@"clock4green.png"];
    
    //Kollar vilka labels som ska vara på
    
    if ([[[Singleton sharedSingleton] sharedSettings] integerForKey:@"ShowSecondsSetting"] == 0 ) {
        secondsDisplay.hidden = YES;
    } else {
        secondsDisplay.hidden = NO;
    }
    
    if ([[[Singleton sharedSingleton] sharedSettings] integerForKey:@"ShowAMPMSetting"] == 0 ) {
        ampmDisplay.hidden = YES;
    } else {
        ampmDisplay.hidden = NO;
    }

    
    //Kollar och fixar rätt design
    if ([[[[Singleton sharedSingleton] sharedSettings] valueForKey:@"ActiveDesignSetting"] isEqualToString:@"Back To School"]) {
        [background setImage:standardBG];
        
        timeDisplay.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        dateDisplay.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        secondsDisplay.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        ampmDisplay.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:1 alpha:1.0];
        dayDisplay.textColor =  [UIColor colorWithRed:1 green:0.4 blue:0.4 alpha:1.0];
        
        ampmDisplay.font = [UIFont fontWithName:@"Chalkduster" size:22];
        dayDisplay.font = [UIFont fontWithName:@"Chalkduster" size:22];
        
    } else if ([[[[Singleton sharedSingleton] sharedSettings] valueForKey:@"ActiveDesignSetting"] isEqualToString:@"Back To School Clean"]) {
        
        [background setImage:simplyBG];
        
        timeDisplay.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        dateDisplay.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        secondsDisplay.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        ampmDisplay.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:1 alpha:1.0];
        dayDisplay.textColor =  [UIColor colorWithRed:1 green:0.4 blue:0.4 alpha:1.0];
        
        ampmDisplay.font = [UIFont fontWithName:@"Chalkduster" size:22];
        dayDisplay.font = [UIFont fontWithName:@"Chalkduster" size:22];
        
    } else if ([[[[Singleton sharedSingleton] sharedSettings] valueForKey:@"ActiveDesignSetting"] isEqualToString:@"White Math"]) {
        
        [background setImage:whiteBG];
        timeDisplay.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
        dateDisplay.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
        secondsDisplay.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
        ampmDisplay.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
        dayDisplay.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
        
        ampmDisplay.font = [UIFont fontWithName:@"Myriad Pro" size:24];
        dayDisplay.font = [UIFont fontWithName:@"Myriad Pro" size:24];
        
    } else if ([[[[Singleton sharedSingleton] sharedSettings] valueForKey:@"ActiveDesignSetting"] isEqualToString:@"Blue LED"]) {
        
        [background setImage:testing];
        timeDisplay.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        dateDisplay.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        secondsDisplay.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        ampmDisplay.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        dayDisplay.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        ampmDisplay.font = [UIFont fontWithName:@"Myriad Pro" size:24];
        dayDisplay.font = [UIFont fontWithName:@"Myriad Pro" size:24];
        
    } else if ([[[[Singleton sharedSingleton] sharedSettings] valueForKey:@"ActiveDesignSetting"] isEqualToString:@"Green LED"]) {
        
        [background setImage:testing2];
        timeDisplay.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        dateDisplay.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        secondsDisplay.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        ampmDisplay.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        dayDisplay.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        ampmDisplay.font = [UIFont fontWithName:@"Myriad Pro" size:24];
        dayDisplay.font = [UIFont fontWithName:@"Myriad Pro" size:24];
    }

    
    if ([[[Singleton sharedSingleton] sharedSettings]integerForKey:@"ClearBackgroundSetting"] == 0) {
        // GÖR INGET ALLS TILLS VIDARE
     
    } else {
   
    }
    
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
@end
