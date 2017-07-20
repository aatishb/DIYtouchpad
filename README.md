# DIYtouchpad

![arduino circuit](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/DIYtouchpad.JPG)

This is a touchpad that you can build with low cost conductive materials (such as conductive paint) and an Arduino. It works using the principle of *voltage triangulation*. When you touch the conductive material, you create a new path to ground, and this lowers the voltage at the nearby voltage probes. Using this effect, we can triangulate the position of your cursor. We use Wekinator (a machine learning program that uses neural networks) to work out the mapping between the input voltages and cursor position.

## Parts

  * Arduino
  * 9 alligator clips
  * 9 jumper wires
  * Conductive material. In this demo, we uses paper painted with conductive paint, but the concept should work with many different conductive materials. [Here's](http://www.kobakant.at/DIY/?cat=24) a list of different materials you can experiment with. You'll need to choose a material with a fairly high resistance. 
  * Software: [Arduino IDE](https://www.arduino.cc/en/Main/Software), [Processing](https://processing.org/), [Wekinator](http://www.wekinator.org/)

## Instructions

1. Paint paper with an even coating of [conductive ink](https://www.bareconductive.com/shop/electric-paint-50ml/).

2. Assemble circuit.

   The conductive patch is hooked up to 6 voltage probes, a 5V voltage supply, and a ground. Make sure the alligator clips are making good contact with the paint. The second ground alligator clip (the one disconnected in the image) will be our cursor, using which we'll draw on the touchpad. Try to ensure that the different alligator clips or wire leads don't touch each other directly.

![fritzig diagram](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/DIYtouchpad.png)

3. Open the Arduino code in the [Arduino IDE](https://www.arduino.cc/en/Main/Software).

   Verify & upload the code to the Arduino.
   
   *If you get a 'problem uploading to board' error message, check that the port is correctly set to the Arduino (under Tools>Port). The exact port will be different depending on your computer set up, it might look something like this.*
   
   ![arduino port](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/arduinoport.png)

   To test input, open up the serial plotter (Tools>Serial Plotter). If it works, you should see something like the below graph when you move the cursor around the touchpad. 
   
   *If you don't see this, check that the dropdown menu is set to 250000 baud (this is the rate at which the Arduino is currently sending data over the serial port).*

   ![example data](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/exampledata.png)

   *Remember to close the serial plotter when done to free up the serial port.*

4. Open input Processing sketch (input_touchpad) using [Processing](https://processing.org/). 

   You'll need to install the oscP5 library. You can do this under the Tools menu. Search for oscP5 and install it.

   ![add library](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/importlibrary.png)

   Run the sketch. You may need to tell it which port the Arduino is connected to. To do this, look at the output of the sketch. You should see a list like this:
   
   ![choose port](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/whichport.png)
   
   Find the number corresponding to the port connected to your Arduino (on our computer this is 1). Then alter the following line of the Processing code to match your port number.
   
   ![which port](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/whichportnum.png)
    
   Now run the sketch. If it works, you should see the following image.

   ![input window](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/inputwindow.png)

   This sketch listens for serial messages from the Arduino and streams the 6 voltage values to Wekinator over OSC port 6448. OSC is a way to send messages from one program to another on your computer (or between computers, although we won't use that here).

5. Run output Processing sketch (output_cursor) using [Processing](https://processing.org/). If it works, you should see the following image.

   ![output window](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/outputwindow.png)

   This sketch listens for an X and Y position from Wekinator over OSC port 12000 and plots it on screen.

6. Download [Wekinator](http://www.wekinator.org/) and run it with the settings below. Hit Next to proceed.

   ![wekinator settings](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/wekinatorsettings.png)

   If it works, you should see the following screen.

   ![wekinator ready](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/wekinatorready.png)

7. Wekinator training.

   Use the sliders to choose a cursor position. The Processing sketch should update the virtual cursor position as you drag the sliders.

   Press the physical cursor (i.e. the spare alligator clip connected to ground) down on the touchpad at the corresponding position to the virtual cursor.

   With the physical cursor held to the touchpad, Press Start Recording, wait a couple of seconds, and then press Stop Recording.

   Repeat this process for a grid of 9-15 different calibration points. If you make a mistake, you can stop the recording, press 'Delete Last Recording', and repeat the last measurement.

   Once you're done with data collection, press Train. Depending on how much data you collected, Wekinator will take a few seconds to a minute to train a neural network on your calibration data.

   Once the training is complete, press Run. This makes Wekinator run as a bridge between your input and output sketch. It has 'learned' the mapping between your input and output using the calibration data, and the output Processing sketch should now display the position of your cursor in realtime.

8. Modify the Processing sketch to do something cool (e.g. make a drawing or a sound) or try another [example sketch](http://www.wekinator.org/examples/#Processing_animation_audio)

## Questions?

The DIY touchpad was built by [Aatish Bhatia](https://aatishb.com/) and [Sharon De La Cruz](http://unoseistres.com/) at the [StudioLab](cst.princeton.edu/studiolab). We were inspired by [Electrick](http://yang-zhang.me/research/Electrick/Electrick.html). The code is free to use and open source. If you have questions or you like what we're building, feel free to drop us a line!
