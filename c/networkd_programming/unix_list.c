#include <sys/socket.h>
#include <netdb.h>
#include <ifaddrs.h>
#include <stdio.h>
#include <stdlib.h>

/*
     Ask the operating system for every network interface
     and print all IPv4 and IPv6 addresses.
     Ethernet, wifi, VPN, Docker, Virtual Box
*/

int main() {
    struct ifaddrs *addresses;
    /*
     * addresses: pointer to the struct (ifaddrs[which is na linked list]) 
     */

    if (getifaddrs(&addresses)  == -1) {
        printf("getifaddrs call falied\n");
        return -1;
    }


    printf("+----------------------+---------+--------------------------------------------------------------+\n");
    printf("| Interface            | Protocol| Address                                                      |\n");
    printf("+----------------------+---------+--------------------------------------------------------------+\n");

    struct ifaddrs *address = addresses; 
    while(address) {
        // skip node without addresses
        if (address->ifa_addr == NULL){
            address = address->ifa_next;
            continue;
        }

        int family = address->ifa_addr->sa_family;
        if (family == AF_INET || family == AF_INET6) {

            // printf("Interface : %s\n", address->ifa_name);
            // printf("Protocol  : %s\n", family == AF_INET ? "IPv4" : "IPv6");
            char ap[100];

            const int family_size = family == AF_INET ?
                sizeof(struct sockaddr_in) : sizeof(struct sockaddr_in6);

            getnameinfo(address->ifa_addr, family_size, ap, sizeof(ap), 0, 0,NI_NUMERICHOST);
            // printf("Address   : %s\n", ap);
            // printf("----------------------------\n");

            printf("| %-20s | %-7s | %-60s |\n",
                    address->ifa_name,
                    family == AF_INET ? "IPv4" : "IPv6",
                    ap
            );
        }

        address = address->ifa_next;
    }
    printf("+----------------------+---------+--------------------------------------------------------------+\n");

    freeifaddrs(addresses);
    return 0;
}


