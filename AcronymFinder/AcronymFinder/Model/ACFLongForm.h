//
//  ACFLongForm.h
//  AcronymFinder
//
//  Created by Gauri Tikekar on 3/2/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACFLongForm : NSObject

//Long Form. Used the same key as json result
@property (nonatomic, copy) NSString *lf;

//freq
@property (nonatomic) int freq;

//since
@property (nonatomic) int sinceDate;

//vars as obtained from json result
@property (nonatomic, strong) NSDictionary *vars;

@end
