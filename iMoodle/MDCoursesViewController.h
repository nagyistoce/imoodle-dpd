//
//  MDViewController.h
//  iMoodle
//
//  Created by Dimitar Dobrev on 07.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface MDCoursesViewController : UITableViewController<RKObjectLoaderDelegate>
{
	NSArray* _courses;
}

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControlMineAll;
@property (strong, nonatomic) IBOutlet UITableView *tableViewCourses;

@property (strong, nonatomic) NSString* token;
@property int userID;

- (IBAction)segmentedControlMineAllValueChanged:(id)sender;

@end
