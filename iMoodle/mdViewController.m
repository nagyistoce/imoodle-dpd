//
//  mdViewController.m
//  iMoodle
//
//  Created by Dimitar Dobrev on 26.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "mdViewController.h"
#import "mdCourse.h"
#import <RestKit/RestKit.h>

@implementation MDViewController

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
	_tableView.dataSource = self;
	_tableView.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
	[self loadCourses:@"moodle_enrol_get_users_courses&userid=393"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
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
	[_tableView reloadData];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error 
{
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to connect to Moodle." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	NSLog(@"Hit error: %@", error);
}

#pragma mark UITableViewDelegate methods

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	CGSize size = [[[_courses objectAtIndex:indexPath.row] fullName] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, 9000)];
	return size.height + 10;
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView*)table numberOfRowsInSection:(NSInteger)section 
{
	return [_courses count];
}

- (UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSString* reuseIdentifier = @"Moodle Cell";
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
	if (cell == nil) 
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
		cell.textLabel.font = [UIFont systemFontOfSize:14];
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"listbg.png"]];
	}
	cell.textLabel.text = [[_courses objectAtIndex:indexPath.row] fullName];
	return cell;
}

- (void)viewDidUnload {
	_switchCourses = nil;
	[super viewDidUnload];
}

- (IBAction)switchCoursesValueChanged:(id)sender 
{
	if (_switchCourses.selectedSegmentIndex == 0)
	{
		[self loadCourses:@"moodle_enrol_get_users_courses&userid=393"];
	}
	else
	{
		[self loadCourses:@"moodle_course_get_courses"];
	}
}
@end
