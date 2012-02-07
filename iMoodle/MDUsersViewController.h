//
//  MDUsersViewController.h
//  iMoodle
//
//  Created by Dimitar Dobrev on 07.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface MDUsersViewController : UITableViewController<RKObjectLoaderDelegate>
{
	NSArray* _users;
}

@property (strong, nonatomic) IBOutlet UITableView *tableViewUsers;


@end
