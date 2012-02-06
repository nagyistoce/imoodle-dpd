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
@property (nonatomic, retain) NSString* shortName;
@property (nonatomic) int categoryID;
@property (nonatomic) int categorySortOrder;
@property (nonatomic, retain) NSString* fullName;
@property (nonatomic, retain) NSString* IDNumber;
@property (nonatomic, retain) NSString* summary;
@property (nonatomic) int summaryFormat;
@property (nonatomic, retain) NSString* format;
@property (nonatomic) int showGrades;
@property (nonatomic) int newsItems;
@property (nonatomic) int numberOfSections;
@property (nonatomic) int maxBytes;
@property (nonatomic) int visible;
@property (nonatomic) int hiddenSections;
@property (nonatomic) int groupModeForce;
@property (nonatomic) int defaultGroupingID;
@property (nonatomic) int timeCreated;
@property (nonatomic) int timeModified;
@property (nonatomic) int enableCompletion;
@property (nonatomic) int completionStartOnEnrol;
@property (nonatomic) int completionNotify;
@property (nonatomic, retain) NSString* language;

@end
