//
//  MasterViewController.m
//  EveryDo
//
//  Created by Daniel Grosman on 2017-11-14.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ToDoItem.h"
#import "CustomTableViewCell.h"
#import "AddItemViewController.h"

@interface MasterViewController () <UITableViewDataSource, AddNewViewControllerDelegate>


@property (strong, nonatomic) NSMutableArray<ToDoItem *> *todoItems;
@property NSMutableArray *objects;

@end

@implementation MasterViewController

- (NSMutableArray<ToDoItem *> *)todoItems {
    if (_todoItems == nil) {
        _todoItems = [[NSMutableArray alloc] init];
        [_todoItems addObject:[[ToDoItem alloc] initWithTitle:@"Finish Assignment" todoDescription:@"Complete the EveryDo Assignment for LHL" priorityNumber:1 isCompleted:NO]];
        [_todoItems addObject:[[ToDoItem alloc] initWithTitle:@"Run Errands" todoDescription:@"Go to the Grocery Store" priorityNumber:2 isCompleted:NO]];
        [_todoItems addObject:[[ToDoItem alloc] initWithTitle:@"Clean Up Apartment" todoDescription:@"Wash Dishes and Fold Laundry" priorityNumber:3 isCompleted:NO]];
        [_todoItems addObject:[[ToDoItem alloc] initWithTitle:@"Play Video Games" todoDescription:@"Play Call of Duty and NBA 2k18" priorityNumber:4 isCompleted:YES]];
    }
    return _todoItems;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewItem:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)addNew:(ToDoItem *)newToDo {
    [self.todoItems insertObject:newToDo atIndex:0];
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)viewWillAppear:(BOOL)animated {
}


- (void)insertNewItem:(id)sender {
    [self performSegueWithIdentifier:@"AddToDo" sender:self];
//    if (!self.todoItems) {
//        self.todoItems = [[NSMutableArray alloc] init];
//    }
//    [self.todoItems insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ToDoItem *todoItem = self.todoItems[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        [controller setDetailItem:todoItem];
    }
    if ([segue.identifier isEqualToString:@"AddToDo"]) {
        [segue.destinationViewController setDelegate:self];
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    ToDoItem *todoItem = self.todoItems[indexPath.row];
    if (todoItem.isCompleted) {
        NSDictionary* attributes = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]};
        NSAttributedString* attributedTitleString = [[NSAttributedString alloc] initWithString:todoItem.title attributes:attributes];
        NSAttributedString* attributedDescriptionString = [[NSAttributedString alloc] initWithString:todoItem.todoDescription attributes:attributes];
        cell.titleLabel.attributedText = attributedTitleString;
        cell.titleLabel.textColor = [UIColor redColor];
        cell.descriptionLabel.attributedText = attributedDescriptionString;
        cell.descriptionLabel.textColor = [UIColor redColor];
        cell.priorityLabel.text = [NSString stringWithFormat:@"%ld",todoItem.priorityNumber];
    } else {
        cell.titleLabel.text = todoItem.title;
        cell.titleLabel.textColor = [UIColor blackColor];
        cell.descriptionLabel.text = todoItem.todoDescription;
        cell.descriptionLabel.textColor = [UIColor blackColor];
        cell.priorityLabel.text = [NSString stringWithFormat:@"%ld",todoItem.priorityNumber];
    }
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


@end
