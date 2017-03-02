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

-(void) searchLongFormsFor: (NSString *) aShortForm block:(void (^) (NSArray *results,  NSError *error))handler {
    self.sf = aShortForm;
    self.lfs = [[NSMutableArray alloc] init];
    NSString *dataUrl = [NSString stringWithFormat:@"https://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@", aShortForm];
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url
                                          completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              if(data != nil && error == nil) {
                                                  NSError *e = nil;
                                                  NSArray *array_ = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
                                                  if(array_ != nil && array_.count > 0) {
                                                      NSArray *lfs_ = [array_[0] objectForKey:@"lfs"];
                                                      for(int i=0; i<lfs_.count; i++) {
                                                          NSDictionary *iLF_ = lfs_[i];
                                                          ACFLongForm *lf_ = [[ACFLongForm alloc] init];
                                                          lf_.lf = [iLF_ objectForKey:@"lf"];
                                                          lf_.sinceDate = [[iLF_ objectForKey:@"since"] intValue];
                                                          lf_.freq = [[iLF_ objectForKey:@"freq"] intValue];
                                                          lf_.vars = [iLF_ objectForKey:@"vars"];
                                                          [self.lfs addObject:lf_];
                                                      }
                                                  }
                                              }
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  handler(self.lfs, error);
                                              });
                                              
                                          }];
    
    [downloadTask resume];
    
}

@end
