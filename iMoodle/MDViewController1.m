//
//  MDViewController.m
//  iMoodle
//
//  Created by Dimitar Dobrev on 07.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MDViewController.h"
#import "MDUsersViewController.h"
#import "MDCourse.h"
#import <RestKit/RestKit.h>

@implementation MDViewController
@synthesize segmentedControlMineAll;
@synthesize tableViewCourses;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
	{
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)loadCourses:(NSString*)function
{
	RKObjectManager* restKitObjectManager = [RKObjectManager sharedManager];
	restKitObjectManager.client.baseURL = @"http://moodle.openfmi.net";
	NSString* resourcePath = [@"/webservice/rest/server.php?wstoken=091d9d94bf2044c7d54aebcb1420dc53&wsfunction=" stringByAppendingString:function];
	[restKitObjectManager loadObjectsAtResourcePath:resourcePath delegate:self];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	[self loadCourses:@"moodle_enrol_get_users_courses&userid=393"];
}

- (void)viewDidUnload
{
	[self setTableViewCourses:nil];
	[self setSegmentedControlMineAll:nil];
	[self setTableViewCourses:nil];
	[self setSegmentedControlMineAll:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _courses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString* reuseIdentifier = @"Moodle Cell";
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
	if (cell == nil) 
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
		cell.textLabel.font = [UIFont systemFontOfSize:14];
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.backgroundColor = [UIColor clearColor];
	}
	cell.textLabel.text = [[_courses objectAtIndex:indexPath.row] fullName];
	return cell;
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
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	MDUsersViewController* usersViewController = [[MDUsersViewController alloc] initWithNibName:@"MDUsersViewController" bundle:nil];
	[self.navigationController pushViewController:usersViewController animated:YES];
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	CGSize size = [[[_courses objectAtIndex:indexPath.row] fullName] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, 9000)];
	return size.height + 10;
}

- (IBAction)segmentedControlMineOrAllValueChanged:(id)sender 
{
	if (segmentedControlMineAll.selectedSegmentIndex == 0)
	{
		[self loadCourses:@"moodle_enrol_get_users_courses&userid=393"];
	}
	else
	{
		[self loadCourses:@"moodle_course_get_courses"];
	}
}

#pragma mark RKObjectLoaderDelegate methods

- (void)objectLoader:(RKObjectLoader*)loader willMapData:(inout id*)mappableData
{
	for (NSDictionary* single in [[[*mappableData valueForKey:@"RESPONSE"] valueForKey:@"MULTIPLE"] valueForKey:@"SINGLE"])
	{
		for (NSDictionary* keyValuePair in [single valueForKey:@"KEY"])
		{
			[single setValue:[keyValuePair valueForKey:@"VALUE"] forKey:[keyValuePair valueForKey:@"name"]];
		}
	}
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects 
{
	_courses = objects;
	[tableViewCourses reloadData];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error 
{
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to connect to Moodle." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	NSLog(@"Hit error: %@", error);
}

@end
