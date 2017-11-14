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
@property (strong, nonatomic) NSMutableArray<ToDoItem *> *completedItems;

@end

@implementation MasterViewController

- (NSMutableArray<ToDoItem *> *)todoItems {
    if (_todoItems == nil) {
        _todoItems = [[NSMutableArray alloc] init];
        [_todoItems addObject:[[ToDoItem alloc] initWithTitle:@"Finish Assignment" todoDescription:@"Complete the EveryDo Assignment for LHL" priorityNumber:1 deadline:[NSDate dateWithTimeInterval:604800 sinceDate:[NSDate date]] isCompleted:NO]];
        [_todoItems addObject:[[ToDoItem alloc] initWithTitle:@"Run Errands" todoDescription:@"Go to the Grocery Store" priorityNumber:2 deadline:[NSDate dateWithTimeInterval:1209600 sinceDate:[NSDate date]] isCompleted:NO]];
        [_todoItems addObject:[[ToDoItem alloc] initWithTitle:@"Clean Up Apartment" todoDescription:@"Wash Dishes and Fold Laundry" priorityNumber:3 deadline:[NSDate dateWithTimeInterval:809650 sinceDate:[NSDate date]] isCompleted:NO]];
        [_todoItems addObject:[[ToDoItem alloc] initWithTitle:@"Play Video Games" todoDescription:@"Play Call of Duty and NBA 2k18" priorityNumber:4 deadline:[NSDate dateWithTimeInterval:200000 sinceDate:[NSDate date]] isCompleted:NO]];
    }
    return _todoItems;
}

- (NSMutableArray<ToDoItem *> *)completedItems {
    if (_completedItems == nil) {
        _completedItems = [[NSMutableArray alloc] init];
    }
    return _completedItems;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(saveNewItem:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UISwipeGestureRecognizer *swipeCompleted = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(itemWasSwiped:)];
    [self.tableView addGestureRecognizer:swipeCompleted];
}

-(void) itemWasSwiped: (UISwipeGestureRecognizer *) sender {
    CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    ToDoItem *todoItem = self.todoItems[indexPath.row];
    
    todoItem.isCompleted = YES;
    todoItem.priorityNumber = 0;
    
    [self.todoItems removeObject:todoItem];
    [self.completedItems addObject:todoItem];
    
    [self.tableView reloadData];
}

- (void)addNew:(ToDoItem *)newToDo {
    [self.todoItems insertObject:newToDo atIndex:0];
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)viewWillAppear:(BOOL)animated {
}


- (void)saveNewItem:(id)sender {
    [self performSegueWithIdentifier:@"AddToDo" sender:self];
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
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Outstanding Tasks";
            break;
        case 1:
            sectionName = @"Completed Tasks";
            break;
    }
    return sectionName;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0){
        return self.todoItems.count;
    } else {
        return self.completedItems.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.section==1) {
        ToDoItem *completedItem = self.completedItems[indexPath.row];
        NSDictionary* attributes = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]};
        NSAttributedString* attributedTitleString = [[NSAttributedString alloc] initWithString:completedItem.title attributes:attributes];
        NSAttributedString* attributedDescriptionString = [[NSAttributedString alloc] initWithString:completedItem.todoDescription attributes:attributes];
        cell.titleLabel.attributedText = attributedTitleString;
        cell.titleLabel.textColor = [UIColor redColor];
        cell.descriptionLabel.attributedText = attributedDescriptionString;
        cell.descriptionLabel.textColor = [UIColor redColor];
        cell.priorityLabel.text = [NSString stringWithFormat:@"%ld",completedItem.priorityNumber];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date = [dateFormatter stringFromDate:completedItem.deadline];
        cell.dueDateLabel.text = [NSString stringWithFormat:@"Deadline: %@", date];
    }
    if (indexPath.section==0) {
            ToDoItem *todoItem = self.todoItems[indexPath.row];
        cell.titleLabel.text = todoItem.title;
        cell.titleLabel.textColor = [UIColor blackColor];
        cell.descriptionLabel.text = todoItem.todoDescription;
        cell.descriptionLabel.textColor = [UIColor blackColor];
        cell.priorityLabel.text = [NSString stringWithFormat:@"%ld",todoItem.priorityNumber];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date = [dateFormatter stringFromDate:todoItem.deadline];
        cell.dueDateLabel.text = [NSString stringWithFormat:@"Deadline: %@", date];
    }
    
    return cell;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    ToDoItem *todoItem = self.todoItems[sourceIndexPath.row];
    [self.todoItems removeObjectAtIndex:sourceIndexPath.row];
    [self.todoItems insertObject:todoItem atIndex:destinationIndexPath.row];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.todoItems removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


@end
