//
//  mdViewController.h
//  iMoodle
//
//  Created by Dimitar Dobrev on 26.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface mdViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate>
{
	IBOutlet UITableView* _tableView;
	
	NSString* _token;
	NSArray* _courses;
}

@end