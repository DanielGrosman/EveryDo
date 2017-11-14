//
//  AddItemViewController.h
//  EveryDo
//
//  Created by Daniel Grosman on 2017-11-14.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"

@protocol AddNewViewControllerDelegate <NSObject>

- (void)addNew:(ToDoItem *)newToDo;

@end

@interface AddItemViewController : UIViewController
@property (nonatomic, weak) id<AddNewViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextField *descTextField;
@property (strong, nonatomic) IBOutlet UITextField *priorityTextField;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;

@end
