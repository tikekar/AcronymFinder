//
//  ACShortForm.m
//  AcronymFinder
//
//  Created by Gauri Tikekar on 3/2/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import "ACFShortForm.h"
#import "ACFLongForm.h"

@implementation ACFShortForm

// search for long forms for the given string and then call the handler method when results are found.
-(void) searchLongFormsFor: (NSString *) aShortForm block:(void (^) (NSArray *results,  NSError *error))handler {
    
    self.sf = aShortForm;
    self.lfs = [[NSMutableArray alloc] init];
    
    NSString *dataUrl = [NSString stringWithFormat:@"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@", aShortForm];
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url
                                          completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              if(data != nil && error == nil) {
                                                  NSError *e = nil;
                                                  NSArray *array_ = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
                                                  [self createLongFormArray:array_];                                              }
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  handler(self.lfs, error);
                                              });
                                              
                                          }];
    
    [downloadTask resume];
}

-(void) createLongFormArray: (NSArray *) array {
    if(array != nil && array.count > 0) {
        NSArray *lfs_ = [array[0] objectForKey:@"lfs"];
        for(int i=0; i<lfs_.count; i++) {
            NSDictionary *iLF_ = lfs_[i];
            ACFLongForm *lf_ = [[ACFLongForm alloc] init];
            lf_.lf = [iLF_ objectForKey:@"lf"];
            lf_.sinceDate = [iLF_ objectForKey:@"since"] != nil?[[iLF_ objectForKey:@"since"] intValue]:-1;
            lf_.freq = [iLF_ objectForKey:@"freq"] != nil?[[iLF_ objectForKey:@"freq"] intValue]:-1;
            lf_.vars = [iLF_ objectForKey:@"vars"];
            [self.lfs addObject:lf_];
        }
    }
}

@end
