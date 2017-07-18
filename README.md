# DIYtouchpad

![arduino circuit](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/DIYtouchpad.JPG)

This is a touchpad that you can build with low cost conductive materials (such as conductive paint) and an Arduino. You'll also need some alligator clips and jumper wire (9 of each). It works using the principle of 'voltage triangulation'. When you touch the conductive material with a cursor connected to ground, you end up lowering the voltage at the nearby voltage probes. Using this effect, we can triangulate the position of the cursor. We use Wekinator (a neural network based machine learning program) to work out the mapping between the input voltages and cursor position.

## Instructions

1. Paint paper with [conductive ink](https://www.bareconductive.com/shop/electric-paint-50ml/).

2. Assemble circuit.

   The conductive patch is hooked up to 6 voltage probes, a 5V voltage supply, and a ground. Make sure the alligator clips are making good contact with the paint. The second ground alligator clip (the one disconnected in the image) will be our cursor, using which we'll draw on the touchpad.

![fritzig diagram](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/DIYtouchpad.png)

3. Open the Arduino code in the Arduno IDE.

   To test input, change the Serial communication rate from 1000000 to 250000, upload the code, and open up the serial plotter (under the Tools menu). If it works, you should see something like the below graph when you move the cursor around the touchpad.

   ![example data](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/exampledata.png)

   *Remember to change back to 1000000 when done and reupload.*

4. Run input processing sketch (input_touchpad) using Processing. If it works, you should see the following image.

   ![input window](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/inputwindow.png)

   This listens for serial messages from the Arduino and streams the 6 voltage values to Wekinator over OSC port 6448. OSC is a way to send messages from one program to another on your computer (or between computers, although we won't use that here).

5. Run output processing sketch (output_cursor) using Processing. If it works, you should see the following image.

   ![output window](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/outputwindow.png)

   This sketch listens for an X and Y position from Wekinator over OSC port 12000 and plots it on screen.

6. Download [Wekinator](wekinator.org) and run it with the settings below. Hit Next to proceed.

   ![wekinator settings](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/wekinatorsettings.png)

   If it works, you should see the following screen.

   ![wekinator ready](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/wekinatorready.png)

7. Run Wekinator training.

   Use the sliders to choose a cursor position.

   Press the physical cursor (i.e. the spare alligator clip connected to ground) down on the touchpad at the corresponding position.

   With the cursor held to the touchpad, Press Start Recording, collect 100-200 data points, and then press Stop Recording.

   Repeat this process for a grid of 9-15 calibration points. If you make a mistake, you can stop the recording, press 'Delete Last Recording', and repeat that measurement.

   Once you are done with data collection, press Train. Depending on how much data you have collected, Wekinator will take a few seconds to a minute to train a neural network using your calibration data.

   Wekinator is now trained and should be running as a bridge between your input and output sketch. Now that it has 'learned' the mapping between your input and output using the calibration data, it should show you the position of your cursor in realtime.

8. Modify the Processing sketch to do something cool (e.g. make a drawing or a sound) or try another [example sketch](http://www.wekinator.org/examples/#Processing_animation_audio)

## Questions?

The DIY touchpad was built by [Aatish Bhatia](https://aatishb.com/) and [Sharon De La Cruz](http://unoseistres.com/) at the [StudioLab](cst.princeton.edu/studiolab). We were inspired by [Electrick](http://yang-zhang.me/research/Electrick/Electrick.html). The code is free to use and open source. If you have questions or you like what we're building, feel free to drop us a line!
