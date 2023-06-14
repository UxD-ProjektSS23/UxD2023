package com.uxd.accelerometerapp;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class MainActivity extends AppCompatActivity {

    private SensorManager sensorManager;
    private TextView accelerometerLabel, directionLabel;
    private TextView sensitivityLabel, pauseLabel;
    private TextView connectionLabel;
    private TextView ipLabel;
    private int sensitivity = 4;
    private int pause = 1000;
    private boolean connected = false;

    // Server Connection
    private static String hostip = "192.168.178.119";
    private static int port = 5000;
    public Socket socket;
    public PrintWriter outputwriter;
    public BufferedReader inputwriter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        sensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);

        //set the Labels
        accelerometerLabel = findViewById(R.id.accelerometerLabel);
        directionLabel = findViewById(R.id.directionLabel);
        sensitivityLabel = findViewById(R.id.sensitivityLabel);
        pauseLabel = findViewById(R.id.pauseLabel);
        connectionLabel = findViewById(R.id.connectionLabel);
        ipLabel = findViewById(R.id.iptext);
    }

    private final SensorEventListener sensorEventListener = new SensorEventListener() {
        private boolean isPaused = false;
        private float maxX = 0.0f;
        private float maxY = 0.0f;
        private float maxZ = 0.0f;
        private float minX = 0.0f;
        private float minY = 0.0f;
        private float minZ = 0.0f;

        /**
         * runs on every Change of the Accelerometer Values and checks if the movement can be classified
         * @param event Change of the Accelerometer Sensor
         */
        @Override
        public void onSensorChanged(SensorEvent event) {


            //get live Accelerometer Values
            //x+ Right side x- Left side
            //y+ Top of Phone y- Bottom of Phone
            //z+ Display direction z- Back of Phone
            float x = event.values[0];
            float y = event.values[1];
            float z = event.values[2];

            //get the max values to help calibrate the sensitivity

            if (x > maxX) {
                maxX = x;
            } else if (x < minX) {
                minX = x;
            }

            if (y > maxY) {
                maxY = y;
            } else if (y < minY) {
                minY = y;
            }

            if (z > maxZ) {
                maxZ = z;
            } else if (z < minZ) {
                minZ = z;
            }

            //Show Live Accelerometer Data
            String data = "X: " + x + "\nY: " + y + "\nZ: " + z;
            accelerometerLabel.setText(data);

            if (isPaused) {
                return; // Ignore sensor events during the pause
            }

            //Check if one Value is larger than the set sensitivity
            if (Math.abs(x) > sensitivity || Math.abs(z) > sensitivity || y > sensitivity) {
                String direction = "";

                float absX = Math.abs(x);
                float absZ = Math.abs(z);

                //check if the Movement was in x, y or z direction
                if (y > absX && y > absZ){
                    direction = "front";
                    //we do not check for negative y because it is not used
                }else if (absX > absZ) {
                    direction = x > 0 ? "right" : "left";
                } else {
                    direction = z > 0 ? "up" : "down";
                }

                //write the direction in the Label
                directionLabel.setText(direction);

                sendDataToServer(direction);

                //pause the Listener for 1 Second
                isPaused = true;
                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {

                        //Log the max values for sensitivity calibrations
                        Log.d("MainActivity", "Max x: " + maxX + " | " + minX);
                        Log.d("MainActivity", "Max y: " + maxY + " | " + minY);
                        Log.d("MainActivity", "Max z: " + maxZ + " | " + minZ);
                        //TODO: send log to server
                        //reset the values
                        maxX = 0.0f;
                        maxY = 0.0f;
                        maxZ = 0.0f;
                        minX = 0.0f;
                        minY = 0.0f;
                        minZ = 0.0f;

                        isPaused = false; // Resume sensor events after the pause
                    }
                }, pause); // 1000 milliseconds = 1 second
            }
        }

        @Override
        public void onAccuracyChanged(Sensor sensor, int accuracy) {
            // Not needed for accelerometer
        }
    };

    @Override
    protected void onPause() {
        super.onPause();
        sensorManager.unregisterListener(sensorEventListener);
    }

    @Override
    protected void onResume() {
        super.onResume();

        //Sensor accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
        Sensor accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_LINEAR_ACCELERATION);
        sensorManager.registerListener(sensorEventListener, accelerometer, SensorManager.SENSOR_DELAY_NORMAL);
    }

    /**
     * Starts the Async task to connect to the server
     * @param v
     */
    public void connectToServer(View v) {
        new ConnectTask().execute();
    }

    /**
     * Async Task to connect to the Server
     * TODO: maybe transform into a thread instead of an async task
     */
    private class ConnectTask extends AsyncTask<Void, String, Void> {
        @Override
        protected Void doInBackground(Void... voids) {
            try {
                hostip = ipLabel.getText().toString();
                socket = new Socket(hostip, port);
                // Perform actions on the socket (e.g., send/receive data)
                // Create a PrintWriter to send data
                outputwriter = new PrintWriter(socket.getOutputStream(), true);
                //outputwriter.println("Android App connected");

                //TODO: Update UI Element to show connection status
                connected = true;
                publishProgress("Connected");

                //TODO: handle incoming data

                // Create a BufferedReader to receive data
                inputwriter = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                String receivedMessage = inputwriter.readLine();
                // Process the received message

            } catch (IOException e) {
                e.printStackTrace();
            }
            return null;
        }

        @Override
        protected void onProgressUpdate(String... values) {
            // Update UI elements on the main thread
            String message = values[0];
            connectionLabel.setText(message);
        }
    }

    /**
     * Send a String to the Server
     * TODO: double check if this means we open a new Thread for every message and never stop them
     * @param data the string that needs to be send to the Server
     */
    private void sendDataToServer(final String data) {
        if (connected) {
            Thread thread = new Thread(new Runnable() {
                @Override
                public void run() {
                    outputwriter.println("Message:" + data);
                    Log.d("MainActivity", "Sent message to server: " + data);
                }
            });
            thread.start();
        }
    }

    private void sendLogToServer(final String data) {
        if (connected) {
            Thread thread = new Thread(new Runnable() {
                @Override
                public void run() {
                    outputwriter.println("Log:" + data);
                    Log.d("MainActivity", "Sent Log to server: " + data);
                }
            });
            thread.start();
        }
    }

    /**
     * Lowers the sensitivity needed to detect movement by 1m/s²
     * @param v
     */
    public void lowersensitivity(View v) {
        if (sensitivity > 1){
            sensitivity--;
            sensitivityLabel.setText("Sensitivity: " + sensitivity + "m/s²");
        }
    }

    /**
     * Increases the sensitivity needed to detect movement by 1m/s²
     * @param v
     */
    public void highersensitivity(View v) {
        sensitivity++;
        sensitivityLabel.setText("Sensitivity: " + sensitivity + "m/s²");
    }

    /**
     * Sets the sensitivity needed to detect movement to a given value
     * @param v
     * @param newsens sensitivity in m/s²
     */
    public void setsensitivity(View v, int newsens) {
        sensitivity = newsens;
        sensitivityLabel.setText("Sensitivity: " + sensitivity + "m/s²");
    }

    /**
     * Lowers the pause between detecting movement by 1s
     * @param v
     */
    public void lowerpause(View v) {
        if (pause > 100){
            pause = pause - 100;
            pauseLabel.setText("Pause: " + pause + "ms");
        }
    }

    /**
     * Increases the pause between detecting movement by 1s
     * @param v
     */
    public void higherpause(View v) {
        pause = pause + 100;
        pauseLabel.setText("Pause: " + pause + "ms");
        String dataToSend = "Your data here";
        sendDataToServer(dataToSend);
    }

    /**
     * Sets the pause between detecting movement to a given value
     * @param v
     * @param newpause pause in seconds
     */
    public void setpause(View v, int newpause) {
        pause = newpause;
        pauseLabel.setText("Pause: " + pause + "ms");
    }
}