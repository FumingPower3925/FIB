# TEMA 1

## 1.1 Networks: Historical Perspective

**OSI**: Open Systems Interconnection, proposed by ISO+CCITT

**ISO**: International Organization for Standardization

**CCITT**: Comité Consultivo Internacional Telegráfico y Telefónico

-- FIGURE 1

## 1.2 C/S Model

- Client: 
  
  - Usually in the user machine. 
  
  - Convert local calls to remote ones.
  
  -     Receive results and give them to the user.

- Server:
  
  - Usually in a different machine from client's one.
  
  - Solve operations invoked by user.
  
  - Returns operation results

## 1.3 Distributed Application

**Definition**: An application made up of distinct components running in separate runtime environments, usually on different platforms connected via a network.

- Two-tier: Client-Server

- Three-tier: Client-Middleware-Server

- Multitier: Client-Multiple Middleware-Multiple Servers

## 1.4 Operation and method remote invocation

- RPC - Remote Procedure Call
  
  - Procedure call made remotely
  
  - Definition of remote procedure data types and interfaces
  
  - **RPCGEN**: Program used to create stubs and skeletons in RPC, it uses as input a eXternal Data Representation (**XDR**)
  
  - C Linux

        -- FIGURE 2

- RMI - Remote Method Invocation
  
  - Similar to RPC
  
  - Implemented in JAVA
  
  - Object Oriented
  
  - Remot Object Method Invocation
    
     -- Figure 3
    
    - Basic type: By value
    
    - Object Implementing **Remote** interface. References object like a local one
      
      - Object does not move from the "remote" JVM.
    
    -- Figure 4
    
    - Object implementing **Serializable** interface. Transformed in bytes and sent
      
      - Object sent to the client, local execution in client
    
    -- Figure 5

- CORBA - Common Object Request Broker Architecture
  
  - Defined bt Object Management Group (OMG)
  
  - Defines an architecture that allows connecting objects written in different programming languages.
  
  - Communication is done in binary.

## 1.5 Sockets

- Sockets
  
  - Mechanism for sending remote information at TCP and UDP level.
  
  - Two socket types
    
    - Stream for TCP
    
    - Datagram for UDP
  
  - Lower level where communication can be done.

## 1.6 HTTP (HyperText Transfer Protocol)

- Works over TCP (stream sockets) (Up to HTTP 2.0)

- Application level protocol for distributed systems

- Supports different types of information

**FEATURES**

- Stateless protocol

- Request / Reply

- External mechanisms for state control
  
  - Cookies
  
  - Sessions

- Port 80 by default

- If **Keep-Alive** is not used the connection is closed immediately.

**EVOLUTION**

- 0.9 version: Byte Strips Without Format

- 1.0 version: Formatted Messages

- 1.1 version: New Features (Connection persistence, proxies, data cahce...)

- Version 2: Common semantics, change in data sending.

- Version 3: HTTP over **QUIC** protocol (UDP)

**HTTP REQUEST**

-- Figure 6

**HTTP REPLY**

-- Figure 7

HTTP Methods

- No modification
  
  - **GET**: Requests the specified resource. May pass parameters.
  
  - HEAD: Reponse identical to GET without the body.
  
  - TRACE: Echoes back the received request.
  
  - OPTIONS: Returns the HTTP methods that the server supports.

- Modification
  
  - **POST**: Submits data to be processed: Update, Creation.
  
  - PUT: Uploads the specified resource: Creation.
  
  - PATCH: Applies partial modifications to the resource: Update.
  
  - DELETE: Deletes the specified resource.

**HTTP GET REQUEST EXAMPLE**

-- Figure 8

**HTTP GET RESPONSE EXAMPLE**

-- Figure 9

## 1.6.1 HTTP 2

- Based on SPDY

- Methods, state codes and semantics are the same as HTTP/1.1

- Changes the way of sending data

- Appears the Frame Concept

- Data is sent in binary format

- Performance improvement is pursued

- Allows the server to send responses to the client (Server push) without request

## 1.7 MIME (Multipurpose Internet Mail Extensions)

- It's used to send contents for multiple formats not only in mail.

**MIME FORMAT**

-- Figure 10

## 1.8 HTML (HyperText Markup Language)

- Defined by **W3C**

