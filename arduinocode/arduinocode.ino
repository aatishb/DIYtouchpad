
int sensorValue;
float avg0_filter = 0;
float avg1_filter = 0;
float avg2_filter = 0;
float avg3_filter = 0;
float avg4_filter = 0;
float avg5_filter = 0;

// smoothing parameter. 0 = no smoothing, 0.99 = max smoothing. 0.5 = default.
// a higher smoothing will smooth out high frequency jitters in the data
// but will also lead to a slower respone
float smooth = 0.5;

void setup()
{
  Serial.begin(250000); 
}

void loop()
{

  float avg0 = 0;
  float avg1 = 0;
  float avg2 = 0;
  float avg3 = 0;
  float avg4 = 0;
  float avg5 = 0;
  
  for(int i=0; i<10; i++){

    // read the input on analog pins:
    
    sensorValue = analogRead(A0);
    avg0 += sensorValue;

    sensorValue = analogRead(A1);
    avg1 += sensorValue;

    sensorValue = analogRead(A2);
    avg2 += sensorValue;

    sensorValue = analogRead(A3);
    avg3 += sensorValue;

    sensorValue = analogRead(A4);
    avg4 += sensorValue;

    sensorValue = analogRead(A5);
    avg5 += sensorValue;

  }
  
  avg0 = avg0/10.0;
  avg1 = avg1/10.0;
  avg2 = avg2/10.0;
  avg3 = avg3/10.0;
  avg4 = avg4/10.0;
  avg5 = avg5/10.0;

  avg0_filter = smooth*avg0_filter + (1-smooth)*avg0;
  avg1_filter = smooth*avg1_filter + (1-smooth)*avg1;
  avg2_filter = smooth*avg2_filter + (1-smooth)*avg2;
  avg3_filter = smooth*avg3_filter + (1-smooth)*avg3;
  avg4_filter = smooth*avg4_filter + (1-smooth)*avg4;
  avg5_filter = smooth*avg5_filter + (1-smooth)*avg5;

  Serial.print(avg0_filter);
  Serial.print(' ');
  Serial.print(avg1_filter);
  Serial.print(' ');
  Serial.print(avg2_filter);
  Serial.print(' ');
  Serial.print(avg3_filter);
  Serial.print(' ');
  Serial.print(avg4_filter);
  Serial.print(' ');
  Serial.println(avg5_filter);
  
}

