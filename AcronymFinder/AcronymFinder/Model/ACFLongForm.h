//
//  ACFLongForm.h
//  AcronymFinder
//
//  Created by Gauri Tikekar on 3/2/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACFLongForm : NSObject

@property (nonatomic, copy) NSString *lf;
@property (nonatomic) int freq;
@property (nonatomic) int sinceDate;
@property (nonatomic, strong) NSDictionary *vars;

@end
