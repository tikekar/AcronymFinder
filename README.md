# AcronymFinder
Find the meanings of given acronym
## Features
1. SearchBar to search for any acronym.(in ACFMainViewController)
2. UITableView to show the long form results. (in ACFMainViewController)
3. Clicking on UITableViewCell will take to details page showing variations. (ACFVariationsTableViewController for variations)
4. Used Navigation Bar
5. Used Core data: The app will work offline for already searched acronyms.

## Model Layer
1. ACFShortForm and ACFLongForm model classes to store all the data coming from json.

## Frameworks and Apis used
1. Used cocoapods to integrate MBProgressHUD.
2. Used NSURLSession to fetch server data.
3. Used core data to store the results for already searched acronyms.

## Steps
1. Open the AcronymFinder.xcworkspace as I have used cocoapods.
2. Run AcronymFinder
3. Search for any acronym.
