#if defined(_WIN32)
#ifndef _WIN32_WINNT
#define _WIN32_WINNT 0x0600
#endif
#include <winsock2.h>
#include <ws2tcpip.h>
#pragma comment(lib, "ws2_32.lib")

#else 
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <unistd.h>
#include <error.h>

/*
    sys/socket.h  (sockeet creation)
        socket(), connect(), bind(), listen(), accept(), 

    netinet/in.h (internet address structure)
        sockaddr_in, sockeaddr_in6, AF_INET, AF_INET6
        
    arpa/inet.h (IP conversion)
        inet_pton(), inet_ntop() 
        eg: 192.168.1.10 ----->  binary ip address

    netdb.h (DNS)
        getaddrinfo(), getnameinfo()
        eg:  google.com ----->  142.250.195.14

    unistd.h (close socket)
        close() 
        eg: close(socket);
*/

#endif


#include <stdio.h>


int main() {
#if defined(_WIN32)
    WSADATA d;
    if (WSAStartup(MAKEWORD(2,2), &d)) {
        fprintf(stderr , "Failed to initialize.\n");
        return 1;
    }
#endif

    printf("Ready to use socket API.\n");

#if defined (_WIN32)
    WSACleanup();
#endif
    return 0;
}
