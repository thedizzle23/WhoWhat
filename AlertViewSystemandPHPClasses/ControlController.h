//
//  ControlController.h
//  AlertViewSystemandPHPClasses
//
//  Created by Robert DeNicola on 5/16/12.
//  Copyright (c) 2012 Developmental Applications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface ControlController : UIViewController  {
    
    
    GKSession *currentSession;
    IBOutlet UITextField *txtMessage;
    IBOutlet UIButton *connect;
    IBOutlet UIButton *disconnect;
    
    
    
}

@property (nonatomic, retain) GKSession *currentSession;
@property (nonatomic, retain) UITextField *txtMessage;
@property (nonatomic, retain) UIButton *connect;
@property (nonatomic, retain) UIButton *disconnect;
-(IBAction) btnSend:(id) sender;
-(IBAction) btnConnect:(id) sender;
-(IBAction) btnDisconnect:(id) sender;

@end
