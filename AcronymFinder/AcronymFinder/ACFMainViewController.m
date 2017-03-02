//
//  ViewController.m
//  AcronymFinder
//
//  Created by Gauri Tikekar on 3/2/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import "ACFMainViewController.h"
#import "ACFShortForm.h"
#import "ACFLongForm.h"
#import "ACFResultTableViewCell.h"
#import "MBProgressHUD.h"

@interface ACFMainViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;

// Stores the array of ACFLongForms for searched acronym
@property (strong, nonatomic) NSArray *results;

// Instance of ACFShortForm model object. It also searches for passed string.
@property (strong, nonatomic) ACFShortForm *shortForm;

@property (copy, nonatomic) NSString *emptyTableText;

@end

@implementation ACFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shortForm = [[ACFShortForm alloc] init];
    
    // For dynamic tableview cell's height as per the longForm text size.
    self.resultsTableView.estimatedRowHeight = 125;
    self.resultsTableView.rowHeight = UITableViewAutomaticDimension;
    
    self.emptyTableText = @"Acronym search results will appear here.";
}

// When searchBar search button clicked.
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    __block MBProgressHUD *hud_ = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud_.mode = MBProgressHUDModeIndeterminate;
    hud_.labelText = @"Finding Acronyms";
    
    // Pass the searchbar text and search long forms for that text.
    [self.shortForm searchLongFormsFor:searchBar.text block:^(NSArray *results, NSError *error) {
        [hud_ hide:YES];
        hud_ = nil;
        if(results == nil || results.count == 0) {
            self.emptyTableText = @"No Acronyms Found";
        }
        self.results = results;
        
        [self.resultsTableView reloadData];
    }];
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View Data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.results.count == 0) {
        // Show label like "No Acronyms found" when search result brings empty result.
        UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
        noDataLabel.text = self.emptyTableText;
        noDataLabel.textColor = [UIColor blackColor];
        noDataLabel.textAlignment = NSTextAlignmentCenter;
        tableView.backgroundView = noDataLabel;
    }
    else {
        tableView.backgroundView = nil;
    }
    return self.results.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ACFResultTableViewCell* cell = (ACFResultTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
    if(!cell) {
        cell = [[ACFResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchResultCell"];
    }
    [cell setUI:self.results[indexPath.section]];
    return cell;
}


@end
