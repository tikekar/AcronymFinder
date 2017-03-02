//
//  ACShortForm.h
//  AcronymFinder
//
//  Created by Gauri Tikekar on 3/2/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACFShortForm : NSObject

@property (nonatomic, copy) NSString *sf;
@property (nonatomic, strong) NSMutableArray *lfs;

-(void) searchLongFormsFor: (NSString *) aShortForm block:(void (^) (NSArray *results,  NSError *error))handler;

@end
