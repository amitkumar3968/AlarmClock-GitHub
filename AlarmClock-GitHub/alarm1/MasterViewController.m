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
    NSLog(@"Dismiss");
}



- (IBAction)settingsButton:(id)sender {
}

-(void)showClock //Beskriver vad som händer då man kallar "showClock"
{
    
    
    NSDate *dateShow= [NSDate dateWithTimeIntervalSinceNow:0];
    
    dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setTimeStyle:NSDateFormatterMediumStyle];
    NSString *dateString = [dateFormat stringFromDate:dateShow];
    timeDisplay.text = dateString;
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
    
    NSLog(@"Did start MasterViewController ViewDidLoad");
     [[self navigationController] setNavigationBarHidden:YES animated:NO];   
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(showClock) userInfo:nil repeats:YES]; //Kallar showClock med intervallet 0,5 sekunder.
    
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    NSLog(@"Did finish MasterViewController ViewDidLoad");
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    dateFormat = nil;
    
    [super viewDidUnload];
        
}

- (void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [super viewWillAppear:animated];
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
