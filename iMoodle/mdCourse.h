//
//  mdCourse.h
//  iMoodle
//
//  Created by Dimitar Dobrev on 27.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mdCourse : NSObject

@property (nonatomic) int id;
@property (nonatomic, retain) NSString* shortname;
@property (nonatomic) int categoryid;
@property (nonatomic) int categorysortorder;
@property (nonatomic, retain) NSString* fullname;
@property (nonatomic, retain) NSString* idnumber;
@property (nonatomic, retain) NSString* summary;
@property (nonatomic) int summaryformat;
@property (nonatomic, retain) NSString* format;
@property (nonatomic) int showgrades;
@property (nonatomic) int newsitems;
@property (nonatomic) int numsections;
@property (nonatomic) int maxbytes;
@property (nonatomic) int visible;
@property (nonatomic) int hiddensections;
@property (nonatomic) int groupmodeforce;
@property (nonatomic) int defaultgroupingid;
@property (nonatomic) int timecreated;
@property (nonatomic) int timemodified;
@property (nonatomic) int enablecompletion;
@property (nonatomic) int completionstartonenrol;
@property (nonatomic) int completionnotify;
@property (nonatomic, retain) NSString* lang;

@end
