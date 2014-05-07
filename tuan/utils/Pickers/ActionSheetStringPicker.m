//
//Copyright (c) 2011, Tim Cinel
//All rights reserved.
//
//Redistribution and use in source and binary forms, with or without
//modification, are permitted provided that the following conditions are met:
//* Redistributions of source code must retain the above copyright
//notice, this list of conditions and the following disclaimer.
//* Redistributions in binary form must reproduce the above copyright
//notice, this list of conditions and the following disclaimer in the
//documentation and/or other materials provided with the distribution.
//* Neither the name of the <organization> nor the
//names of its contributors may be used to endorse or promote products
//derived from this software without specific prior written permission.
//
//THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
//DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//åLOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "ActionSheetStringPicker.h"
#import "Category.h"

@interface ActionSheetStringPicker()
@property (nonatomic,retain) NSArray *data;
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,assign) NSInteger selectedComp;
@property (nonatomic,assign) NSInteger rowinone;
@property (nonatomic,assign) NSInteger rowintwo;
@property (nonatomic,strong) NSString *mtitle;

@end

@implementation ActionSheetStringPicker
@synthesize data = _data;
@synthesize selectedIndex = _selectedIndex;
@synthesize selectedComp = _selectedComp;
@synthesize onActionSheetDone = _onActionSheetDone;
@synthesize onActionSheetCancel = _onActionSheetCancel;

+ (id)showPickerWithTitle:(NSString *)title rows:(NSArray *)strings initialSelectionRow:(NSInteger)index initialSelectionComp:(NSInteger)comp doneBlock:(ActionStringDoneBlock)doneBlock cancelBlock:(ActionStringCancelBlock)cancelBlockOrNil origin:(id)origin {
    
    ActionSheetStringPicker * picker = [[ActionSheetStringPicker alloc] initWithTitle:title rows:strings initialSelectionRow:index initialSelectionComp:comp doneBlock:doneBlock cancelBlock:cancelBlockOrNil origin:origin];
    [picker showActionSheetPicker];
    return [picker autorelease];
}

- (id)initWithTitle:(NSString *)title rows:(NSArray *)strings initialSelectionRow:(NSInteger)index initialSelectionComp:(NSInteger)comp doneBlock:(ActionStringDoneBlock)doneBlock cancelBlock:(ActionStringCancelBlock)cancelBlockOrNil origin:(id)origin {
    self = [self initWithTitle:title rows:strings initialSelectionRow:index initialSelectionComp:comp target:nil successAction:nil cancelAction:nil origin:origin];
    self.mtitle = title;
    if (self) {
        self.onActionSheetDone = doneBlock;
        self.onActionSheetCancel = cancelBlockOrNil;
    }
    return self;
}

+ (id)showPickerWithTitle:(NSString *)title rows:(NSArray *)data initialSelectionRow:(NSInteger)index initialSelectionComp:(NSInteger)comp target:(id)target successAction:(SEL)successAction cancelAction:(SEL)cancelActionOrNil origin:(id)origin {
    ActionSheetStringPicker *picker = [[[ActionSheetStringPicker alloc] initWithTitle:title rows:data initialSelectionRow:index initialSelectionComp:comp target:target successAction:successAction cancelAction:cancelActionOrNil origin:origin] autorelease];
    [picker showActionSheetPicker];
    return picker;
}

- (id)initWithTitle:(NSString *)title rows:(NSArray *)data initialSelectionRow:(NSInteger)index initialSelectionComp:(NSInteger)comp target:(id)target successAction:(SEL)successAction cancelAction:(SEL)cancelActionOrNil origin:(id)origin {
    self = [self initWithTarget:target successAction:successAction cancelAction:cancelActionOrNil origin:origin];
    if (self) {
        self.data = data;
        self.selectedIndex = index;
        self.selectedComp = comp;
        self.title = title;
    }
    return self;
}

- (void)dealloc {
    self.data = nil;
    
    Block_release(_onActionSheetDone);
    Block_release(_onActionSheetCancel);
    
    [super dealloc];
}

