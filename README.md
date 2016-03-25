# kraudesorce
Goals
-----
For our midterm MVP, we proposed that we would build a simple iOS app.

>  - An app that would use location services to find the users current location. 
>  - If the user was detected to be inside Holmes Lounge, the screen would turn green.

We have successfully built this goal and have started working towards our end of semester MVP.

Technology stack
----

 - iOS app - Built using Objective C
 - Firebase - Backend server
 - Nmap - A command line tool used to interact with the network that you are currently connected to

Features
-----

**iOS App**

 - User authentication (Registration and Login)
 - Get's user's current location
 - Compares user's location with GPS coordinates of Holmes Lounge (client side)
 - Sends data to server if user is inside Holmes Lounge

**Firebase Server**

 - User authentication (with client)
	 - Encrypted user IDs and passwords
 - JSON style storage of locations, user counts and user profiles
 - Successfully receives data from client in real time

**Nmap Script**

 - Bash script to automatically get wifi hosts data
	 - Pulls current network data using ifconfig
	 - Reformats IP address to a Nmap compatible format
	 - Calls Nmap and exports data to an XML file
	 - Parse XML file to get number of currently connected devices
 - JS Script to communicate with Firebase
	 - Can send current hosts data
	 - Can pull current user data from server
 

Screenshots
----

![KraudeSorce app icon on the home screen ](http://i.imgur.com/ozNrxl1.png) ![Login Screen](http://i.imgur.com/2THxji3.png)

KraudeSorce app on the home screen and the app's login screen

![User not in Holmes Lounge](http://i.imgur.com/urBmVRX.png) ![Firebase Server](http://i.imgur.com/AGOYPmh.png)

App when user is not Holmes Lounge

![User not in Holmes Lounge](http://i.imgur.com/6ML8Yv1.png) ![Firebase server](http://i.imgur.com/ZmHwwEa.png)

App when user is in Holmes Lounge
<p align="center">
	<img alt="nmap example output" src="http://i.imgur.com/IpyGTd7.png">
</p>
Nap example output
<p align="center">
	<img alt="nmap sample output" src="http://i.imgur.com/xIjsbnM.png">
</p>
Nmap hostCount sample output 