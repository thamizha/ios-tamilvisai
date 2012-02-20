//
//  EditorViewController.h
//  VisaiDemo
//
//  Created by Kishore Kumar on 20/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditorViewController : UIViewController{
    NSString *selectedLang;
    IBOutlet UITextView *textView;
}

@property (nonatomic, strong) NSString *selectedLang;;
@property (nonatomic, strong) UITextView *textView;;

@end
