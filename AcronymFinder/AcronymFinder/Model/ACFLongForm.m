//
//  ACFLongForm.m
//  AcronymFinder
//
//  Created by Gauri Tikekar on 3/2/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import "ACFLongForm.h"

@implementation ACFLongForm

-(void) setDetails: (NSDictionary *) aDictionary {
    self.vars = [[NSMutableArray alloc] init];
    self.longForm = [aDictionary objectForKey:@"lf"];
    self.sinceDate = [aDictionary objectForKey:@"since"] != nil?[[aDictionary objectForKey:@"since"] intValue]:-1;
    self.freq = [aDictionary objectForKey:@"freq"] != nil?[[aDictionary objectForKey:@"freq"] intValue]:-1;
    NSArray *vars_ = [aDictionary objectForKey:@"vars"];
    if(vars_ != nil && vars_.count > 0) {
        for(int i=0; i<vars_.count; i++) {
            NSDictionary *iVar_ = vars_[i];
            
            // Treating vars as array of children ACFLongForm objects of ACLongForm
            ACFLongForm *lf_ = [[ACFLongForm alloc] init];
            [lf_ setDetails:iVar_];
            [self.vars addObject:lf_];
        }
    }
}

@end
