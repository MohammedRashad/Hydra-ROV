/**
 * Copyright (C) 2016 root
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
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
    static About aboutDialog;
    static Dimension dim;

    JPanel messagePane;
    JPanel buttonPane;
    JRootPane rootPane;
    JButton button;
    
    InputMap inputMap;
    KeyStroke stroke;
    Action action;
    Point p;

    
    public About(JFrame parent, String title, String message) {
        super(parent, title);

        p = new Point(400, 400);
        setLocation(p.x, p.y);

        messagePane = new JPanel();
        messagePane.add(new JLabel(message));

        buttonPane = new JPanel();
        button = new JButton("We're Awesome");
        
        
        getContentPane().add(messagePane);

        buttonPane.add(button);
        button.addActionListener(new MyActionListener());
        
        getContentPane().add(buttonPane, BorderLayout.PAGE_END);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        
        pack();
        
        setVisible(true);

    }

   
    @Override
    public JRootPane createRootPane() {

        rootPane = new JRootPane();
        stroke = KeyStroke.getKeyStroke("ESCAPE");

        action = new AbstractAction() {

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

    
    private static void setDialogLocation() {
        
        dim = Toolkit.getDefaultToolkit().getScreenSize();
        newW = dim.width / 2 - aboutDialog.getSize().width / 2;
        newH = dim.height / 2 - aboutDialog.getSize().height / 2;
        aboutDialog.setLocation(newW, newH);

    }
    

        private static void createDialog() {
        
        aboutDialog = new About(new JFrame(), "ADMIRAL TEAM", "We are a team of engineering students in Suez Canal University.We Build Underwater Robots.");
        aboutDialog.setSize(700, 80);

    }

        
    public static void main(String[] a) {

        createDialog();
        setDialogLocation();

    }

    
     class MyActionListener implements ActionListener {

        @Override
        public void actionPerformed(ActionEvent e) {

            setVisible(false);
            dispose();

        }
    }
     
}


