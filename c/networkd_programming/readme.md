ip address => street address of a hotel and port number is room number
networkd byte order / host byte order

Function 	Description
htons() 	host to network short
htonl() 	host to network long
ntohs() 	network to host short
ntohl() 	network to host long

a socket descripter: int

struct addrinfo {
    int     ai_flags;    //AI_PASSIVE, AI_CANONNAME, 
    int     ai_family;   //AF_INET, AF_INET6, AF_UNSPEC
    int     ai_socktype; //SOCKET_STREAM, SOCK_DRAM
    int     ai_protocol; //use 0 for "any"
    size_t  ai_addrlen;  //size of ai_addr in bytes
    struct  sockaddr *ai_addr; //struct sockaddr_in or _in6
    char    *ai_canonname; //full canonnical hostname
    
    struct addrinfo *ai_next; // linked list, next node
}
struct sockaddr {
    unsigned short    sa_family; // address family, AF_XXX
    char              sa_data[14]; // 14 bytes of protocol address
}

// (IPv4 only--see struct sockaddr_in6 for IPv6)

struct sockaddr_in {
    short int          sin_family;  // Address family, AF_INET
    unsigned short int sin_port;    // Port number
    struct in_addr     sin_addr;    // Internet address
    unsigned char      sin_zero[8]; // Same size as struct sockaddr
};


// (IPv4 only--see struct in6_addr for IPv6)

// Internet address (a structure for historical reasons)
struct in_addr {
    uint32_t s_addr; // that's a 32-bit int (4 bytes)
};

// IPv4:

char ip4[INET_ADDRSTRLEN];  // space to hold the IPv4 string
struct sockaddr_in sa;      // pretend this is loaded with something

inet_ntop(AF_INET, &(sa.sin_addr), ip4, INET_ADDRSTRLEN);

printf("The IPv4 address is: %s\n", ip4);


// IPv6:

char ip6[INET6_ADDRSTRLEN]; // space to hold the IPv6 string
struct sockaddr_in6 sa6;    // pretend this is loaded with something

inet_ntop(AF_INET6, &(sa6.sin6_addr), ip6, INET6_ADDRSTRLEN);

printf("The address is: %s\n", ip6);
