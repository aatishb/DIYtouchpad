# DIYtouchpad
![arduino circuit](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/DIYtouchpad.JPG)

1. Paint paper with [conductive ink](https://www.bareconductive.com/shop/electric-paint-50ml/)

2. Assemble circuit.

   The conductive patch is hooked up to 6 voltage probes, a 5V voltage supply, and a ground. The second ground alligator clip (the one disconnected in the image) will be our cursor, with which we'll draw on the touchpad. 

![fritzig diagram](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/DIYtouchpad.png)

3. Open the Arduino code in the Arduno IDE

   To test input, change the Serial communication rate from 1000000 to 250000, upload the code, and open up the serial plotter. If it works, you should see something like the below graph when you move the cursor around the touchpad.

   ![example data](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/exampledata.png)

   *Remember to change back to 1000000 when done and reupload.*

4. Run input processing sketch (input_touchpad) using Processing. If it works, you should see the following image.

   ![input window](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/inputwindow.png)

   This listens for serial messages from the Arduino and streams the 6 input values to Wekinator over OSC port 6448

   For the purposes of this demo, OSC is a way to send messages from one program to another on your computer

5. Run output processing sketch (output_cursor) using Processing.

   ![output window](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/outputwindow.png)

   This receives an X and Y position from Wekinator over OSC port 12000

6. Download Wekinator and run it with the settings below. Hit Next to proceed.

   ![wekinator settings](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/wekinatorsettings.png)

   You should get a screen that looks like this

   ![wekinator ready](https://raw.githubusercontent.com/aatishb/DIYtouchpad/master/images/wekinatorready.png)

7. Run Wekinator training

   Use the sliders to choose a cursor position

   Press the physical cursor down on the touchpad at the corresponding position

   With the cursor held to the touchpad, Press Start Recording, collect 100-200 data points, and then press Stop Recording

   Repeat this process for a grid of 9-15 calibration points. If you make a mistake, you can stop the recording and press delete last recording, and repeat that measurement.

   Once you are done with data collection, press Train. Depending on how much data you have collected, Wekinator will take a few seconds to a minute to train a neural network using your calibration data.

   Press Train

   Wekinator is now trained and should be running as a bridge between your input and output sketch. Now that it has learned the mapping between your input and output using the calibration data, it should be able to show you the position of your cursor in realtime.
