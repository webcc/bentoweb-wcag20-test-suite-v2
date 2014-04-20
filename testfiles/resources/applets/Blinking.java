/*
  Blinking.java
  Copyright BenToWeb 2005-2007
*/
import java.awt.*;
import java.awt.event.*;

/**
    Blinking applet
*/
public class Blinking extends java.applet.Applet implements Runnable, MouseListener {
    int delay;
    Thread animator;
    int color=0;

    public void init() {
              String str = getParameter("fps").trim();
              int fps = (str != null) ? Integer.parseInt(str) : 10;
              delay = (fps > 0) ? (1000 / fps) : 100;
              
              addMouseListener(this);
    }

    public void start() {
              animator = new Thread(this);
              animator.start();
    }

    public void run() {
              // Remember the starting time
              long tm = System.currentTimeMillis();
              while (Thread.currentThread() == animator) {
                // Display the next frame of animation.
                repaint();

                // Delay depending on how far we are behind.
                try {
                    tm += delay;
                    Thread.sleep(Math.max(0, tm - System.currentTimeMillis()));
                } catch (InterruptedException e) {
                    break;
                }

                // Advance the frame
              }
    }

    public void stop() {
               animator = null;
    }

    public void paint(Graphics g) {
                if (color==0) {
                  g.setColor(Color.black);
                  color=1;
                }  else {
                  g.setColor(Color.white);
                  color=0;
                }
                g.fillRect(0, 0, getSize().width-1, getSize().height-1);
    }
    
    public void mouseClicked (MouseEvent me) {
        animator = null;
    }
    public void mousePressed (MouseEvent me) {}
    public void mouseReleased (MouseEvent me) {}
    public void mouseEntered (MouseEvent me) {}
    public void mouseExited (MouseEvent me) {}
    
}
