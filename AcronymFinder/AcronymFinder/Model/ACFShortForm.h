//
//  ACShortForm.h
//  AcronymFinder
//
//  Created by Gauri Tikekar on 3/2/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACFShortForm : NSObject

//Short Form.
@property (nonatomic, copy) NSString *shortForm;

//Long Forms array.
@property (nonatomic, strong) NSMutableArray *longForms;

// Get a shortForm string and fetch longForms for that. Return the results array in the block handler.
+(void) searchLongFormsFor: (NSString *) aShortForm block:(void (^) (NSArray *results,  NSError *error))handler;

@end
