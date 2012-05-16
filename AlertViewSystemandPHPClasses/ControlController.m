//
//  ControlController.m
//  AlertViewSystemandPHPClasses
//
//  Created by Robert DeNicola on 5/16/12.
//  Copyright (c) 2012 Developmental Applications. All rights reserved.
//

#import "ControlController.h"

@implementation ControlController


@synthesize currentSession;
@synthesize txtMessage;
@synthesize connect;
@synthesize disconnect;


GKPeerPickerController *picker;
//The GKPeerPickerController class provides a standard UI to let your application discover and connect to another Bluetooth device. This is the easiest way to connect to another Bluetooth device.

//To discover and connect to another Bluetooth device, implement the btnConnect: method as follows:


-(IBAction) btnConnect:(id) sender {
    picker = [[GKPeerPickerController alloc] init];
    picker.delegate = self;
    picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
    [connect setHidden:YES];
    [disconnect setHidden:NO];
    [picker show];
}


- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker
{
    picker.delegate = nil;
   // [picker autorelease];
    [connect setHidden:NO];
    [disconnect setHidden:YES];
}


-(IBAction) btnDisconnect:(id) sender {
    [self.currentSession disconnectFromAllPeers];
//    [self.currentSession release];
    currentSession = nil;
    [connect setHidden:NO];
    [disconnect setHidden:YES];
}
//When a device is connected or disconnected, the session:peer:didChangeState: method will be called. Implement the method as follows:


- (void)session:(GKSession *)session
           peer:(NSString *)peerID
 didChangeState:(GKPeerConnectionState)state {
    switch (state)
    {
        case GKPeerStateConnected:
            NSLog(@"connected");
            break;
        case GKPeerStateDisconnected:
            NSLog(@"disconnected");
            //[self.currentSession release];
            currentSession = nil;
            [connect setHidden:NO];
            [disconnect setHidden:YES];
            break;
    }
}


- (void) mySendDataToPeers:(NSData *) data
{
    if (currentSession)
        [self.currentSession sendDataToAllPeers:data
                                   withDataMode:GKSendDataReliable
                                          error:nil];
}
//Define the btnSend: method as follows so that the text entered by the user will be sent to the remote device:


-(IBAction) btnSend:(id) sender
{
    //---convert an NSString object to NSData---
    NSData* data;
    NSString *str = [NSString stringWithString:txtMessage.text];
    data = [str dataUsingEncoding: NSASCIIStringEncoding];
    [self mySendDataToPeers:data];
}

- (void) receiveData:(NSData *)data
            fromPeer:(NSString *)peer
           inSession:(GKSession *)session
             context:(void *)context {
    //---convert the NSData to NSString---
    NSString* str;
    str = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Data received"
                                                    message:str
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    //[alert release];
}
//Here, the received data is in t

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
