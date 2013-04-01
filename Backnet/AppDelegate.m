//
//  AppDelegate.m
//  Backnet
//
//  Created by Edmond van der Plas on 16-03-13.
//  Copyright (c) 2013 Edmond van der Plas. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    }

- (IBAction)connect:(id)sender {
    NSLog(@"received a connect: message");
    
   // Check of het klikken van de knop Connect goed doorkomt
    
    NSString *ipField = self.ipField.stringValue;               // weergeven van het ip-adres server
    NSString *accountField = self.accountField.stringValue;      // weergeven van de accountnaam
    NSString *passwordField = self.passwordField.stringValue;   // weergeven van secure password
    NSString *entireURL = [NSString stringWithFormat:@"afp://%@:%@@%@", accountField, passwordField, ipField];
    
    NSString *shareField = @"/Users/Edge/Volumes/testdisk";               // Naam ingeven van share
    
    NSLog(@"Het ip-adres is %@. De accountnaam is %@. Password is %@", ipField, accountField, passwordField); //terugkoppeling van ip-adres en account in de debug weergave
    NSLog(@"Adres is afp://%@:%@@%@", accountField, passwordField, ipField); //terugkoppeling van ip-adres en account in de debug weergave
    
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath:@"/sbin/mount_afp"];     // opstarten van het commando mount_afp via NSTask
    
    NSArray *arguments;
        //Definieren van de argumenten die gebruikt moeten worden voor mount_afp
    arguments = [NSArray arrayWithObjects: entireURL, shareField, nil];
    [task setArguments: arguments];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    
    
}

- (IBAction)sync:(id)sender {
     NSLog(@"received a sync: message");

    NSString *bronMapField = self.bronMapField.stringValue;    // weergeven van de bron map
    NSString *doelMapField = self.doelMapField.stringValue;    // weergeven van de doel map
       
    NSLog(@"De bron is %@. Het doel is %@.", bronMapField, doelMapField); //terugkoppeling van de bron en doel map in de debug weergave
    
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath:@"/usr/bin/rsync"];    // opstarten van het commando Rsync via NSTask
    
    NSArray *arguments;
            //Definieren van de argumenten die gebruikt moeten worden voor Rsync
    arguments = [NSArray arrayWithObjects: @"-avun", @"--progress", bronMapField, doelMapField, nil];
    [task setArguments: arguments];
    
   // NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
   // [center addObserver:self
    //           selector:@selector(readPipe:)
    //               name:@"NSFileHandleReadCompletionNotification"
    //             object:nil];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];
    
    NSFileHandle *fileHandle = [pipe fileHandleForReading];
    [fileHandle readInBackgroundAndNotify];
    
   // -(void)readPipe: (NSNotification *)notification
   // {
   //     NSData *data;
    //    NSString *text;
   
   //     if( [notification object] != fileHandle )
    //        return;
    
   //     data = [[notification userInfo]
   //             objectForKey:NSFileHandleNotificationDataItem];
   //     text = [[NSString alloc] initWithData:data
   //                                  encoding:NSASCIIStringEncoding];
        
        // Do something with your text
        // ...
        
   //     [text release];
   //     if( _task )
   //         [fileHandle readInBackgroundAndNotify];
   // }

       
    [task launch];
     
    
    
    [task waitUntilExit];
    int status = [task terminationStatus];
    
    if (status == 1)
        NSLog(@"Task succeeded.");
    else
        NSLog(@"Task failed.");
    
}

- (IBAction)takeIPFrom:(id)sender {
    NSString *ipField = [_ipField stringValue];
    NSLog(@"%@",ipField);
    
    //checken of string input goed doorkomt
}

- (IBAction)takeAccountFrom:(id)sender {
    NSString *accountField = [_accountField stringValue];
    NSLog(@"%@",accountField);
    
    //checken of string input goed doorkomt
}

- (IBAction)takePasswordFrom:(id)sender {
    NSString *passwordField = [_passwordField stringValue];
    NSLog(@"%@",passwordField);
    
    //checken of string input goed doorkomt

}

- (IBAction)takeBronMapFrom:(id)sender {
    NSString *bronMapField = [_bronMapField stringValue];
    NSLog(@"%@",bronMapField);
    
    //checken of string input goed doorkomt
}

- (IBAction)takeDoelMapFrom:(id)sender {
    NSString *doelMapField = [_doelMapField stringValue];
    NSLog(@"%@",doelMapField);
    
    //checken of string input goed doorkomt
}

- (IBAction)disconnect:(id)sender {
    NSLog(@"received a disconnect: message");
    
    // Check of het klikken van de knop Disconnect goed doorkomt
    
    NSString *shareField = @"/Users/Edge/Volumes/testdisk";               // Naam ingeven van share
        
    NSLog(@"Disconnect van share %@", shareField); //terugkoppeling van disconnect
    
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath:@"/sbin/umount"];     // opstarten van het commando mount_afp via NSTask
    
    NSArray *arguments;
    //Definieren van de argumenten die gebruikt moeten worden voor mount_afp
    arguments = [NSArray arrayWithObjects: shareField, nil];
    [task setArguments: arguments];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];

    
}



@end
