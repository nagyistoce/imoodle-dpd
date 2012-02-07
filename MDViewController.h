//
//  mdViewController.h
//  iMoodle
//
//  Created by Dimitar Dobrev on 26.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface MDViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate>
{
	IBOutlet UISegmentedControl* _switchCourses;
	IBOutlet UITableView* _tableView;
	
	NSString* _token;
	NSArray* _courses;
}
- (IBAction)switchCoursesValueChanged:(id)sender;

@end