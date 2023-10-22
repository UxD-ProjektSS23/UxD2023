# UxD2023
## Description
This Software was created during a University Projekt on the topic of investigating of Spatial Influences on the User Experience.  

In this repositoy is all the custom software that was used during this study.  
The first Piece of software is an Android App that reads an classifies the movement a participant makes. The clasified movements are then send via Wi-Fi to the Server App which turn them into simulated Button presses. The Processing Sketch displays the game that was used for the study and processes the button presses to change the state of the game.
## Installation
Ihe "Exports" folder holds compiled files for the three software pieces of this Project that can be downloaded and executed.
### Android
Requires an Android Smartphone with an Accelerometer and Android Version 4.1 (Jelly Bean) or above. To connect with the Server an active Wi-Fi connection is needed.  
Install the Apk in the repository and make sure the App is allowed to use Wi-Fi and the needed Sensors.
### Server App
Requires any device with a Wi-Fi connection and a Java Runtime Environment.  
Download and run the Apk in the Repository.
### Processing
Requires a Windows Device.  
Download and run the Processing.exe file.
## Use
Start the Processing Sketch and the Server App on the Same Device and the Android App on an Android Smartphone. Make sure the server PC and the Android App are on the same Wi-Fi Network. Connect the Android App to the Server by entering the IP Adress in the Android App. If the connection is successfull movements of the Smartphone will trigger virtuall button presses on the server Pc. Now maximise the Processing Sketch to have it be controlled by the movement of the Smartphone.
## Limitations and known issues
Both the Android app and the server App can only connect to one devide at a time.  
temporarily losing connection can turn the Android App unresponsive until restart.  
The Processing sketch will not scale correctly if the heigth of the display is lager the width.  
