//
//  TRMacInfo.m
//  NewTrade_Mall
//
//  Created by xph on 2024/9/12.
//

#import "TRMacInfo.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
@implementation TRMacInfo
+ (NSString *)getMacInfo
{
 
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
 
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
 
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        return NULL;
    }
 
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        return NULL;
    }
 
    if ((buf = malloc(len)) == NULL) {
        return NULL;
    }
 
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        return NULL;
    }
 
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];

    free(buf);
 
    return [outstring uppercaseString];
}
 
@end
