//
//  AddItemViewController.m
//  EveryDo
//
//  Created by Daniel Grosman on 2017-11-14.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)doneButtonWasTapped:(id)sender {
    ToDoItem *newToDo = [[ToDoItem alloc] initWithTitle:self.titleTextField.text todoDescription:self.descTextField.text priorityNumber:[self.priorityTextField.text intValue] deadline:nil isCompleted:NO];
    [self.delegate addNew:newToDo];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
