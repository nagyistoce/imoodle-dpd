//
//  MDViewController.h
//  iMoodle
//
//  Created by Dimitar Dobrev on 07.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface MDViewController : UITableViewController<RKObjectLoaderDelegate>
{
	NSArray* _courses;
}

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControlMineAll;
@property (strong, nonatomic) IBOutlet UITableView *tableViewCourses;

- (IBAction)segmentedControlMineAllValueChanged:(id)sender;

@end