- Based on tags

- Define the document logical structure, no tthe display
  
  - Javascript: Add scripting capabilities in the client
  
  - CSS (Cascade Style Sheets): Style sheets
  
  - HTML5: 
    
    - Still under constgruction.
    
    - Beowsers support some of its new features.

## 1.9 XML

- XML (eXtensible Markup Language):

- Designed to transport and store data. To process it automatiacally.

- Users must define their own tags.
  
  - Private usrers and SDO (Standards Developing Organitzations)

**Structure & Syntax**

- Tree Structure

- Elements, attributes & text

-- Figure 11

**Other Issues**

- Name conflicts:
  
  - Namespaces: Differentiate element names defined in different places.
  
  - Defined with xmlns attribute:
    
    - xmlns:prefix = "URI"

**Validity**

- "**well-formed**" CML document:
  
  - Document taht satisfies XML syntax rules.

- "**valid**" XML document:
  
  - Well-formed document that also conforms to some rules specified in a restrictions document (DTD or Schema)

- Two ways of defining restrictions/rules formXML:
  
  -- Figure 12
  
  DTD (Document Type Definition):
  
  - 1st generation: based on SGML
  
  - Simple but limited
  
  -- Figure 13
  
  XML Schema:
  
  - Higher expressiveness, but very complex
  
  -- Figure 14
  
  XML Schema & Namespaces:
  
  -- Figure 15

# TEMA 2

## 2.1 Web Services

- 2 approaches
  
  - SOAP: Simple Object Access Protocol
  
  - REST: REpresentational State Transfer

- Features:
  
  - Independen from platform and programming language
  
  - Work over HTTP(s)
  
  - They can be freely used to pass through firewalls
  
  - Do no provide: security, session, management, QoS

- Derived from RPC

- Calls to remote methods through web using XML as data interchange language

### 2.1.1 Protocols and formats stack

- WSDL: Universal Description, Dicovery & Integration (UDDI)
  
  - Not used anymore

- XML: Simple Object Access Protocol (SOAP)

- HTTP

- TCP/IP

## 2.2 RMI with SOAP

-- Figure 16

-- Figure 17

## 2.3 WSDL

-- Figure 18

-- Figure 19

-- Figure 20

-- Figure 21

### 2.3.1 WSDL Styles

-- Figure 22

## 2.4 HTTP SOAP

- Request
  
  -- Figure 23

- Response

-- Figure 24

**SOAP ANALYSIS**

- Advantages
  
  - Several Transport protocols can be used
    
    - Mainly is used HTTP, but SMTP is also possible

- Disadvantages
  
  - Binding by default SOAP + HTTP
    
    - Sends a lot of information = Slow
  
  - Not a problem for small messages
  
  - Binary objects: Other mechanisms
    
    - Message Transmission Optimization Mechanism (MTOM)
    
    - XML-binary Optimized Packaging (XOP)

## 2.5 SOAP + MTOM + XOP

-- Figure 25

## 2.6 REST: REpresentational State Transfer

- Simplified distributed Applications Architecture

- Uses http methods to implement operations
  
  - No specific operations or methods are defined

- Not a standard, although it is based on them

**REST REQUEST EXAMPLE**

-- Figure 26

**REST RESPONSE EXAMPLE**

-- Figure 27

### 2.6.1 CRUD operations with REST

- Create
  
  - HTTP PUT method (if exists, it is updated)

- Read
  
  - HTTP GET method

- Update
  
  - HTTP PATCH method

- Delete
  
  - HTTP DELETE method

- POST is an alternative for each method

### 2.6.2 REST components

- REST is stateless

- Resources can be cached, idicating when they expire

- URL's identify resources
  
  - Universally accesible
  
  - Resources are key for a correct REST design

- Resource network
  
  - Not complex resources
  
  - Links to get extra info

## 2.7 Mobile

- JavaME (Java **Micro** Edition)
  
  - App development for different mobile devices
  
  - Limited capabilites

# TEMA 3

- MPEGs: + temporal compression; I-frames, P-frames, B-frames

- AOM -- AV1

- MPEG creates multimedia and monomedia standrads.

- La fase principal en el ciclo de vida de un contenido es el processing.

- ITU-T: letters + numbers

- ISO/IEC: numbers


