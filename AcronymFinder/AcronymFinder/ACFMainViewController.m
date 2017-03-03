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
#import "ACFVariationsTableViewController.h"

@interface ACFMainViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;

// Stores the array of ACFLongForms for searched acronym
@property (strong, nonatomic) NSMutableArray *results;

@property (copy, nonatomic) NSString *emptyTableText;

@end

@implementation ACFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // For dynamic tableview cell's height as per the longForm text size.
    self.resultsTableView.estimatedRowHeight = 125;
    self.resultsTableView.rowHeight = UITableViewAutomaticDimension;
    self.emptyTableText = @"Acronym search results will appear here.";
    
    //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTableViewTap)];
    //[self.resultsTableView addGestureRecognizer:tap];
    
    self.resultsTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(nonnull NSString *)searchText {
    if(searchText.length > 1) {
        [self doSearch:searchText];
    }
    else if(searchText.length == 0 || searchText == nil) {
        self.emptyTableText = @"Acronym search results will appear here.";
        [self.results removeAllObjects];
        [self.resultsTableView reloadData];
    }
    
}

-(void) onTableViewTap {
    [self.searchBar resignFirstResponder];
}

// When searchBar search button clicked.
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self doSearch:searchBar.text];
    [searchBar resignFirstResponder];
}

-(void) doSearch:(NSString *) aStringText {
    __block MBProgressHUD *hud_ = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud_.mode = MBProgressHUDModeIndeterminate;
    hud_.labelText = @"Finding Acronyms";
    
    // Pass the searchbar text and search long forms for that text.
    [ACFShortForm searchLongFormsFor:aStringText block:^(NSArray *results, NSError *error) {
        [hud_ hide:YES];
        hud_ = nil;
        if(results == nil || results.count == 0) {
            self.emptyTableText = @"No Acronyms Found";
        }
        self.results = [results mutableCopy];
    
        [self.resultsTableView reloadData];
    }];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ACFResultTableViewCell* cell = (ACFResultTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
    if(!cell) {
        cell = [[ACFResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchResultCell"];
    }
    [cell setUI:self.results[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"Show Variations" sender:self.results[indexPath.row]];
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"Show Variations"]) {
         ACFVariationsTableViewController *vc_ = segue.destinationViewController;
         vc_.longForm = (ACFLongForm *)sender;
     }
 }


@end
