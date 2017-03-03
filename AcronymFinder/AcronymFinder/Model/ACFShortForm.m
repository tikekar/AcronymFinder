//
//  ACShortForm.m
//  AcronymFinder
//
//  Created by Gauri Tikekar on 3/2/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import "ACFShortForm.h"
#import "ACFLongForm.h"
#import "AppDelegate.h"

// Core Data Class
static NSString * const KClass_AcronymResults = @"AcronymResults";

@implementation ACFShortForm

// search for long forms for the given string and then call the handler method when results are found.
+(void) searchLongFormsFor: (NSString *) aShortForm block:(void (^) (NSArray *results,  NSError *error))handler {
    
    ACFShortForm *shortForm_ = [[ACFShortForm alloc] init];
    shortForm_.shortForm = aShortForm;
    shortForm_.longForms = [[NSMutableArray alloc] init];
    
    // Get Results from local (Core Data)
    NSArray *array_ = [shortForm_ getResultsFromCoreData];
    if(array_ != nil) {
        [shortForm_ createLongFormArray:array_];
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(shortForm_.longForms, nil);
        });
        
        return;
    }
    
    // If not found locally, then fetch from server.
    NSString *dataUrl = [NSString stringWithFormat:@"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@", aShortForm];
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url
                                          completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              if(data != nil && error == nil) {
                                                  NSError *e = nil;
                                                  NSArray *array_ = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
                                                  [shortForm_ createLongFormArray:array_]; // create ACFLongForm objs array
                                                  [shortForm_ saveResultsToCoreData:array_]; // save results locally
                                              }
                                              // Call the block handler on main thread.
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  handler(shortForm_.longForms, error);
                                              });
                                              
                                          }];
    
    [downloadTask resume];
}

// Form ACLongForm objects out of json array and create lfs array
-(void) createLongFormArray: (NSArray *) array {
    if(array != nil && array.count > 0) {
        NSArray *lfs_ = [array[0] objectForKey:@"lfs"];
        for(int i=0; i<lfs_.count; i++) {
            NSDictionary *iLF_ = lfs_[i];
            ACFLongForm *lf_ = [[ACFLongForm alloc] init];
            [lf_ setDetails:iLF_];
            [self.longForms addObject:lf_];
        }
    }
}

// Save Results to Core data AcronymResults entity
-(void) saveResultsToCoreData: (NSArray *) aArray {
    if(aArray != nil && aArray.count > 0) {
        
        AppDelegate *delegate_ = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSEntityDescription *description_ = [NSEntityDescription entityForName:KClass_AcronymResults inManagedObjectContext:delegate_.persistentContainer.viewContext];
        NSManagedObject *results_ = [[NSManagedObject alloc] initWithEntity:description_ insertIntoManagedObjectContext:delegate_.persistentContainer.viewContext];
        
        // Get String from JSON array
        NSError *e = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:aArray options:NSJSONWritingPrettyPrinted error:&e];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [results_ setValue:jsonString forKey:@"results"];
        
        [results_ setValue:[NSDate date] forKey:@"createdAt"];
        [results_ setValue:self.shortForm forKey:@"shortForm"];
        
        [delegate_ saveContext];
    }
}

// Get Results from Core data AcronymResults entity for given shortForm (sf)
-(NSArray *) getResultsFromCoreData {
    NSString *shortForm_ = self.shortForm;
    if(shortForm_ == nil) return nil;
    AppDelegate *delegate_ = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSEntityDescription *description_ = [NSEntityDescription entityForName:KClass_AcronymResults inManagedObjectContext:delegate_.persistentContainer.viewContext];
    NSFetchRequest *request_ = [[NSFetchRequest alloc] init];
    [request_ setEntity:description_];
    NSPredicate *predicate_ = [NSPredicate predicateWithFormat:@"shortForm like %@", shortForm_];
    if(predicate_ ==nil) return nil;
    [request_ setPredicate:predicate_];
    NSError *e;
    NSArray *matchingData_ = [delegate_.persistentContainer.viewContext executeFetchRequest:request_ error: &e];
    if(matchingData_ != nil && matchingData_.count > 0) {
        NSManagedObject *obj_ = matchingData_[0];
        NSString *dataString_ = [obj_ valueForKey:@"results"];
        
        // Form array from json string.
        NSData* data_ = [dataString_ dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *array_ = [NSJSONSerialization JSONObjectWithData:data_ options:NSJSONReadingMutableContainers error:nil];
        return array_;
    }
    return nil;
}

@end
