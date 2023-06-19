import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;

public class GUI extends JFrame {
    private JButton lowersens;
    private JButton highersens;
    private JButton lowerpause;
    private JButton higherpause;
    private JPanel MainPanel;
    private JLabel Sensitivityfield;
    private JLabel Pausefield;
    private String msg;

    public GUI() {
        // Set up the frame properties
        setTitle("Settings");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setContentPane(MainPanel);
        pack();

        //Listeners for the four Buttons
        //All of them send a short instruction message to the Client
        try {
            lowersens.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    msg = "sens -";
                    System.out.println("Lower Sensitivity");
                    Main.sendMessageToClient(msg);
                }
            });
            highersens.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    msg = "sens +";
                    System.out.println("Higher Sensitivity");
                    Main.sendMessageToClient(msg);
                }
            });
            lowerpause.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    msg = "pause -";
                    System.out.println("Lower Pause");
                    Main.sendMessageToClient(msg);
                }
            });
            higherpause.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    msg = "pause +";
                    System.out.println("Higher Pause");
                    Main.sendMessageToClient(msg);
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * sets the Text of the Sensitivity Textfield
     * @param sensitivity the value the Textfield is supposed to be set at
     */
    public void setSensitivityfield(String sensitivity){
        Sensitivityfield.setText("Sensitivity "+sensitivity+"m/s²");
    }

    /**
     * sets the Text of the Pause Textfield
     * @param pause the value the Textfield is supposed to be set at
     */
    public void setPausefield(String pause){
        Pausefield.setText("Pause "+pause+"ms");
    }
}