- (UIView *)configuredPickerView {
    if (!self.data)
        return nil;
    CGRect pickerFrame = CGRectMake(0, 40, self.viewSize.width, 216);
    UIPickerView *stringPicker = [[[UIPickerView alloc] initWithFrame:pickerFrame] autorelease];
    stringPicker.delegate = self;
    stringPicker.dataSource = self;
    stringPicker.showsSelectionIndicator = YES;
    [stringPicker selectRow:self.selectedIndex inComponent:self.selectedComp animated:NO];
    
    //need to keep a reference to the picker so we can clear the DataSource / Delegate when dismissing
    self.pickerView = stringPicker;
    
    return stringPicker;
}

- (void)notifyTarget:(id)target didSucceedWithAction:(SEL)successAction origin:(id)origin {
    if (self.onActionSheetDone) {
        Category *cat = [self.data objectAtIndex:self.rowinone];
        
        if (cat.hasChild) {
            Category *childcat = [cat.childCategoryList objectAtIndex:self.rowintwo];
            _onActionSheetDone(self, self.selectedIndex, childcat);
            return;
        }else
        {
        
            _onActionSheetDone(self, self.selectedIndex,cat);
            return;
        }
        
       
    }
    else if (target && [target respondsToSelector:successAction]) {
        [target performSelector:successAction withObject:[NSNumber numberWithInt:self.selectedIndex] withObject:origin];
        return;
    }
    
    // NSLog(@"Invalid target/action ( %s / %s ) combination used for ActionSheetPicker", object_getClassName(target), (char *)successAction);
    
}

- (void)notifyTarget:(id)target didCancelWithAction:(SEL)cancelAction origin:(id)origin {
    if (self.onActionSheetCancel) {
        _onActionSheetCancel(self);
        return;
    }
    else if (target && cancelAction && [target respondsToSelector:cancelAction])
        [target performSelector:cancelAction withObject:origin];
}

#pragma mark - UIPickerViewDelegate / DataSource

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.selectedIndex = row;
    self.selectedComp = component;
    
    
    
    if (component==0) {
        
        [pickerView selectRow:0 inComponent:1 animated:NO];
        [pickerView reloadComponent:1];
        
    }
    if (component==1) {
        
    }
    
    self.rowinone = [pickerView selectedRowInComponent:0];
    self.rowintwo = [pickerView selectedRowInComponent:1];
    
   // NSLog(@"selected option:%d,%d",[pickerView selectedRowInComponent:0],[pickerView selectedRowInComponent:1]);
    
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component==0) {
        return self.data.count;
    }
    if (component==1) {
        
        Category *catcomp = [self.data objectAtIndex:self.selectedIndex];
        return [catcomp.childCategoryList count];
        
        
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
   // NSLog(@"title cord  comp:%d,%d",row,component);
    
    
    if (component==0) {
        Category *cat1 = [self.data objectAtIndex:row];
        NSString *str = nil ;
        
        if ([self.mtitle isEqualToString:@"选择分类"]) {
            str = [cat1.name stringByAppendingFormat:@"（%d）",cat1.count];
        }else
        {
            str=cat1.name;
        }
        return str;
    }
    if (component==1) {
        
        Category *catcomp = [self.data objectAtIndex:self.rowinone];
        
        if (catcomp.hasChild) {
            Category *childcat = [catcomp.childCategoryList objectAtIndex:row];
            
            NSString *str = nil;
            if ([self.mtitle isEqualToString:@"选择分类"]) {
                str = [childcat.name stringByAppendingFormat:@"（%d）",childcat.count];
            }else
            {
                str=childcat.name;
            }
            
            return str;
        }
       //  return @"tester";
        
}
    return nil;
}
//
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//
//    UIView *pv = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 20.0f)];
//    pv.backgroundColor  = [UIColor redColor];
//    return pv;
//
//}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return pickerView.frame.size.width/2;
}

#pragma mark - Block setters

// NOTE: Sometimes see crashes when relying on just the copy property. Using Block_copy ensures correct behavior

- (void)setOnActionSheetDone:(ActionStringDoneBlock)onActionSheetDone {
    if (_onActionSheetDone) {
        Block_release(_onActionSheetDone);
        _onActionSheetDone = nil;
    }
    _onActionSheetDone = Block_copy(onActionSheetDone);
}

- (void)setOnActionSheetCancel:(ActionStringCancelBlock)onActionSheetCancel {
    if (_onActionSheetCancel) {
        Block_release(_onActionSheetCancel);
        _onActionSheetCancel = nil;
    }
    _onActionSheetCancel = Block_copy(onActionSheetCancel);
}

@end