# UNIT 3: Local Area Networks, LANs

#### 3.1 Diferences with WANs

WANs: **Huge** networks created normally by ISPs to **conect all the internet**.

LANs: "**Little**" networks created normally by enterprises or private owners to help them use and **conect to internet in all the devices** that they want. **LANs need MAC protocols in order to work**.

#### 3.2 MACs

Normally macs are ssigned **randomly**, like for example in Ethernet (**CSMA/CD**):

- **CSMA/CD**: Basically is a random MAC protocol in wich the nodes "hear" the traffic to know if someone is transmitting in that moment in order to decide if they can transmit or if they cannot.

CSMA/CD is **only used in half duplex ethernet**, **not in full duplex** because there **cannot occur collisions**.

#### 3.3 Ethernet Frames

They are pretty similar to the IP frames. Some important parts are:

- Destination and source macs: 6 bytes each.

- Frame type: 2 bytes that describe the protocol of the Payload they carry.

#### 3.4 Hubs and Switches

**HUB**: A hub is just a multiport ethernet signal repeater, when they recieve a frame they resend it by all the ports.

**SWITCH**: A switch is a layer 2 device that **exchanges frames between its ports** reading the origen and destination MACS. To know which port corresponds with a MAC has some **MAC tables that by default are filled automatically**. Every port is in a different segment so are in different collision domains (there are no collisions).

##### 3.4.1 MAC table filling

All the switch ports are waiting in promiscuous mode (they accept all inputs), and once an input arrives they **read the origin mac of that frame** and **assign that mac to the port where the frame has come from in the mac tables**.

If the **destination address** is not found in the mac tables then **flooding** is used. Flooding basically sends a request through all the ports of the switch.

##### 3.4.2 Broadcast and Collision Domains

- **Broadcast Domain**: Set of stations that will received a broadcast frame sent by any of them.

- **Routers segment broadcast domains**. **Switches don't segment them** unless VLANs are used.

- This is important for ARP

##### 3.4.3 Flow Control

**Flow control**: Consist in adapting the rate at which the switch receives the frames, and the rate at which the switch can send them. To implement it there are two techiniques:

- **Jabber signal**: Used in **half-duplex**, the switch sends a signal to the port that need to be throttled down.

- **Pause frames**: Uesed in **full-duplex**, the switch sends a signal indicating the number of slot-times that it has to remain silent.

**Spanning Tree Protocol (STP)**: Is used to prevent having unwanted loops in the net.

##### 3.4.4 VLANs

**VLANs** separate in **different broadcast domains** the ports of a switch that belong to different VLANs. A router is needed to send traffic to a different VLAN.

**VLAN Trunking**: If port is needed to **exchange packets of different VLANS** (normally the one that is connected to the router) it has to be configured in **trunk mode**.

#### 3.5 Wireless LANs

Wire LANs are self explanatory, consist of two main devices:

- **Distribution System (DS)**: Used by AP to exchange information using wires.

- **Acces Point (AP)**: Are the *brideges* that connect devices, may have a router inside.

The main protocol for detecting collisions is **CSMA/CA**, taht it's only difference with **CSMA/CD** is that it **waits a random time** before the ACKs detect if the transmitted frame collided.

Wireless frames can contain **up to 4 adresses**.

There is also **RTS** protocol to solve the hidden node problem.

# UNIT 4: The Internet Transport Layer, TCP

##### 4.1 UDP vs TCP

| TCP                                 | UDP                                 |
|:-----------------------------------:|:-----------------------------------:|
| Used in transport layer             | Used in transport layer             |
| **Reliable Service**                | **Datagram Service (non reliable)** |
| Communication channerl between apps | Communication channerl between apps |
| 16 bit port numbers                 | 16 bit port numbers                 |
| Uses the client/server paradigm     | Uses the client/server paradigm     |

> UDP is normally only used in **Real Time Applications** such as: Voice over IP, videoconferencing and audio/video stream.

##### 4.2 TCP Protocol

- **Congestion control**: Adapt the TCP throughput to network conditions.

- **Segments of optimal size**: Variable Maximum Segment Size (**MSS**)

- **Window = min(awnd, cwnd)**
  
  - **Advertised window (awnd)**: Is the spare space in the buffers.
  
  - **Congestion window (cwnd)**: Is the guessed maximum spare space of the bottleneck node in the network.

- **Delayed ack**: The ack's are sended every 2 MSS (if packets in order, else ack each1)

- **Window Scale Factor**: The awnd is multiplied by $2^{Window\ Scale}$

- $V=\cfrac{W}{RTT}$
