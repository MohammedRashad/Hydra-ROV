/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rov.bridge;

/**
 * @author rashad
 */
import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.Point;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.AbstractAction;
import javax.swing.Action;
import javax.swing.InputMap;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JRootPane;
import javax.swing.KeyStroke;

public class About extends JDialog {

    private static final long serialVersionUID = 1L;
    static int newH, newW;

    JRootPane rootPane = new JRootPane();
    InputMap inputMap = rootPane.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW);
    KeyStroke stroke = KeyStroke.getKeyStroke("ESCAPE");

    public About(JFrame parent, String title, String message) {
        super(parent, title);

        // set the position of the window
        Point p = new Point(400, 400);
        setLocation(p.x, p.y);

        // Create a message
        JPanel messagePane = new JPanel();
        messagePane.add(new JLabel(message));

		// get content pane, which is usually the
        // Container of all the dialog's components.
        getContentPane().add(messagePane);

        // Create a button
        JPanel buttonPane = new JPanel();
        JButton button = new JButton("We're Awesome");
        buttonPane.add(button);

        // set action listener on the button
        button.addActionListener(new MyActionListener());
        getContentPane().add(buttonPane, BorderLayout.PAGE_END);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        pack();
        setVisible(true);

    }

	// override the createRootPane inherited by the JDialog, to create the rootPane.
    // create functionality to close the window when "Escape" button is pressed
    @Override
    public JRootPane createRootPane() {

        rootPane = new JRootPane();
        stroke = KeyStroke.getKeyStroke("ESCAPE");

        Action action = new AbstractAction() {

            @Override
            public void actionPerformed(ActionEvent e) {

                setVisible(false);
                dispose();

            }
        };

        inputMap = rootPane.getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW);
        inputMap.put(stroke, "ESCAPE");
        rootPane.getActionMap().put("ESCAPE", action);
        return rootPane;

    }

	// an action listener to be used when an action is performed
    // (e.g. button is pressed)
    class MyActionListener implements ActionListener {

        //close and dispose of the window.
        @Override
        public void actionPerformed(ActionEvent e) {

            setVisible(false);
            dispose();

        }
    }

    public static void main(String[] a) {

        About dialog = new About(new JFrame(), "ADMIRAL TEAM", "We are a team of engineering students in Suez Canal University.\nWe Build Robots. ");
        
        // set the size of the window
        dialog.setSize(600, 70);

        Dimension dim = Toolkit.getDefaultToolkit().getScreenSize();
        newW = dim.width / 2 - dialog.getSize().width / 2;
        newH = dim.height / 2 - dialog.getSize().height / 2;
        dialog.setLocation(newW, newH);

    }
}
