import java.awt.*;
import java.awt.event.KeyEvent;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;

public class Main {
    public static void main(String[] args) {
        try {
            ServerSocket serverSocket = new ServerSocket(5000); // Specify the port number

            System.out.println("Server started. Listening for connections...");
            System.out.println("Server IP address: " + InetAddress.getLocalHost().getHostAddress());

            while (true) {
                Socket clientSocket = serverSocket.accept(); // Accept incoming connections
                System.out.println("New client connected: " + clientSocket.getInetAddress().getHostAddress());

                // Handle client communication in a separate thread
                Thread clientThread = new Thread(() -> {
                    try {
                        BufferedReader reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
                        String message;
                        while ((message = reader.readLine()) != null) {
                            System.out.println("Received message from client: " + message);
                            // Process the received message and send a response if needed
                            processMessage(message);
                        }

                        reader.close();
                        clientSocket.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                });

                clientThread.start();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void processMessage(String message){
        //Message structure Type:Message

        String[] parts = message.split(":");
        message = parts[1];
        switch (parts[0]){
            case "Message":
                //The Type Message means the received data is a direction String
                switch (message){
                    case "front":
                        keyPress(KeyEvent.VK_SPACE);
                        break;
                    case "right":
                        keyPress(KeyEvent.VK_RIGHT);
                        break;
                    case "left":
                        keyPress(KeyEvent.VK_LEFT);
                        break;
                    case "up":
                        keyPress(KeyEvent.VK_UP);
                        break;
                    case "down":
                        keyPress(KeyEvent.VK_DOWN);
                        break;
                }
                break;
            case "Log":
                //The Type Log means the received data is Logging data
                System.out.println("Received Log from client: " + message);
                break;
            default:
                break;
        }
    }

    public static void keyPress(int key){
        try {
            // Create an instance of Robot
            Robot robot = new Robot();

                // Simulate a key press
                robot.keyPress(key);
                // Simulate a key release
                robot.keyRelease(key);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}